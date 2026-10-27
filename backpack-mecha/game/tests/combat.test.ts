import test from 'node:test';
import assert from 'node:assert/strict';
import {newRun,resolveBattle,startWave} from '../src/economy.ts';
import {MODULE_BY_ID} from '../src/content.ts';
import {battleResult,createBattle,damagePlayer,spawnEnemy,stepBattle} from '../src/combat.ts';
import type {BattleState,EnemyState} from '../src/combat.ts';
import type {InputFrame,Item,Tier} from '../src/types.ts';

const idle:InputFrame={x:0,y:0,dash:false,overload:false};
function setup(ids=['W01'],supports:{id:string;weapon:number;tier?:Tier}[]=[],utilities:string[]=[]):BattleState {
 const run=newRun('scavenger','full',0,'combat-tests');
 run.items=ids.map((id,i)=>({uid:`w${i}`,id,tier:1,x:i*2,y:1,rotation:0,stored:false}));
 for(const [i,s] of supports.entries())run.items.push({uid:`s${i}`,id:s.id,tier:s.tier||1,x:i,y:3,rotation:0,stored:false,link:`w${s.weapon}`});
 for(const [i,id] of utilities.entries())run.items.push({uid:`u${i}`,id,tier:1,x:i,y:4,rotation:0,stored:false});
 const w=createBattle(run);w.obstacles=[];w.encounter.budget=0;w.encounter.nextSpawn=1000;w.rng=12345;return w;
}
function dummy(w:BattleState,x=w.player.x+110,y=w.player.y):EnemyState {
 const e=spawnEnemy(w,{id:'E03',x,y,elite:false,affix:0,reward:false,cost:0});e.hp=e.maxHp=10000;e.armor=0;e.speed=0;e.damage=0;e.cooldown=1000;return e;
}
const advance=(w:BattleState,seconds:number,input=idle)=>stepBattle(w,input,seconds);

test('every weapon has an executable attack and damages an in-range target',()=>{
 for(let n=1;n<=12;n++){
  const id=`W${String(n).padStart(2,'0')}`,w=setup([id]),range=MODULE_BY_ID[id]!.range||100;
  dummy(w,w.player.x+Math.min(60,range*.6));advance(w,2);
  assert.ok(w.stats.damageByModule[id]>0,`${id} did not deal damage`);
  assert.ok(w.weapons[0]!.shotCount>0,`${id} did not fire`);
  assert.ok(Number.isFinite(w.stats.damageByModule[id]));
 }
});

test('wet electric bonus is replaced by conductive contact and chains never revisit a target',()=>{
 const ordinary=setup(['W04']),enhanced=setup(['W04'],[{id:'S05',weapon:0}]);
 for(const w of [ordinary,enhanced])for(let i=0;i<6;i++){const e=dummy(w,w.player.x+100+i*50);e.wet=3;}
 advance(ordinary,.2);advance(enhanced,.2);
 assert.equal(ordinary.stats.maxChain,4);assert.equal(enhanced.stats.maxChain,5);
 assert.equal(enhanced.enemies[0]!.maxHp-enhanced.enemies[0]!.hp,14);
 assert.ok(enhanced.stats.damageByModule.W04>ordinary.stats.damageByModule.W04);
});

test('split shots are independent, while support modifiers still use the same weapon instance',()=>{
 const w=setup(['W01'],[{id:'S03',weapon:0},{id:'S01',weapon:0}]);dummy(w);advance(w,.15);
 assert.equal(w.weapons[0]!.shotCount,1);assert.equal(w.bullets.length,2);assert.notEqual(w.bullets[0]!.shot,w.bullets[1]!.shot);
 advance(w,.25);assert.ok(w.stats.damageByModule.W01>8);
});

test('oil and burning create bounded secondary explosions without recursive trigger loops',()=>{
 const w=setup(['W05','W06'],[{id:'S06',weapon:0,tier:3}]),e=dummy(w);advance(w,2.2);
 assert.ok(w.stats.damageByModule.W05>35);assert.ok(e.burns.length>0&&e.burns.length<=5);
 assert.ok(w.events.filter(e=>e.type==='explosion'&&e.source==='W05').length<=2);
 assert.ok(w.zones.length<20);assert.ok(w.bullets.length<10);assert.ok(Number.isFinite(e.hp));
});

test('normal enemies freeze but a boss accumulates stagger without a permanent freeze',()=>{
 const normal=setup(['W12'],[{id:'S12',weapon:0}]),n=dummy(normal);normal.weapons[0]!.cooldown=100;
 for(let i=0;i<5;i++){normal.weapons[0]!.cooldown=0;advance(normal,.2);}
 assert.ok(n.frozen>0);
 const run=newRun('scavenger','full',0,'ice-boss');run.wave=4;run.bosses=['B1A'];run.items=[{uid:'w0',id:'W12',tier:1,x:1,y:1,rotation:0,stored:false},{uid:'s0',id:'S12',tier:1,x:1,y:2,rotation:0,stored:false,link:'w0'}];
 const boss=createBattle(run),b=boss.enemies[0]!;b.x=boss.player.x+70;b.y=boss.player.y;b.speed=0;b.damage=0;boss.bossCenter={x:b.x,y:b.y};boss.bossClock=1000;boss.weapons[0]!.cooldown=100;
 for(let i=0;i<5;i++){boss.weapons[0]!.cooldown=0;advance(boss,.2);}
 assert.equal(b.frozen,0);assert.equal(b.stagger,20);
});

