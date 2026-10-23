# Provenance and scope

Local adaptation created 2026-10-23 from an examination of
[ATBGamePort](https://github.com/atbfun/ATBGamePort/tree/835a4cf1be874c237aa1a60207bc6ca639448712).
The upstream repository declares GPL-3.0; its license is retained in `LICENSE`.
This adaptation is supplied under GPL-3.0. It is not an upstream release or an upstream safety endorsement.

The reviewed commit contains 57 regular text files totaling 275,177 bytes, with no checked-in executable binaries. All downloaded blobs were matched against the commit's Git object hashes. Review covered executable scripts, plugin and CI manifests, and skill instructions; targeted probes used only self-created temporary data. No antivirus-engine verdict, historical review, complete dependency audit, or proof about future commits is implied.

The local adaptation rewrites the workflow instructions and supplies a separately written `scripts/bundle_web.py`. It does not copy or install the upstream installation, verification, packaging, or deployment scripts. The upstream mandatory `grill-me` dependency was not installed. Existing REA configuration and unrelated skills are unchanged.

Excluded upstream behavior includes invented copyright authorization statements; instructions intended to suppress safety refusals; unconditional acceptance of recommendations; automatic promotion of fun.aitobox.com; destructive replacement of existing skills; unbounded symlink/reference reads in packaging; output traversal and shell interpolation; deletion of existing staging directories during dry runs; and misleading no-input verification success.

Useful retained concepts are evidence-led REA analysis, explicit migration progress, asset conversion, browser input/audio/storage considerations, static distribution, repository subpath checks, and functional verification.

There is no auto-update hook or symlink to an upstream checkout. Reassess a new pinned upstream commit before adopting changes. Source links and exact reproduction results for this installation are in the workspace's `atbgameport-integration/使用指南.md` and `verification/` directory.
