import test from 'node:test';
import assert from 'node:assert/strict';
import type {BattleResult,InputFrame,Mode,Profile,Run} from '../src/types.ts';
import type {BattleState} from '../src/combat.ts';
import {createBattle,stepBattle,battleResult} from '../src/combat.ts';
import {createEncounter,enemyPool} from '../src/encounters.ts';
import {CHASSIS_BY_ID,DEMO_IDS,PROTOTYPE_IDS,WAVES} from '../src/content.ts';
import * as economy from '../src/economy.ts';
import {applyProgress,freshProfile,sanitizeSave,scoreRun} from '../src/storage.ts';
import {overloadRequested} from '../src/input.ts';

const serial=<T>(value:T):T=>JSON.parse(JSON.stringify(value));
function pilot(world:BattleState,tick:number):InputFrame {
 const x=800+Math.cos(world.time*.7)*230-world.player.x,y=650+Math.sin(world.time*.7)*180-world.player.y,m=Math.max(1,Math.hypot(x,y));
 return {x:x/m,y:y/m,dash:tick%360===0,overload:tick%1200===0};
}
function snapshot(run:Run,battle:BattleState|null,profile=freshProfile()) {return sanitizeSave(serial({version:1,profile,run,battle,savedAt:123456}));}
/** State-machine fixture only: this does not measure whether a build can beat enemies. */
function simulatedOutcome(run:Run):BattleResult {
 return {won:true,hp:CHASSIS_BY_ID[run.chassis].hp,shield:20,elapsed:WAVES[run.wave-1].duration,insuranceUsed:false,rng:run.rng.combat,stats:{damageByModule:{W01:100},damageTakenBy:{},kills:5,killedBudget:5,goldEarned:WAVES[run.wave-1].bonus*.7,maxChain:2,damageTaken:0}};
}
function collectPending(run:Run):void {
 while(['reward','expansion','protocol'].includes(run.phase)){
  if(run.phase==='reward')assert.equal(economy.chooseReward(run,-1).ok,true);
  else if(run.phase==='expansion')assert.equal(economy.chooseExpansion(run,[0,1,2,3].filter(c=>!run.unlockedCorners.includes(c)).slice(0,2)).ok,true);
  else assert.equal(economy.chooseProtocol(run,run.protocolOptions[0]).ok,true);
 }
}

test('real first-wave simulation reaches victory and settles actual pickup income exactly once',()=>{
 const run=economy.newRun('scavenger','full',0,'integration-first-wave');assert.equal(economy.startWave(run).ok,true);const world=createBattle(run);
 for(let i=0;i<2600&&world.status==='playing';i++)stepBattle(world,pilot(world,i),1/60);
 assert.equal(world.status,'won');assert.equal(world.time,40);assert.ok(world.player.hp>0);assert.ok(world.stats.kills>0);assert.ok(world.stats.goldEarned<=12);
 const result=battleResult(world);assert.equal(economy.resolveBattle(run,result).ok,true);assert.equal(run.wave,2);assert.equal(run.phase,'prep');assert.ok(Math.abs(run.gold-(40+28+result.stats.goldEarned))<1e-9);assert.equal(run.rng.combat,result.rng);
 const before=serial(run);assert.equal(economy.resolveBattle(run,result).ok,false);assert.deepEqual(serial(run),before);
});

test('real populated battle snapshot resumes with the same inputs, RNG, entities and outcome',()=>{
 const run=economy.newRun('scavenger','full',0,'integration-first-wave');economy.startWave(run);const original=createBattle(run);
 for(let i=0;i<600;i++)stepBattle(original,pilot(original,i),1/60);
 assert.equal(original.status,'playing');assert.ok(original.enemies.length+original.bullets.length+original.zones.length>0);
 const checkpoint=snapshot(run,original);assert.equal(checkpoint.run!.phase,'battle');assert.notEqual(checkpoint.battle,null);
 const restored=checkpoint.battle as BattleState;
 for(let i=600;i<2600&&original.status==='playing';i++){
  stepBattle(original,pilot(original,i),1/60);stepBattle(restored,pilot(restored,i),1/60);
 }
 assert.equal(original.status,'won');assert.deepEqual(serial(restored),serial(original));assert.deepEqual(battleResult(restored),battleResult(original));
});

