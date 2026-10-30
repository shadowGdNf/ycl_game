/** Deterministic boss tuning evidence. Fixtures do not imply shop reachability or human win rate. */
import assert from 'node:assert/strict';
import {writeFileSync,readFileSync} from 'node:fs';
import {resolve} from 'node:path';
import {pathToFileURL} from 'node:url';
import {createHash} from 'node:crypto';
import {createPilotMemory,decide} from './probe-pilot.ts';
import {createBattle,stepBattle} from '../src/combat.ts';
import {newRun} from '../src/economy.ts';
import {BOSSES} from '../src/content.ts';
import {TRAINING_PRESETS} from '../src/training.ts';
import type {Tier} from '../src/types.ts';
const output=process.argv.find(a=>a.startsWith('--output='))?.slice(9)??'qa/dev9-boss-pressure.json';
const baseline=process.argv.find(a=>a.startsWith('--baseline='))?.slice(11),round=(v:number)=>Math.round(v*1000)/1000;
const phases=(id:string)=>['B1A','B1B','B2B'].includes(id)?2:3;
const idle={x:0,y:0,dash:false,overload:false};
async function choreography(root:string){
 const {bossTurn,bossPursuitSpeed}=await import(pathToFileURL(resolve(root,'src/encounters.ts')).href);
 return BOSSES.flatMap(boss=>Array.from({length:phases(boss.id)},(_,i)=>i+1).flatMap(phase=>[0,4].map(difficulty=>{
  const turns=Array.from({length:6},(_,index)=>bossTurn(boss.id,phase,index,{x:800,y:300},{x:800,y:650},difficulty)),plans=turns.flatMap(t=>t.plans),cycle=turns.reduce((n,t)=>n+t.duration+t.recovery,0);
  const shots=plans.filter(p=>p.effect==='projectile'),shotCount=shots.reduce((n,p)=>n+p.count,0);
  return {boss:boss.id,phase,difficulty,turnsPerMinute:round(360/cycle),shotsPerMinute:round(shotCount*60/cycle),meanShotSpeed:shots.length?round(shots.reduce((n,p)=>n+p.speed*p.count,0)/shotCount):0,chargeSpeed:round(plans.find(p=>p.effect==='charge')?.speed??0),pursuitSpeed:round(bossPursuitSpeed?bossPursuitSpeed(boss.speed,phase,difficulty):boss.speed*(boss.id==='B2A'&&phase===3?1.15:1)),minWarning:Math.min(...plans.map(p=>p.warning)),maxShotCountPerTurn:Math.max(...turns.map(t=>t.plans.filter(p=>p.effect==='projectile').reduce((n,p)=>n+p.count,0)))};
 })));
}
const sourceNames=['combat','encounters','rarity','training','content','version'];
const hashes=()=>Object.fromEntries(sourceNames.map(n=>[n,createHash('sha256').update(readFileSync(new URL(`../src/${n}.ts`,import.meta.url))).digest('hex')]));
const before=hashes(),current=await choreography('.'),previous=baseline?await choreography(baseline):undefined;
const runtime=BOSSES.map(boss=>{
 const r=newRun('bulwark','full',4,`PRESSURE-${boss.id}`);r.wave=boss.act*4;r.bosses[boss.act-1]=boss.id;r.items=[];
 const w=createBattle(r);w.player.invulnerable=1000;w.enemies.forEach(e=>{e.hp=e.maxHp*.2;});const shots=new Set<number>();let peakBullets=0,peakZones=0;
 for(let frame=0;frame<60*45;frame++){stepBattle(w,idle);const bullets=w.bullets.filter(b=>b.owner==='enemy'&&b.source===boss.id);bullets.forEach(b=>shots.add(b.eid));peakBullets=Math.max(peakBullets,w.bullets.filter(b=>b.owner==='enemy').length);peakZones=Math.max(peakZones,w.zones.length);assert.ok(Number.isFinite(w.player.x+w.player.y+w.enemies[0].hp));}
 return {boss:boss.id,seconds:45,difficulty:4,phase:phases(boss.id),turns:w.bossTurn,observedBossProjectiles:shots.size,peakEnemyBullets:peakBullets,peakZones};
});
async function practice(root:string){
const {trainingRun}=await import(pathToFileURL(resolve(root,'src/training.ts')).href);
const {createBattle,stepBattle}=await import(pathToFileURL(resolve(root,'src/combat.ts')).href);
const practices=[];
for(const boss of BOSSES)for(const tier of [2,4] as Tier[])for(let index=0;index<TRAINING_PRESETS.length;index++){
 const preset=TRAINING_PRESETS[index],setup=trainingRun({chassis:'scavenger',boss:boss.id,difficulty:0,tier,power:18,modules:preset.modules});assert.ok(setup.ok,setup.reason);
 const w=createBattle(setup.run!),memory=createPilotMemory(index);let input=idle;
 const build={preferredSurfaceRange:[210,275,140,64,275,210][index],melee:index===3};
 for(let frame=0;frame<60*301&&w.status==='playing';frame++){if(frame%6===0)input={...decide(w,build,memory),skill:(w.player.skillCooldown??0)<=0&&w.player.hp<=w.player.maxHp-6};stepBattle(w,input);assert.ok(Number.isFinite(w.player.hp+w.player.x+w.player.y));}
 practices.push({boss:boss.id,tier,preset:preset.name,status:w.status,failure:w.failureReason,seconds:round(w.time),hp:round(w.player.hp),damageTaken:round(w.stats.damageTaken),bossHp:round(w.enemies.find(e=>e.kind==='boss')?.hp??0),dashDecisions:memory.dashDecisions});
}
return practices;
}
const practices=await practice('.'),previousPractices=baseline?await practice(baseline):undefined;
assert.deepEqual(hashes(),before,'Sources changed during probe');
const report={checkedAt:new Date().toISOString(),sources:before,baselinePath:baseline,method:['Six-turn schedule metrics at every boss phase and threats 0/4.','45s pressure fixtures: no weapons, explicit invulnerability and low boss HP to hold final phase; measures traffic, not survival.','72 practice battles: 6 bosses × 6 presets × tiers II/IV, threat 0, power 18, 10Hz visible-state reactive pilot; Q heals when ready and at least 6 HP are missing (same policy for both builds). No HP, invulnerability or damage changes in practice battles.','Pre-equipped legal training fixtures; does not test shop acquisition or establish human win rates.'],previous,current,runtime,previousPractices,practices};
writeFileSync(resolve(output),JSON.stringify(report,null,2)+'\n');
for(const b of BOSSES){const c=current.find(r=>r.boss===b.id&&r.phase===phases(b.id)&&r.difficulty===0)!,p=previous?.find(r=>r.boss===b.id&&r.phase===c.phase&&r.difficulty===0);console.log(`${b.id}: turns/min ${p?.turnsPerMinute??'?'} -> ${c.turnsPerMinute}, shots/min ${p?.shotsPerMinute??'?'} -> ${c.shotsPerMinute}, speed ${p?.meanShotSpeed??'?'} -> ${c.meanShotSpeed}`);}
for(const tier of [2,4]){const rows=practices.filter(r=>r.tier===tier);console.log(`Practice tier ${tier}: ${rows.filter(r=>r.status==='won').length}/${rows.length} won, ${rows.filter(r=>r.failure==='timeout').length} game timeouts, ${rows.filter(r=>r.status==='playing').length} unfinished, mean damage taken ${round(rows.reduce((n,r)=>n+r.damageTaken,0)/rows.length)}`);}
