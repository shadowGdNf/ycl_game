# Verification that supports the claim

Use the browser/testing tools actually available in the session. Record failures and untested cases instead of inventing success.

For a playable port, exercise the real transitions: start, representative gameplay input, score change, pause/resume, win or loss, restart, and requested stage progression. Test save reload/import/export only when those features are present. Check the requested desktop and mobile viewports with pointer/touch input and audio after a user gesture.

Capture page errors, console errors, failed requests, screenshots, and observable gameplay state. A test-only stage query parameter may help reproduce a state but does not prove that a player can reach it. A non-black pixel ratio cannot distinguish correct gameplay from a blank colored canvas. Do not claim 60 FPS without measurement, cross-browser support without the relevant browsers, or Windows compatibility from a macOS-only run.

For a bundle, compare each copied file and ZIP member to `manifest.json`, confirm there are no links or extra files, and serve the extracted result from a new temporary location. Exercise the game through that copy. If offline support is requested, test with network access blocked and inspect attempted external requests. Retaining a remote script or a fetch fallback can make a nominally single-file game depend on the network.

Keep outputs separated by scenario so later runs do not silently replace evidence needed for the report. Do not use an upstream script's success message as a substitute for checking that an artifact was actually supplied and the intended scenario was run.
