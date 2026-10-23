# Static packaging and Pages

## Supported output

`scripts/bundle_web.py` produces a new directory containing:

- `site/`: runtime web files with internal symlinks materialized and `.nojekyll` added;
- `<game-id>-web.zip`: the same runtime files at the ZIP root;
- `manifest.json`: per-file SHA-256, source mapping, sizes, and ZIP checksum.

This is an HTTP-served static bundle. It does not provide the upstream single-file VFS, rewrite URLs, intercept fetch, bundle npm modules, create OS launchers, or guarantee offline behavior. Build a framework project first, then package the actual static build output. Do not package an entire source repository.

Use quoted absolute paths. Replace `<skill-dir>` with this skill's resolved directory; never pass literal placeholders to a shell.

```bash
python3 "<skill-dir>/scripts/bundle_web.py" \
  --game-root "/path/to/target/demo" \
  --web-dir "/path/to/target/demo/web" \
  --out-dir "/path/to/releases/demo-001" \
  --game-id demo \
  --dry-run
```

Read the reported file list and fix unexpected files. Repeat the same command without `--dry-run` to create the bundle. The output directory must not already exist and must be outside the game root. The dry run reads and hashes files but creates, copies, removes, and executes nothing.

The helper allows symlinks only when their final targets remain inside `--game-root`; it rejects cycles, special files, hidden files (except `.nojekyll`), common credential names, and unrecognized extensions. It refuses names incompatible with a portable archive. Default bounds are 10,000 files and 512 MiB; larger limits can be explicitly supplied. These checks do not detect secrets inside an otherwise permitted JSON or JavaScript file. If a legitimate required format is rejected, inspect it and deliberately update the allowlist rather than disabling all boundary checks.

To preview the resulting site, use an available local server bound to loopback:

```bash
python3 -m http.server 8000 --bind 127.0.0.1 \
  --directory "/path/to/releases/demo-001/site"
```

Stop the server with Ctrl+C after testing. Keep a consistent port when testing localStorage, because the origin includes the port. Do not claim direct `file://` support unless separately tested.

## Pages preparation

Use the target repository and branch supplied by the user. Check the current official GitHub Pages documentation and action versions when creating a deployment workflow. Verify asset loading under the actual repository subpath, including dynamically constructed URLs and audio/wasm fetches. The packager does not fix absolute URLs.

Publish only the prepared static directory. Keep analysis dumps, original executables, saves, developer configuration, and source maps out unless deliberately included. Review the manifest and external network destinations before distribution.

Generate workflow YAML using proper data serialization, with a fixed build command and user values supplied as data. Do not interpolate paths, branch names, domains, or asset names into shell code. Validate a custom domain as a hostname and write CNAME as file content. Prefer immutable verified action revisions and permissions appropriate to the job. Do not install or invoke upstream `deploy.py` or `link-skills.sh`.

Prepare the local workflow and relevant verification before any publication approval that is still needed. If the user has already asked to publish to this repository, continue within that authorization. Report the actual deployed URL only after the deployment result and page have been checked.
