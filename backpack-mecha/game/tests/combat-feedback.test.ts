import test from 'node:test';
import assert from 'node:assert/strict';
import {newRun} from '../src/economy.ts';
import {createBattle,stepBattle,damagePlayer,spawnEnemy} from '../src/combat.ts';
import type {ZoneState} from '../src/combat.ts';
import {combatSound,GameAudio} from '../src/audio.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
import {locomotion} from '../src/visual-motion.ts';
import {motionFrame} from '../src/motion.ts';

const idle={x:0,y:0,dash:false,overload:false};
function crane(weapon=false){
 const run=newRun('scavenger','full',0,'CRANE-FEEDBACK-REGRESSION');run.wave=4;run.bosses[0]='B1B';run.phase='battle';
 if(!weapon)run.items=[];
 const w=createBattle(run);w.bossClock=0;w.bossTurn=1;w.player.x=1000;w.player.y=300;return {run,w};
}

test('stationary player is hit when the crane sweep crosses between old 500ms pulse samples',()=>{
 const {w}=crane();w.player.shield=5;w.lastDamage=0;
 stepBattle(w,idle,2.4);
 assert.equal(w.stats.damageTaken,27);assert.equal(w.player.shield,0);assert.equal(w.player.hp,78);
 const hit=w.events.find(e=>e.type==='player-hit')!;
 assert.equal(hit.shieldDamage,5);assert.equal(hit.hullDamage,22);assert.deepEqual({x:hit.x,y:hit.y},{x:1000,y:300});
 assert.deepEqual(hit.from,{x:800,y:300});assert.equal(combatSound(hit),'hurt');
});

test('sweep preserves the safe inner arc and only hits the traversed outer sector',()=>{
 for(const radius of [85,200,310]){
  const {w}=crane();w.player.x=800+radius;w.enemies[0].damage=0;
  stepBattle(w,idle,2.4);assert.equal(w.stats.damageTaken,radius===200?27:0,`radius ${radius}`);
 }
});

test('entering an active area deals damage immediately, then respects its damage interval',()=>{
 const {w}=crane();w.bossClock=1000;w.enemies[0].speed=0;
 const plan={x:1200,y:600,kind:'circle' as const,radius:40,angle:0,warning:0,active:3,damage:10,period:.5};
 const z:ZoneState={...plan,id:999,plan,source:'test-hazard',duration:3,remaining:3,active:true,type:'hazard',color:'#f00',delay:0,age:0,pulse:0,triggered:false,originalAngle:0};
 w.zones=[z];stepBattle(w,idle,.15);assert.equal(w.stats.damageTaken,0);
 w.player.x=1200;w.player.y=600;stepBattle(w,idle,1/60);assert.equal(w.stats.damageTaken,10);
 stepBattle(w,idle,.4);assert.equal(w.stats.damageTaken,10);
 stepBattle(w,idle,.15);assert.equal(w.stats.damageTaken,20);
});

test('dash immunity is preserved, and contact is retried after immunity expires',()=>{
 const {w}=crane();w.player.invulnerable=1.55;
 stepBattle(w,idle,2.4);assert.equal(w.stats.damageTaken,27);
 const {w:dash}=crane();dash.player.dashTime=2.5;dash.dashAngle=0;
 stepBattle(dash,idle,.1);assert.equal(damagePlayer(dash,18,'B1B'),0);
});

test('equipped starter weapon damages the crane and emits directed impact events',()=>{
 const {w}=crane(true);stepBattle(w,idle,1.2);
 assert.ok(w.enemies[0].hp<w.enemies[0].maxHp);assert.ok(w.stats.damageByModule.W01>0);
 const hit=w.events.find(e=>e.type==='hit'||e.type==='critical')!;
 assert.ok(hit.from);assert.equal(hit.targetId,w.enemies[0].eid);assert.ok(hit.radius!>0);
});

test('electric endpoint survives the target dying during the same simulation tick',()=>{
 const run=newRun('scavenger','full',0,'ARC-FEEDBACK');run.items=[{id:'W04',uid:'arc',tier:1,x:1,y:1,rotation:0,stored:false}];
 const w=createBattle(run);w.encounter.budget=0;w.obstacles=[];
 const target=spawnEnemy(w,{id:'E01',x:900,y:650,elite:false,affix:0,reward:false,cost:0});target.hp=1;target.speed=0;
 stepBattle(w,idle,.2);assert.ok(!w.enemies.includes(target));assert.deepEqual(w.events.find(e=>e.type==='arc')!.to,{x:900,y:650});
});

test('combat sounds route shield, hull, critical and enemy shots and ignore bookkeeping',()=>{
 const {w}=crane();damagePlayer(w,10,'B1B',{x:800,y:300});
 assert.equal(combatSound(w.events.find(e=>e.type==='player-hit')!),'shield');
 assert.equal(combatSound({id:1,at:0,x:0,y:0,type:'critical'}),'critical');
 assert.equal(combatSound({id:1,at:0,x:0,y:0,type:'shield-break'}),'break');
 assert.equal(combatSound({id:1,at:0,x:0,y:0,type:'enemy-fire'}),'enemy-shot');
 const audio=new GameAudio(freshProfile().settings),played:string[]=[];audio.play=(type)=>{played.push(type);};
 audio.consume(w.events);audio.consume(w.events);assert.deepEqual(played,['shield']);
});

test('crane slam anticipation is visible before the active pull ends',()=>{
 const {w}=crane();w.bossTurn=0;w.player.invulnerable=100;
 stepBattle(w,idle,1/60);const slam=w.zones.find(z=>z.source==='B1B'&&z.plan.damage===33)!;
 stepBattle(w,idle,slam.remaining-.2);const m=motionFrame(w).get(w.enemies[0].eid)!;
 assert.ok(w.zones.some(z=>z.plan.effect==='pull'&&z.active&&z.remaining>0));
 assert.equal(m.kind,'slam');assert.equal(m.stage,'windup');assert.ok(m.progress>.8);
});

test('locomotion pauses exactly and walking phase depends on travel rather than render cadence',()=>{
 let slow=locomotion(undefined,{x:0,y:0},0),fast={...slow};
 for(let i=1;i<=30;i++)slow=locomotion(slow,{x:i*3,y:0},1/30);
 for(let i=1;i<=60;i++)fast=locomotion(fast,{x:i*1.5,y:0},1/60);
 assert.ok(Math.abs(slow.stride-fast.stride)<1e-10);assert.ok(Math.abs(slow.amount-fast.amount)<.01);
 assert.equal(locomotion(fast,{x:90,y:0},0),fast);
 const stopped=locomotion(fast,{x:90,y:0},.1);assert.ok(stopped.amount<fast.amount);assert.ok(stopped.amount>0);
});

test('existing battle saves resume the corrected sweep without discarding the run',()=>{
 const {run,w}=crane();stepBattle(w,idle,1.2);
 const saved=sanitizeSave(JSON.parse(JSON.stringify({version:1,profile:freshProfile(),run,battle:w,savedAt:1})));
 assert.equal(saved.run?.phase,'battle');assert.ok(saved.battle);
 const resumed=saved.battle as typeof w;stepBattle(resumed,idle,1.2);stepBattle(w,idle,1.2);
 assert.deepEqual(JSON.parse(JSON.stringify(resumed)),JSON.parse(JSON.stringify(w)));assert.equal(resumed.stats.damageTaken,27);
});
