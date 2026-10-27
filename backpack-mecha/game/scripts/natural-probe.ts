import assert from 'node:assert/strict';
import {readFileSync,writeFileSync,mkdirSync} from 'node:fs';
import {createHash} from 'node:crypto';
import {gzipSync} from 'node:zlib';
import {newRun,startWave,resolveBattle} from '../src/economy.ts';
import {createBattle,stepBattle,battleResult} from '../src/combat.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
import {exportRunReport} from '../src/journal.ts';
import {FAMILIES,prepare,pilotBuild} from './natural-policy.ts';
import {decide,createPilotMemory} from './probe-pilot.ts';

const arg=(name:string)=>process.argv.find(a=>a.startsWith(`--${name}=`))?.split('=')[1];
const count=Number(arg('seeds')??10);
assert.ok(Number.isInteger(count)&&count>=1&&count<=20,'--seeds must be an integer from 1 to 20');
const families=arg('family')?FAMILIES.filter(f=>f.id===arg('family')):FAMILIES;
assert.ok(families.length,'Unknown family');
const sourcePaths=['src/combat.ts','src/encounters.ts','src/economy.ts','src/content.ts','src/types.ts','src/random.ts','src/journal.ts','src/storage.ts','src/version.ts','assets/content.json','scripts/natural-policy.ts','scripts/probe-pilot.ts','scripts/natural-probe.ts'];
const hashes=()=>Object.fromEntries(sourcePaths.map(path=>[path,createHash('sha256').update(readFileSync(new URL(`../${path}`,import.meta.url))).digest('hex')]));
const before=hashes(),started=new Date().toISOString(),results=[];
for(const family of families)for(let index=0;index<count;index++){
 let run=newRun('scavenger','full',0,`natural-v02-${String(index+1).padStart(2,'0')}`);
 const attained:number[]=[],anomalies:string[]=[];let resumedWaves=0,verifiedResume=false;
 while(run.phase!=='won'&&run.phase!=='lost'){
  prepare(run,family);
  if(family.core.every(id=>run.items.some(i=>i.id===id&&!i.stored)))attained.push(run.wave);
  assert.equal(startWave(run).ok,true);let world=createBattle(run);
  const memory=createPilotMemory(index),build=pilotBuild(run,family);let input=memory.lastInput,shadow:typeof world|undefined;
  for(let tick=0;tick<60*301&&world.status==='playing';tick++){
   if(tick===600){
    const save=sanitizeSave(JSON.parse(JSON.stringify({version:1,profile:freshProfile(),run,battle:world,savedAt:1})));
    assert.equal(save.run?.phase,'battle');assert.ok(save.battle);assert.deepEqual(save.battle,JSON.parse(JSON.stringify(world)));
    shadow=world;world=save.battle as typeof world;run=save.run!;resumedWaves++;
   }
   if(tick%6===0)input=decide(world,build,memory);
   stepBattle(world,input,1/60);
   if(shadow){stepBattle(shadow,input,1/60);if(tick>=720||world.status!=='playing'){assert.deepEqual(JSON.parse(JSON.stringify(world)),JSON.parse(JSON.stringify(shadow)));shadow=undefined;verifiedResume=true;}}
  }
  if(world.status==='playing')throw Error('Simulation did not reach a terminal result');
  if(!Number.isFinite(world.player.hp)||world.time>=299.9)anomalies.push(`wave ${run.wave}: timeout or non-finite state`);
  assert.equal(resolveBattle(run,battleResult(world)).ok,true);
 }
 const report=exportRunReport(run);
 results.push({family:family.id,name:family.name,core:family.core,attainedAtWaves:attained,resumedWaves,verifiedResume,anomalies,...report});
 console.log(`${family.id} / ${run.seed}: ${run.phase}, wave ${run.wave}, ${run.elapsed.toFixed(1)}s combat, core ${attained[0]??'not attained'}, resume ${resumedWaves}`);
}
assert.deepEqual(hashes(),before,'Source changed while the probe ran');
const summaries=families.map(f=>{const group=results.filter(r=>r.family===f.id);return {family:f.id,name:f.name,runs:group.length,wins:group.filter(r=>r.status==='won').length,coreAttainedRuns:group.filter(r=>r.attainedAtWaves.length).length,coreOfferedRuns:group.filter(r=>{const seen=new Set(r.journal.events.flatMap(e=>[...e.shop.map(o=>o.id),...e.rewardOptions,...e.items.map(i=>i.id)]));return f.core.every(id=>seen.has(id));}).length,meanBattleSeconds:group.reduce((n,r)=>n+r.battleSeconds,0)/group.length,failedWaves:group.filter(r=>r.status==='lost').map(r=>r.wave),resumeChecks:group.reduce((n,r)=>n+r.resumedWaves,0),anomalies:group.flatMap(r=>r.anomalies)};});
const output={probe:'natural-shop-growth-v1',started,finished:new Date().toISOString(),sourceHashes:before,seedsPerFamily:count,
 limitations:['Machine policy outcomes are not human win rates, retention or device performance.','Fresh scavenger, difficulty 0; only normal routes; events skipped; no prior unlocks.','Only normal game APIs buy, equip, sell, upgrade, repair, collect rewards and advance waves. No granted equipment, currency, HP or forced victories.','At most two paid rerolls per shop; a deterministic, bounded policy may miss valid packing, transitions or purchases.','Each family expresses an equipment preference; missing cores remain missing and every failed run is retained.','Combat uses fixed 1/60 steps and a visible-state pilot at 10 Hz. Its accurate geometric avoidance is stronger than typical human play.','No rendering or human preparation delays: combat time excludes real browsing and decision time.','Every battle lasting ten seconds is saved/restored through production validation, then compared with an uninterrupted branch for up to two seconds.','The seed reproduces RNG under the same rules and choices; the report is not a full input replay or importable save.'],summaries,results};
mkdirSync(new URL('../qa/',import.meta.url),{recursive:true});
const outputName=arg('output')??(count===10&&families.length===6?'natural-probe.json':'natural-probe-smoke.json');
assert.match(outputName,/^[a-zA-Z0-9._-]+\.json$/,'--output must be a JSON filename');
const rawName=outputName.replace(/\.json$/, '-runs.json.gz');
writeFileSync(new URL(`../qa/${rawName}`,import.meta.url),gzipSync(JSON.stringify(output),{level:9}));
const summary={...output,rawRuns:rawName,results:results.map(({journal,history,...run})=>({...run,journal:{...journal,events:undefined}}))};
writeFileSync(new URL(`../qa/${outputName}`,import.meta.url),JSON.stringify(summary,null,2)+'\n');
console.log(`Saved ${results.length} natural runs to qa/${outputName}`);
