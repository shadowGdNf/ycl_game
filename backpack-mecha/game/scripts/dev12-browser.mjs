// Local browser QA; an isolated context never touches the player's saved campaign.
import assert from 'node:assert/strict';
import {readFile,writeFile} from 'node:fs/promises';
const {chromium}=await import(process.env.PLAYWRIGHT_MODULE||'playwright');
const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH||'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'});
const context=await browser.newContext({viewport:{width:1200,height:900},deviceScaleFactor:1});
const page=await context.newPage(),errors=[],captures=[],performance=[];
const smokeOnly=process.argv.includes('--smoke-only');
const skipPerformance=smokeOnly||process.argv.includes('--screenshots-only');
page.on('pageerror',e=>errors.push(String(e)));
try{
 for(const baseline of (smokeOnly?[]:[true,false])){
  await page.goto(`http://localhost:4202/${baseline?'?baseline':''}`);
  await page.locator('#status').filter({hasText:'规则'}).waitFor();
  const scenes=baseline?['B3B-impact']:['B3B-impact','B1A-slam','B1A-charge','B1B-pull','B3A-ring','B3A-beam','B2A-fire'];
  for(const scene of scenes){
   await page.locator('#scene').selectOption(scene);
   await page.waitForFunction(()=>document.querySelector('#status').textContent.includes('暂停'));
   // Allow a paint after the synchronous fixture reset.
   await page.evaluate(()=>new Promise(resolve=>requestAnimationFrame(()=>requestAnimationFrame(resolve))));
   const file=`qa/dev12-${scene}${baseline?'-before':''}.png`;
   await page.screenshot({path:file});captures.push({scene,baseline,file,status:await page.locator('#status').innerText()});
   if(!baseline&&scene==='B3B-impact'){
    await page.locator('#reduced').check();await page.locator('#assist').check();
    await page.screenshot({path:'qa/dev12-impact-reduced.png'});
    await page.locator('#reduced').uncheck();await page.locator('#assist').uncheck();
   }
  }
  for(const scene of (skipPerformance?[]:['B3B-pressure','dense'])){
   await page.locator('#scene').selectOption(scene);await page.locator('#benchmark').click();
   await page.waitForFunction(()=>document.querySelector('#report').textContent.startsWith('{'),{},{timeout:18000});
   const report=JSON.parse(await page.locator('#report').innerText());
   assert.ok(report.render.samples>300);assert.equal(report.battleStatus,'playing');assert.ok(report.battleSeconds>10);
   performance.push({baseline,...report});console.log(`${baseline?'before':'after'} ${scene} render p95 ${report.render.p95.toFixed(2)}ms`);
  }
 }
 // Open the normal product, exercise its real training form, then reload.
 await page.goto('http://localhost:4202/game/');await page.locator('#app').waitFor();
 await page.locator('[data-action="practice"]').click();
 await page.locator('[data-practice="boss"]').selectOption('B3B');
 await page.locator('[data-action="practice-clear"]').click();
 await page.locator('[data-action="practice-module"][data-id="W01"]').click();
 await page.locator('[data-action="practice-start"]').click();
 await page.locator('#battle-screen').waitFor({state:'visible'});
 await page.waitForFunction(()=>document.querySelector('.boss-hud')?.textContent.includes('6240'));
 await page.waitForFunction(()=>document.querySelector('.battle-timer strong')?.textContent==='00:04',{},{timeout:10000});
 const hitHud=await page.locator('.player-hud').innerText();assert.match(hitHud,/84 \/ 100/);
 await page.locator('#skill-button').click();await page.waitForFunction(()=>document.querySelector('.player-hud')?.textContent.includes('90 / 100'));
 await page.locator('#pause-button').click();const pausedTime=await page.locator('.battle-timer strong').innerText();
 await page.waitForTimeout(250);assert.equal(await page.locator('.battle-timer strong').innerText(),pausedTime);
 await page.locator('[data-action="resume"]').click();
 await page.setViewportSize({width:390,height:844});await page.screenshot({path:'qa/dev12-practice-mobile.png'});
 const productSmoke={boss:'B3B',bossMaxHp:6240,afterBombardment:hitHud,afterSkill:await page.locator('.player-hud').innerText(),pausePreserved:true,mobileViewport:[390,844]};
 await page.reload();await page.locator('[data-action="practice"]').waitFor();
 const productText=await page.locator('body').innerText();assert.match(await page.locator('.edition').textContent(),/dev\.12/);
 assert.equal(errors.length,0,errors.join('\n'));
 const previous=skipPerformance?JSON.parse(await readFile('qa/dev12-browser.json','utf8')):{};
 await writeFile('qa/dev12-browser.json',JSON.stringify({...previous,checkedAt:new Date().toISOString(),browser:await browser.version(),headless:true,viewport:{width:1200,height:900},captures:smokeOnly?previous.captures:captures,performance:skipPerformance?previous.performance:performance,errors,productText,productSmoke,
  limits:['Headless desktop Chrome synthetic fixtures; not physical-phone FPS or human playtesting.','Attack scenes use explicit invulnerability; dense scene uses 10000 HP to sustain rendering.','Audio routing is covered by unit tests; no human listening assessment.']},null,2)+'\n');
 console.log('Browser QA passed, screenshots and timings saved.');
}finally{await context.close();await browser.close();}
