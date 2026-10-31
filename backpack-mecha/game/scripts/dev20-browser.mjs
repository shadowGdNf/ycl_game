// Isolated browser profiles: exercise real mouse/touch events without touching the player's save.
import assert from 'node:assert/strict';
import {writeFile} from 'node:fs/promises';
const {chromium}=await import(process.env.PLAYWRIGHT_MODULE||'playwright');
const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH||'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'});
const url=process.env.MECHA_QA_URL||'http://localhost:4174/',checks=[],errors=[];
async function fixture(touch=false,leftHanded=false,position={x:800,y:650}){
 const context=await browser.newContext({viewport:touch?{width:390,height:844}:{width:1200,height:900},hasTouch:touch,isMobile:touch,deviceScaleFactor:1});
 const page=await context.newPage();page.setDefaultTimeout(10000);page.on('pageerror',error=>errors.push(String(error)));
 const ready=()=>page.waitForFunction(()=>document.querySelector('[data-action="new-run"]')?.disabled===false);
 await page.goto(url);await ready();
 await page.evaluate(async ({leftHanded,position})=>{
  const v=new URL(document.querySelector('script[type="module"]').src).search;
  const e=await import(`./js/economy.js${v}`),s=await import(`./js/storage.js${v}`),c=await import(`./js/combat.js${v}`);
  const run=e.newRun('scavenger','full',0,'DEV20-INPUT');e.startWave(run);
  const battle=c.createBattle(run);Object.assign(battle.player,position);battle.obstacles=[];battle.weapons=[];battle.encounter.nextSpawn=1000;
  const profile=s.freshProfile();profile.tutorial=true;profile.settings.music=false;profile.settings.sound=false;profile.settings.leftHanded=leftHanded;
  await s.saveGame({version:1,profile,run,battle,savedAt:Date.now()});
 },{leftHanded,position});
 await page.reload();await ready();
 await page.evaluate(async()=>{
  const v=new URL(document.querySelector('script[type="module"]').src).search;
  const {Renderer}=await import(`./js/renderer.js${v}`),draw=Renderer.prototype.draw;
  Renderer.prototype.draw=function(state,options){const result=draw.call(this,state,options),origin=this.toWorld(0,0),pixel=this.toWorld(1,1);window.inputQA={x:state.player.x,y:state.player.y,screenX:(state.player.x-origin.x)/(pixel.x-origin.x),screenY:(state.player.y-origin.y)/(pixel.y-origin.y),time:state.time,target:options.target??null};return result;};
 });
 await page.locator('[data-action="continue"]').click();await page.locator('[data-action="resume"]').click();
 await page.waitForFunction(()=>window.inputQA?.time>0);
 return {context,page};
}
const sample=page=>page.evaluate(()=>({...window.inputQA,joystick:getComputedStyle(document.getElementById('joystick')).display}));
async function after(page){const t=(await sample(page)).time;await page.waitForFunction(t=>window.inputQA.time>=t+.16,t);return sample(page);}
function samePosition(a,b){assert.equal(a.x,b.x);assert.equal(a.y,b.y);}
try{
 const {context,page}=await fixture();let start=await sample(page);
 // A press with no subsequent mouse movement must already walk toward the cursor.
 await page.mouse.move(start.screenX+200,start.screenY);await page.mouse.down();
 let right=await after(page);assert.ok(right.x>start.x);assert.equal(right.y,start.y);assert.equal(right.joystick,'none');
 // Moving the cursor slightly left still leaves it to the right of the rig: keep walking right.
 await page.mouse.move(start.screenX+190,start.screenY);let before=await sample(page),stillRight=await after(page);assert.ok(stillRight.x>before.x);
 await page.mouse.move(stillRight.screenX-160,stillRight.screenY);before=await sample(page);let left=await after(page);assert.ok(left.x<before.x);
 await page.mouse.move(left.screenX,left.screenY-150);before=await sample(page);let up=await after(page);assert.ok(up.y<before.y);
 await page.mouse.move(up.screenX,up.screenY+150);before=await sample(page);let down=await after(page);assert.ok(down.y>before.y);
 await page.mouse.move(down.screenX+150,down.screenY-150);before=await sample(page);let diagonal=await after(page);assert.ok(diagonal.x>before.x&&diagonal.y<before.y);
 assert.equal(diagonal.joystick,'none');await page.screenshot({path:'qa/dev20-mouse.png'});
 await page.mouse.move(diagonal.screenX,diagonal.screenY);let centered=await after(page);samePosition(centered,await after(page));
 await page.mouse.move(centered.screenX+100,centered.screenY);await after(page);await page.mouse.up();
 let stopped=await sample(page);samePosition(stopped,await after(page));
 checks.push({name:'press without dragging moves toward cursor; direction uses player position; center and release stop; no joystick',passed:true,start,right,stillRight,left,up,down,diagonal});
 await page.mouse.click(950,350,{button:'right'});let focused=await after(page);assert.ok(focused.target);samePosition(stopped,focused);
 await page.keyboard.down('KeyD');assert.ok((await after(page)).x>focused.x);await page.keyboard.up('KeyD');
 checks.push({name:'right-click focus and keyboard movement remain available',passed:true});
 await page.mouse.move(800,350);await page.mouse.down();await page.keyboard.press('KeyP');
 assert.equal((await sample(page)).joystick,'none');await page.mouse.up();await page.locator('[data-action="resume"]').click();
 stopped=await sample(page);samePosition(stopped,await after(page));
 checks.push({name:'pause clears held mouse movement',passed:true});await context.close();
 // At map edges the rig is off-center: screen center must not be used as the origin.
 for(const position of [{x:140,y:200},{x:1460,y:1100}]){
  const {context,page}=await fixture(false,false,position),start=await sample(page);
  const direction=position.x<800?1:-1;
  assert.ok(Math.abs(start.screenX-600)>250);
  // This cursor is toward the viewport center but left/right relative to the rig is unambiguous.
  await page.mouse.move(start.screenX+direction*70,start.screenY);await page.mouse.down();
  const moved=await after(page);assert.ok((moved.x-start.x)*direction>0);assert.ok(Math.abs(moved.y-start.y)<1);
  await page.mouse.up();const stopped=await sample(page);samePosition(stopped,await after(page));
  checks.push({name:'off-center rig follows cursor correctly with camera clamped at map edge',passed:true,start,moved});await context.close();
 }
 for(const leftHanded of [false,true]){
  const {context,page}=await fixture(true,leftHanded),cdp=await context.newCDPSession(page);
  const anchor=leftHanded?270:90,focusX=leftHanded?80:310;
  const touch=async(type,points)=>cdp.send('Input.dispatchTouchEvent',{type,touchPoints:points.map(([id,x,y])=>({id,x,y}))});
  await touch('touchStart',[[1,anchor,350]]);await touch('touchMove',[[1,anchor+42,350]]);
  let fullStart=await sample(page),moved=await after(page);assert.equal(moved.joystick,'block');
  const fullSpeed=(moved.x-fullStart.x)/(moved.time-fullStart.time);
  // Finger returns toward the anchor but remains right of it: retain rightward analog input.
  await touch('touchMove',[[1,anchor+21,350]]);let begin=await sample(page),held=await after(page);assert.ok(held.x>begin.x);assert.equal(held.y,begin.y);
  const analogSpeed=(held.x-begin.x)/(held.time-begin.time);assert.ok(Math.abs(analogSpeed/fullSpeed-.5)<.01,`Expected half speed: ${analogSpeed}/${fullSpeed}`);
  await touch('touchMove',[[1,anchor,350]]);stopped=await sample(page);samePosition(stopped,await after(page));
  await touch('touchMove',[[1,anchor-21,350]]);begin=await sample(page);assert.ok((await after(page)).x<begin.x);
  await touch('touchStart',[[1,anchor-21,350],[2,focusX,350]]);
  await page.waitForFunction(()=>window.inputQA.target!==null);assert.equal((await sample(page)).joystick,'block');
  // CDP touchEnd releases the whole gesture; update the active set to release only finger 2.
  await touch('touchMove',[[1,anchor-21,350]]);assert.equal((await sample(page)).joystick,'block');
  await page.screenshot({path:`qa/dev20-touch-${leftHanded?'left-handed':'default'}.png`});
  await touch('touchEnd',[]);stopped=await sample(page);assert.equal(stopped.joystick,'none');samePosition(stopped,await after(page));
  checks.push({name:`touch ${leftHanded?'left-handed':'default'}: visible anchored analog stick, center stops, reverse past center, second-finger focus, release stops`,passed:true,analogSpeed});
  await context.close();
 }
 assert.deepEqual(errors,[]);
 const report={version:'0.2.0-dev.20',checkedAt:new Date().toISOString(),checks,errors,note:'Desktop Chromium and emulated mobile touch input; not a physical-phone performance test.'};
 await writeFile('qa/dev20-input-browser.json',JSON.stringify(report,null,2)+'\n');console.log(JSON.stringify(report,null,2));
}finally{await browser.close();}
