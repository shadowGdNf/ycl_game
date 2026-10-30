import test from 'node:test';
import assert from 'node:assert/strict';
import {BOSSES} from '../src/content.ts';
import {newRun} from '../src/economy.ts';
import {bossTurn} from '../src/encounters.ts';
import {bossAttackSlot,BOSS_COMBOS} from '../src/boss-patterns.ts';
import {guardBossTurn,findEscapeRoute,routeInput} from '../src/boss-safety.ts';
import {contains,createBattle,stepBattle} from '../src/combat.ts';
import {zonePath} from '../src/motion-renderer.ts';
import {zoneVisible} from '../src/motion.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
const idle={x:0,y:0,dash:false,overload:false};
const positions=[{x:800,y:650},{x:20,y:20},{x:1580,y:20},{x:20,y:1180},{x:1580,y:1180},{x:800,y:1180},{x:20,y:600},{x:1580,y:600},{x:800,y:150},{x:980,y:400}];
function scene(id:string,phase=1,difficulty=0){
 const r=newRun('bulwark','full',difficulty,'DEV14-COMBO');r.items=[];r.phase='battle';r.wave=Number(id[1])*4;r.bosses[r.wave/4-1]=id;
 const w=createBattle(r);w.bossClock=0;w.player.speed*=.97;w.player.dashCooldown=100;
 w.enemies.forEach(e=>{e.hp=e.maxHp*(phase===1?1:phase===2?.45:.2);e.phase=phase;if(e.offsetX&&id==='B3B')e.exposed=phase>=2;});return {r,w};
}

test('six bosses each alternate three signature attacks with three named two-beat combinations',()=>{
 assert.deepEqual(Array.from({length:12},(_,i)=>bossAttackSlot(i)),[0,3,1,4,2,5,0,3,1,4,2,5]);
 for(const boss of BOSSES)for(const phase of [1,2,3])for(const difficulty of [0,4])for(let index=3;index<6;index++){
  const turn=bossTurn(boss.id,phase,index,{x:800,y:300},positions[0],difficulty,true);
  assert.equal(BOSS_COMBOS[boss.id].length,3);assert.equal(turn.combo?.length,4);
  assert.ok(turn.plans.some(p=>p.beat===1));assert.ok(turn.plans.some(p=>p.beat===2));
  assert.ok(turn.plans.every(p=>p.warning>=1.15));assert.equal(turn.recovery,1.1);
  assert.ok(turn.duration>=Math.max(...turn.plans.map(p=>(p.delay||0)+p.warning+p.active)));
 }
});

test('540 corner, edge and center combinations have a walking escape after reaction at 174.6 speed, without dash',()=>{
 let cases=0;
 for(const boss of BOSSES)for(const phase of [1,2,3])for(let index=3;index<6;index++)for(const position of positions){
  const {w}=scene(boss.id,phase,4);w.bossEnraged=true;Object.assign(w.player,position);
  const proposed=bossTurn(boss.id,phase,index,w.bossCenter!,w.player,4,true);
  const allowed=guardBossTurn(w,proposed);assert.ok(allowed,`${boss.id} phase ${phase} pattern ${index} @ ${position.x},${position.y}`);
  assert.ok(findEscapeRoute(w,allowed!));cases++;
 }
 assert.equal(cases,540);
});

test('certified routes survive the real 60Hz engine: 180 final-phase encounters, no immunity or dash',()=>{
 for(const boss of BOSSES)for(let index=3;index<6;index++)for(const position of positions){
  const {w}=scene(boss.id,3,4);w.bossEnraged=true;Object.assign(w.player,position);
  w.bossTurn=[1,3,5][index-3];const turn=guardBossTurn(w,bossTurn(boss.id,3,index,w.bossCenter!,w.player,4,true))!;
  assert.ok(turn);const route=findEscapeRoute(w,turn)!;assert.ok(route);
  stepBattle(w,idle);assert.ok(w.bossIntent);w.bossClock=1000;w.bossIntent!.until=1000;
  for(let i=0;i<Math.ceil(route.duration*60);i++)stepBattle(w,{...idle,...routeInput(route,i/60)});
  assert.equal(w.stats.damageTaken,0,`${boss.id} pattern ${index} @ ${position.x},${position.y} ${JSON.stringify(route)}`);
  assert.equal(w.status,'playing');assert.ok(w.player.dashCooldown>0);
 }
});