test('real combat repeatedly activates automatic overdrive for 42 seconds while a manually held input triggers once',()=>{
 const firstRun=economy.newRun('bulwark','full',0,'integration-first-wave');assert.equal(economy.startWave(firstRun).ok,true);const firstBattle=createBattle(firstRun);
 for(let i=0;i<2600&&firstBattle.status==='playing';i++)stepBattle(firstBattle,pilot(firstBattle,i),1/60);
 assert.equal(firstBattle.status,'won');assert.equal(economy.resolveBattle(firstRun,battleResult(firstBattle)).ok,true);assert.equal(firstRun.wave,2);
 const counts:Record<string,number>={};
 for(const control of ['automatic','held'] as const){
  const run=structuredClone(firstRun);assert.equal(economy.startWave(run).ok,true);const world=createBattle(run),activations=new Map<number,number>();
  for(let i=0;i<2520&&world.status==='playing';i++){
   const input=pilot(world,i);input.overload=overloadRequested(control==='held',control==='automatic',world.player.overloadCooldown);
   stepBattle(world,input,1/60);for(const event of world.events)if(event.type==='overload')activations.set(event.id,event.at);
  }
  assert.ok(world.time>=41,`${control} stopped at ${world.time}s`);assert.equal(world.status,'playing');assert.ok(world.player.hp>0);counts[control]=activations.size;
  if(control==='automatic'){const times=[...activations.values()];assert.ok(times[0]<.1);assert.ok(times[1]>=20&&times[1]<20.2);assert.ok(times[2]>=40&&times[2]<40.3);}
 }
 assert.equal(counts.automatic,3);assert.equal(counts.held,1);
});

test('simulated results traverse all modes, reward checkpoints, upgrade gates, save reloads and profile unlocks',()=>{
 for(const mode of ['prototype','demo','full'] as Mode[]){
  let run=economy.newRun('scavenger',mode,0,'flow-integration');let profile:Profile=freshProfile();profile.totalRuns=1;const visited:number[]=[];
  while(run.phase!=='won'){
   const wave=run.wave;visited.push(wave);
   if(wave<=4)assert.equal(run.maxTier,1);else if(wave<=8)assert.equal(run.maxTier,2);else assert.equal(run.maxTier,3);
   if(mode!=='full'){const allowed=mode==='demo'?DEMO_IDS:PROTOTYPE_IDS;assert.ok(run.items.every(i=>allowed.includes(i.id)));assert.ok(run.shop.every(o=>!o.id||allowed.includes(o.id)));assert.equal(run.protocols.includes('P05'),false);}
   if(run.eventId&&!run.eventResolved)assert.equal(economy.resolveEvent(run,-1).ok,true);
   const encounter=createEncounter(run);if(mode!=='full')assert.ok(enemyPool(wave,mode).every(id=>Number(id.slice(1))<=(mode==='demo'?6:5)));
   if(wave%4===0)assert.equal(encounter.boss,mode==='full'?run.bosses[Math.ceil(wave/4)-1]:`B${Math.ceil(wave/4)}A`);
   assert.equal(economy.startWave(run).ok,true);const outcome=simulatedOutcome(run);assert.equal(economy.resolveBattle(run,outcome).ok,true);applyProgress(profile,run,wave,outcome.won,false);
   const restored=snapshot(run,null,profile);assert.notEqual(restored.run,null);run=restored.run!;profile=restored.profile;
   if(run.phase==='expansion'){assert.equal(run.protocolOptions.length,3);assert.equal(new Set(run.protocolOptions).size,3);if(mode!=='full')assert.equal(run.protocolOptions.includes('P05'),false);}
   collectPending(run);
   if(wave===4&&mode!=='prototype'){const before=run.gold;assert.equal(economy.upgrade(run,run.items[0].uid).ok,true);assert.equal(run.items[0].tier,2);assert.equal(run.gold,before-18);assert.equal(economy.upgrade(run,run.items[0].uid).ok,false);}
   if(wave===8&&mode==='full'){assert.equal(economy.upgrade(run,run.items[0].uid).ok,true);assert.equal(run.items[0].tier,3);}
  }
  const total=mode==='full'?12:mode==='demo'?8:4;assert.deepEqual(visited,Array.from({length:total},(_,i)=>i+1));assert.equal(profile.wins,1);assert.ok(profile.unlocked.includes('bulwark'));assert.equal(profile.unlocked.includes('kestrel'),mode==='full');assert.equal(profile.unlocked.includes('hive'),false);assert.equal(profile.maxDifficulty,mode==='full'?1:0);
  assert.equal(profile.best[`${mode}:scavenger:0`].score,scoreRun(run));assert.equal(run.eventsSeen.length,mode==='full'?2:0);assert.equal(run.unlockedCorners.length,mode==='full'?4:mode==='demo'?2:0);
 }
});

