// Synthetic isolated saves only; never opens the player's browser profile.
import assert from 'node:assert/strict';
import {writeFile} from 'node:fs/promises';
const {chromium}=await import(process.env.PLAYWRIGHT_MODULE||'playwright');
const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH||'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'});
const context=await browser.newContext({viewport:{width:1200,height:900},deviceScaleFactor:1});
const page=await context.newPage(),errors=[],checks=[],screenshots=[];
page.on('pageerror',e=>errors.push(String(e)));
const url=process.env.MECHA_QA_URL||'http://localhost:4174/';
const snapshot=()=>page.locator('#backpack-canvas').evaluate(c=>c.toDataURL());
async function fixture(reduced=false){
 await page.goto(url);await page.waitForFunction(()=>document.querySelector('[data-action="new-run"]')?.disabled===false);
 await page.evaluate(async reduced=>{
  const v=new URL(document.querySelector('script[type="module"]').src).search;
  const {newRun}=await import(`./js/economy.js${v}`),s=await import(`./js/storage.js${v}`);
  const r=newRun('scavenger','full',0,'DEV15-MOTION');r.wave=2;
  const profile=s.freshProfile();profile.tutorial=true;profile.settings.sound=false;profile.settings.music=false;profile.settings.reducedMotion=reduced;
  await s.saveGame({version:1,profile,run:r,battle:null,savedAt:Date.now()});
 },reduced);
 await page.reload();await page.locator('[data-action="continue"]').click();await page.locator('#backpack-canvas').waitFor();await page.waitForTimeout(400);
}
async function capture(name,selector){const file=`qa/dev15-${name}.png`;await (selector?page.locator(selector):page).screenshot({path:file});screenshots.push(file);}
try{
 await fixture();const before=await snapshot();await page.waitForTimeout(200);assert.notEqual(await snapshot(),before);checks.push('active connections carry animated energy while the board is idle');
 await capture('workshop');
 await page.locator('#settings-button').click();await page.locator('[data-setting="reducedMotion"]').check();await page.locator('#modal [data-action="close"]').click();
 const switched=await snapshot();await page.waitForTimeout(180);assert.equal(await snapshot(),switched);checks.push('changing reduced motion settles the workshop immediately');
 await page.locator('#settings-button').click();await page.locator('[data-setting="reducedMotion"]').uncheck();await page.locator('#modal [data-action="close"]').click();
 const board=await page.locator('#backpack-canvas').boundingBox(),at=(x,y)=>({x:board.x+(x+.5)*board.width/5,y:board.y+(y+.5)*board.height/5});
 const from=at(1,0),to=at(2,2);await page.mouse.move(from.x,from.y);await page.mouse.down();await page.mouse.move(to.x,to.y,{steps:10});await capture('drag');await page.mouse.up();
 const landing=await snapshot();await page.waitForTimeout(170);assert.notEqual(await snapshot(),landing);checks.push('drag ghost and placement transition render after release');
 await page.waitForTimeout(300);await capture('placed');
 await page.locator('[data-action="undo-edit"]').click();await page.waitForTimeout(400);checks.push('animated placement remains undoable');
 await page.locator('[data-action="deploy"]').click();if(await page.locator('[data-action="deploy-confirm"]').isVisible())await page.locator('[data-action="deploy-confirm"]').click();await page.locator('#battle-screen').waitFor({state:'visible'});await page.waitForTimeout(300);
 await page.keyboard.down('KeyD');await page.waitForTimeout(400);await page.keyboard.up('KeyD');await page.keyboard.press('Space');await page.waitForTimeout(70);await capture('dash');
 await page.locator('#pause-button').click();await page.waitForTimeout(150);
 const paused=await page.locator('#battle-canvas').evaluate(c=>c.toDataURL());await page.waitForTimeout(220);assert.equal(await page.locator('#battle-canvas').evaluate(c=>c.toDataURL()),paused);checks.push('walk and dash render; paused combat remains pixel-stable');
 await fixture(true);const reduced=await snapshot();await page.waitForTimeout(200);assert.equal(await snapshot(),reduced);checks.push('reduced-motion connection display remains pixel-stable');
 await page.setViewportSize({width:390,height:844});await fixture(false);await capture('workshop-mobile');
 const layout=await page.evaluate(()=>({width:innerWidth,scrollWidth:document.documentElement.scrollWidth,bottom:document.querySelector('.workshop-deploy').getBoundingClientRect().bottom}));
 assert.equal(layout.width,layout.scrollWidth);assert.ok(layout.bottom<=844);checks.push('390 × 844 workbench fits');

 // Draw real simulation snapshots in an independent canvas, sampling all attacks.
 await page.setViewportSize({width:1200,height:900});await page.goto(url);await page.waitForFunction(()=>document.querySelector('[data-action="new-run"]')?.disabled===false);
 const scenes=await page.evaluate(async()=>{
  const v=new URL(document.querySelector('script[type="module"]').src).search;
  const {Renderer}=await import(`./js/renderer.js${v}`),{newRun}=await import(`./js/economy.js${v}`),{createBattle,stepBattle,spawnEnemy}=await import(`./js/combat.js${v}`);
  const {ENEMIES,MODULES}=await import(`./js/content.js${v}`);
  const canvas=document.createElement('canvas');canvas.id='motion-fixture';canvas.style.cssText='position:fixed;inset:50px auto auto 230px;width:720px;height:720px;z-index:999;background:#101b24';document.body.append(canvas);
  const renderer=new Renderer(canvas);await renderer.load();const options={lang:'zh',reducedMotion:false,colorAssist:false};
  const cases=[],times=[];
  function simulate(id,enemyId='E03'){
   const r=newRun('scavenger','full',0,'DEV15-'+id+enemyId);r.items=[{uid:'gun',id,tier:1,x:1,y:1,rotation:0,stored:false}];
   const w=createBattle(r);w.enemies=[];w.obstacles=[];w.encounter.nextSpawn=1000;w.player.invulnerable=1000;
   const enemy=spawnEnemy(w,{id:enemyId,x:w.player.x+90,y:w.player.y,elite:false,affix:0,reward:false,cost:0});enemy.hp=enemy.maxHp=100000;
   for(let tick=0;tick<150;tick++){
    stepBattle(w,{x:Math.sin(tick/30)*.25,y:Math.cos(tick/30)*.25,dash:false,overload:false},1/60);
    const before=JSON.stringify(w),start=performance.now();renderer.draw(w,options);times.push(performance.now()-start);
    if(JSON.stringify(w)!==before)throw Error('Renderer mutated simulation: '+id+'/'+enemyId);
   }
   cases.push({weapon:id,enemy:enemyId,shots:w.weapons[0].shotCount});return w;
  }
  for(const weapon of MODULES.filter(m=>m.kind==='weapon'))simulate(weapon.id);
  for(const enemy of ENEMIES)simulate('W13',enemy.id);
  const w=simulate('W08','E03');cases.pop();w.events.push({id:99999,type:'fire',at:w.time-.1,x:w.player.x,y:w.player.y,source:'W08',angle:0,radius:110});
  w.weapons[0].shotCount++;renderer.draw(w,options);
  const before=JSON.stringify(w);renderer.draw(w,{...options,reducedMotion:true});if(JSON.stringify(w)!==before)throw Error('Reduced renderer mutated simulation');
  renderer.draw(w,options);
  times.sort((a,b)=>a-b);return {cases,renderSamples:times.length,renderMs:{p50:times[Math.floor(times.length*.5)],p95:times[Math.floor(times.length*.95)]}};
 });
 assert.equal(scenes.cases.length,34);await capture('combat-fixture','#motion-fixture');checks.push('18 weapons and 16 enemies render without mutating any simulation field');
 assert.deepEqual(errors,[]);
 await writeFile('qa/dev15-browser.json',JSON.stringify({browser:await browser.version(),checks,layout,scenes,screenshots,errors,limits:['Isolated desktop Chrome with synthetic states; phone dimensions are not physical-device testing.','Render timings are synchronous fixture samples, not live frame rate.']},null,2)+'\n');
 console.log(JSON.stringify({checks,layout,renderSamples:scenes.renderSamples,renderMs:scenes.renderMs,errors},null,2));
}finally{await context.close();await browser.close();}
