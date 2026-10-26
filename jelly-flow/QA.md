# Jelly Flow quality checks

## Automated suite

Run `npm test` with Node 24 or later. The tests replay the supplied solutions for all 20 levels; check candy conservation by color, immutable state, cup replacement and buffer cascades, exact capacity versus overflow, invalid and terminal input, clone isolation, and verified hints on small fixtures. A seeded randomized campaign sweep covers 800 playthroughs without relying on nondeterministic tests. Storage tests cover malformed data, version and campaign bounds, defensive copying, preferences, round trips, blocked storage and quota errors.

Status on 2026-10-26: **44/44 checks passed** on the finalized rules and levels, storage implementation including assist counts, and controller regression suite (approximately 0.3 seconds). All 20 published solution sequences reach victory. No rules or inventory defects were found by this suite.

The five controller checks execute the actual `app.ts` in a Node VM with minimal DOM and renderer stubs and controlled timers. They cover partial-run reload and undo, assist persistence, immediate persistence of victory before its animation completes, prevention of stacked result/help modals, restart invalidating an old animation callback, and repeated input committing only once. This harness is not a browser or rendering test. It exposed a delayed-win persistence race and modal-stacking risk; both were fixed in the controller and now have passing regression coverage.

Initial hint queries for all 20 levels were checked separately: maximum approximately 0.022 ms on this development machine because their supplied routes are cached. This is not a mobile-device performance guarantee or an off-route search benchmark.

## Browser acceptance results

Checked on 2026-10-26 in the Codex in-app browser using actual UI input:

- Completed all 20 levels through the visible controls, verified each result, next-level unlock and the final campaign completion screen. Replay returned to level 1; all 20 completion ratings remained visible after reload.
- Checked desktop 1280×900, portrait 390×844 and 320×740, and landscape 844×390. No horizontal overflow at the checked sizes. At 320px with six chutes, all six numbered controls measured 44.5×44px. Short screens use normal vertical scrolling.
- Tested both direct Canvas selection and the numbered buttons, keyboard number input and Z undo, hint display, restart, level selection, partial-run reload and undo, progress persistence, and mute persistence.
- Deliberately overflowed the buffer on level 18, verified the failure dialog hides Next, and retried successfully from zero moves.
- Browser console had no warnings or errors during the campaign checks.
- Fixed animation arrival mapping so buffer cascades cannot assign released candies another color's collection destination. Build and all 44 tests passed after that fix.

These checks use a desktop browser with resized viewports. They are not physical phone tests, a screen-reader audit, or a guarantee of Safari/TikTok container behavior. Audio preference behavior was checked; listening quality on phone speakers has not been evaluated.

## Remaining device acceptance checks

These should be repeated on real target devices before release:

- Desktop mouse and keyboard can select every chute; undo, restart, hint, help and level selector work.
- At 320px, 390px, and desktop widths, controls and playfield remain visible with no horizontal overflow.
- On mobile, one tap releases one group; dragging the board scrolls normally without releasing a group.
- Rapid interaction during candy motion does not duplicate actions or corrupt the board.
- Sound starts only after interaction, mute persists, and background/resume does not cause a burst of effects.
- Progress and completed levels survive reload; invalid or inaccessible browser storage degrades safely.
- Winning the last level provides a replay/campaign action instead of an invalid level 21.
- Hint exhaustion or a no-longer-solvable position communicates clearly and does not point to a losing move.
- Dialog focus, escape/close actions and screen-reader labels remain usable.
- Chrome Android and Safari iOS real-device checks are recorded separately from desktop viewport emulation.

## Difficulty review

The provided solutions certify solvability, not human difficulty. An additional seeded diagnostic on the final campaign ran 200 uniformly random action playthroughs per level (4,000 total). Levels 1–3 won all 200 runs each, while the final four levels won 45, 40, 29 and 15 respectively. This supports a broad structural difficulty ramp; it does not measure real player success or establish strictly increasing difficulty for every consecutive level. Record first-try wins, buffer use and retries during player tests.
