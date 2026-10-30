import test from 'node:test';
import assert from 'node:assert/strict';
import {newRun,moveItem,storeItem} from '../src/economy.ts';
import {WorkshopRenderer} from '../src/workshop-renderer.ts';
import {weaponPose,impactOffset} from '../src/visual-motion.ts';
import {motionFrame} from '../src/motion.ts';
import {createBattle,spawnEnemy} from '../src/combat.ts';

test('animated inventory, undo and reduced motion never change inventory or its RNG',()=>{
 const r=newRun('scavenger','full',0,'motion-inventory'),renderer=new WorkshopRenderer();
 let paths=0;
 const ctx=new Proxy({globalAlpha:1,quadraticCurveTo:()=>paths++},{get:(obj,key)=>key in obj?(obj as any)[key]:()=>{}}) as CanvasRenderingContext2D;
 const canvas={getContext:()=>ctx} as unknown as HTMLCanvasElement;
 const draw=(time:number,reduced=false)=>renderer.draw(canvas,r,{time,reduced,ready:false,selected:r.items[1].uid,placements:[],icon:()=>{}});
 const before=structuredClone(r);
 draw(0);draw(.1);draw(1);draw(2,true);assert.deepEqual(r,before);assert.equal(paths,4,'one active connection is drawn each frame');
 const original=structuredClone(r.items);
 assert.ok(storeItem(r,r.items[1].uid).ok);const stored=structuredClone(r);draw(2.1);draw(2.3);assert.deepEqual(r,stored);assert.equal(paths,4,'stored supports do not keep a live connection');
 r.items=original;draw(3);assert.equal(paths,5,'restoring inventory restores its connection');
 assert.ok(moveItem(r,r.items[1].uid,0,3,0).ok);const moved=structuredClone(r);draw(3.1);draw(3.3);assert.deepEqual(r,moved);assert.equal(paths,5,'disconnected supports never display an active flow');
 renderer.reject(r.items[1].uid,4);draw(4.1);assert.deepEqual(r,moved);draw(5,true);assert.equal(renderer.needsFrame(true),false);
});

test('weapon reactions recover completely, remain finite and suppress displacement in reduced motion',()=>{
 for(const id of ['W01','W02','W07','W08','W09','W13','W14','W15','W18']){
  for(const age of [0,.016,.1,.24,.5,Infinity]){
   const pose=weaponPose(id,age,.12,false);assert.ok(Object.values(pose).every(Number.isFinite));
   const reduced=weaponPose(id,age,.12,true);assert.equal(reduced.recoil,0);assert.equal(reduced.swing,0);
  }
  assert.equal(weaponPose(id,.6,0,false).recoil,0);assert.ok(weaponPose(id,Infinity,0,false).swing===0);
 }
 const impact=impactOffset(.04,Math.PI/2,10,false);assert.ok(impact.y>0);assert.ok(Math.abs(impact.x)<1e-10);
 assert.deepEqual(impactOffset(.24,0,10,false),{x:0,y:0});assert.deepEqual(impactOffset(.04,0,10,true),{x:0,y:0});
});

test('enemy hit direction comes from impact and release poses are stable across pause / reload',()=>{
 const w=createBattle(newRun('scavenger','full',0,'motion-hit'));w.enemies=[];
 const e=spawnEnemy(w,{id:'E03',x:850,y:650,elite:false,affix:0,reward:false,cost:0});
 w.time=2;w.events=[{id:1,type:'hit',at:1.96,x:e.x,y:e.y,from:{x:e.x-80,y:e.y},targetId:e.eid},
  {id:2,type:'enemy-attack',at:1.92,x:e.x,y:e.y,targetId:e.eid,source:e.id,cue:'slam'}];
 const before=structuredClone(w),motion=motionFrame(w).get(e.eid)!;
 assert.equal(motion.hitAngle,0);assert.equal(motion.stage,'active');assert.ok(motion.releaseAge!<.1);
 assert.deepEqual(motionFrame(w).get(e.eid),motion);assert.deepEqual(motionFrame(JSON.parse(JSON.stringify(w))).get(e.eid),motion);assert.deepEqual(w,before);
 w.time=2.4;assert.equal(motionFrame(w).get(e.eid)?.hit,0);assert.equal(motionFrame(w).get(e.eid)?.releaseAge,undefined);
});
