import test from 'node:test';
import assert from 'node:assert/strict';
import {newRun} from '../src/economy.ts';
import {createBattle,spawnEnemy,stepBattle} from '../src/combat.ts';
import {BOSSES} from '../src/content.ts';
import {bossTurn} from '../src/encounters.ts';
import {combatSound,GameAudio} from '../src/audio.ts';
import {drawCombatEffect,effectLife} from '../src/feedback.ts';
import {Renderer} from '../src/renderer.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
import type {CombatEvent} from '../src/types.ts';
const idle={x:0,y:0,dash:false,overload:false};
function scene(id='B3B',difficulty=0){const r=newRun('scavenger','full',difficulty,'DEV12-REGRESSION');r.wave=Number(id[1])*4;r.bosses[r.wave/4-1]=id;r.items=[];r.phase='battle';const w=createBattle(r);w.bossClock=0;return {r,w};}

test('ordinary contact breaks a starter shield in two hits and invulnerable contact does not consume the attack',()=>{
 const r=newRun('scavenger','full',0,'CONTACT');r.items=[];const w=createBattle(r);w.obstacles=[];w.encounter.budget=0;
 const e=spawnEnemy(w,{id:'E01',x:w.player.x,y:w.player.y,elite:false,affix:0,reward:false,cost:0});e.speed=0;e.born=-1;e.cooldown=100;
 w.player.invulnerable=.2;w.lastDamage=0;stepBattle(w,idle,.1);assert.equal(e.contactAt,0);assert.equal(w.stats.damageTaken,0);
 stepBattle(w,idle,.15);assert.equal(w.player.shield,9);assert.equal(w.player.hp,100);
 stepBattle(w,idle,.8);assert.equal(w.stats.damageTaken,11,'Contact still respects its one-second successful-hit cooldown');
 stepBattle(w,idle,.3);assert.equal(w.player.shield,0);assert.equal(w.player.hp,98);assert.equal(w.stats.damageTaken,22);
});

test('healer has no hidden fallback contact damage, while its telegraphed pulse is strengthened',()=>{
 const r=newRun('scavenger','full',0,'HEALER');r.wave=7;r.items=[];const w=createBattle(r);w.encounter.budget=0;w.obstacles=[];
 const e=spawnEnemy(w,{id:'E06',x:900,y:650,elite:false,affix:0,reward:false,cost:0});e.speed=0;e.cooldown=0;
 assert.equal(e.damage,0);stepBattle(w,idle);assert.equal(w.zones.find(z=>z.source==='E06')!.plan.damage,8);
});

test('boss contact, projectiles, carrier escorts and lingering fire use the stronger damage exactly once',()=>{
 const {w}=scene('B3B',4);w.player.invulnerable=100;w.bossTurn=1;assert.equal(w.enemies[0].damage,34.5);
 stepBattle(w,idle,1.5);assert.ok(w.enemies.some(e=>e.id==='E02'));assert.ok(w.enemies.filter(e=>e.id==='E02').every(e=>Math.abs(e.damage-13.8)<1e-9));
 assert.ok(w.bullets.filter(b=>b.source==='B3B').every(b=>Math.abs(b.damage-17.25)<1e-9));
 const {w:fire}=scene('B2A',0);fire.bossTurn=1;fire.player.invulnerable=10;stepBattle(fire,idle,1.3);
 const z=fire.zones.find(z=>z.plan.effect==='fire'&&z.active)!;assert.equal(z.plan.damage,24);fire.zones=[z];fire.bullets=[];fire.bossClock=100;
 fire.player.x=z.x;fire.player.y=z.y;fire.player.invulnerable=0;fire.enemies[0].damage=0;stepBattle(fire,idle);assert.equal(fire.stats.damageTaken,9);
});

