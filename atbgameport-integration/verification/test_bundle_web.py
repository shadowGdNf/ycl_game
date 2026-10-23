"""Behavioral and security regression tests for the local bundle helper."""
import contextlib
import hashlib
import importlib.util
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
import zipfile

SCRIPT = Path(__file__).resolve().parents[1] / "skill/atb-gameport-reviewed/scripts/bundle_web.py"
SPEC = importlib.util.spec_from_file_location("reviewed_bundle", SCRIPT)
bundle = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(bundle)


class BundleTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="atb-reviewed-test-")
        self.base = Path(self.temp.name).resolve()
        self.game = self.base / "game"
        self.web = self.game / "web"
        self.web.mkdir(parents=True)
        (self.web / "index.html").write_text('<html><script src="game.js"></script></html>')
        (self.web / "game.js").write_text("console.log('fixture only');")
        self.out = self.base / "release"

    def tearDown(self):
        self.temp.cleanup()

    def plan(self, **kwargs):
        return bundle.make_plan(self.game, self.web, self.out, kwargs.pop("game_id", "demo"), **kwargs)

    def test_internal_assets_symlink_and_zip_hashes(self):
        assets = self.game / "assets"
        assets.mkdir()
        (assets / "level.json").write_text('{"level":1}')
        (self.web / "assets").symlink_to(assets, target_is_directory=True)
        root, output, plan = self.plan()
        result = bundle.write_bundle(root, output, plan)
        self.assertTrue((output / "manifest.json").is_file())
        self.assertFalse(any(path.is_symlink() for path in output.rglob("*")))
        with zipfile.ZipFile(output / "demo-web.zip") as zf:
            self.assertEqual(set(zf.namelist()), {row["path"] for row in result["files"]})
            for row in result["files"]:
                archived = zf.read(row["path"])
                self.assertEqual(hashlib.sha256(archived).hexdigest(), row["sha256"])
                self.assertEqual(archived, (output / "site" / row["path"]).read_bytes())
        self.assertEqual(result["archive"]["sha256"], hashlib.sha256((output / "demo-web.zip").read_bytes()).hexdigest())

    def test_external_file_symlink_is_rejected_without_output(self):
        outside = self.base / "outside.json"
        outside.write_text('{"secret":"TEST_ONLY"}')
        (self.web / "linked.json").symlink_to(outside)
        with self.assertRaisesRegex(bundle.BundleError, "escapes"):
            self.plan()
        self.assertFalse(self.out.exists())

    def test_external_directory_symlink_is_rejected(self):
        outside = self.base / "outside"
        outside.mkdir()
        (outside / "data.json").write_text("{}")
        (self.web / "assets").symlink_to(outside, target_is_directory=True)
        with self.assertRaisesRegex(bundle.BundleError, "escapes"):
            self.plan()

    def test_symlink_cycle_is_rejected(self):
        (self.web / "loop").symlink_to(self.web, target_is_directory=True)
        with self.assertRaisesRegex(bundle.BundleError, "cycle"):
            self.plan()

    def test_hidden_file_and_credential_name_are_rejected(self):
        nested = self.web / "data"
        nested.mkdir()
        for name in (".env", "credentials.json", "service-account.json"):
            with self.subTest(name=name):
                path = nested / name
                path.write_text("TEST_ONLY")
                with self.assertRaises(bundle.BundleError):
                    self.plan()
                path.unlink()

    def test_alias_to_hidden_source_is_rejected(self):
        hidden = self.game / ".private"
        hidden.mkdir()
        (hidden / "data.json").write_text("{}")
        (self.web / "assets").symlink_to(hidden, target_is_directory=True)
        with self.assertRaisesRegex(bundle.BundleError, "Hidden"):
            self.plan()

    def test_existing_output_is_never_changed(self):
        self.out.mkdir()
        keep = self.out / "KEEP.txt"
        keep.write_text("keep me")
        with self.assertRaisesRegex(bundle.BundleError, "already exists"):
            self.plan()
        self.assertEqual(keep.read_text(), "keep me")

    def test_existing_output_created_after_plan_is_not_overwritten(self):
        root, output, plan = self.plan()
        output.mkdir()
        (output / "KEEP.txt").write_text("keep me")
        with self.assertRaises(FileExistsError):
            bundle.write_bundle(root, output, plan)
        self.assertEqual(list(output.iterdir()), [output / "KEEP.txt"])

    def test_output_within_game_is_rejected(self):
        self.out = self.game / "dist"
        with self.assertRaisesRegex(bundle.BundleError, "outside"):
            self.plan()

    def test_malicious_game_names_are_rejected(self):
        for name in ("../escape", "$(touch marker)", "a;touch marker", "bad\nname", "-option"):
            with self.subTest(name=name), self.assertRaises(bundle.BundleError):
                self.plan(game_id=name)
        self.assertFalse((self.base / "marker").exists())

    def test_count_and_byte_limits_are_enforced(self):
        with self.assertRaisesRegex(bundle.BundleError, "file-count"):
            self.plan(max_files=1)
        with self.assertRaisesRegex(bundle.BundleError, "byte limit"):
            self.plan(max_bytes=1)

    def test_unsupported_executable_and_fifo_are_rejected(self):
        executable = self.web / "setup.exe"
        executable.write_bytes(b"MZ_TEST_ONLY")
        with self.assertRaisesRegex(bundle.BundleError, "extension"):
            self.plan()
        executable.unlink()
        fifo = self.web / "pipe.json"
        os.mkfifo(fifo)
        with self.assertRaisesRegex(bundle.BundleError, "Special"):
            self.plan()

    def test_missing_index_is_not_a_success(self):
        (self.web / "index.html").unlink()
        with self.assertRaisesRegex(bundle.BundleError, "index.html"):
            self.plan()

    def test_html_reference_does_not_inline_outside_files(self):
        secret = self.base / "outside.txt"
        secret.write_text("TEST_ONLY_OUTSIDE_SENTINEL")
        (self.web / "index.html").write_text('<html><script src="../../outside.txt"></script></html>')
        root, output, plan = self.plan()
        bundle.write_bundle(root, output, plan)
        with zipfile.ZipFile(output / "demo-web.zip") as zf:
            self.assertNotIn("outside.txt", zf.namelist())
            self.assertNotIn(secret.read_bytes(), b"".join(zf.read(name) for name in zf.namelist()))

    def test_nonportable_filename_is_rejected(self):
        for name in ("NUL.txt", "a\\b.json", "bad?.json"):
            with self.subTest(name=name):
                path = self.web / name
                path.write_text("TEST_ONLY")
                with self.assertRaisesRegex(bundle.BundleError, "Non-portable"):
                    self.plan()
                path.unlink()

    def test_changed_input_is_not_reported_as_complete(self):
        root, output, plan = self.plan()
        (self.web / "game.js").write_text("console.log('modified after plan');")
        with self.assertRaisesRegex(bundle.BundleError, "Source changed"):
            bundle.write_bundle(root, output, plan)
        self.assertFalse((output / "manifest.json").exists())

    def test_dry_run_writes_nothing_and_empty_cli_fails(self):
        # Mimic the original deploy script's dangerous staging directory name.
        stage = self.game / "_stage_verify_tmp"
        stage.mkdir()
        (stage / "KEEP.txt").write_text("keep me")
        args = ["--game-root", str(self.game), "--web-dir", str(self.web), "--out-dir", str(self.out),
                "--game-id", "demo", "--dry-run"]
        before = {str(p.relative_to(self.base)): p.read_bytes() for p in self.base.rglob("*") if p.is_file()}
        with contextlib.redirect_stdout(io.StringIO()) as capture:
            self.assertEqual(bundle.main(args), 0)
        self.assertTrue(json.loads(capture.getvalue())["dry_run"])
        after = {str(p.relative_to(self.base)): p.read_bytes() for p in self.base.rglob("*") if p.is_file()}
        self.assertEqual(before, after)
        self.assertFalse(self.out.exists())
        proc = subprocess.run([sys.executable, "-B", str(SCRIPT)], capture_output=True, timeout=5)
        self.assertNotEqual(proc.returncode, 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