test('guard respects lingering fire, does not mutate plans or RNG, and defers a fully blocked combination',()=>{
 const {w}=scene('B2A');const fire={x:800,y:650,kind:'circle' as const,radius:2000,angle:0,warning:0,active:6,damage:10,effect:'fire' as const};
 w.zones.push({...fire,id:999,type:'hazard',color:'#f00',remaining:6,duration:6,active:true,plan:fire,delay:0,age:0,pulse:0,triggered:true,source:'B2A',originalAngle:0});
 w.bossTurn=1;const turn=bossTurn('B2A',1,3,w.bossCenter!,w.player),before=JSON.stringify({w,turn});
 assert.equal(guardBossTurn(w,turn),undefined);assert.equal(JSON.stringify({w,turn}),before);
 stepBattle(w,idle);assert.equal(w.bossTurn,1);assert.equal(w.zones.length,1);assert.ok(w.bossClock>0);assert.equal(w.bossIntent,undefined);
});

test('ring gap agrees with collision and painting, accounts for player radius and survives rotation',()=>{
 const ring={x:0,y:0,kind:'ring' as const,radius:220,innerRadius:198,angle:1,gapAngle:Math.PI/2,gapWidth:Math.PI*.62};
 assert.equal(contains(ring,{x:0,y:210},14),false);assert.equal(contains(ring,{x:0,y:-210},14),true);
 const boundary=ring.gapAngle+ring.gapWidth/2;assert.equal(contains(ring,{x:Math.cos(boundary)*210,y:Math.sin(boundary)*210},14),true);
 const arcs:number[][]=[];const ctx=new Proxy({},{get:(_,key)=>key==='arc'?(...args:number[])=>arcs.push(args):()=>{}}) as CanvasRenderingContext2D;
 zonePath(ctx,ring);assert.equal(arcs.length,2);assert.equal(arcs[0][3]+ring.angle,ring.gapAngle+ring.gapWidth/2);assert.equal(arcs[1][4],arcs[0][3]);
 for(const phase of [1,2,3])for(const index of [0,1,3,4,5])for(const p of bossTurn('B3A',phase,index,{x:800,y:300},positions[0]).plans)if(p.kind==='ring')assert.ok(p.gapWidth!>Math.PI/3);
});

test('predicted second beats intercept sustained strafing but remain fixed after the warning',()=>{
 const {w}=scene('B3B');w.bossTurn=1;stepBattle(w,{...idle,x:1});const second=w.zones.find(z=>z.beat===2)!;
 assert.ok(second.x>w.player.x+200);const marked={x:second.x,y:second.y,angle:second.angle};
 stepBattle(w,{...idle,x:-1},.8);assert.deepEqual({x:second.x,y:second.y,angle:second.angle},marked);
 // A straight runner reaches the predicted stripe, while a braking/reversing player escapes.
 assert.ok(contains(second,{x:w.player.x+174.6*(.8+1.8),y:650},14));
});

test('both combination beats are visible immediately, while the delayed beat retains its full countdown',()=>{
 const {w}=scene('B1A');w.bossTurn=1;stepBattle(w,idle);const second=w.zones.find(z=>z.beat===2)!;
 assert.ok(second.delay>0);assert.ok(zoneVisible(w,second));assert.equal(zoneVisible(w,{...second,beat:undefined}),false);
 const warning=second.remaining;stepBattle(w,idle,.2);assert.equal(second.remaining,warning);assert.equal(second.active,false);
});

