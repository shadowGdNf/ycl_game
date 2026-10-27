import test from 'node:test';
import assert from 'node:assert/strict';
import * as e from '../src/economy.ts';
import {recordAction,recordFrame,recordPrepTime,exportRunReport,preserveJournal} from '../src/journal.ts';
import {sanitizeSave,freshProfile} from '../src/storage.ts';
import {FocusGesture} from '../src/input.ts';
import type {BattleResult} from '../src/types.ts';

const outcome:BattleResult={won:true,hp:80,shield:5,elapsed:40,insuranceUsed:false,stats:{damageByModule:{W01:100},damageTakenBy:{E01:20},kills:5,killedBudget:5,goldEarned:4,maxChain:0,damageTaken:20}};
test('wave record captures immutable loadout, shop supply, actual income and exactly one settlement',()=>{
 const r=e.newRun('scavenger','full',0,'report'),original=structuredClone(r.items);
 recordPrepTime(r,.5);e.startWave(r);recordFrame(r,16);recordFrame(r,55);e.resolveBattle(r,outcome);
 assert.deepEqual(r.journal?.waves[0].start.items,original);assert.equal(r.journal?.waves[0].prepSeconds,.5);
 assert.equal(r.journal?.waves[0].end?.income,32);assert.equal(r.journal?.waves[0].end?.gold,72);
 assert.equal(r.journal?.frames[1].samples,2);assert.equal(r.journal?.frames[1].over50ms,1);
 assert.ok(r.journal?.events.some(event=>event.action==='shop'&&event.shop.filter(o=>o.id).length===4));
 const before=structuredClone(r);assert.equal(e.resolveBattle(r,outcome).ok,false);assert.deepEqual(r,before);
 const report=exportRunReport(r);report.journal.waves[0].start.items[0].tier=3;assert.equal(r.journal!.waves[0].start.items[0].tier,1);
});

test('failed actions are atomic, while undo preserves the audit and time but rolls back the full economic state',()=>{
 const r=e.newRun('scavenger','full',0,'undo');e.startWave(r);e.resolveBattle(r,outcome);
 const start=structuredClone(r);assert.equal(e.buy(r,9).ok,false);assert.deepEqual(r,start);
 e.sell(r,r.items[1].uid);recordPrepTime(r,.75);e.refreshShop(r);assert.equal(e.undoSale(r).ok,true);
 assert.equal(r.gold,start.gold);assert.deepEqual(r.items,start.items);assert.deepEqual(r.shop,start.shop);assert.deepEqual(r.rng,start.rng);
 assert.equal(r.journal!.prepSeconds[2],.75);assert.equal(r.journal!.events.at(-1)?.action,'undo-sale');assert.ok(r.journal!.events.some(event=>event.action==='sell'));
 const edited=structuredClone(r);e.storeItem(r,r.items[1].uid);recordPrepTime(r,.25);preserveJournal(r,edited,'undo-edit');
 assert.equal(edited.journal!.prepSeconds[2],1);assert.equal(edited.journal!.events.at(-1)?.action,'undo-edit');
});

test('old or damaged diagnostics never invalidate a usable save, and partial history is identified',()=>{
 const r=e.newRun('scavenger','full',0,'old');delete r.journal;
 const base={version:1,profile:freshProfile(),run:r,battle:null,savedAt:1};
 const legacy=sanitizeSave(base);assert.ok(legacy.run);assert.equal(legacy.run.journal,undefined);
 recordPrepTime(legacy.run,.1);assert.equal(legacy.run.journal?.partial,true);
 for(const journal of [null,{}, {version:1,events:[null]}, {...legacy.run.journal,frames:{1:{samples:'bad'}}}]){
  const restored=sanitizeSave({...base,run:{...r,journal}});assert.ok(restored.run);assert.equal(restored.run.journal,undefined);
 }
});

test('diagnostics are bounded and invalid timer samples do not poison exported data',()=>{
 const r=e.newRun('scavenger','full',0,'bounds');for(let i=0;i<420;i++)recordAction(r,'test');
 assert.equal(r.journal!.events.length,400);assert.equal(r.journal!.droppedEvents,21);
 for(const value of [NaN,Infinity,-1]){recordPrepTime(r,value);recordFrame(r,value);}
 assert.deepEqual(r.journal!.prepSeconds,{});assert.deepEqual(r.journal!.frames,{});
 const restored=sanitizeSave({version:1,profile:freshProfile(),run:JSON.parse(JSON.stringify(r)),battle:null,savedAt:0});assert.deepEqual(restored.run?.journal,r.journal);
});

test('focus gesture survives unrelated fingers, cancels on drag or pause, and fires once',()=>{
 const gesture=new FocusGesture();gesture.begin(2,100,150,0);gesture.end(1);gesture.move(1,1000,1000);
 assert.equal(gesture.take(349),undefined);assert.deepEqual(gesture.take(350),{x:100,y:150});assert.equal(gesture.take(700),undefined);
 gesture.begin(3,20,20,1000);gesture.move(3,40,20);assert.equal(gesture.take(1400),undefined);
 gesture.begin(4,20,20,1500);gesture.clear();assert.equal(gesture.take(1900),undefined);
 gesture.begin(5,20,20,2000);gesture.end(5);assert.equal(gesture.take(2400),undefined);
});