test('orbital impact survives the short damage zone and preserves its exact rotated rectangle after reload',()=>{
 const {r,w}=scene();w.player.invulnerable=100;stepBattle(w,idle,1.55);
 assert.equal(w.zones.length,0);const impact=w.events.find(e=>e.type==='enemy-attack')!;
 assert.equal(impact.shape,'rect');assert.equal(impact.w,1200);assert.equal(impact.h,135);assert.equal(impact.angle,Math.PI/2);assert.equal(combatSound(impact),'beam');
 const restored=sanitizeSave(JSON.parse(JSON.stringify({version:1,profile:freshProfile(),run:r,battle:w,savedAt:1}))).battle!;
 assert.deepEqual(restored.events.find(e=>e.id===impact.id),JSON.parse(JSON.stringify(impact)));
 const calls:{name:string,args:unknown[]}[]=[];const c=new Proxy({}, {get:(_,name)=> (...args:unknown[])=>calls.push({name:String(name),args})}) as CanvasRenderingContext2D;
 for(const reduced of [false,true]){calls.length=0;drawCombatEffect(c,impact,w.time-impact.at,effectLife(impact),reduced,'zh',1);
  assert.ok(calls.some(call=>call.name==='rect'&&JSON.stringify(call.args)==='[0,-67.5,1200,135]'));
  assert.ok(calls.some(call=>call.name==='stroke'));assert.ok(calls.some(call=>call.name==='clip'&&call.args[0]==='evenodd'));
 }
 const renderer=new Renderer({getContext:()=>c} as unknown as HTMLCanvasElement) as any;
 renderer.captureEvents(w);assert.ok(renderer.effects.some((fx:any)=>fx.event.id===impact.id));
});

test('every real boss attack cue has both a visible release and sound in normal and reduced motion',()=>{
 const events:CombatEvent[]=[];
 for(const boss of BOSSES){const {w}=scene(boss.id);w.player.invulnerable=1000;w.enemies.forEach(e=>e.hp=e.maxHp*.2);
  for(let i=0;i<60*35;i++){stepBattle(w,idle);for(const e of w.events)if(e.type==='enemy-attack'&&!events.some(old=>old.source===e.source&&old.cue===e.cue&&old.shape===e.shape))events.push(e);}
 }
 for(const cue of ['rect','line','cone','circle','ring','charge','projectile','pull','conveyor','fire','mortar','spawn'])assert.ok(events.some(e=>e.cue===cue),cue);
 for(const e of events)for(const reduced of [false,true]){
  let paints=0;const c=new Proxy({}, {get:(_,name)=>()=>{if(['stroke','fill','fillRect'].includes(String(name)))paints++;}}) as CanvasRenderingContext2D;
  drawCombatEffect(c,e,.08,effectLife(e),reduced,'zh',1);assert.ok(paints>0,`${e.source} ${e.cue}`);assert.ok(combatSound(e),`${e.source} ${e.cue}`);
 }
 const audio=new GameAudio(freshProfile().settings),played:string[]=[];audio.play=type=>{played.push(type);};
 const sequenced=events.map((e,i)=>({...e,id:i+1}));audio.consume(sequenced);audio.consume(sequenced);assert.equal(played.length,events.length);
});

test('sweep release keeps the safe inner arc, and new ranged follow-ups retain complete warnings',()=>{
 const {w}=scene('B1B');w.bossTurn=1;w.player.invulnerable=100;stepBattle(w,idle,1);
 const e=w.events.find(e=>e.type==='enemy-attack'&&e.cue==='cone')!,arcs:unknown[][]=[];
 const c=new Proxy({}, {get:(_,key)=>key==='arc'?(...args:unknown[])=>arcs.push(args):()=>{}}) as CanvasRenderingContext2D;
 drawCombatEffect(c,e,.05,.5,false,'zh',1);assert.ok(arcs.some(a=>a[2]===100&&a[5]===true));
 for(const [id,index] of [['B1A',1],['B1B',0],['B2A',2],['B2B',0]] as const){
  const plans=bossTurn(id,1,index,{x:800,y:300},{x:800,y:800}).plans;
  assert.ok(plans.some(p=>p.effect==='projectile'||p.x===800&&p.y===800),id);
  assert.ok(plans.every(p=>p.warning>=.8),id);
 }
});
