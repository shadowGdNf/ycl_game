# Jelly Flow working contract

This is an English-language, desktop and mobile H5 puzzle game. Four candy colors: pink, yellow, mint, purple. Tap/click a queue to release its contiguous front color group. Three active cup slots. Matching candies fill active cups, unmatched candies wait in a bounded buffer. Full cups leave and the next cup enters; waiting matching candies drain automatically. Buffer overflow loses. All candy collected wins. State changes are deterministic; visuals do not affect rules.

## Shared TypeScript API (core.ts)

Export CandyColor, CupSpec {color,capacity}, Cup extends CupSpec {id,filled}, Level {id,name,subtitle,queues:CandyColor[][],cups:CupSpec[],bufferSize,solution:number[],par:number}, GameState {levelId,queues:CandyColor[][],activeCups:(Cup|null)[],pendingCups:Cup[],buffer:CandyColor[],bufferSize,moves,collected,total,status:'playing'|'won'|'lost'}, ActionEvent {type:'release'|'collect'|'buffer'|'complete'|'enter'|'win'|'lose',color?:CandyColor,queue?:number,slot?:number,cupId?:number,amount?:number}, ActionResult {state:GameState,events:ActionEvent[]}.

Export createState(level), releaseQueue(state,index), cloneState(state), getHint(state):number|null. State transitions immutable. Empty/invalid/end-state actions no-op. Process each candy deterministically, fill smallest active slot index that matches, replace completed cup immediately, repeatedly drain buffer while a matching cup exists. Overflow only if settled buffer.length exceeds bufferSize. Cup id stable. getHint must return a winning-path move or null, never an arbitrary losing recommendation; bounded search may return null.

levels.ts exports LEVELS:Level[] (exactly 20, increasing difficulty, each with verified solution). Queue index 0 is the leftmost queue; front color at array index 0.

## Ownership

- core agent: src/core.ts, src/levels.ts only (plus optional own levels generator script).
- interface agent: index.html, styles.css and assets/ only.
- QA agent: tests/ and QA.md only.
- primary: src/app.ts, src/renderer.ts, src/audio.ts, src/storage.ts, scripts/, package/config/README, integration and deployment.

## DOM contract

index.html must expose canvas#game-canvas inside #board-wrap, #queue-controls (accessible queue buttons root will populate), #level-number, #level-name, #level-subtitle, #moves-value, #collected-value, #progress-fill, #buffer-label, #toast, buttons #undo-btn #restart-btn #hint-btn #sound-btn #levels-btn #help-btn. Dialogs #level-dialog with #level-grid and #close-levels; #help-dialog with #close-help and #start-playing; #result-dialog with #result-eyebrow #result-title #result-description #result-stars #next-btn #retry-btn #result-levels. Optional #chapter-label, #best-value. Script type=module src=./js/app.js in built output. Styles and DOM responsive. Primary draws all playfield visuals, tube queues/cups/buffer, controls in canvas.

Design: polished candy workshop. Cream paper background, ink navy text, coral pink accent, chunky friendly type, illustrated soft candies. Desktop page has playful editorial side information alongside centered game, mobile prioritizes game screen. No dashboard look. Board 440x600 logical canvas, dynamically scaled; 4–6 queues. DOM controls match 44px touch targets. English product copy.
