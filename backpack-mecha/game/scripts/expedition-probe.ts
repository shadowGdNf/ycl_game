import assert from 'node:assert/strict';
import {readFileSync,writeFileSync,mkdirSync} from 'node:fs';
import {createHash} from 'node:crypto';
import {gzipSync,gunzipSync} from 'node:zlib';
import {BUILD_VERSION,RULESET_VERSION} from '../src/version.ts';
import {newRun,startWave,resolveBattle} from '../src/economy.ts';
import {createBattle,stepBattle,battleResult} from '../src/combat.ts';
import type {BattleState} from '../src/combat.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
import {exportRunReport} from '../src/journal.ts';
import {FAMILIES,prepare,pilotBuild} from './natural-policy.ts';
import {INPUT_MODELS,createInputDriver} from './input-models.ts';
import type {InputModel} from './input-models.ts';
import {resolvePreferredEvent,chooseRiskRoute} from './expedition-policy.ts';
import type {EventPreference,BranchRecord} from './expedition-policy.ts';
import {createGrowthDiagnostics} from './growth-diagnostics.ts';

const arg=(name:string)=>process.argv.find(a=>a.startsWith(`--${name}=`))?.slice(name.length+3);
const count=Number(arg('seeds')??10),suite=arg('suite')??'all';
assert.ok(Number.isInteger(count)&&count>=1&&count<=10,'--seeds must be 1..10');
assert.ok(['all','calibration','matrix'].includes(suite),'--suite must be all, calibration or matrix');
const models=arg('model')?[arg('model') as InputModel]:Object.keys(INPUT_MODELS) as InputModel[];
assert.ok(models.every(m=>m in INPUT_MODELS),'Unknown input model');
const sourcePaths=['src/combat.ts','src/encounters.ts','src/economy.ts','src/content.ts','src/types.ts','src/random.ts','src/journal.ts','src/performance.ts','src/storage.ts','src/version.ts','assets/content.json',
 'scripts/natural-policy.ts','scripts/purchase-search.ts','scripts/growth-diagnostics.ts','scripts/probe-pilot.ts','scripts/input-models.ts','scripts/expedition-policy.ts','scripts/expedition-probe.ts'];
const hashes=()=>Object.fromEntries(sourcePaths.map(p=>[p,createHash('sha256').update(readFileSync(new URL(`../${p}`,import.meta.url))).digest('hex')]));
const sourceHashes=hashes(),started=new Date().toISOString();
type Case={id:string;suite:'calibration'|'matrix';family:string;seedIndex:number;chassis:string;difficulty:number;route:0|1|2;events:EventPreference};
const cases:Case[]=[];
if(suite!=='matrix')for(const family of FAMILIES)for(let n=1;n<=count;n++)cases.push({id:`calibration-${family.id}-${n}`,suite:'calibration',family:family.id,seedIndex:n,chassis:'scavenger',difficulty:0,route:0,events:'skip'});
if(suite!=='calibration')for(const [i,chassis] of ['scavenger','bulwark','kestrel','hive'].entries())for(const [j,difficulty] of [0,2,4].entries())
 cases.push({id:`matrix-${chassis}-${difficulty}`,suite:'matrix',family:FAMILIES[(i*3+j)%6].id,seedIndex:i*3+j+1,chassis,difficulty,route:j as 0|1|2,events:i%2===0?'first':'second'});
