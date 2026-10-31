import test from 'node:test';
import assert from 'node:assert/strict';
import * as economy from '../src/economy.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
import {RenderQuality,MAX_FRAME_SECONDS} from '../src/performance.ts';
import type {Run} from '../src/types.ts';

function advance(r:Run){
 if(r.eventId&&!r.eventResolved)assert.equal(economy.resolveEvent(r,-1).ok,true);
 assert.equal(economy.startWave(r).ok,true);
 assert.equal(economy.resolveBattle(r,{won:true,hp:100,shield:0,elapsed:60,insuranceUsed:false,stats:{kills:0,killedBudget:0,goldEarned:0,maxChain:0,damageTaken:0,damageByModule:{},damageTakenBy:{}}}).ok,true);
 while(['reward','expansion','protocol'].includes(r.phase)){
  if(r.phase==='reward')economy.chooseReward(r,-1);
  else if(r.phase==='expansion')economy.chooseExpansion(r,[0,1,2,3].filter(x=>!r.unlockedCorners.includes(x)).slice(0,2));
  else economy.chooseProtocol(r,r.protocolOptions[0]);
 }
}
test('both contracts persist through rewards, events, boss expansion, reload and a manual return to standard',()=>{
 for(const route of [1,2] as const){
  let r=economy.newRun('scavenger','full',0,'remember-route');advance(r);
  assert.equal(economy.setRoute(r,route).ok,true);advance(r);
  assert.equal(r.wave,3);assert.equal(r.route,route);
  r=sanitizeSave({version:1,profile:freshProfile(),run:r,battle:null,savedAt:1}).run!;
  assert.equal(r.preferredRoute,route);advance(r);
  assert.equal(r.wave,4);assert.equal(r.route,0);assert.equal(r.preferredRoute,route);
  const before=structuredClone(r);assert.equal(economy.setRoute(r,route).ok,false);assert.deepEqual(r,before);
  advance(r);assert.equal(r.wave,5);assert.equal(r.route,route);
  assert.equal(economy.setRoute(r,0).ok,true);advance(r);assert.equal(r.route,0);assert.equal(r.preferredRoute,0);
  assert.equal(economy.newRun('scavenger','full',0,'another').route,0);
 }
});
test('remembered route cannot stack with event risk and unsuccessful choices never replace it',()=>{
 const r=economy.newRun('scavenger','full',0,'event');advance(r);economy.setRoute(r,2);advance(r);
 r.eventId='EV08';r.eventResolved=false;
 assert.equal(economy.resolveEvent(r,0).ok,false);assert.equal(r.preferredRoute,2);
 economy.setRoute(r,0);assert.equal(economy.resolveEvent(r,0).ok,true);
 assert.equal(economy.setRoute(r,1).ok,false);assert.equal(r.preferredRoute,0);
 advance(r);advance(r);assert.equal(r.route,0);
});
test('legacy route is retained and malformed preferences fall back without losing the run',()=>{
 const r=economy.newRun('scavenger','full',0,'old');r.wave=2;r.route=1;delete r.preferredRoute;
 const envelope={version:1,profile:freshProfile(),run:r,battle:null,savedAt:1};
 assert.equal(sanitizeSave(envelope).run!.preferredRoute,1);
 for(const preferredRoute of [null,99,'2',NaN])assert.equal(sanitizeSave({...envelope,run:{...r,preferredRoute}}).run!.preferredRoute,1);
});
test('render quality ignores isolated stalls, bounds resolution and recovers only after sustained headroom',()=>{
 const q=new RenderQuality();q.sample(1000);for(let i=0;i<10;i++)q.sample(2);assert.equal(q.pixelRatioLimit,2);
 for(let i=0;i<30;i++)q.sample(12);assert.equal(q.pixelRatioLimit,1.5);assert.equal(q.simpleEffects,true);
 for(let i=0;i<300;i++)q.sample(12);assert.equal(q.pixelRatioLimit,1);
 for(let i=0;i<299;i++)q.sample(2);assert.equal(q.pixelRatioLimit,1);
 q.sample(2);assert.equal(q.pixelRatioLimit,1.5);
 for(let i=0;i<300;i++)q.sample(2);assert.equal(q.pixelRatioLimit,2);assert.equal(q.simpleEffects,false);
 assert.equal(MAX_FRAME_SECONDS,3/60);
});
test('sustained slow presentation lowers visual cost even when command submission is fast',()=>{
 const q=new RenderQuality();q.sample(1,5000);assert.equal(q.pixelRatioLimit,2);
 for(let i=0;i<30;i++)q.sample(1,33.3);assert.equal(q.pixelRatioLimit,1.5);
 for(let i=0;i<300;i++)q.sample(1,20);assert.equal(q.pixelRatioLimit,1.5);
 for(let i=0;i<300;i++)q.sample(1,16.7);assert.equal(q.pixelRatioLimit,2);
});