test('two connected drone hives stay at five drones and recycler never recursively counts bonus shots',()=>{
 const drones=setup(['W11','W11'],[{id:'S10',weapon:0},{id:'S02',weapon:1}]);dummy(drones);advance(drones,.2);
 assert.equal(drones.weapons.reduce((sum,w)=>sum+w.droneCount,0),5);
 const recycler=setup(['W01'],[],['U10']);dummy(recycler);advance(recycler,2.3);
 assert.equal(recycler.weapons[0]!.shotCount,6);assert.equal(recycler.nextShot,8);
});

test('shared boss bodies take one explosion hit but separate projectiles may each hit',()=>{
 const run=newRun('scavenger','full',0,'shared');run.wave=8;run.bosses=['B1A','B2B'];
 run.items=[{uid:'w',id:'W10',tier:1,x:1,y:1,rotation:0,stored:false}];
 const shared=createBattle(run);shared.bossClock=1000;shared.bossCenter={x:920,y:650};shared.rng=12345;
 shared.enemies.forEach((e,i)=>{e.x=900+i*40;e.y=650;e.speed=0;e.damage=0;e.frozen=1000;});
 const single=JSON.parse(JSON.stringify(shared)) as BattleState;single.enemies=single.enemies.slice(0,1);
 advance(shared,.7);advance(single,.7);
 assert.equal(shared.stats.damageByModule.W10,single.stats.damageByModule.W10);
 assert.equal(shared.enemies[0]!.hp,shared.enemies[1]!.hp);
});

test('split children grant normal kill events but cannot duplicate scrap or kill-budget rewards',()=>{
 const w=setup(['W01']);w.encounter.budget=100;w.player.invulnerable=100;
 const crate=spawnEnemy(w,{id:'E10',x:850,y:650,elite:false,affix:0,reward:true,cost:3});crate.hp=1;crate.armor=0;crate.speed=0;crate.damage=0;
 advance(w,5);
 assert.equal(w.stats.kills,3);assert.equal(w.stats.killedBudget,3);
 assert.ok(Math.abs(w.stats.goldEarned-w.encounter.wave.bonus*3/100)<1e-8);
});

test('insurance resolves once, shield overflow reaches hull, and hit protection blocks repeated damage',()=>{
 const w=setup([],[],['U12']);w.player.shield=5;
 assert.equal(damagePlayer(w,12,'E01'),12);assert.equal(w.player.hp,93);assert.equal(w.player.shield,0);
 assert.equal(damagePlayer(w,12,'E01'),0);
 advance(w,.4);damagePlayer(w,1000,'E03');assert.equal(w.player.hp,15);assert.equal(w.insuranceUsed,true);assert.equal(w.status,'playing');
 advance(w,1.1);damagePlayer(w,1000,'E03');assert.equal(w.status,'lost');
});

test('dash grants brief immunity, cooldown and overload timers advance only through simulation',()=>{
 const w=setup([]);advance(w,1/60,{...idle,x:1,dash:true,overload:true});const x=w.player.x;
 assert.equal(damagePlayer(w,100,'E01'),0);assert.ok(w.player.overloadTime>3.9);assert.ok(w.player.dashCooldown>5.9);
 advance(w,.15,{...idle,x:1});assert.equal(damagePlayer(w,100,'E01'),0);assert.ok(w.player.x>x);
 advance(w,.08);assert.ok(damagePlayer(w,1,'E01')>0);
 const snapshot=JSON.stringify(w);stepBattle(w,idle,0);assert.equal(JSON.stringify(w),snapshot);
});

test('normal-wave timeout wins before a late projectile can kill the player',()=>{
 const w=setup([]);w.time=w.duration-1/60;w.player.hp=1;w.player.shield=0;
 w.bullets.push({eid:999,x:w.player.x,y:w.player.y,vx:0,vy:0,radius:10,damage:100,life:1,color:'#f00',owner:'enemy',kind:'ballistic',factor:1,shot:999,hitAt:{},pierce:1,bounces:0,bounceFactor:0,traveled:0,range:500,slow:0,applyStatus:false,source:'late-shot'});
 advance(w,1/60);assert.equal(w.status,'won');assert.equal(w.player.hp,1);assert.equal(battleResult(w).stats.damageTaken,0);
});

test('JSON round trip preserves live bullets, status layers, cooldowns and deterministic RNG',()=>{
 const original=setup(['W05','W06','W12'],[{id:'S06',weapon:0},{id:'S03',weapon:2}],['U03','U09']);dummy(original);advance(original,1.35);
 assert.ok(original.enemies[0]!.burns.length>0);
 const resumed=JSON.parse(JSON.stringify(original)) as BattleState;
 for(let i=0;i<180;i++){const input={...idle,x:i<60?.4:0,y:i>=60&&i<120?.3:0,overload:i===40,dash:i===100};stepBattle(original,input);stepBattle(resumed,input);}
 assert.deepEqual(resumed,original);assert.deepEqual(battleResult(resumed),battleResult(original));
});

test('30Hz and 60Hz rendering inputs produce the same 60Hz simulation',()=>{
 const sixty=setup(['W01']),thirty=setup(['W01']);dummy(sixty);dummy(thirty);
 for(let i=0;i<120;i++)stepBattle(sixty,idle,1/60);
 for(let i=0;i<60;i++)stepBattle(thirty,idle,1/30);
 assert.deepEqual(thirty,sixty);
});

test('safe-recovery protocol is paid once by run settlement, not by both combat and economy',()=>{
 const run=newRun('scavenger','full',0,'settlement');run.hp=50;run.protocols=['P08'];assert.ok(startWave(run).ok);
 const w=createBattle(run);w.time=w.duration-1/60;stepBattle(w,idle);assert.equal(w.player.hp,50);
 assert.ok(resolveBattle(run,battleResult(w)).ok);assert.equal(run.hp,58);
});
