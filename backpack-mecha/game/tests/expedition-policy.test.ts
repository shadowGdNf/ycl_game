import test from 'node:test';
import assert from 'node:assert/strict';
import * as economy from '../src/economy.ts';
import {FAMILIES,prepare} from '../scripts/natural-policy.ts';
import {resolvePreferredEvent,chooseRiskRoute} from '../scripts/expedition-policy.ts';
import type {BranchRecord} from '../scripts/expedition-policy.ts';

/** Explicit event fixtures; natural encounter coverage is recorded by the probe. */
function event(id:string){const r=economy.newRun('scavenger','full',0,'events');r.wave=3;r.eventId=id;r.eventResolved=false;return r;}
test('event policy retains failed choices and falls back through public APIs without free resources',()=>{
 const r=event('EV01');r.gold=0;const records:BranchRecord[]=[];
 resolvePreferredEvent(r,FAMILIES[0],'first',records);
 assert.deepEqual(records.map(r=>[r.requested,r.accepted]),[[0,false],[1,true]]);
 assert.equal(r.gold,0);assert.equal(r.eventResolved,true);
});
test('event reward returns to preparation and is collected through the existing purchase policy',()=>{
 const r=event('EV01'),records:BranchRecord[]=[];
 prepare(r,FAMILIES[0],{onEvent:run=>resolvePreferredEvent(run,FAMILIES[0],'first',records)});
 assert.equal(r.phase,'prep');assert.equal(r.eventResolved,true);assert.ok(economy.validateLoadout(r).ok);
 assert.ok(r.journal!.events.some(e=>e.action==='reward'));assert.equal(records[0].goldAfter,16);
});
test('event risk prevents a second contract and rejection is retained without changing route',()=>{
 const r=event('EV04'),records:BranchRecord[]=[];
 resolvePreferredEvent(r,FAMILIES[0],'first',records);chooseRiskRoute(r,2,records);
 assert.equal(r.extra!.eventExtraElite,1);assert.equal(r.route,0);assert.equal(records.at(-1)!.accepted,false);
});
