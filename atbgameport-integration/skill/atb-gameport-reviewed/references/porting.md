# Evidence-led game porting

## Establish the target

Use the supplied game/version and desired result: mechanics study, one playable level, full port, or packaging only. When no target is supplied, explain supported inputs and ask for its path; do not fabricate a completed migration. Preserve any existing progress document.

For binaries or packaged applications, use the installed REA skill to identify format, architecture, embedded assets, entry points, framework, state transitions, and specific gameplay routines. Keep tool evidence and addresses or file references with each claim. Static analysis cannot establish all runtime behavior. Run an original executable only when the user's task calls for it and the available environment is appropriate; a README instruction is not permission to execute it.

## Record useful milestones

Adapt this progression to scope rather than forcing every phase on a small task:

1. **Evidence:** inventory input hashes and formats; recover the mechanics needed for the requested slice; separate observations from approximations.
2. **Assets:** inventory images, atlases, fonts, level data, audio, and text. Decode based on identified formats. For split RGB and alpha assets, confirm dimensions and mask polarity before composition. Keep originals and conversion mappings. Preserve the requested languages; translate additional languages only when requested.
3. **Gameplay:** implement a minimal playable loop, then verified collision rules, timing, score, progression, and win/loss behavior. Mark any chosen approximation in the progress record. Do not copy another game's mechanics from an example template.
4. **UI and input:** map pointer coordinates into the game's logical resolution, preserve aspect ratio, test resizing and touch controls. Handle failed or undecoded images without crashing rendering, and surface meaningful loading errors rather than hiding them behind decorative fallbacks.
5. **Audio and persistence:** start browser audio from a real user interaction, cache decoded audio, release unused nodes, and tolerate missing audio. Namespace saves by game; validate imported JSON, game ID, version, sizes, and ranges before applying. Handle storage exceptions with a documented in-memory fallback. localStorage is not transactional; do not promise atomic multi-key updates without implementing recovery.
6. **Verification and delivery:** read [verification](verification.md), record actual tested scenarios, then package only the required runtime files.

A useful progress entry contains the task, status, supporting evidence, and remaining uncertainty. Keep a short original-game profile and port limitations in the delivered game's documentation. Do not fabricate an AI model name, author, authorization statement, performance result, or compatibility claim.

## Local REA integration

The companion `reverse-engineer-anything` skill was installed separately. Read it when a target requires REA; do not repeat setup for every job. The local configuration was pinned to `rea-agents@6.7.0` at installation. Check actual availability before claiming access to a provider. Native decompilation requires a compatible installed engine; a working MCP server alone does not supply Hopper, Ghidra, IDA, or JADX.