test('fixed-seed shop and event sequence is identical after every preparation checkpoint reload',()=>{
 const a=economy.newRun('scavenger','full',0,'sequence'),b=economy.newRun('scavenger','full',0,'sequence');let resumed=b;
 for(let n=1;n<=7;n++){
  for(const r of [a,resumed]){if(r.eventId&&!r.eventResolved)economy.resolveEvent(r,-1);assert.equal(economy.startWave(r).ok,true);assert.equal(economy.resolveBattle(r,simulatedOutcome(r)).ok,true);collectPending(r);}
  const saved=snapshot(resumed,null);resumed=saved.run!;
  assert.deepEqual(serial(a),serial(resumed));
  if(n>=1&&a.phase==='prep'){assert.equal(economy.refreshShop(a).ok,true);assert.equal(economy.refreshShop(resumed).ok,true);assert.deepEqual(a.shop,resumed.shop);}
 }
});

test('protocol and event modifiers are consumed by combat and expire at the intended boundary',()=>{
 const run=economy.newRun('scavenger','full',0,'modifiers');run.wave=5;run.power=12;run.maxTier=2;run.unlockedCorners=[0,1];run.phase='protocol';run.protocolOptions=['P04','P07','P08'];
 assert.equal(economy.chooseProtocol(run,'P04').ok,true);assert.equal(economy.upgrade(run,run.items[0].uid).ok,true);run.wave=7;run.eventId='EV07';run.eventResolved=false;
 assert.equal(economy.resolveEvent(run,1).ok,true);assert.equal(economy.startWave(run).ok,true);const world=createBattle(run);
 assert.equal(world.player.maxShield,55);assert.equal(world.player.shield,55);assert.equal(world.dashBase,6.5);assert.equal(world.weapons[0].tier,2);assert.ok(world.protocols.includes('P04'));
 assert.equal(economy.resolveBattle(run,simulatedOutcome(run)).ok,true);assert.equal(run.extra!.temporaryShield,undefined);assert.equal(economy.getShieldCapacity(run),40);
});

test('drone and full-clear unlocks follow their actual progression API conditions',()=>{
 const profile=freshProfile(),run=economy.newRun('scavenger','full',0,'unlocks');run.wave=9;run.phase='expansion';
 assert.deepEqual(applyProgress(profile,run,8,false,true),[]);assert.deepEqual(applyProgress(profile,run,8,true,false),[]);assert.deepEqual(applyProgress(profile,run,8,true,true),['hive']);assert.deepEqual(applyProgress(profile,run,8,true,true),[]);
 run.wave=12;run.phase='won';run.difficulty=4;assert.deepEqual(applyProgress(profile,run,12,true,true),['kestrel']);assert.equal(profile.maxDifficulty,4);assert.equal(profile.wins,1);assert.equal(profile.best['full:scavenger:4'].score,scoreRun(run));
});
