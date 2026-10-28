/** Compare every rule field at every tick against the preserved dev.3 source. */
import assert from 'node:assert/strict';
import {writeFileSync,readFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
import {stepBattle} from '../src/combat.ts';
import {fixtureWorld,idle,makeFixtures} from './motion-fixtures.ts';
const base=process.argv[2]??'/private/tmp/backpack-mecha-dev4-baseline/src/combat.ts';
const old=await import(pathToFileURL(base).href);
const project=(w:any)=>{const copy=JSON.parse(JSON.stringify(w));delete copy.events;delete copy.nextEvent;for(const e of copy.enemies)delete e.controlReason;return copy;};
const events=(w:any)=>w.events.filter((e:any)=>e.type!=='enemy-explosion').map(({id,...e}:any)=>e);
const cases=[...['E05','E12','B1A','B1B','B2A','B2B','B3A','B3B'].flatMap(id=>Array.from({length:id[0]==='E'?1:['B1A','B1B','B2B'].includes(id)?2:3},(_,i)=>({id:`${id}-p${i+1}`,world:fixtureWorld(id,i+1)}))),...makeFixtures().filter(f=>/impact|control|dense|overlap/.test(f.id))];
let ticks=0;
for(const f of cases){
 const next=structuredClone(f.world),prior=structuredClone(f.world);
 for(let tick=0;tick<1800&&next.status==='playing';tick++){
  const input={...idle,x:Math.sin(tick/180),y:Math.cos(tick/150),dash:tick%240===0,overload:tick%600===0};
  stepBattle(next,input);old.stepBattle(prior,input);
  assert.deepEqual(project(next),project(prior),`${f.id} rule state diverged at tick ${tick}`);
  assert.deepEqual(events(next),events(prior),`${f.id} existing events diverged at tick ${tick}`);ticks++;
 }
 console.log(`${f.id}: identical`);
}
const hash=(f:string)=>createHash('sha256').update(readFileSync(f)).digest('hex');
const report={checkedAt:new Date().toISOString(),baseline:base,baselineCombatHash:hash(base),currentCombatHash:hash('src/combat.ts'),cases:cases.map(f=>f.id),ticks,status:'passed',excludedRuleFields:['events (existing event payloads compared separately; only enemy-explosion and event IDs excluded)','nextEvent','enemies[].controlReason'],note:'Explicit fixtures; not a natural browser run. All remaining fields, including RNG, damage, AI, rewards and positions, compared every tick.'};
writeFileSync('qa/dev4-rule-parity.json',JSON.stringify(report,null,2)+'\n');console.log(`Compared ${ticks} ticks across ${cases.length} scenarios.`);
