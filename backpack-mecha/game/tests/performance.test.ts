import test from 'node:test';
import assert from 'node:assert/strict';
import {ForegroundFrameClock,FRAME_WINDOW_LIMIT,summarizeFrameWindow} from '../src/performance.ts';
import {recordFrame,exportRunReport} from '../src/journal.ts';
import {newRun,startWave} from '../src/economy.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';

test('foreground clock excludes pause, hidden intervals, replaced battles and explicit lifecycle resets',()=>{
 const c=new ForegroundFrameClock(),battle={};
 assert.equal(c.sample(0,battle),undefined);assert.equal(c.sample(16,battle),16);
 assert.equal(c.sample(20),undefined);assert.equal(c.sample(10000,battle),undefined);
 assert.equal(c.sample(10033,battle),33);
 c.reset();assert.equal(c.sample(30000,battle),undefined);assert.equal(c.sample(30016,battle),16);
 assert.equal(c.sample(30100,{}),undefined);assert.equal(c.sample(NaN,battle),undefined);
});

test('raw frame retention is bounded, reports nearest-rank p95, and keeps full-wave stall counts',()=>{
 const r=newRun('scavenger','full',0,'frames');startWave(r);
 for(let i=0;i<FRAME_WINDOW_LIMIT+100;i++)recordFrame(r,i<100?200:16,1,'desktop');
 const f=r.journal!.frames[1],summary=summarizeFrameWindow(f.recent!);
 assert.equal(f.samples,3700);assert.equal(f.over50ms,100);assert.equal(f.maxMs,200);
 assert.equal(f.recent!.intervals.length,3600);assert.equal(summary.interval.p95Ms,16);
 assert.equal(summary.discardedOlderSamples,100);assert.equal(summary.retainedSeconds,57.6);
 const exported=exportRunReport(r);assert.equal(exported.performance?.waves[1].interval.p95Ms,16);
 exported.journal.frames[1].recent!.intervals[0]=999;assert.equal(f.recent!.intervals[0],16);
});

test('viewport or settings changes start a new exact-sample window without erasing whole-wave data',()=>{
 const r=newRun('scavenger','full',0,'context');recordFrame(r,100,10,'portrait');recordFrame(r,20,2,'landscape');
 const f=r.journal!.frames[1];assert.equal(f.samples,2);assert.equal(f.over50ms,1);
 assert.equal(f.recent!.resets,1);assert.deepEqual(f.recent!.intervals,[20]);
 assert.equal(summarizeFrameWindow(f.recent!).render.p95Ms,2);
 for(const ms of [NaN,Infinity,-1,0])recordFrame(r,ms,1,'landscape');
 assert.equal(f.samples,2);
});

test('raw windows survive save/reload; broken optional samples preserve journal and valid progress',()=>{
 const r=newRun('scavenger','full',0,'save-window');recordFrame(r,16,2,'desktop');
 const envelope={version:1,profile:freshProfile(),run:r,battle:null,savedAt:1};
 assert.deepEqual(sanitizeSave(envelope).run!.journal,r.journal);
 for(const bad of [{}, {...r.journal!.frames[1].recent,next:99}, {...r.journal!.frames[1].recent,renders:[NaN]},
  {...r.journal!.frames[1].recent,intervals:Array(3601).fill(16)}]){
  const copy=structuredClone(envelope);copy.run.journal!.frames[1].recent=bad as never;
  const saved=sanitizeSave(copy);assert.ok(saved.run);assert.ok(saved.run.journal);
  assert.equal(saved.run.journal.frames[1].samples,1);assert.equal(saved.run.journal.frames[1].recent,undefined);
 }
 delete r.journal!.frames[1].recent;
 assert.deepEqual(sanitizeSave(envelope).run!.journal,r.journal);
});
