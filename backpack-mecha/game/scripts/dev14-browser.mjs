// Isolated synthetic saves. These screenshots are choreography fixtures, not natural survival evidence.
import assert from 'node:assert/strict';
import {writeFile} from 'node:fs/promises';
const {chromium}=await import(process.env.PLAYWRIGHT_MODULE||'playwright');
const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH||'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'});
const url=process.env.MECHA_QA_URL||'http://localhost:4174/';
let context=await browser.newContext({viewport:{width:1200,height:900},deviceScaleFactor:1}),page=await context.newPage();
const errors=[],checks=[],screenshots=[],timings=[];page.on('pageerror',e=>errors.push(String(e)));
async function setup(boss,turn,advance=.35,reduced=false,lang='zh'){
 await page.goto(url);await page.waitForFunction(()=>document.querySelector('[data-action="new-run"]')?.disabled===false);
 const timing=await page.evaluate(async({boss,turn,advance,reduced,lang})=>{
  const v=new URL(document.querySelector('script[type="module"]').src).search;
  const {newRun}=await import(`./js/economy.js${v}`),{createBattle,stepBattle}=await import(`./js/combat.js${v}`),s=await import(`./js/storage.js${v}`);
  const r=newRun('bulwark','full',4,'DEV14-BROWSER');r.wave=Number(boss[1])*4;r.bosses[r.wave/4-1]=boss;r.items=[];r.phase='battle';
  const w=createBattle(r);w.bossClock=0;w.bossTurn=turn;w.player.invulnerable=1000;w.enemies.forEach(e=>{e.hp=e.maxHp*.2;});
  const start=performance.now();stepBattle(w,{x:0,y:0,dash:false,overload:false},advance);const elapsed=performance.now()-start;
  const profile=s.freshProfile();profile.tutorial=true;profile.language=lang;profile.settings.reducedMotion=reduced;profile.settings.sound=false;profile.settings.music=false;
  await s.saveGame({version:1,profile,run:r,battle:w,savedAt:Date.now()});return {boss,turn,frames:Math.round(advance*60),elapsed};
 },{boss,turn,advance,reduced,lang});timings.push(timing);
 await page.reload();await page.locator('[data-action="continue"]').click();await page.locator('#battle-screen').waitFor({state:'visible'});await page.locator('.boss-intent').waitFor();await page.locator('[data-action="resume"]').click();
}
async function capture(name){const file=`qa/dev14-${name}.png`;await page.screenshot({path:file});screenshots.push(file);}
try{
 for(const [boss,turn,label] of [['B1A',1,'碾压夹击'],['B1B',3,'双臂绞索'],['B2A',3,'熔墙逼位'],['B2B',5,'夹击电网'],['B3A',3,'震环点名'],['B3B',1,'棋盘接力']]){
  await setup(boss,turn);assert.ok((await page.locator('.boss-intent').innerText()).includes(label));await capture(boss);checks.push(`${boss}: live combo title and two-beat telegraphs`);
 }
 await setup('B3A',3,1.8);await capture('ring-active');checks.push('growing ring gap and mortar follow-ups');
 await setup('B2B',1,2.2);await page.waitForFunction(()=>document.querySelector('.boss-intent')?.classList.contains('recovering'));await capture('counter-window');checks.push('recovery prompt in live HUD');
 await context.close();context=await browser.newContext({viewport:{width:390,height:844},hasTouch:true,isMobile:true,deviceScaleFactor:1,reducedMotion:'reduce'});page=await context.newPage();page.on('pageerror',e=>errors.push(String(e)));
 await setup('B3A',3,.6,true);await capture('mobile-ring');
 const layout=await page.evaluate(()=>{const b=document.querySelector('.boss-intent').getBoundingClientRect();return {left:b.left,right:b.right,bottom:b.bottom,width:innerWidth,scroll:document.documentElement.scrollWidth};});assert.ok(layout.left>=0&&layout.right<=390);assert.equal(layout.width,layout.scroll);assert.ok(layout.bottom<844/3);checks.push('390x844 reduced-motion touch HUD fits');
 await page.locator('#pause-button').tap();await page.waitForTimeout(100);assert.ok(await page.locator('#modal').isVisible());checks.push('touch pause remains available');
 await page.setViewportSize({width:844,height:390});await setup('B2B',5,.4,true,'en');await capture('mobile-landscape-en');
 const english=await page.locator('.boss-intent').innerText();assert.ok(english.includes('Pincer grid'));const box=await page.locator('.boss-intent').boundingBox();assert.ok(box.y+box.height<130);checks.push('844x390 English combo HUD and reduced-motion telegraphs');
 await page.setViewportSize({width:320,height:740});await setup('B3B',1,.4,true);const narrow=await page.locator('.boss-intent').boundingBox();assert.ok(narrow.x>=0&&narrow.x+narrow.width<=320);await capture('mobile-narrow');checks.push('320px narrow HUD fits');
 assert.deepEqual(errors,[]);
 await writeFile('qa/dev14-browser.json',JSON.stringify({browser:await browser.version(),checks,screenshots,timings,layout,errors,limits:['Explicitly invulnerable fixtures for visual QA only.','Isolated Chrome desktop and emulated touch viewports; not physical-device validation.']},null,2)+'\n');console.log(JSON.stringify({checks,errors,timings},null,2));
}finally{await context.close();await browser.close();}
