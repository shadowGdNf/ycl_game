import test from 'node:test';
import assert from 'node:assert/strict';
import * as e from '../src/economy.ts';
import {snapPlacement} from '../src/placement-input.ts';
import {trainingRun,toggleTrainingModule} from '../src/training.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
import type {TrainingSetup} from '../src/training.ts';

test('dragging from either end of a weapon tolerates offset landings and commits its exact preview',()=>{
 for(const grabX of [.05,.5,1.95])for(const grabY of [.05,.95])for(const dx of [-.3,0,.3])for(const dy of [-.3,0,.3]){
  const r=e.newRun('scavenger','full',0,'SNAP'),gun=r.items[0];r.items=[gun];r.unlockedCorners=[0,1,2,3];
  const before=structuredClone(r),plan=snapPlacement(r,gun.uid,{x:3+grabX+dx,y:3+grabY+dy},{x:grabX,y:grabY},0);
  assert.ok(plan.ok,`${grabX}/${grabY}/${dx}/${dy}: ${plan.reason}`);assert.equal(plan.item?.x,3);assert.equal(plan.item?.y,3);assert.deepEqual(r,before);
  assert.ok(e.applyPlacement(r,gun.uid,plan).ok);assert.deepEqual(r.items,plan.items);
 }
});
test('whole-item swap targets work at their far edge, while a drop far outside never moves inventory',()=>{
 const r=e.newRun('scavenger','full',0,'SWAP');r.unlockedCorners=[0,1,2,3];r.items=[{...r.items[0],x:0,y:0},{...r.items[0],uid:'other',id:'W03',x:3,y:3}];
 const plan=snapPlacement(r,r.items[0].uid,{x:4.98,y:3.97},{x:1.7,y:.7},0);assert.ok(plan.ok);assert.equal(plan.swappedUid,'other');
 assert.ok(e.applyPlacement(r,r.items[0].uid,plan).ok);assert.equal(r.items[1].x,0);assert.equal(r.items[0].x,3);
 const before=structuredClone(r),outside=snapPlacement(r,r.items[0].uid,{x:7,y:3},{x:.5,y:.5},0);assert.equal(outside.ok,false);assert.equal(e.applyPlacement(r,r.items[0].uid,outside).ok,false);assert.deepEqual(r,before);
});
test('no-spend confirmation is per stop, survives reload, and excludes free actions and rejected spending',()=>{
 const r=e.newRun('scavenger','full',0,'SPEND');assert.equal(e.shouldConfirmNoSpend(r),false);r.wave=2;r.gold=500;r.shop=Array.from({length:4},()=>({id:'W01',tier:1,locked:false}));
 assert.equal(e.shouldConfirmNoSpend(r),true);assert.ok(e.autoPack(r).ok);assert.equal(e.shouldConfirmNoSpend(r),true);
 const poor=structuredClone(r);poor.gold=0;assert.equal(e.refreshShop(poor).ok,false);assert.equal(e.shouldConfirmNoSpend(poor),true);
 assert.ok(e.refreshShop(r).ok);assert.equal(e.shouldConfirmNoSpend(r),false);
 const saved=sanitizeSave({version:1,profile:freshProfile(),run:r,battle:null,savedAt:1});assert.equal(e.shouldConfirmNoSpend(saved.run!),false);
 r.wave++;assert.equal(e.shouldConfirmNoSpend(r),true);r.extra!.training=true;assert.equal(e.shouldConfirmNoSpend(r),false);
});
test('buying, buying to the board, combining, repairs and paid events each count as spending',()=>{
 for(const action of ['reserve','board','merge','repair','event']){
  const r=e.newRun('scavenger','full',0,'SPEND-'+action);r.wave=2;r.gold=500;r.shop=Array.from({length:4},()=>({id:'W01',tier:1,locked:false}));r.hp=20;r.shop=Array.from({length:4},()=>({id:'W01',tier:1,locked:false}));
  const result=action==='reserve'?e.buy(r,0):action==='board'?e.buy(r,0,{x:1,y:3,rotation:0}):action==='merge'?e.buyAndMerge(r,0,r.items[0].uid):action==='repair'?e.repair(r):(()=>{r.eventId='EV05';r.eventResolved=false;return e.resolveEvent(r,1);})();
  assert.ok(result.ok,action+': '+result.reason);assert.equal(e.spentDuringPrep(r),true,action);
 }
});
test('a restored pre-purchase state requires confirmation again even with the operation journal retained',()=>{
 const r=e.newRun('scavenger','full',0,'UNDO-SPEND');r.wave=2;r.gold=500;r.shop=Array.from({length:4},()=>({id:'W01',tier:1,locked:false}));const before=structuredClone(r);assert.ok(e.refreshShop(r).ok);
 before.journal=r.journal;assert.equal(e.spentDuringPrep(before),false);
 const legacy=structuredClone(r);delete legacy.extra!.spentPrepWave;assert.equal(e.spentDuringPrep(legacy),true);
});
const setup:TrainingSetup={chassis:'scavenger',boss:'B1A',difficulty:0,tier:2,power:18,modules:['W01','S01']};
test('boss lab preserves edited coordinates, rotation and links through settings, launch and rematch',()=>{
 const r=trainingRun(setup).run!,gun=r.items.find(i=>i.id==='W01')!;
 assert.ok(e.moveItem(r,gun.uid,3,3,1).ok);const layout=structuredClone(r.items),custom={...setup,layout};
 for(const changes of [{},{tier:4 as const},{difficulty:3},{boss:'B3B'},{chassis:'hive'}]){
  const ready=trainingRun({...custom,...changes});assert.ok(ready.ok,ready.reason);
  assert.deepEqual(ready.run!.items.map(({tier,...item})=>item),layout.map(({tier,...item})=>item));
  assert.ok(e.startWave(ready.run!).ok);assert.deepEqual(ready.run!.items.map(({tier,...item})=>item),layout.map(({tier,...item})=>item));
 }
 assert.deepEqual(custom.layout,layout);assert.deepEqual(trainingRun(custom).run!.items,layout);
});
test('boss lab adding and removing modules preserves existing placements and rejects overlapping layouts',()=>{
 const initial=trainingRun(setup).run!,custom={...setup,layout:structuredClone(initial.items)},before=structuredClone(custom);
 const added=toggleTrainingModule(custom,'W03');assert.ok(added.ok);assert.deepEqual(custom,before);
 for(const item of initial.items){const actual=added.setup!.layout!.find(i=>i.uid===item.uid)!;assert.deepEqual([actual.x,actual.y,actual.rotation],[item.x,item.y,item.rotation]);}
 const removed=toggleTrainingModule(added.setup!,'W03');assert.ok(removed.ok);assert.deepEqual(removed.setup!.modules,setup.modules);
 const overlapping=structuredClone(initial.items);overlapping[1].x=overlapping[0].x;overlapping[1].y=overlapping[0].y;
 assert.equal(trainingRun({...setup,layout:overlapping}).ok,false);
 assert.equal(trainingRun({...setup,layout:[]}).ok,false);
 const empty=trainingRun({...setup,modules:[],layout:[]});assert.equal(empty.ok,false);assert.deepEqual(empty.run?.items,[]);
});
