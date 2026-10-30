import test from 'node:test';
import assert from 'node:assert/strict';
import {createBattle,stepBattle,spawnEnemy,damagePlayer} from '../src/combat.ts';
import type {BattleState} from '../src/combat.ts';
import {newRun,buy,sell,offerPrice} from '../src/economy.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
import {CHASSIS,MODULES} from '../src/content.ts';
import {equipmentPrice,TIERS} from '../src/rarity.ts';
import {chassisSkill,skillDescription} from '../src/skills.ts';
import {createEncounter,findPath,traversable} from '../src/encounters.ts';
const idle={x:0,y:0,dash:false,overload:false};
function scene(id:string){const run=newRun(id,'full',0,'DEV11-SKILLS');run.phase='battle';run.wave=11;run.items=[];const w=createBattle(run);w.obstacles=[];w.encounter.nextSpawn=10000;return {run,w};}
function enemy(w:BattleState,x=w.player.x+100){const e=spawnEnemy(w,{id:'E01',x,y:w.player.y,elite:false,affix:0,reward:false,cost:0});e.hp=e.maxHp=10000;e.speed=0;e.damage=0;return e;}

test('each chassis has an independent edge-triggered skill and localized description',()=>{
 for(const c of CHASSIS){const {w}=scene(c.id);w.player.invulnerable=1000;
  assert.ok(skillDescription(c.id,'zh'));assert.ok(skillDescription(c.id,'en'));
  stepBattle(w,{...idle,skill:true});assert.equal(w.player.skillCooldown,chassisSkill(c.id).cooldown);assert.equal(w.player.overloadCooldown,0);
  const events=w.nextEvent;stepBattle(w,{...idle,skill:true});assert.equal(w.nextEvent,events);
  stepBattle(w,{...idle,skill:true},chassisSkill(c.id).cooldown+1);assert.equal(w.player.skillCooldown,0);assert.equal(w.player.skillTime,0);
  stepBattle(w,idle);stepBattle(w,{...idle,skill:true});assert.equal(w.player.skillCooldown,chassisSkill(c.id).cooldown);
 }
});
test('salvage pulse heals within HP cap and collects real drops once without minting scrap',()=>{
 const {w}=scene('scavenger');w.player.hp=98;w.drops=[{id:100,x:1100,y:650,value:12},{id:101,x:1200,y:650,value:9}];
 stepBattle(w,{...idle,skill:true});assert.equal(w.player.hp,100);assert.equal(w.stats.goldEarned,12);assert.equal(w.drops.length,1);
 stepBattle(w,idle,3.1);w.drops.push({id:102,x:1000,y:650,value:7});stepBattle(w,idle);assert.equal(w.stats.goldEarned,12);
});
test('bastion pulse has a bounded area and halves damage only during its duration',()=>{
 const {w}=scene('bulwark'),near=enemy(w),far=enemy(w,1200);w.player.armor=0;
 stepBattle(w,{...idle,skill:true});assert.equal(near.hp,9964);assert.equal(far.hp,10000);assert.equal(w.stats.damageByModule['skill-bulwark'],36);
 assert.equal(damagePlayer(w,20,'test'),10);stepBattle(w,idle,4.1);assert.equal(damagePlayer(w,20,'test'),20);
});
test('slipstream resets dash before same-frame dash and restores normal movement after expiry',()=>{
 const {w}=scene('kestrel');w.player.dashCooldown=5;
 stepBattle(w,{...idle,x:1,skill:true});assert.equal(w.player.dashCooldown,0);assert.ok(Math.abs(w.player.x-800-w.player.speed*1.35/60)<1e-8);assert.equal(damagePlayer(w,50,'test'),0);
 stepBattle(w,idle,3.1);const x=w.player.x;stepBattle(w,{...idle,x:1});assert.ok(Math.abs(w.player.x-x-w.player.speed/60)<1e-8);
 const next=scene('kestrel').w;next.player.dashCooldown=5;stepBattle(next,{...idle,skill:true,dash:true,x:1});assert.ok(next.player.dashTime>0);assert.equal(next.player.dashCooldown,next.dashBase);
});
test('escort swarm works without equipment, respects range/focus and expires after ten volleys',()=>{
 const {w}=scene('hive'),near=enemy(w),focused=enemy(w,1100),far=enemy(w,1400);w.priority=focused.eid;w.priorityUntil=10;
 stepBattle(w,{...idle,skill:true});stepBattle(w,idle,6.1);
 assert.ok(Math.abs(w.stats.damageByModule['skill-hive']-3*10*6*1.15)<1e-7);
 assert.equal(near.hp,10000);assert.equal(far.hp,10000);assert.ok(focused.hp<10000);assert.equal(w.weapons.length,0);
 const damage=w.stats.damageByModule['skill-hive'];stepBattle(w,idle,2);assert.equal(w.stats.damageByModule['skill-hive'],damage);
});
test('skills resume deterministically mid-effect and old saves still resume battle',()=>{
 for(const c of CHASSIS){const {run,w}=scene(c.id);enemy(w);stepBattle(w,{...idle,skill:true});stepBattle(w,idle,.75);
  const saved=sanitizeSave(JSON.parse(JSON.stringify({version:1,profile:freshProfile(),run,battle:w,savedAt:1})));assert.ok(saved.battle,c.id);
  const restored=saved.battle as BattleState;stepBattle(w,idle,7);stepBattle(restored,idle,7);assert.deepEqual(restored,w);
  const legacy=structuredClone(w);delete legacy.player.skillCooldown;delete legacy.player.skillTime;delete legacy.skillReleased;delete legacy.skillPulseAt;
  const old=sanitizeSave({version:1,profile:freshProfile(),run,battle:legacy,savedAt:1});assert.equal(old.run?.phase,'battle');assert.ok(old.battle);
  stepBattle(old.battle as BattleState,{...idle,skill:true});assert.equal(old.battle!.player.skillCooldown,chassisSkill(c.id).cooldown);
 }
});
test('invalid skill timers are rejected and terminal battles cannot activate skills',()=>{
 for(const invalid of [-1,NaN,Infinity,'ready',null]){const {run,w}=scene('hive');(w.player as any).skillTime=invalid;
  const saved=sanitizeSave({version:1,profile:freshProfile(),run,battle:w,savedAt:1});assert.equal(saved.battle,null);assert.equal(saved.run?.phase,'prep');}
 const {w}=scene('scavenger');w.status='lost';const before=structuredClone(w);stepBattle(w,{...idle,skill:true},5);assert.deepEqual(w,before);
});
test('rare weapon prices drop while base weapons, supports and utilities retain prices',()=>{
 for(const m of MODULES)for(const tier of TIERS){const multiplier=(m.kind==='weapon'?[1,1.5,2.4,3.75]:[1,1.75,3,5])[tier-1];assert.equal(equipmentPrice(m.id,tier),Math.ceil(m.price*multiplier));}
 const r=newRun('scavenger','full',0,'PRICES');r.wave=9;r.gold=180;r.shop=[{id:'W07',tier:4,locked:true},...Array.from({length:3},()=>({id:'',locked:false}))];
 assert.equal(offerPrice(r.shop[0]),180);assert.ok(buy(r,0).ok);assert.equal(r.gold,0);const item=r.items.find(i=>i.id==='W07')!;assert.equal(item.tier,4);assert.ok(sell(r,item.uid).ok);assert.equal(r.gold,90);
});
test('navigation cache preserves paths and invalidates when geometry changes in place',()=>{
 const run=newRun('scavenger','full',0,'NAV-DEV11');run.wave=11;const {obstacles}=createEncounter(run),a={x:100,y:100},b={x:1500,y:1100};
 const first=findPath(a,b,obstacles,28);assert.deepEqual(findPath(a,b,obstacles,28),first);
 obstacles.push({x:700,y:400,w:100,h:400});const changed=findPath(a,b,obstacles,28);assert.deepEqual(changed,findPath(a,b,structuredClone(obstacles),28));assert.ok(changed.every(p=>traversable(p,28,obstacles)));
 for(const radius of [14,40,20])assert.deepEqual(findPath(a,b,obstacles,radius),findPath(a,b,structuredClone(obstacles),radius));
});
