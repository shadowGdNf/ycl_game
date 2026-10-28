import test from 'node:test';
import assert from 'node:assert/strict';
import {motionFrame,motionLabel,zoneRole,zoneVisible,chargeContactRadius} from '../src/motion.ts';
import {enemyMotionLabel,zonePath} from '../src/motion-renderer.ts';
import {Renderer} from '../src/renderer.ts';
import {createBattle,spawnEnemy,stepBattle} from '../src/combat.ts';
import {newRun,startWave} from '../src/economy.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
import {fixtureWorld,makeFixtures,idle} from '../scripts/motion-fixtures.ts';
import type {BattleState} from '../src/combat.ts';

const fixtures=makeFixtures();
const get=(id:string)=>structuredClone(fixtures.find(f=>f.id===id)!.world);
const pose=(w:BattleState)=>motionFrame(w).get(w.enemies[0].eid)!;

test('delayed charge stays invisible until its own warning, then follows its current angle',()=>{
 const w=get('B1A-p2-charge-windup'),second=w.zones.find(z=>z.delay>0)!;
 w.zones=[second];assert.equal(pose(w).stage,'recover');
 second.delay=0;second.remaining=second.duration;second.angle=.8;second.plan.angle=.8;
 assert.equal(pose(w).stage,'windup');assert.equal(pose(w).angle,.8);
 second.active=true;second.angle=1.1;assert.equal(pose(w).angle,1.1);
});

test('live zone survives freeze while dead sources cancel their warnings and explosion is emitted once',()=>{
 const w=get('E05-p1-detonate-windup');w.enemies[0].frozen=2;w.enemies[0].controlReason='ice';
 assert.equal(pose(w).control,'ice');assert.equal(pose(w).stage,'windup');stepBattle(w,idle,.6);
 assert.equal(w.events.filter(e=>e.type==='enemy-explosion').length,1);assert.ok(!w.enemies.some(e=>e.id==='E05'&&e.hp>0));
 stepBattle(w,idle,.1);assert.equal(w.events.filter(e=>e.type==='enemy-explosion').length,1);
 const killed=get('E05-p1-detonate-windup');killed.enemies[0].dead=true;killed.enemies[0].hp=0;stepBattle(killed,idle,.6);
 assert.ok(!killed.zones.some(z=>z.source==='E05'));assert.ok(!killed.events.some(e=>e.type==='enemy-explosion'));
});

test('impact, ice, stagger, and unknown legacy controls have separate labels and expire',()=>{
 for(const [id,reason,label] of [['E12-impact','impact','撞墙硬直'],['control-ice','ice','冰冻'],['control-stagger','stagger','失衡'],['control-unknown','unknown','行动受限']]){
  const w=get(id),m=pose(w);assert.equal(m.control,reason);assert.equal(motionLabel(m,'zh'),label);
  w.enemies[0].frozen=.001;stepBattle(w,idle);assert.equal(w.enemies[0]?.controlReason,undefined);
 }
});

test('charge path ends on impact; contact footprint uses the charge radius and disappears while controlled',()=>{
 const impact=get('B1A-impact'),stopped=impact.zones.find(z=>z.plan.effect==='charge'&&z.active)!;
 assert.ok(stopped);assert.equal(zoneVisible(impact,stopped),false);assert.equal(chargeContactRadius(impact.enemies[0],impact.time),undefined);
 const active=get('E12-p1-charge-active'),enemy=active.enemies[0],zone=active.zones.find(z=>z.plan.effect==='charge')!;
 assert.equal(zoneVisible(active,zone),true);assert.equal(chargeContactRadius(enemy,active.time),32.5);
 enemy.frozen=.3;enemy.controlReason='ice';assert.equal(chargeContactRadius(enemy,active.time),undefined);
 assert.equal(zoneVisible(active,zone),true,'An unexpired charge can resume after freezing');
});

test('a cryo projectile marks actual freezing and a boss stagger marks mechanical control',()=>{
 for(const boss of [false,true]){
  const r=newRun('scavenger','full',0,'motion-cryo');r.items=[{id:'W12',uid:'cryo',tier:1,x:0,y:0,rotation:0,stored:false}];
  if(boss){r.wave=4;r.bosses[0]='B1A';}
  const w=boss?createBattle(r):fixtureWorld('E03');if(!boss)w.weapons=createBattle(r).weapons;
  w.obstacles=[];w.encounter.nextSpawn=1000;w.player.invulnerable=1000;
  const e=w.enemies[0];e.x=w.player.x+70;e.y=w.player.y;e.speed=0;e.hp=e.maxHp=10000;e.armor=0;e.chill=4;e.chillUntil=100;e.stagger=90;
  for(let i=0;i<45&&!e.frozen;i++)stepBattle(w,idle);
  assert.ok(e.frozen>0);assert.equal(e.controlReason,boss?'stagger':'ice');
 }
});

test('weak point appears only within the furnace window and grouped bodies share the fixed attack plan',()=>{
 const w=get('B2A-p1-idle-recover');assert.equal(pose(w).weak,true);
 w.time=w.enemies[0].vulnerableUntil;assert.equal(pose(w).weak,false);assert.notEqual(motionLabel(pose(w),'zh'),'弱点暴露');
 const twin=get('B2B-p1-beam-active'),frames=motionFrame(twin);
 assert.equal(frames.get(twin.enemies[0].eid)!.zone,frames.get(twin.enemies[1].eid)!.zone);
 const x=frames.get(twin.enemies[0].eid)!.zone!.x;twin.enemies[0].x-=100;
 assert.equal(pose(twin).zone!.x,x);
});

