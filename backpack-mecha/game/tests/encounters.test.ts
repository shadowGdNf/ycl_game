import test from 'node:test';
import assert from 'node:assert/strict';
import {newRun} from '../src/economy.ts';
import {BOSSES} from '../src/content.ts';
import {availableBudget,bossTurn,createEncounter,enemyPool,findPath,traversable} from '../src/encounters.ts';
import {contains,createBattle,stepBattle} from '../src/combat.ts';

const idle={x:0,y:0,dash:false,overload:false};

test('prototype, demo and full encounters exclude content that is not in their tier',()=>{
 assert.ok(enemyPool(7,'demo').every(id=>Number(id.slice(1))<=6));
 assert.ok(enemyPool(3,'prototype').every(id=>Number(id.slice(1))<=5));
 assert.equal(enemyPool(11,'full').length,16);
 for(const mode of ['prototype','demo'] as const){const run=newRun('scavenger',mode,0,'boss-tier');run.wave=4;run.bosses=['B1B'];assert.equal(createEncounter(run).boss,'B1A');}
});

test('budget ramps are 20/50/30 percent and route/event risk does not multiply twice',()=>{
 const run=newRun('scavenger','full',0,'budget');run.wave=11;run.route=1;run.extra={eventBudgetBonus:.15};
 const {state}=createEncounter(run);assert.equal(state.budget,Math.ceil(116*1.15));
 assert.equal(availableBudget(state,state.wave.duration*.25),Math.floor(state.budget*.2));
 assert.equal(availableBudget(state,state.wave.duration*.75),Math.floor(state.budget*.7));
 assert.equal(availableBudget(state,state.wave.duration),state.budget);
});

test('arena templates have navigable routes from spawn ring to center and across corners',()=>{
 const variants=new Set<number>();
 const geometry=new Set<string>();
 for(let act=1;act<=3;act++)for(let i=1;i<=80;i++){
  const run=newRun('scavenger','full',0,`map-${i}`);run.wave=act*4-3;
  const {state,obstacles}=createEncounter(run);variants.add(state.variant);geometry.add(JSON.stringify(obstacles));
  for(const [start,end] of [[{x:100,y:100},{x:1500,y:1100}],[{x:1500,y:100},{x:100,y:1100}],[{x:800,y:100},{x:800,y:650}]] as const){
   const path=findPath(start,end,obstacles,28);assert.ok(path.length>0);assert.ok(Math.hypot(path.at(-1)!.x-end.x,path.at(-1)!.y-end.y)<80);
   assert.ok(path.every(p=>traversable(p,28,obstacles)));
  }
 }
 assert.equal(variants.size,4);assert.equal(geometry.size,12);
});

test('wave spawning respects budget, population caps and visible spawn warning',()=>{
 const run=newRun('scavenger','full',0,'spawns');run.wave=11;run.items=[];
 const w=createBattle(run);w.player.invulnerable=1000;
 let sawWarning=false,sawEnemy=false;
 for(let frame=0;frame<3600&&w.status==='playing';frame++){
  stepBattle(w,idle);sawWarning ||= w.zones.some(z=>Boolean(z.spawn)&&!z.active);sawEnemy ||= w.enemies.length>0;
  assert.ok(w.enemies.length<=70);assert.ok(w.encounter.spent<=w.encounter.budget);
 }
 assert.ok(sawWarning&&sawEnemy);assert.equal(w.status,'won');
});

test('all six bosses expose complete telegraphs and execute phase-specific choreography',()=>{
 for(const boss of BOSSES){
  for(const phase of [1,2,3])for(let index=0;index<3;index++){
   const turn=bossTurn(boss.id,phase,index,{x:800,y:300},{x:800,y:650});assert.ok(turn.plans.length>0);
   assert.ok(turn.plans.every(p=>p.warning>=.4));assert.ok(turn.plans.filter(p=>!p.delay).every(p=>p.warning>=.8));
   assert.ok(turn.duration>0&&turn.recovery>=.4);
  }
  const run=newRun('bulwark','full',0,`boss-${boss.id}`);run.wave=boss.act*4;run.bosses[ boss.act-1]=boss.id;run.items=[];
  const world=createBattle(run);world.player.invulnerable=1000;world.enemies.forEach(e=>{e.hp=e.maxHp*.2;});
  stepBattle(world,idle,30);assert.equal(world.status,'playing');assert.ok(world.bossTurn>=3,`${boss.id} did not complete three actions`);
  assert.ok(world.enemies.every(e=>Number.isFinite(e.x)&&Number.isFinite(e.y)&&Number.isFinite(e.hp)));
 }
});

test('boss primary wind-ups never deal immediate damage before their warning ends',()=>{
 for(const boss of BOSSES){const run=newRun('bulwark','full',0,`windup-${boss.id}`);run.wave=boss.act*4;run.bosses[boss.act-1]=boss.id;run.items=[];
  const w=createBattle(run);stepBattle(w,idle,2.5);assert.equal(w.stats.damageTaken,0,boss.id);assert.ok(w.zones.some(z=>!z.active&&z.remaining>0));}
});

test('compactor charge can be dodged with the slow chassis and its damage stays inside the telegraph',()=>{
 const run=newRun('bulwark','full',0,'dodge');run.wave=4;run.bosses=['B1A'];run.items=[];
 const w=createBattle(run);stepBattle(w,idle,2.05);const warning=w.zones.find(z=>z.source==='B1A')!;assert.ok(warning&&!warning.active);
 stepBattle(w,{...idle,x:1},1);assert.equal(contains(warning,w.player,w.player.radius),false);
 stepBattle(w,idle,1.5);assert.equal(w.stats.damageTaken,0);
});

test('orbital bombing always leaves two wide safe corridors and twin beam endpoints are fixed',()=>{
 const bombing=bossTurn('B3B',3,0,{x:800,y:300},{x:800,y:650});
 for(const x of [540,1060])for(const y of [100,600,1100])assert.ok(bombing.plans.every(p=>!contains({...p,remaining:1,duration:1,active:false,color:'#f00',type:'warning',id:0},{x,y},60)));
 const twin=bossTurn('B2B',2,0,{x:800,y:300},{x:800,y:650});assert.equal(twin.plans[0]!.x,655);assert.equal(twin.plans[0]!.w,290);assert.equal(twin.plans[0]!.warning,1);
});
