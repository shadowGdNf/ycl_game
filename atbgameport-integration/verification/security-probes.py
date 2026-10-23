#!/usr/bin/env python3
"""Bounded ATBGamePort regression probes; use only the reviewed source snapshot.

All payloads use self-created files in TemporaryDirectory. No secrets are read,
no browsers are launched, and no network or Git mutations are performed.
"""
import argparse
import base64
import contextlib
import importlib.util
import io
import json
from pathlib import Path
import subprocess
import sys
import tempfile
from unittest.mock import patch


def load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


def probe(source):
    pkg = load("atb_review_package", source / "skills/atb-game-package/scripts/package-game.py")
    deploy = load("atb_review_deploy", source / "skills/atb-game-to-githubpage/scripts/deploy.py")
    results = []
    with tempfile.TemporaryDirectory(prefix="atb-owned-probes-") as temp:
        root = Path(temp).resolve()
        game = root / "game"
        game.mkdir()
        (game / "index.html").write_text("<html><head></head><body>test</body></html>")
        sentinel = b"ATB_TEST_ONLY_OUTSIDE_SENTINEL"
        outside = root / "outside.txt"
        outside.write_bytes(sentinel)
        (game / "linked.txt").symlink_to(outside)
        layout = pkg.resolve_game_layout(game)
        vfs = pkg.gather_vfs_assets(layout)
        results.append({"id": "outside_symlink_read", "reproduced": any(
            base64.b64decode(entry["b64"]) == sentinel for entry in vfs.values()
        ), "impact": "Outside-root file bytes become part of the distributable VFS."})
        (game / "linked.txt").unlink()

        (game / "index.html").write_text('<html><head><script src="../outside.txt"></script></head></html>')
        inline_output = root / "inline-result.html"
        pkg.build_standalone_html(layout, {}, inline_output)
        results.append({"id": "outside_html_reference_read", "reproduced": sentinel.decode() in inline_output.read_text(),
                        "impact": "A parent-relative script reference embeds a file outside the input root."})
        (game / "index.html").write_text("<html><head></head><body>test</body></html>")

        with contextlib.redirect_stdout(io.StringIO()):
            result = pkg.package_game(game, out_dir=root / "dist", game_name="../escaped", mode="single")
        results.append({"id": "output_path_traversal", "reproduced": (root / "escaped-standalone.html").is_file()
                        and result["standalone_html"].resolve().parent == root,
                        "impact": "A crafted game name writes outside the selected output directory."})

        # Execute only the generated echo line with a harmless local marker.
        payload_name = "$(touch atb-owned-launcher-marker)"
        layout.game_name = payload_name
        bundle = pkg.build_portable_bundle(layout, root / "portable")
        echo_line = next(line for line in (bundle / "Play-macOS.command").read_text().splitlines()
                         if line.startswith('echo " Starting local server'))
        subprocess.run(["/bin/sh", "-c", echo_line], cwd=root, check=True, capture_output=True, timeout=5)
        results.append({"id": "launcher_command_injection", "reproduced": (root / "atb-owned-launcher-marker").is_file(),
                        "impact": "The interpolated game name executes shell substitution in the generated macOS launcher."})

        site = root / "_site"
        site.mkdir()
        script = deploy.generate_build_script(game, root, [], "$(touch atb-owned-domain-marker).example.com")
        domain_line = next(line.strip() for line in script.splitlines() if " > _site/CNAME" in line)
        subprocess.run(["/bin/sh", "-c", domain_line], cwd=root, check=True, capture_output=True, timeout=5)
        results.append({"id": "workflow_domain_command_injection", "reproduced": (root / "atb-owned-domain-marker").is_file(),
                        "impact": "The generated Actions shell step executes command substitution supplied as a domain."})

        existing_stage = game / "_stage_verify_tmp"
        existing_stage.mkdir()
        keep = existing_stage / "KEEP.txt"
        keep.write_text("ATB_TEST_ONLY_EXISTING_USER_FILE")
        git_info = {"is_git": False, "branch": "main", "pages_url": ""}
        with patch.object(deploy, "detect_git_info", return_value=git_info), contextlib.redirect_stdout(io.StringIO()):
            ok = deploy.deploy_workflow(game, dry_run=True, auto_readme=False)
        results.append({"id": "dry_run_deletes_existing_stage", "reproduced": ok and not keep.exists(),
                        "impact": "A dry run deletes the pre-existing _stage_verify_tmp directory and its contents."})

        empty_verify = subprocess.run([sys.executable, "-B", str(source / "skills/atb-game-package/scripts/verify-package.py")],
                                      cwd=root, capture_output=True, text=True, timeout=5)
        results.append({"id": "empty_verification_passes", "reproduced": empty_verify.returncode == 0,
                        "impact": "The package verifier exits successfully when no artifact is specified.",
                        "stdout": empty_verify.stdout.strip()})
    return {"commit": "835a4cf1be874c237aa1a60207bc6ca639448712", "probes": results,
            "all_reproduced": all(item["reproduced"] for item in results)}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(probe(args.source.resolve()), ensure_ascii=False, indent=2))