test('instant projectile release remains visible after its warning is removed and expires on logic time',()=>{
 const w=get('B3B-p1-volley-active'),m=pose(w);
 assert.equal(m.stage,'active');assert.equal(m.kind,'volley');assert.equal(m.zone,undefined);
 assert.ok(w.bullets.some(b=>b.owner==='enemy'));assert.deepEqual(pose(JSON.parse(JSON.stringify(w))),m);
 stepBattle(w,idle,.2);assert.notEqual(pose(w).stage,'active');
});

test('crane inner safe arc is part of the path and force/spawn cues are not damage cues',()=>{
 const w=get('B1B-p1-sweep-active'),z=pose(w).zone!,arcs:number[][]=[];
 const c=new Proxy({}, {get:(_,key)=>key==='arc'? (...args:number[])=>arcs.push(args):()=>{}}) as CanvasRenderingContext2D;
 zonePath(c,z);assert.deepEqual(arcs.map(a=>a[2]),[z.radius,z.innerRadius]);assert.equal(arcs[1][5],true);
 assert.equal(zoneRole(get('B1B-p1-pull-active').zones.find(z=>z.plan.effect==='pull')!),'force');
 assert.equal(zoneRole(get('B1B-p1-summon-windup').zones[0]),'spawn');assert.equal(zoneRole(z),'damage');
});

test('boss state labels stay visible when the body is clipped by the viewport edge',()=>{
 const w=get('B3B-p3-bombard-windup'),e=w.enemies[0],drawn:{text:string;x:number;y:number}[]=[];
 const c=new Proxy({measureText:(s:string)=>({width:s.length*7}),fillText:(text:string,x:number,y:number)=>drawn.push({text,x,y})},{get:(o,k)=>k in o?(o as any)[k]:()=>{}}) as CanvasRenderingContext2D;
 const view={x:440,y:290,w:720,h:720};enemyMotionLabel(c,e,pose(w),e.radius*2.3,1,'zh',view);
 assert.equal(drawn.length,1);assert.ok(drawn[0].y>view.y);assert.ok(drawn[0].y<view.y+view.h);
 e.x=view.x+view.w-5;enemyMotionLabel(c,e,pose(w),e.radius*2.3,.5,'en',view);
 assert.ok(drawn[1].x+drawn[1].text.length*7/2<view.x+view.w);
});

test('valid legacy battle resumes with absent or invalid presentation metadata without dropping the run',()=>{
 const run=newRun('scavenger','full',0,'old-save');startWave(run);const w=createBattle(run);spawnEnemy(w,{id:'E03',x:900,y:650,elite:false,affix:0,reward:false,cost:0});
 assert.ok(w.enemies.length);
 for(const reason of [undefined,'not-a-control','ice','impact','stagger']){
  const raw=JSON.parse(JSON.stringify({version:1,profile:freshProfile(),run,battle:w,savedAt:123}));
  raw.battle.enemies[0].frozen=1;raw.battle.enemies[0].controlReason=reason;
  const restored=sanitizeSave(raw);assert.equal(restored.run?.phase,'battle');assert.ok(restored.battle);
  assert.equal(restored.battle.enemies[0].controlReason,['ice','impact','stagger'].includes(reason??'')?reason:undefined);
  assert.deepEqual(restored.battle.rng,w.rng);assert.deepEqual(restored.run,raw.run);
 }
});

test('all reachable boss phases render without changing frozen snapshots; pause and reload preserve poses',()=>{
 const freeze=(v:any):any=>{if(v&&typeof v==='object'){Object.values(v).forEach(freeze);Object.freeze(v);}return v;};
 const c=new Proxy({globalAlpha:1,createRadialGradient:()=>({addColorStop:()=>{}}),measureText:(s:string)=>({width:s.length*7})},{get:(obj,key)=>key in obj?(obj as any)[key]:()=>{}}) as CanvasRenderingContext2D;
 const canvas={getContext:()=>c,getBoundingClientRect:()=>({width:390,height:694}),width:390,height:694} as unknown as HTMLCanvasElement;
 const renderer=new Renderer(canvas);
 for(const fixture of fixtures){
  const w=freeze(structuredClone(fixture.world)),before=JSON.stringify(w);
  const a=[...motionFrame(w)],b=[...motionFrame(JSON.parse(before))];assert.equal(JSON.stringify(a),JSON.stringify(b));
  renderer.draw(w,{lang:'zh',reducedMotion:false,colorAssist:false});renderer.draw(w,{lang:'en',reducedMotion:true,colorAssist:true});
  assert.equal(JSON.stringify(w),before,fixture.id);assert.deepEqual([...motionFrame(w)],a);
 }
 for(const [id,phases] of [['B1A',2],['B1B',2],['B2A',3],['B2B',2],['B3A',3],['B3B',3]] as const){
  for(let phase=1;phase<=phases;phase++)assert.ok(fixtures.some(f=>f.id.startsWith(`${id}-p${phase}-`)&&f.world.enemies[0].phase===phase));
 }
});
