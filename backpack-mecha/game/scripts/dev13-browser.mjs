// Isolated browser context: only synthetic saves, no access to the player's profile.
import assert from 'node:assert/strict';
import {writeFile} from 'node:fs/promises';
const {chromium}=await import(process.env.PLAYWRIGHT_MODULE||'playwright');
const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH||'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'});
let context=await browser.newContext({viewport:{width:1200,height:900},deviceScaleFactor:1});
let page=await context.newPage(),touch=false;const errors=[],checks=[],screenshots=[];
page.on('pageerror',e=>errors.push(String(e)));
const url=process.env.MECHA_QA_URL||'http://localhost:4203/';
async function fixture(mode='swap',chassis='scavenger'){
 await page.goto(url);await page.waitForFunction(()=>document.querySelector('[data-action="new-run"]')?.disabled===false);
 await page.evaluate(async({mode,chassis})=>{
  const v=new URL(document.querySelector('script[type="module"]').src).search;
  const econ=await import(`./js/economy.js${v}`),storage=await import(`./js/storage.js${v}`),growth=await import(`./js/progression.js${v}`);
  const r=econ.newRun(chassis,'full',0,'DEV13-BROWSER');r.wave=3;r.power=24;r.unlockedCorners=[0,1,2,3];r.gold=500;r.nextUid=100;
  r.shop=['W13','W14','W17','W18'].map(id=>({id,locked:false,tier:2}));
  const item=(id,x,y,stored=false)=>({uid:id,id,x,y,stored,rotation:0,tier:1});
  if(mode==='narrow'){
   r.power=99;r.items=['S01','S03','S06','S08','S09','S11','U03','U06','U07','U10'].map((id,n)=>item(id,n%2*2,Math.floor(n/2)));
   r.items.push(item('S02',4,0),item('S05',4,3),item('S07',4,4),item('W01',-1,-1,true));
  }else{
   r.items=[item('W01',1,0),item('W03',1,2),item('S01',1,1),item('W16',-1,-1,true),item('W18',-1,-1,true),item('U02',-1,-1,true)];
   for(let i=0;i<3;i++)growth.awardExperience(r,30);
  }
  const profile=storage.freshProfile();profile.tutorial=true;profile.settings.unlockAll=true;
  await storage.saveGame({version:1,profile,run:r,battle:null,savedAt:Date.now()});
 },{mode,chassis});
 await page.reload();await page.locator('[data-action="continue"]').click();await page.locator('#backpack-canvas').waitFor();
}
async function saved(){return page.evaluate(async()=>{const v=new URL(document.querySelector('script[type="module"]').src).search;return (await (await import(`./js/storage.js${v}`)).loadSave()).run;});}
async function until(predicate,message){for(let n=0;n<40;n++){const r=await saved();if(predicate(r))return r;await page.waitForTimeout(50);}assert.fail(message);}
async function cell(x,y){const b=await page.locator('#backpack-canvas').boundingBox();return {x:b.x+(x+.5)*b.width/5,y:b.y+(y+.5)*b.height/5};}
async function clickCell(x,y){const p=await cell(x,y);if(touch)await page.touchscreen.tap(p.x,p.y);else await page.mouse.click(p.x,p.y);}
async function drag(from,to){if(touch){const cdp=await context.newCDPSession(page);await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[{x:from.x,y:from.y}]});for(let i=1;i<=12;i++)await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:[{x:from.x+(to.x-from.x)*i/12,y:from.y+(to.y-from.y)*i/12}]});await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});await cdp.detach();return;}await page.mouse.move(from.x,from.y);await page.mouse.down();await page.mouse.move(to.x,to.y,{steps:12});await page.mouse.up();}
async function capture(name){const file=`qa/dev13-${name}.png`;await page.screenshot({path:file});screenshots.push(file);}
try{
 await fixture();
 await page.locator('.rack-slot[data-uid="W16"]').click();await clickCell(1,0);
 await until(r=>r.items.find(i=>i.id==='W01').stored&&!r.items.find(i=>i.id==='W16').stored,'full reserve swap');checks.push('full-reserve tap swap');
 await page.locator('[data-action="undo-edit"]').click();await until(r=>!r.items.find(i=>i.id==='W01').stored,'undo swap');
 await clickCell(1,0);await clickCell(2,2);await until(r=>r.items.find(i=>i.id==='W01').y===2&&r.items.find(i=>i.id==='W03').y===0,'board swap');checks.push('board tap swap and undo');
 await drag(await cell(1,0),await cell(3,3));await until(r=>r.items.find(i=>i.id==='W03').x===3&&r.items.find(i=>i.id==='W03').y===3,'drag move');checks.push('board drag movement');
 await page.locator('.rack-slot[data-uid="U02"]').click();await page.locator('[data-action="sell"]').click();await until(r=>!r.items.some(i=>i.id==='U02'),'reserve sell');
 const slot=await page.locator('.rack-slot:not(.filled)').boundingBox();await drag(await cell(3,3),{x:slot.x+slot.width/2,y:slot.y+slot.height/2});await until(r=>r.items.find(i=>i.id==='W03').stored,'drag to reserve');checks.push('drag to reserve');
 await page.locator('[data-action="undo-edit"]').click();await until(r=>!r.items.find(i=>i.id==='W03').stored,'undo store');
 await page.locator('[data-action="chassis-growth"]').click();await capture('growth-desktop');const before=await saved();await page.locator('[data-action="upgrade-chassis"][data-id="hp"]').click();await until(r=>r.growth.choices.hp===before.growth.choices.hp+1&&r.hp>before.hp,'allocate HP');
 await page.locator('#modal [data-action="close"]').click();await page.reload();await page.locator('[data-action="continue"]').click();assert.equal((await saved()).growth.choices.hp,1);checks.push('growth allocation and reload');await capture('workshop-desktop');
 await fixture('narrow');await page.locator('.rack-slot[data-uid="W01"]').click();await clickCell(4,1);await until(r=>!r.items.find(i=>i.id==='W01').stored&&r.items.find(i=>i.id==='W01').rotation===1,'auto rotate');checks.push('horizontal weapon auto rotates into vertical-only gap');
 await page.locator('[data-action="undo-edit"]').click();await page.locator('[data-action="equip"]').first().click();await until(r=>!r.items.find(i=>i.id==='W01').stored,'auto equip');checks.push('one-button auto equip');
 await context.close();context=await browser.newContext({viewport:{width:390,height:844},deviceScaleFactor:1,hasTouch:true,isMobile:true});page=await context.newPage();page.on('pageerror',e=>errors.push(String(e)));touch=true;await fixture('swap','kestrel');await capture('workshop-mobile');
 const geometry=await page.evaluate(()=>{const board=document.querySelector('#backpack-canvas').getBoundingClientRect(),footer=document.querySelector('.workshop-deploy').getBoundingClientRect(),quick=document.querySelector('.quick-equip').getBoundingClientRect();return {board:{x:board.x,y:board.y,w:board.width,h:board.height},footerBottom:footer.bottom,quickBottom:quick.bottom,width:document.documentElement.scrollWidth,viewport:innerWidth};});
 assert.equal(geometry.width,geometry.viewport);assert.ok(geometry.board.w>=140);assert.ok(geometry.footerBottom<=844);assert.ok(Math.abs(geometry.board.w-geometry.board.h)<2,JSON.stringify(geometry));
 await page.locator('.rack-slot[data-uid="W16"]').tap();await clickCell(2,0);await until(r=>!r.items.find(i=>i.id==='W16').stored,'mobile swap');await drag(await cell(1,2),await cell(3,3));await until(r=>r.items.find(i=>i.id==='W03').x===3,'touch drag');checks.push('touch tap on non-origin cell and touch drag');checks.push('390x844 board and controls');
 await page.locator('[data-action="chassis-growth"]').click();await capture('growth-mobile');await page.locator('[data-action="upgrade-chassis"][data-id="speed"]').click();await page.locator('#modal [data-action="close"]').click();
 await page.locator('[data-action="deploy"]').click();const confirm=page.locator('[data-action="deploy-confirm"]');if(await confirm.isVisible())await confirm.click();await page.locator('#battle-screen').waitFor({state:'visible'});await page.waitForTimeout(1000);assert.match(await page.locator('.player-hud').innerText(),/Lv\./);await page.locator('#pause-button').click();await capture('battle-mobile');checks.push('upgraded loadout enters combat');
 await page.goto(url);await page.locator('[data-action="practice"]').click();await page.locator('[data-action="practice-clear"]').click();
 for(const id of ['W14','W15','W18'])await page.locator(`[data-action="practice-module"][data-id="${id}"]`).click();await page.locator('[data-action="practice-start"]').click();await page.locator('#battle-screen').waitFor({state:'visible'});await page.waitForTimeout(1700);await page.locator('#pause-button').click();checks.push('new weapons selectable and rendered in boss lab');
 await fixture('narrow');await page.locator('.rack-slot[data-uid="W01"]').tap();await drag(await page.locator('.rack-slot[data-uid="W01"]').evaluate(el=>{const b=el.getBoundingClientRect();return {x:b.x+b.width/2,y:b.y+b.height/2};}),await cell(4,1));await until(r=>!r.items.find(i=>i.id==='W01').stored,'touch reserve drag auto-rotates');await capture('narrow-touch');checks.push('touch drag from reserve auto-rotates into two-cell column');
 for(const viewport of [{width:320,height:740},{width:844,height:390}]){await page.setViewportSize(viewport);await fixture();const layout=await page.evaluate(()=>({width:document.documentElement.scrollWidth,viewport:innerWidth,bodyOverflow:getComputedStyle(document.body).overflow,footer:document.querySelector('.workshop-deploy').getBoundingClientRect().bottom,screen:innerHeight}));assert.equal(layout.width,layout.viewport);assert.ok(layout.footer<=layout.screen||layout.bodyOverflow==='auto',JSON.stringify(layout));checks.push(`${viewport.width}x${viewport.height} layout`);}
 assert.deepEqual(errors,[]);
 await writeFile('qa/dev13-browser.json',JSON.stringify({browser:await browser.version(),checks,geometry,screenshots,errors,limits:['Synthetic isolated desktop Chrome; mobile dimensions are not physical-device validation.']},null,2)+'\n');console.log(JSON.stringify({checks,geometry,errors},null,2));
}finally{await context.close();await browser.close();}
