import test from 'node:test';
import assert from 'node:assert/strict';
import {TRAINING_PRESETS,trainingRun,chassisUnlocked,difficultyLimit} from '../src/training.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
import {CHASSIS,BOSSES} from '../src/content.ts';
import {newRun,startWave,validateLoadout} from '../src/economy.ts';
import {createBattle,spawnEnemy,stepBattle} from '../src/combat.ts';
import {clearPath,traversable} from '../src/encounters.ts';
import {motionFrame} from '../src/motion.ts';
const idle={x:0,y:0,dash:false,overload:false};
const setup={chassis:'scavenger',boss:'B1A',difficulty:0,tier:2 as const,power:18,modules:TRAINING_PRESETS[0].modules};
function arena(){const run=newRun('scavenger','full',0,'DEV7-AI');run.wave=11;run.items=[];const w=createBattle(run);w.obstacles=[];w.encounter.nextSpawn=10000;w.player.invulnerable=1000;return w;}
function enemy(w:ReturnType<typeof arena>,id:string,x=500,y=650){return spawnEnemy(w,{id,x,y,elite:false,affix:0,reward:false,cost:0});}

test('unlock override round-trips without replacing earned unlocks or difficulty',()=>{
 const p=freshProfile();p.unlocked.push('bulwark');p.maxDifficulty=2;const earned=[...p.unlocked];
 assert.equal(chassisUnlocked(p,'hive'),false);p.settings.unlockAll=true;
 const restored=sanitizeSave({version:1,profile:p}).profile;
 assert.ok(CHASSIS.every(c=>chassisUnlocked(restored,c.id)));assert.equal(difficultyLimit(restored),4);
 restored.settings.unlockAll=false;assert.deepEqual(restored.unlocked,earned);assert.equal(difficultyLimit(restored),2);assert.equal(chassisUnlocked(restored,'hive'),false);
});
test('all six training presets fit every chassis and launch the chosen boss without shared state',()=>{
 const career=newRun('scavenger','full',0,'CAREER'),before=JSON.stringify(career),presets=JSON.stringify(TRAINING_PRESETS);
 for(const chassis of CHASSIS)for(const boss of BOSSES)for(const preset of TRAINING_PRESETS){
  const result=trainingRun({...setup,chassis:chassis.id,boss:boss.id,modules:preset.modules});
  assert.ok(result.ok,`${chassis.id}/${boss.id}/${preset.name}: ${result.reason}`);const r=result.run!;
  assert.ok(validateLoadout(r).ok);assert.equal(r.extra?.training,true);assert.ok(startWave(r).ok);
  const w=createBattle(r);assert.equal(w.bossId,boss.id);assert.equal(w.weapons.length,preset.modules.filter(id=>id.startsWith('W')).length);
 }
 assert.equal(JSON.stringify(career),before);assert.equal(JSON.stringify(TRAINING_PRESETS),presets);
});
test('training refuses empty, duplicated, overpowered and over-armed loadouts',()=>{
 for(const modules of [[],['W01','W01'],['W01','W02','W03','W04'],['unknown'],['W10','W11','W12','S01','S02','S04','U02']]){
  assert.equal(trainingRun({...setup,power:10,modules}).ok,false,modules.join(','));
 }
 assert.equal(trainingRun({...setup,difficulty:8}).ok,false);
});
test('fast melee turns toward player immediately and does not orbit an unobstructed target',()=>{
 const w=arena(),e=enemy(w,'E02');e.angle=Math.PI;const initial=Math.hypot(e.x-w.player.x,e.y-w.player.y);
 stepBattle(w,idle,.6);assert.ok(Math.hypot(e.x-w.player.x,e.y-w.player.y)<initial-80);assert.ok(Math.abs(e.y-650)<1);
});
test('chase routes around a wall without crossing collision geometry',()=>{
 const w=arena(),e=enemy(w,'E02');w.player.x=1000;w.obstacles=[{x:700,y:450,w:80,h:380}];
 assert.equal(clearPath(e,w.player,w.obstacles,e.radius),false);
 for(let i=0;i<600;i++){stepBattle(w,idle);assert.ok(traversable(e,e.radius,w.obstacles));}
 assert.ok(Math.hypot(e.x-w.player.x,e.y-w.player.y)<50);
});
test('later ranged enemies telegraph then fire forward, with slowing tethers and positive orb damage',()=>{
 for(const [id,count] of [['E07',3],['E09',2],['E11',5],['E06',1]] as const){
  const w=arena();enemy(w,id);stepBattle(w,idle,.6);assert.equal(w.bullets.length,0,id);assert.ok(w.zones.some(z=>!z.active),id);if(id==='E07'||id==='E09')assert.ok(w.zones.some(z=>z.kind==='cone'&&z.width!>0));
  stepBattle(w,idle,.9);const shots=w.bullets.filter(b=>b.owner==='enemy');assert.equal(shots.length,count,id);
  assert.ok(shots.every(b=>b.vx>0&&b.damage>0),id);if(id==='E09')assert.ok(shots.every(b=>b.slow>.0));
 }
});
test('split crate mortar locks its warning to a location with time to dodge',()=>{
 const w=arena();enemy(w,'E10');stepBattle(w,idle,.6);const z=w.zones.find(z=>z.plan.effect==='mortar')!;
 assert.ok(z&&!z.active);assert.equal(z.radius,62);assert.equal(z.x,w.player.x);
 const marked={x:z.x,y:z.y};stepBattle(w,{...idle,y:-1},.8);assert.equal(z.x,marked.x);assert.equal(z.y,marked.y);assert.ok(Math.abs(w.player.y-z.y)>z.radius);
});
test('shot recoil belongs only to the enemy that fired, even among identical units',()=>{
 const w=arena(),a=enemy(w,'E04'),b=enemy(w,'E04',500,800);b.cooldown=10;
 stepBattle(w,idle,1.25);const m=motionFrame(w);assert.equal(m.get(a.eid)?.stage,'active');assert.notEqual(m.get(b.eid)?.stage,'active');
});
test('visible scrap drop and pickup events preserve the exact economy amount',()=>{
 const r=newRun('scavenger','full',0,'SCRAP-EVENTS');const w=createBattle(r);w.obstacles=[];w.encounter.nextSpawn=10000;
 const e=spawnEnemy(w,{id:'E01',x:1000,y:650,elite:false,affix:0,reward:true,cost:1});e.hp=1;e.speed=0;
 stepBattle(w,idle,.7);const drop=w.events.find(e=>e.type==='scrap-drop');assert.ok(drop);assert.equal(drop.amount,e.reward);assert.equal(w.stats.goldEarned,0);
 w.player.x=1000;stepBattle(w,idle);const pickup=w.events.find(e=>e.type==='pickup');assert.ok(pickup?.to);assert.equal(pickup.amount,e.reward);assert.equal(w.stats.goldEarned,e.reward);assert.equal(w.drops.length,0);
});