test('432 moving-entry combinations either defer or survive an engine-replayed walking route',t=>{
 let played=0,deferred=0;
 for(const boss of BOSSES)for(let index=3;index<6;index++)for(const position of positions.slice(0,6))for(const a of [0,Math.PI/2,Math.PI,Math.PI*1.5]){
  const {w}=scene(boss.id,3,4);w.bossEnraged=true;Object.assign(w.player,position);w.bossTurn=[1,3,5][index-3];
  stepBattle(w,{...idle,x:Math.cos(a),y:Math.sin(a)});
  if(!w.bossIntent){assert.equal(w.zones.length,0);deferred++;continue;}
  const route=findEscapeRoute(w,{plans:[],duration:w.bossIntent.recoverAt-w.time,recovery:1.1});assert.ok(route,`${boss.id} ${index} ${JSON.stringify(position)} ${a}`);
  w.bossClock=1000;w.bossIntent.until=1000;
  for(let i=0;i<Math.ceil(route!.duration*60);i++)stepBattle(w,{...idle,...routeInput(route!,i/60)});
  assert.equal(w.stats.damageTaken,0,`${boss.id} ${index} ${JSON.stringify(position)} ${a}`);played++;
 }
 assert.equal(played+deferred,432);assert.ok(played>=400,`Unexpectedly many deferrals: ${deferred}`);t.diagnostic(`${played} walking replays, ${deferred} safe deferrals`);
});

test('escape forecasts account for a slow or Kestrel speed boost expiring during the attack',()=>{
 for(const boss of BOSSES)for(let index=3;index<6;index++)for(const buff of [false,true]){
  const {w}=scene(boss.id,3,4);w.bossTurn=[1,3,5][index-3];
  if(buff){w.chassis='kestrel';w.player.speed=245;w.player.skillTime=1.2;}else{w.slowUntil=1.2;w.slowAmount=.3;}
  stepBattle(w,idle);assert.ok(w.bossIntent);
  const route=findEscapeRoute(w,{plans:[],duration:w.bossIntent!.recoverAt-w.time,recovery:1.1});assert.ok(route);
  w.bossClock=1000;w.bossIntent!.until=1000;
  for(let i=0;i<Math.ceil(route!.duration*60);i++)stepBattle(w,{...idle,...routeInput(route!,i/60)});
  assert.equal(w.stats.damageTaken,0,`${boss.id} ${index} ${buff?'boost':'slow'}`);
 }
});

test('committed second beats keep their target, recovery holds position, and the combo survives save/reload',()=>{
 const {r,w}=scene('B1A');w.bossTurn=1;stepBattle(w,idle);const marked=w.zones.filter(z=>z.beat===2).map(z=>({x:z.x,y:z.y,angle:z.angle}));
 stepBattle(w,{...idle,x:1},.55);assert.deepEqual(w.zones.filter(z=>z.beat===2).map(z=>({x:z.x,y:z.y,angle:z.angle})),marked);
 const restored=sanitizeSave(JSON.parse(JSON.stringify({version:1,profile:freshProfile(),run:r,battle:w,savedAt:1}))).battle as typeof w;assert.ok(restored?.bossIntent);
 stepBattle(w,{...idle,x:1},.5);stepBattle(restored,{...idle,x:1},.5);assert.deepEqual(JSON.parse(JSON.stringify(restored)),JSON.parse(JSON.stringify(w)));
 const {w:recovery}=scene('B2B');recovery.bossTurn=1;recovery.player.x=300;stepBattle(recovery,idle);assert.ok(recovery.bossIntent);
 while(recovery.time<recovery.bossIntent!.recoverAt+.05)stepBattle(recovery,idle);
 const p={...recovery.bossCenter!};stepBattle(recovery,idle,.7);assert.deepEqual(recovery.bossCenter,p);
});
