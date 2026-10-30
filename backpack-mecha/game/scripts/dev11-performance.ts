// Deterministic synthetic stress tests, not natural play or real-device FPS.
import {pathToFileURL} from 'node:url';
import path from 'node:path';
import {writeFileSync} from 'node:fs';
import assert from 'node:assert/strict';
const baseline=process.argv[2];if(!baseline)throw Error('Pass the baseline project directory');
const load=async(root:string)=>({...(await import(pathToFileURL(path.resolve(root,'src/combat.ts')).href)),...(await import(pathToFileURL(path.resolve(root,'src/economy.ts')).href))});
const before=await load(baseline),after=await load('.'),idle={x:0,y:0,dash:false,overload:false};
function fixture(api:any,kind:string){
 const r=api.newRun('scavenger','full',4,'DEV11-PERF');r.wave=kind==='boss'?12:11;
 r.items=kind==='projectiles'?['W02','W07','W11'].map((id,i)=>({id,uid:'w'+i,tier:1,x:i,y:0,stored:false,rotation:0})):[];
 r.bosses[2]='B3B';const w=api.createBattle(r);w.player.invulnerable=10000;w.encounter.nextSpawn=10000;
 if(kind==='boss'){w.enemies.forEach((e:any)=>e.hp=e.maxHp*.2);w.bossClock=0;return w;}
 if(kind==='projectiles')w.obstacles=[];
 for(let i=0;i<60;i++){const a=i*Math.PI*2/60;const e=api.spawnEnemy(w,{id:kind==='navigation'?'E01':`E${String(i%16+1).padStart(2,'0')}`,x:800+Math.cos(a)*570,y:600+Math.sin(a)*470,elite:false,affix:0,reward:false,cost:0});e.hp=e.maxHp=100000;}
 if(kind==='projectiles'){
  const weapon=w.weapons[0];
  for(let i=0;i<240;i++){const a=i*Math.PI*2/240;w.bullets.push({eid:w.nextId++,x:800+Math.cos(a)*200,y:600+Math.sin(a)*200,vx:Math.cos(a)*200,vy:Math.sin(a)*200,radius:4,damage:5,life:12,color:'#fff',owner:'player',weapon:'W02',weaponUid:weapon.uid,kind:'ballistic',factor:1,shot:w.nextShot++,hitAt:{},pierce:5,bounces:2,bounceFactor:.75,traveled:0,range:3000,slow:0,applyStatus:true,source:'W02'});}
 }
 return w;
}
function normalize(w:any){const copy=structuredClone(w);delete copy.player.skillTime;delete copy.player.skillCooldown;delete copy.skillReleased;delete copy.skillPulseAt;for(const e of copy.enemies)e.path=e.path.map((p:any)=>({x:p.x,y:p.y}));return copy;}
const distribution=(values:number[])=>{const v=values.toSorted((a,b)=>a-b);return {samples:v.length,p50Ms:v[Math.ceil(v.length*.5)-1],p95Ms:v[Math.ceil(v.length*.95)-1],maxMs:v.at(-1),totalMs:v.reduce((a,b)=>a+b,0)};};
const results=[];
for(const kind of ['navigation','projectiles','boss']){
 const a=fixture(before,kind),b=fixture(after,kind);assert.deepEqual(normalize(a),normalize(b));
 // Warm up both engines and verify unchanged RNG, damage, entities, and paths at every tick.
 for(let tick=0;tick<360;tick++){const input={...idle,x:Math.sin(tick/60),y:Math.cos(tick/60)};before.stepBattle(a,input);after.stepBattle(b,input);assert.deepEqual(normalize(a),normalize(b),`${kind} tick ${tick}`);}
 const samples={before:[] as number[],after:[] as number[]};
 for(let round=0;round<6;round++)for(const label of (round%2?['after','before']:['before','after']) as ('before'|'after')[]){
  const api=label==='before'?before:after,w=fixture(api,kind);
  for(let tick=0;tick<360;tick++){const input={...idle,x:Math.sin(tick/60),y:Math.cos(tick/60)},start=performance.now();api.stepBattle(w,input);samples[label].push(performance.now()-start);}
 }
 results.push({scene:kind,parityTicks:360,before:distribution(samples.before),after:distribution(samples.after)});
}
const report={description:'Synthetic Node simulation timings; no browser rendering or real-device FPS. Skills unused for rule parity.',node:process.version,baseline,results};
writeFileSync('qa/dev11-performance.json',JSON.stringify(report,null,2)+'\n');console.log(JSON.stringify(report,null,2));
