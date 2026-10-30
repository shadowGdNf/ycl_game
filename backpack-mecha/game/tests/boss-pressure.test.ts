import test from 'node:test';
import assert from 'node:assert/strict';
import {BOSSES,CHASSIS_BY_ID} from '../src/content.ts';
import {bossTurn,bossPursuitSpeed} from '../src/encounters.ts';
import {newRun} from '../src/economy.ts';
import {createBattle,stepBattle} from '../src/combat.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
const idle={x:0,y:0,dash:false,overload:false},bossPoint={x:800,y:300},playerPoint={x:800,y:650};
function scene(id:string,difficulty=0,phase=1,index=0){const boss=BOSSES.find(b=>b.id===id)!,r=newRun('bulwark','full',difficulty,`DEV9-${id}`);r.wave=boss.act*4;r.bosses[boss.act-1]=id;r.items=[];r.phase='battle';const w=createBattle(r);w.player.invulnerable=1000;w.enemies.forEach(e=>{e.hp=e.maxHp*(phase===1?1:phase===2?.45:.2);});w.bossClock=0;w.bossTurn=index;return {r,w};}

test('every boss fires projectiles and keeps visible wind-ups and recovery at every threat',()=>{
 for(const boss of BOSSES)for(const phase of [1,2,3])for(let difficulty=0;difficulty<=4;difficulty++){
  const turns=Array.from({length:6},(_,i)=>bossTurn(boss.id,phase,i,bossPoint,playerPoint,difficulty));
  assert.ok(turns.some(t=>t.plans.some(p=>p.effect==='projectile')),boss.id);
  for(const t of turns){assert.ok(t.recovery>=.4&&t.recovery<=(t.combo?1.1:1));assert.ok(t.plans.every(p=>p.warning>=.6));assert.ok(t.plans.filter(p=>!p.delay).every(p=>p.warning>=.8));
   for(const p of t.plans)assert.ok(Number.isFinite(p.x+p.y+p.warning+p.active+p.damage));
  }
 }
});
test('twin and carrier final phases have denser barrages with genuine gaps',()=>{
 for(const [id,phase,bullets] of [['B2B',2,64],['B3B',3,120]] as const){
  const turn=bossTurn(id,phase,id==='B2B'?1:2,bossPoint,playerPoint),shots=turn.plans.filter(p=>p.effect==='projectile');
  assert.equal(shots.reduce((n,p)=>n+p.count!,0),bullets);
  for(const p of shots){assert.ok(p.speed!>330);const step=p.spread!>=Math.PI*2-.01?p.spread!/p.count!:p.spread!/(p.count!-1);assert.ok(2*150*Math.sin(step/2)>2*(14+(p.projectileRadius??5)),'A player fits between adjacent shots at 150 units');}
  if(id==='B3B')assert.ok(Math.PI*2-shots[0].spread!>=Math.PI/3-1e-9);
 }
});
test('higher threats and overload accelerate attacks without removing warnings or changing the attack sequence',()=>{
 for(const boss of BOSSES)for(let i=0;i<12;i++){
  const normal=bossTurn(boss.id,2,i,bossPoint,playerPoint),hard=bossTurn(boss.id,2,i,bossPoint,playerPoint,4),overload=bossTurn(boss.id,2,i,bossPoint,playerPoint,4,true);
  assert.equal(normal.plans.length,hard.plans.length);assert.ok(normal.combo?hard.recovery===normal.recovery:hard.recovery<normal.recovery);assert.ok(overload.recovery<=hard.recovery);
  normal.plans.forEach((p,index)=>{assert.equal(hard.plans[index].warning,p.warning);if(p.effect==='projectile'||p.effect==='charge'){assert.ok(hard.plans[index].speed!>p.speed!);assert.ok(overload.plans[index].speed!>hard.plans[index].speed!);}});
 }
});
test('faster charges remain inside their warning lane and pursuit stays escapable on foot',()=>{
 for(let difficulty=0;difficulty<=4;difficulty++)for(const phase of [1,2,3])for(const enraged of [false,true]){
  const turn=bossTurn('B1A',phase,0,bossPoint,playerPoint,difficulty,enraged);
  for(const p of turn.plans){assert.ok(p.speed!>=540);assert.ok(p.speed!*p.active+p.h!/2<=p.w!);}
  for(const boss of BOSSES){const speed=bossPursuitSpeed(boss.speed,phase,difficulty,enraged);assert.ok(speed>boss.speed);assert.ok(speed<CHASSIS_BY_ID.bulwark.speed);}
 }
});
test('crab can start the next attack while its previous ground fire is still active',()=>{
 const {w}=scene('B2A',0,3,2);stepBattle(w,{...idle,x:1},2.6);
 assert.ok(w.bossTurn>=3);assert.ok(w.zones.some(z=>z.plan.effect==='fire'&&z.active));assert.ok(w.zones.some(z=>z.plan.effect!=='fire'&&!z.active));
});
test('all 64 twin projectiles are released once with the tuned velocity',()=>{
 const {w}=scene('B2B',0,2,2);stepBattle(w,idle);w.bossClock=1000;const seen=new Set<number>();
 for(let i=0;i<240;i++){stepBattle(w,idle);for(const b of w.bullets.filter(b=>b.owner==='enemy')){seen.add(b.eid);assert.ok(Math.abs(Math.hypot(b.vx,b.vy)-396)<1e-8);}}
 assert.equal(seen.size,64);
});
test('dense boss pressure stays bounded and finite at maximum threat',()=>{
 for(const boss of BOSSES){const {w}=scene(boss.id,4,3);for(let i=0;i<3600;i++){
  stepBattle(w,{...idle,x:Math.cos(i/240),y:Math.sin(i/240)});assert.ok(w.bullets.length<180,boss.id);assert.ok(w.zones.length<40,boss.id);assert.ok(w.enemies.length<=70);assert.ok(Number.isFinite(w.player.x+w.player.y+w.enemies[0].hp));
 }assert.ok(w.bossTurn>=10,boss.id);}
});
test('save/reload preserves queued dense volleys and resumes deterministically',()=>{
 const {r,w}=scene('B3B',4,3,4);stepBattle(w,idle,1.5);
 const saved=sanitizeSave(JSON.parse(JSON.stringify({version:1,profile:freshProfile(),run:r,battle:w,savedAt:1})));assert.ok(saved.battle);assert.ok(saved.run);
 const resumed=saved.battle as typeof w;stepBattle(w,idle,3);stepBattle(resumed,idle,3);assert.deepEqual(JSON.parse(JSON.stringify(resumed)),JSON.parse(JSON.stringify(w)));
});
