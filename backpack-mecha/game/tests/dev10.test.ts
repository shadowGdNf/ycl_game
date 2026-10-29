import test from 'node:test';
import assert from 'node:assert/strict';
import * as econ from '../src/economy.ts';
import {deploymentWarnings,supportFeedback} from '../src/workshop.ts';
import {createBattle,spawnEnemy,stepBattle,battleResult} from '../src/combat.ts';
import {ENEMY_BY_ID} from '../src/content.ts';
import {enemyPool,chooseEnemy,createEncounter,traversable} from '../src/encounters.ts';
import {shopTierChances} from '../src/rarity.ts';
import {scrapPerCost,waveScrapLimit} from '../src/progression.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
import {trainingRun} from '../src/training.ts';
import {motionFrame} from '../src/motion.ts';
import type {Run,Item} from '../src/types.ts';
const idle={x:0,y:0,dash:false,overload:false};
const make=()=>econ.newRun('scavenger','full',0,'DEV10');
const item=(id:string,uid=id):Item=>({id,uid,tier:1,x:0,y:0,rotation:0,stored:false});
function arena(id:string){const r=make();r.wave=7;r.items=[];const w=createBattle(r);w.obstacles=[];w.encounter.nextSpawn=1000;w.player.invulnerable=1000;const e=spawnEnemy(w,{id,x:560,y:650,elite:false,affix:0,reward:false,cost:0});return {w,e};}

