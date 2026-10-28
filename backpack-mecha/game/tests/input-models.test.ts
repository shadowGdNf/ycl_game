import test from 'node:test';
import assert from 'node:assert/strict';
import {createInputDriver} from '../scripts/input-models.ts';
import {createPilotMemory,decide} from '../scripts/probe-pilot.ts';
import {newRun,startWave} from '../src/economy.ts';
import {createBattle,stepBattle} from '../src/combat.ts';
import type {BattleView,InputFrame} from '../src/types.ts';

test('frequent input model reproduces the original pilot without changing the observed world',()=>{
 const run=newRun('scavenger','full',0,'driver');startWave(run);const world=createBattle(run);
 const build={preferredSurfaceRange:210},memory=createPilotMemory(1),driver=createInputDriver('frequent',build,1);
 let expected:InputFrame=memory.lastInput;
 for(let tick=0;tick<720;tick++){
  if(tick%6===0)expected=decide(world,build,memory);
  const before=structuredClone(world),actual=driver.input(world,tick);
  assert.deepEqual(actual,expected);assert.deepEqual(world,before);stepBattle(world,actual,1/60);
 }
});

test('delayed decisions are applied only after their fixed latency and keep a bounded pending queue',()=>{
 const driver=createInputDriver('delayed',{preferredSurfaceRange:210},0,view=>({x:view.time,y:0,dash:false,overload:false}));
 const outputs=[];
 for(let tick=0;tick<180;tick++)outputs.push(driver.input({time:tick+1} as BattleView,tick).x);
 assert.ok(outputs.slice(0,18).every(x=>x===0));assert.equal(outputs[18],1);assert.equal(outputs[35],1);
 assert.equal(outputs[36],19);assert.ok(driver.stats.maxPending<=2);
});

test('sparse skill model enforces independent dash/overload intervals while preserving steering',()=>{
 const driver=createInputDriver('sparse',{preferredSurfaceRange:210},0,()=>({x:.5,y:-.5,dash:true,overload:true}));
 const presses:{dash:number[];overload:number[]}={dash:[],overload:[]};let previous={dash:false,overload:false};
 for(let tick=0;tick<5401;tick++){
  const input=driver.input({} as BattleView,tick);assert.equal(input.x,.5);assert.equal(input.y,-.5);
  for(const key of ['dash','overload'] as const)if(input[key]&&!previous[key])presses[key].push(tick);
  previous=input;
 }
 assert.deepEqual(presses.overload,[0,2700,5400]);assert.deepEqual(presses.dash,[0,720,1440,2160,2880,3600,4320,5040]);
 assert.ok(driver.stats.suppressedDash>0);assert.ok(driver.stats.suppressedOverload>0);
});
