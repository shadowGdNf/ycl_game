import test from 'node:test';
import assert from 'node:assert/strict';
import * as e from '../src/economy.ts';
import {searchPurchase,applyPurchasePlan} from '../scripts/purchase-search.ts';
import {createGrowthDiagnostics} from '../scripts/growth-diagnostics.ts';
import {FAMILIES,purchasePlan} from '../scripts/natural-policy.ts';
import type {Run} from '../src/types.ts';

/** Inventory fixtures for search guarantees; these are not natural-run evidence. */
function fixture():Run {const r=e.newRun('scavenger','full',0,'search-test');r.wave=2;r.shop=[{id:'U05',locked:false},{id:'',locked:false},{id:'',locked:false},{id:'',locked:false}];return r;}
test('expanded search funds a purchase by selling a real reserve item and replays through normal APIs',()=>{
 const r=fixture();r.gold=0;r.items.push({uid:'spare',id:'U03',tier:1,x:-1,y:-1,rotation:0,stored:true});
 // Two sale sources are necessary: 12 from the spare and 9 from the support.
 const before=structuredClone(r),found=searchPurchase(r,0,['U05'],()=>1);
 assert.equal(found.status,'found');assert.equal(found.plan!.removed.length,2);assert.deepEqual(r,before);
 applyPurchasePlan(r,found.plan!);assert.ok(r.items.some(i=>i.id==='U05'&&!i.stored));assert.equal(r.gold,5);assert.ok(e.validateLoadout(r).ok);
});
test('search separates total budget impossibility from a bounded search with no witness',()=>{
 const r=fixture();r.gold=0;r.items=[];assert.equal(searchPurchase(r,0,[],()=>1).status,'insufficient-total-scrap');
 const full=fixture(),out=searchPurchase(full,0,[],()=>1,0);assert.equal(out.status,'search-exhausted');assert.equal(out.truncated,true);
});
test('a found witness respects full reserve capacity and does not spend RNG while searching',()=>{
 const r=fixture();r.items.push(...['W02','W03','W12'].map((id,i)=>({uid:`spare-${i}`,id,tier:1 as const,x:-1,y:-1,rotation:0,stored:true})));
 const before=structuredClone(r),found=searchPurchase(r,0,['U05'],()=>1);assert.equal(found.status,'found');assert.deepEqual(r,before);
 applyPurchasePlan(r,found.plan!);assert.equal(r.items.filter(i=>i.stored).length,3);assert.deepEqual(r.rng,before.rng);
});
test('diagnostics capture exact states, preserve the source, and mark unassessed reward offers',()=>{
 const r=fixture(),family=FAMILIES.find(f=>f.id==='ballistic')!,diag=createGrowthDiagnostics(family),before=structuredClone(r);
 diag.observe(r,'shop');diag.observe(r,'shop');assert.equal(diag.records.length,1);assert.deepEqual(r,before);
 assert.deepEqual(diag.records[0].snapshot.rng,r.rng);assert.equal(diag.records[0].legacyPlanAvailable,!!purchasePlan(r,0,family));
 r.phase='reward';r.rewardOptions=['W07'];diag.observe(r,'reward');assert.equal(diag.records[1].source,'reward');assert.equal(diag.records[1].expanded,undefined);
 const bounded=createGrowthDiagnostics(family,0);bounded.observe(r,'reward');assert.equal(bounded.summary().dropped,1);
});