test('every higher-rarity cumulative chance rises throughout a run',()=>{
 let previous=[0,0,0];for(let n=1;n<=12;n++){const odds=shopTierChances(n),tail=[odds[1]+odds[2]+odds[3],odds[2]+odds[3],odds[3]];
  tail.forEach((v,i)=>assert.ok(v>=previous[i]));assert.ok(odds.every(v=>v>=0&&v<=1));previous=tail;}
 assert.ok(Math.abs(shopTierChances(12)[0]-.26)<1e-9);assert.equal(shopTierChances(12)[3],.1);
});
test('identical kills pay more later; settlement keeps the increased loot and still clamps forged totals',()=>{
 let previous=0;for(const wave of [1,2,3,5,6,7,9,10,11]){const r=make();r.wave=wave;r.eventResolved=true;assert.ok(econ.startWave(r).ok);const w=createBattle(r);w.obstacles=[];w.encounter.nextSpawn=1000;
  const e=spawnEnemy(w,{id:'E01',x:950,y:650,elite:false,affix:0,reward:true,cost:1});e.hp=1;e.speed=0;
  stepBattle(w,idle,.6);w.player.x=950;stepBattle(w,idle);assert.ok(w.stats.goldEarned>previous);assert.ok(Math.abs(w.stats.goldEarned-scrapPerCost(wave))<1e-9);previous=w.stats.goldEarned;
  const end=battleResult(w);end.won=true;const gold=r.gold;assert.ok(econ.resolveBattle(r,end).ok);assert.ok(r.gold>=gold+previous);
  const capRun=make();capRun.wave=wave;econ.startWave(capRun);const limit=waveScrapLimit(wave,createEncounter(capRun).state.budget);const fake={...end,stats:{...end.stats,goldEarned:1e8}};econ.resolveBattle(capRun,fake);assert.equal(capRun.stats.goldEarned,limit);
 }
});
test('reward rarity is rolled once, survives reload and is exactly the tier received',()=>{
 const r=make();r.wave=10;econ.startWave(r);const w=createBattle(r),outcome=battleResult(w);outcome.won=true;econ.resolveBattle(r,outcome);assert.equal(r.phase,'reward');
 const before=JSON.stringify(r),tiers=r.rewardOptions.map((_,i)=>econ.rewardTier(r,i));assert.equal(JSON.stringify(r),before);
 const restored=sanitizeSave({version:1,profile:freshProfile(),run:r,battle:null,savedAt:1}).run!;
 assert.deepEqual(restored.rewardOptions.map((_,i)=>econ.rewardTier(restored,i)),tiers);const id=restored.rewardOptions[0];assert.ok(econ.chooseReward(restored,0).ok);assert.equal(restored.items.at(-1)?.id,id);assert.equal(restored.items.at(-1)?.tier,tiers[0]);
 delete r.extra!.rewardTier0;assert.equal(econ.rewardTier(r,0),1);
});
test('arrange accepts incompatible, excess, weaponless and unpowered parts without losing items or reserves',()=>{
 for(const ids of [['W01','S05'],['W01','S01','S02','S03'],['S05','U02'],['W01','W04','W07','U02'],[]]){
  const r=make();r.power=0;r.unlockedCorners=[0,1,2,3];r.items=ids.map(id=>item(id));r.items.push({...item('U04','spare'),stored:true,x:-1,y:-1});const idsBefore=r.items.map(i=>i.uid),gold=r.gold,rng={...r.rng};
  assert.ok(econ.autoPack(r).ok,ids.join(','));assert.deepEqual(r.items.map(i=>i.uid),idsBefore);assert.ok(r.items.at(-1)?.stored);assert.equal(r.gold,gold);assert.deepEqual(r.rng,rng);
  const cells=r.items.filter(i=>!i.stored).flatMap(econ.getCells).map(p=>`${p.x},${p.y}`);assert.equal(new Set(cells).size,cells.length);
 }
});
test('arrange keeps valid links; battle edits and genuinely oversized bags fail atomically',()=>{
 const r=make(),before=structuredClone(r.items);assert.ok(econ.autoPack(r).ok);assert.equal(econ.activeSupports(r).length,1);assert.deepEqual(r.items.map(i=>i.uid),before.map(i=>i.uid));
 econ.startWave(r);const saved=structuredClone(r);assert.equal(econ.autoPack(r).ok,false);assert.deepEqual(r,saved);
 const big=make();big.items=['W07','W10','W11','S01','S02','S03','S04','S05','S06','S07','S08','S09','S10','S11','S12','U01','U02'].map(id=>item(id));const original=structuredClone(big);assert.equal(econ.autoPack(big).ok,false);assert.deepEqual(big,original);
});
test('warning reasons distinguish mismatch, distance and full slots; inactive supports never affect combat',()=>{
 const r=make();r.power=24;r.unlockedCorners=[0,1,2,3];r.items.push({...item('S05'),x:3,y:3,link:r.items[0].uid});
 assert.equal(supportFeedback(r,'S05','zh')?.status,'incompatible');assert.ok(deploymentWarnings(r,'zh')[0].reason.includes('标签'));
 assert.ok(econ.startWave(r).ok);const battle=createBattle(r);assert.equal(battle.weapons[0].supports.S05,undefined);assert.equal(battle.weapons[0].supports.S01,1);
 const far=make();far.items[1].x=3;far.items[1].y=3;assert.equal(supportFeedback(far,far.items[1].uid,'zh')?.status,'not-adjacent');assert.equal(createBattle(far).weapons[0].supports.S01,undefined);
 const full=make();full.power=24;full.unlockedCorners=[0,1,2,3];full.items=['W01','S01','S02','S03'].map(id=>item(id));assert.ok(econ.autoPack(full).ok);assert.equal(econ.activeSupports(full).length,2);assert.equal(deploymentWarnings(full,'zh').length,1);assert.equal(supportFeedback(full,econ.inactiveSupports(full)[0].uid,'zh')?.status,'slots-full');
});
test('invalid supports do not weaken hard deployment rules and lab permits compatible or inactive parts',()=>{
 const r=make();r.power=0;assert.equal(econ.startWave(r).ok,false);r.power=10;r.items=r.items.filter(i=>i.id==='S01');assert.equal(econ.startWave(r).ok,false);
 const lab=trainingRun({chassis:'scavenger',boss:'B1A',difficulty:0,tier:1,power:18,modules:['W01','S05']});assert.ok(lab.ok);assert.equal(deploymentWarnings(lab.run!,'en').length,1);
});
test('four new units unlock gradually and have nonzero normal encounter selection probability',()=>{
 for(const [id,first] of [['E13',2],['E14',3],['E15',5],['E16',7]] as const){assert.ok(!enemyPool(first-1,'full').includes(id));assert.ok(enemyPool(first,'full').includes(id));
  const r=make();r.wave=first;const enc=createEncounter(r).state;assert.ok(Array.from({length:1000},(_,i)=>chooseEnemy(enc,8,(i+.5)/1000)).includes(id));assert.ok(ENEMY_BY_ID[id].sprite);}
});
test('new attacks have readable warnings and distinct charge, sniper, mines and radial patterns',()=>{
 for(const id of ['E13','E14','E15','E16']){const {w,e}=arena(id);stepBattle(w,idle,.55);const z=w.zones.find(z=>z.sourceId===e.eid)!;assert.ok(z&&!z.active,id);assert.equal(w.bullets.length,0);assert.equal(motionFrame(w).get(e.eid)?.stage,'windup');
  if(id==='E13'){stepBattle(w,idle,.65);assert.ok(e.charge);assert.ok(e.x>560);}
  if(id==='E14'){stepBattle(w,idle,1.3);assert.ok(w.bullets.some(b=>b.source===id&&b.vx>600));}
  if(id==='E15'){const points=w.zones.map(z=>({x:z.x,y:z.y}));assert.equal(points.length,2);stepBattle(w,{...idle,x:1},1.3);assert.ok(w.zones.every((z,i)=>z.active&&z.x===points[i].x&&z.y===points[i].y));assert.ok(Math.abs(points[0].y-points[1].y)>96);}
  if(id==='E16'){stepBattle(w,idle,1);assert.equal(w.bullets.length,10);assert.ok(w.bullets.some(b=>b.vx<0)&&w.bullets.some(b=>b.vx>0));}
 }
});
test('new enemies resume deterministically with their in-flight warnings',()=>{
 for(const id of ['E13','E14','E15','E16']){const {w}=arena(id);stepBattle(w,idle,.65);const clone=JSON.parse(JSON.stringify(w));stepBattle(w,idle,2);stepBattle(clone,idle,2);assert.deepEqual(JSON.parse(JSON.stringify(clone)),JSON.parse(JSON.stringify(w)));assert.ok(w.enemies.every(e=>traversable(e,e.radius,w.obstacles)));}
});
test('inactive parts elsewhere do not mark a working placement as inactive',()=>{
 const r=make();r.items.push({...item('S05'),x:3,y:3});
 const gun=r.items[0],coil=r.items[1];assert.equal(econ.inactiveSupports(r).length,1);
 assert.equal(econ.previewPlacement(r,gun.uid,gun.x,gun.y,gun.rotation).ready,true);
 assert.equal(econ.previewPlacement(r,coil.uid,coil.x,coil.y,coil.rotation).ready,true);
 assert.equal(econ.previewPlacement(r,'S05',3,3,0).ready,false);
});
