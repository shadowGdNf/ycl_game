// Isolated contexts and synthetic saves; no access to the player's profile.
import assert from 'node:assert/strict';
import {writeFile} from 'node:fs/promises';
const {chromium}=await import(process.env.PLAYWRIGHT_MODULE||'playwright');
const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH||'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'});
let context=await browser.newContext({viewport:{width:1200,height:900},deviceScaleFactor:1}),page=await context.newPage(),touch=false;
const checks=[],screenshots=[],errors=[],geometry=[];
const url=process.env.MECHA_QA_URL||'http://localhost:4174/';
page.on('pageerror',e=>errors.push(String(e)));
async function ready(){await page.waitForFunction(()=>document.querySelector('[data-action="new-run"]')?.disabled===false);}
async function fixture(completed=false){
 await page.goto(url);await ready();
 await page.evaluate(async completed=>{
  const v=new URL(document.querySelector('script[type="module"]').src).search;
  const e=await import(`./js/economy.js${v}`),s=await import(`./js/storage.js${v}`),c=await import(`./js/combat.js${v}`);
  const r=e.newRun('scavenger','full',0,'DEV16-BROWSER');r.wave=completed?1:3;r.gold=500;r.hp=60;r.power=24;r.unlockedCorners=[0,1,2,3];r.shop=['W03','W13','U02','S02'].map(id=>({id,tier:1,locked:false}));
  let battle=null;if(completed){e.startWave(r);battle=c.createBattle(r);battle.status='won';}
  const profile=s.freshProfile();profile.tutorial=true;profile.settings.unlockAll=true;profile.settings.music=false;profile.settings.sound=false;
  await s.saveGame({version:1,profile,run:r,battle,savedAt:Date.now()});
 },completed);
 await page.reload();await ready();await probe();await page.locator('[data-action="continue"]').click();
 if(completed)await page.locator('[data-action="resume"]').click();
 await page.locator('#backpack-canvas').waitFor({state:'visible'});await page.waitForTimeout(100);
}
async function probe(){
 await page.evaluate(async()=>{
  const v=new URL(document.querySelector('script[type="module"]').src).search;
  const {WorkshopRenderer}=await import(`./js/workshop-renderer.js${v}`),{Renderer}=await import(`./js/renderer.js${v}`);
  const draw=WorkshopRenderer.prototype.draw;WorkshopRenderer.prototype.draw=function(canvas,r,o){window.qaBoards??={};window.qaBoards[canvas.id]={items:structuredClone(r.items),preview:o.preview?structuredClone(o.preview):null};return draw.call(this,canvas,r,o);};
  const combat=Renderer.prototype.draw;Renderer.prototype.draw=function(state,o){window.qaWeapons=structuredClone(state.weapons);return combat.call(this,state,o);};
 });
}
async function saved(){return page.evaluate(async()=>{const v=new URL(document.querySelector('script[type="module"]').src).search;return (await (await import(`./js/storage.js${v}`)).loadSave()).run;});}
async function until(check,label){for(let i=0;i<40;i++){if(await check())return;await page.waitForTimeout(40);}assert.fail(label);}
const items=async(id='backpack-canvas')=>page.evaluate(id=>window.qaBoards?.[id]?.items??[],id);
async function point(id,x,y){const b=await page.locator('#'+id).boundingBox();return {x:b.x+x*b.width/5,y:b.y+y*b.height/5};}
async function drag(id,from,to){
 await page.locator('#'+id).scrollIntoViewIfNeeded();const a=await point(id,...from),b=await point(id,...to);
 if(touch){const cdp=await context.newCDPSession(page);await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[a]});
  for(let i=1;i<=12;i++)await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:[{x:a.x+(b.x-a.x)*i/12,y:a.y+(b.y-a.y)*i/12}]});
  await page.waitForTimeout(60);const preview=await page.evaluate(id=>window.qaBoards[id].preview,id);await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});await cdp.detach();return preview;
 }
 await page.mouse.move(a.x,a.y);await page.mouse.down();await page.mouse.move(b.x,b.y,{steps:12});await page.waitForTimeout(60);
 const preview=await page.evaluate(id=>window.qaBoards[id].preview,id);await page.mouse.up();return preview;
}
async function capture(name){await page.waitForTimeout(450);const path=`qa/dev16-${name}.png`;await page.screenshot({path});screenshots.push(path);}
async function lab(){
 await page.goto(url);await ready();await probe();await page.locator('[data-action="practice"]').click();await page.waitForTimeout(100);
 await page.locator('[data-action="practice-clear"]').click();await page.locator('[data-action="practice-module"][data-id="W01"]').click();await page.waitForTimeout(100);
}
try{
 await fixture();assert.equal(await page.locator('[data-action="workshop-tab"][data-id="shop"]').getAttribute('aria-pressed'),'true');
 const original=(await saved()).items;const plan=await drag('backpack-canvas',[2.92,.84],[4.96,3.98]);assert.ok(plan.ok);assert.equal(plan.item.x,3);assert.equal(plan.item.y,3);
 await until(async()=>{const r=await saved();return r.items[0].x===3&&r.items[0].y===3;},'off-center drag commit');
 assert.deepEqual((await saved()).items,plan.items);await capture('snap-desktop');
 await page.locator('[data-action="undo-edit"]').click();await until(async()=>JSON.stringify((await saved()).items)===JSON.stringify(original),'undo relaxed drop');checks.push('off-center and edge drop commits the highlighted nearby position; undo restores inventory');
 await page.locator('[data-action="workshop-tab"][data-id="module"]').click();await page.locator('#home-button').click();await page.locator('[data-action="continue"]').click();assert.equal(await page.locator('[data-action="workshop-tab"][data-id="shop"]').getAttribute('aria-pressed'),'true');
 await fixture(true);assert.equal(await page.locator('[data-action="workshop-tab"][data-id="shop"]').getAttribute('aria-pressed'),'true');checks.push('resuming prep and completing a wave both select Shop');
 await fixture();const before=await saved();await page.locator('[data-action="deploy"]').click();await page.getByRole('heading',{name:'不买装备，直接进入下一关？'}).waitFor();assert.equal((await saved()).phase,'prep');assert.equal((await saved()).gold,before.gold);await capture('no-spend');
 await page.locator('[data-action="return-shop"]').click();assert.equal(await page.locator('[data-action="workshop-tab"][data-id="shop"]').getAttribute('aria-pressed'),'true');
 await page.locator('[data-action="deploy"]').click();await page.locator('[data-action="deploy-confirm"]').click();await page.locator('#battle-screen').waitFor({state:'visible'});checks.push('no-spend dialog cancels to shop or explicitly proceeds without spending');
 for(const action of ['refresh','repair','buy']){
  await fixture();if(action==='buy'){await page.locator('[data-action="preview-buy"]').first().click();await page.locator('[data-action="buy"]').click();}else await page.locator(`[data-action="${action}"]`).click();
  await until(async()=>!!(await saved()).extra.spentPrepWave,'spending persisted');
  await page.reload();await ready();await page.locator('[data-action="continue"]').click();await page.locator('[data-action="deploy"]').click();await page.locator('#battle-screen').waitFor({state:'visible'});assert.equal(await page.locator('#modal').isVisible(),false);
 }checks.push('purchase, refresh and repair each suppress the warning after reload');

 await lab();const board=await page.locator('#training-preview').boundingBox();geometry.push({viewport:1200,board:board.width});assert.ok(board.width>=400);
 const first=(await items('training-preview'))[0],customPlan=await drag('training-preview',[first.x+.9,first.y+.4],[2.85,3.5]);assert.ok(customPlan.ok);
 await until(async()=>(await items('training-preview'))[0]?.y===3,'lab drag');
 await page.locator('[data-action="practice-rotate"]').click();await until(async()=>(await items('training-preview'))[0]?.rotation===1,'lab rotate');
 const moved=(await items('training-preview'))[0];await page.locator('[data-practice="tier"]').selectOption('4');await page.locator('[data-practice="difficulty"]').selectOption('2');
 await until(async()=>(await items('training-preview'))[0]?.tier===4,'lab rarity');const same=(await items('training-preview'))[0];assert.deepEqual([same.x,same.y,same.rotation],[moved.x,moved.y,moved.rotation]);
 await page.locator('[data-action="practice-module"][data-id="S01"]').click();await page.waitForTimeout(80);const support=(await items('training-preview')).find(i=>i.id==='S01');
 const linked=await drag('training-preview',[support.x+.5,support.y+.5],[3.5,3.5]);assert.ok(linked.ok);await until(async()=>!!(await items('training-preview')).find(i=>i.id==='S01')?.link,'custom link');
 await capture('boss-layout-desktop');const custom=await items('training-preview');
 await page.locator('[data-action="practice-undo"]').click();await page.waitForTimeout(100);assert.equal((await items('training-preview')).find(i=>i.id==='S01').x,support.x);
 await drag('training-preview',[support.x+.5,support.y+.5],[3.5,3.5]);await page.waitForTimeout(100);
 await page.locator('[data-action="practice-start"]').click();await page.locator('#battle-screen').waitFor({state:'visible'});await until(async()=>await page.evaluate(()=>window.qaWeapons?.[0]?.supports?.S01===4),'combat uses custom support connection');
 await page.locator('#pause-button').click();await page.locator('[data-action="save-home"]').click();await page.locator('[data-action="practice"]').click();await page.waitForTimeout(100);assert.deepEqual(await items('training-preview'),custom);checks.push('large boss board supports drag, rotate, linking and undo; settings and re-entry preserve layout; combat uses its link');

 await context.close();context=await browser.newContext({viewport:{width:390,height:844},deviceScaleFactor:1,hasTouch:true,isMobile:true});page=await context.newPage();page.on('pageerror',e=>errors.push(String(e)));touch=true;
 await fixture();const touchPlan=await drag('backpack-canvas',[2.9,.8],[4.94,3.98]);assert.ok(touchPlan.ok);await until(async()=>(await saved()).items[0].y===3,'touch snap');checks.push('touch drag from a weapon edge snaps to the same placement');
 await lab();await page.locator('#training-preview').scrollIntoViewIfNeeded();let mobile=await page.locator('#training-preview').boundingBox();geometry.push({viewport:390,board:mobile.width});assert.ok(mobile.width>=290);
 const initial=(await items('training-preview'))[0];await drag('training-preview',[initial.x+1.9,initial.y+.8],[4.95,3.98]);await until(async()=>(await items('training-preview'))[0]?.y===3,'touch custom placement');await capture('boss-layout-mobile');checks.push('390px phone view exposes a large, editable boss board with working touch drag');
 await page.setViewportSize({width:320,height:740});await page.locator('#training-preview').scrollIntoViewIfNeeded();mobile=await page.locator('#training-preview').boundingBox();geometry.push({viewport:320,board:mobile.width});assert.ok(mobile.width>=240);assert.ok(mobile.x>=0&&mobile.x+mobile.width<=320);await capture('boss-layout-narrow');
 assert.deepEqual(errors,[]);await writeFile('qa/dev16-browser.json',JSON.stringify({browser:await browser.version(),checks,geometry,screenshots,errors,limits:['Isolated synthetic saves; mobile viewports use emulated touch, not physical phones.']},null,2)+'\n');console.log(JSON.stringify({checks,geometry,errors},null,2));
}finally{await context.close();await browser.close();}