const historical=JSON.parse(gunzipSync(readFileSync(new URL('../qa/natural-probe-dev4-legacy-runs.json.gz',import.meta.url))).toString());
const historicalProjection=(report:Record<string,any>)=>{const copy=structuredClone(report);delete copy.buildVersion;delete copy.journal.buildVersion;return copy;};
const results=[];let baselineMatches=0;
for(const scenario of cases)for(const model of models){
 const family=FAMILIES.find(f=>f.id===scenario.family)!,seed=`natural-v02-${String(scenario.seedIndex).padStart(2,'0')}`;
 let run=newRun(scenario.chassis,'full',scenario.difficulty,seed);
 const diagnostic=createGrowthDiagnostics(family),branches:BranchRecord[]=[],attainedAtWaves:number[]=[],inputs=[];
 let resumedWaves=0,verifiedResume=false;
 while(run.phase!=='won'&&run.phase!=='lost'){
  prepare(run,family,{policy:'legacy',onDecision:diagnostic.observe,onEvent:r=>resolvePreferredEvent(r,family,scenario.events,branches)});
  chooseRiskRoute(run,scenario.route,branches);
  if(family.core.every(id=>run.items.some(i=>i.id===id&&!i.stored)))attainedAtWaves.push(run.wave);
  assert.equal(startWave(run).ok,true);let world=createBattle(run),shadow:BattleState|undefined;
  const driver=createInputDriver(model,pilotBuild(run,family),scenario.seedIndex-1);
  for(let tick=0;tick<60*301&&world.status==='playing';tick++){
   if(tick===600){
    const save=sanitizeSave(JSON.parse(JSON.stringify({version:1,profile:freshProfile(),run,battle:world,savedAt:1})));
    assert.equal(save.run?.phase,'battle');assert.ok(save.battle);assert.deepEqual(save.battle,JSON.parse(JSON.stringify(world)));
    shadow=world;world=save.battle as BattleState;run=save.run!;resumedWaves++;
   }
   const input=driver.input(world,tick);stepBattle(world,input,1/60);
   if(shadow){stepBattle(shadow,input,1/60);if(tick>=720||world.status!=='playing'){assert.deepEqual(JSON.parse(JSON.stringify(world)),JSON.parse(JSON.stringify(shadow)));shadow=undefined;verifiedResume=true;}}
  }
  assert.notEqual(world.status,'playing','Unterminated battle');assert.ok(Number.isFinite(world.player.hp));
  inputs.push({wave:run.wave,...driver.stats,noSafeCandidate:driver.memory.noSafeCandidate});
  assert.equal(resolveBattle(run,battleResult(world)).ok,true);
 }
 const report=exportRunReport(run),decisions=diagnostic.records;
 if(scenario.suite==='calibration'&&model==='frequent'){
  const old=historical.results.find((r:any)=>r.family===family.id&&r.seed===seed);assert.ok(old);
  const oldReport=Object.fromEntries(Object.keys(report).map(k=>[k,old[k]]));
  assert.deepEqual(historicalProjection(report),historicalProjection(oldReport),`dev.4 baseline changed: ${family.id}/${seed}`);
  assert.deepEqual(attainedAtWaves,old.attainedAtWaves);assert.equal(resumedWaves,old.resumedWaves);baselineMatches++;
 }
 const spent=(action:string)=>report.journal.events.filter(e=>e.action===action).reduce((n,e)=>n+Number(e.detail.split(':').at(-1)),0);
 const observations=decisions.map(d=>({wave:d.wave,id:d.id,source:d.source,cash:d.snapshot.gold,
  affordable:d.canAffordWithoutSales,readyWithoutSales:d.readyWithoutSales,search:d.expanded?.status,
  legacyPlanAvailable:d.legacyPlanAvailable,witnessSales:d.expanded?.plan?.removed.length??0,
  equippedLater:report.journal.waves.some(w=>w.wave>=d.wave&&w.start.items.some(i=>i.id===d.id&&!i.stored))}));
 results.push({case:scenario,model,seed,attainedAtWaves,resumedWaves,verifiedResume,branches,inputs,
  spending:{buy:spent('buy'),repair:spent('repair'),refresh:spent('refresh'),upgrade:spent('upgrade'),saleIncome:spent('sell'),droppedJournalEvents:report.journal.droppedEvents},
  diagnostics:diagnostic.summary(),observations,decisions,report});
 console.log(`${scenario.id} / ${model}: ${report.status}, wave ${report.wave}, ${report.battleSeconds.toFixed(1)}s, core ${attainedAtWaves[0]??'-'}`);
}
assert.deepEqual(hashes(),sourceHashes,'Source changed during probe');
const summaries=['calibration','matrix'].flatMap(group=>models.map(model=>{
 const runs=results.filter(r=>r.case.suite===group&&r.model===model);
 return {suite:group,model,runs:runs.length,wins:runs.filter(r=>r.report.status==='won').length,
  coreAttained:runs.filter(r=>r.attainedAtWaves.length).length,resumeChecks:runs.reduce((n,r)=>n+r.resumedWaves,0),
  meanDamageTaken:runs.length?runs.reduce((n,r)=>n+r.report.stats.damageTaken,0)/runs.length:null,
  meanBattleSeconds:runs.length?runs.reduce((n,r)=>n+r.report.battleSeconds,0)/runs.length:null,
  failures:runs.filter(r=>r.report.status!=='won').map(r=>({case:r.case.id,seed:r.seed,wave:r.report.wave,reason:r.report.journal.waves.at(-1)?.end?.reason}))};
})).filter(r=>r.runs);
const eventChoices=[...new Set(results.flatMap(r=>r.branches.filter(b=>b.kind==='event'&&b.accepted).map(b=>`${b.id}:${b.requested}`)))].sort();
const output={probe:'dev5-multi-input-natural-expeditions',buildVersion:BUILD_VERSION,rulesVersion:RULESET_VERSION,started,finished:new Date().toISOString(),sourceHashes,
 inputModels:INPUT_MODELS,cases,baselineMatches,summaries,
 coverage:{chassis:[...new Set(results.map(r=>r.case.chassis))],difficulties:[...new Set(results.map(r=>r.case.difficulty))].sort(),
  playedRoutes:[...new Set(results.flatMap(r=>r.report.journal.waves.map(w=>w.route)))].sort(),bosses:[...new Set(results.flatMap(r=>r.report.journal.waves.flatMap(w=>w.boss?[w.boss]:[])))].sort(),eventChoices,
  missingEventChoices:Array.from({length:8},(_,i)=>`EV${String(i+1).padStart(2,'0')}`).flatMap(id=>[0,1].map(choice=>`${id}:${choice}`)).filter(k=>!eventChoices.includes(k)),
  rejectedRiskContracts:results.flatMap(r=>r.branches).filter(b=>b.kind==='route'&&!b.accepted).length},
 limitations:['Synthetic input models are not human skill levels or win rates. The 60 Hz rules simulation has no rendering or device performance measurement.',
  'Calibration holds starting chassis, difficulty, family, seed, event and route policies fixed. Changed combat outcomes can alter later resources and offers.',
  'The 12-case matrix is representative coverage, not a full factorial experiment. Chassis/difficulty/event effects must not be inferred from different rows.',
  'All equipment, HP, currency and outcomes use production APIs. Matrix scenarios assume the selected chassis and difficulty were already unlocked; they do not prove UI unlock flow.',
  'Shop policy is legacy with at most two rerolls. Search witnesses diagnose alternatives but do not change purchases; reward replacement search remains unassessed.',
  'equippedLater means the observed module appears equipped at a later wave, not proof that this particular offer was bought. Complete decision snapshots and reports are in the compressed raw file.',
  'Failed and incomplete runs are retained. Missing event branches stay uncovered. Save restoration compares the same already-selected inputs, not a persisted bot memory.'],results};
const outputName=arg('output')??`dev5-expeditions${suite==='all'&&count===10&&models.length===3?'':'-smoke'}.json`;
assert.match(outputName,/^dev5-[a-zA-Z0-9._-]+\.json$/,'Output must use a dev5- JSON filename');
const rawName=outputName.replace(/\.json$/,'-runs.json.gz');mkdirSync(new URL('../qa/',import.meta.url),{recursive:true});
writeFileSync(new URL(`../qa/${rawName}`,import.meta.url),gzipSync(JSON.stringify(output),{level:9}));
writeFileSync(new URL(`../qa/${outputName}`,import.meta.url),JSON.stringify({...output,rawRuns:rawName,results:results.map(({decisions,report,...r})=>({...r,report:{...report,history:undefined,journal:{...report.journal,events:undefined}}}))},null,2)+'\n');
console.log(JSON.stringify({runs:results.length,baselineMatches,summaries,coverage:output.coverage}));
