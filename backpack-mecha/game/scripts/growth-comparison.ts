import assert from 'node:assert/strict';
import {readFileSync,writeFileSync} from 'node:fs';
import {gunzipSync} from 'node:zlib';
import {createHash} from 'node:crypto';
import {applyPurchasePlan,ruleSnapshot} from './purchase-search.ts';
import {MODULE_BY_ID} from '../src/content.ts';
import type {GrowthDecision} from './growth-diagnostics.ts';

const root=new URL('../qa/',import.meta.url);
const read=(file:string)=>JSON.parse(gunzipSync(readFileSync(new URL(file,root))).toString());
const baseline=read('natural-probe-runs.json.gz'),legacy=read('natural-probe-dev3-legacy-runs.json.gz'),expanded=read('natural-probe-dev3-expanded-runs.json.gz');
const key=(r:any)=>`${r.family}/${r.seed}`;
const projection=(r:any)=>({family:r.family,seed:r.seed,status:r.status,wave:r.wave,items:r.items,stats:r.stats,battleSeconds:r.battleSeconds,attainedAtWaves:r.attainedAtWaves,waves:r.journal.waves});
assert.equal(legacy.results.length,baseline.results.length,'Legacy rerun must cover the entire baseline');
for(const r of legacy.results){const old=baseline.results.find((x:any)=>key(x)===key(r));assert.ok(old,`Unknown baseline run: ${key(r)}`);assert.deepEqual(projection(r),projection(old),`Baseline changed: ${key(r)}`);}
assert.deepEqual(expanded.results.map(key),legacy.results.map(key),'Policies must cover the same family/seed pairs');
let replayed=0;
for(const batch of [legacy,expanded])for(const r of batch.results)for(const decision of (r.decisions??[]) as GrowthDecision[]){
 if(!decision.expanded?.plan)continue;
 const draft=ruleSnapshot(decision.snapshot);applyPurchasePlan(draft,decision.expanded.plan);
 assert.ok(draft.items.some(i=>i.id===decision.id&&!i.stored),'Witness must equip the offered core');replayed++;
}
function observations(batch:any){
 const rows=batch.results.map((r:any)=>r.diagnosticSummary);
 return {decisions:rows.reduce((n:number,r:any)=>n+r.recorded,0),dropped:rows.reduce((n:number,r:any)=>n+r.dropped,0),
  legacyMissedWitnesses:rows.reduce((n:number,r:any)=>n+r.legacyMissedWitnesses,0),noTotalBudget:rows.reduce((n:number,r:any)=>n+r.noTotalBudget,0),
  boundedSearchUnresolved:rows.reduce((n:number,r:any)=>n+r.boundedSearchUnresolved,0),rewardObservations:rows.reduce((n:number,r:any)=>n+r.rewardObservations,0)};
}
const cases=legacy.results.filter((r:any)=>!r.attainedAtWaves.length).map((r:any)=>{
 const decisions=(r.decisions??[]) as GrowthDecision[],offered=new Set(r.journal.events.flatMap((e:any)=>[...e.shop.map((o:any)=>o.id),...e.rewardOptions,...e.items.map((i:any)=>i.id)]));
 const witnesses=decisions.filter(d=>!d.legacyPlanAvailable&&d.expanded?.plan);
 const newer=expanded.results.find((x:any)=>key(x)===key(r));
 return {family:r.family,seed:r.seed,allCoreSeen:r.core.every((id:string)=>offered.has(id)),notSeen:r.core.filter((id:string)=>!offered.has(id)),
  legacyMissedWitnesses:witnesses.length,expandedFirstCoreWave:newer.attainedAtWaves[0]??null,
  unresolvedDecisions:decisions.filter(d=>d.expanded?.status==='search-exhausted').length,
  firstWitness:witnesses[0]?{key:witnesses[0].key,wave:witnesses[0].wave,id:witnesses[0].id,name:MODULE_BY_ID[witnesses[0].id].name,
   cash:witnesses[0].snapshot.gold,constraints:witnesses[0].expanded!.constraints,
   sold:witnesses[0].expanded!.plan!.removed.map(uid=>{const i=witnesses[0].snapshot.items.find(i=>i.uid===uid)!;return {uid,id:i.id,name:MODULE_BY_ID[i.id].name,tier:i.tier};}),
   actions:witnesses[0].expanded!.plan!.actions}:null};
});
const report={generatedAt:new Date().toISOString(),baselineReproducedRuns:legacy.results.length,witnessesReplayed:replayed,
 sources:Object.fromEntries(['natural-probe-runs.json.gz','natural-probe-dev3-legacy-runs.json.gz','natural-probe-dev3-expanded-runs.json.gz'].map(f=>[f,createHash('sha256').update(readFileSync(new URL(f,root))).digest('hex')])),
 observations:{legacy:observations(legacy),expanded:observations(expanded)},families:legacy.summaries.map((r:any)=>({name:r.name,family:r.family,legacy:r,expanded:expanded.summaries.find((x:any)=>x.family===r.family)})),cases,
 limitations:[
  'Same seed/family inputs, not identical later offers: policy choices change subsequent RNG consumption and combat outcomes.',
  'Expanded policy adds a +100 core preference, protects existing cores, and searches up to two sales plus rearrangement. It is not a packing-only ablation.',
  'Witness counts describe observed decisions, not distinct runs or a human success rate.',
  'Reward offers are recorded but their replacement paths are not searched. Search-exhausted means no witness within the bounds, never proven impossible.',
  'Both policies retain the same upgrade timing, two-refresh limit, event skipping and high-frequency combat avoidance.',
 ]};
writeFileSync(new URL('growth-comparison-dev3.json',root),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify({baselineReproducedRuns:report.baselineReproducedRuns,witnessesReplayed:replayed,observations:report.observations,
 families:report.families.map((r:any)=>({name:r.name,legacy:r.legacy.coreAttainedRuns,expanded:r.expanded.coreAttainedRuns,legacyWins:r.legacy.wins,expandedWins:r.expanded.wins})),focusCases:cases.filter((r:any)=>r.seed==='natural-v02-02'&&['ballistic','fortress'].includes(r.family))},null,2));
