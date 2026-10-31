import test from 'node:test';
import assert from 'node:assert/strict';
import {MovementStick,FocusGesture} from '../src/input.ts';
import {newRun} from '../src/economy.ts';
import {createBattle,stepBattle} from '../src/combat.ts';

test('left mouse press moves toward its position without a drag; other buttons cannot move',()=>{
 for(const side of [false,true]){
  const stick=new MovementStick();
  assert.equal(stick.begin(1,'mouse',2,300,200,side),false);
  assert.equal(stick.begin(1,'mouse',1,300,200,side),false);
  assert.equal(stick.begin(1,'mouse',0,300,200,side),true);
  assert.deepEqual([stick.state!.dx,stick.state!.dy],[0,0]);
  stick.aimMouse({x:200,y:200},stick.state!);assert.deepEqual([stick.state!.dx,stick.state!.dy],[1,0]);
 }
});

test('cursor position controls actual combat displacement, caps diagonal speed and stops on release',()=>{
 const stick=new MovementStick(),world=createBattle(newRun('scavenger','full',0,'mouse-drag'));
 world.obstacles=[];world.encounter.nextSpawn=1000;world.weapons=[];
 const start={x:world.player.x,y:world.player.y};
 stick.begin(1,'mouse',0,1100,950,false);stick.aimMouse(world.player,stick.state!);
 assert.ok(Math.abs(Math.hypot(stick.state!.dx,stick.state!.dy)-1)<1e-10);
 const tick=()=>{if(stick.state)stick.aimMouse(world.player,stick.state);stepBattle(world,{x:stick.state?.dx??0,y:stick.state?.dy??0,dash:false,overload:false},1/60);};
 for(let i=0;i<30;i++)tick();
 assert.ok(world.player.x>start.x);assert.ok(world.player.y>start.y);
 stick.end(1);const stopped={x:world.player.x,y:world.player.y};
 for(let i=0;i<30;i++)tick();assert.deepEqual({x:world.player.x,y:world.player.y},stopped);
});

test('mouse direction is relative to the player, never the previous cursor position',()=>{
 const stick=new MovementStick(),player={x:100,y:100};stick.begin(1,'mouse',0,200,100,true);
 const aim=()=>stick.aimMouse(player,stick.state!);
 aim();assert.deepEqual([stick.state!.dx,stick.state!.dy],[1,0]);
 stick.move(1,199,100,1);aim();assert.deepEqual([stick.state!.dx,stick.state!.dy],[1,0]);
 stick.move(1,50,100,1);aim();assert.deepEqual([stick.state!.dx,stick.state!.dy],[-1,0]);
 stick.move(1,100,200,1);aim();assert.deepEqual([stick.state!.dx,stick.state!.dy],[0,1]);
 stick.move(1,100,50,1);aim();assert.deepEqual([stick.state!.dx,stick.state!.dy],[0,-1]);
 stick.move(1,200,200,1);aim();assert.ok(stick.state!.dx>0&&stick.state!.dy>0);
 assert.ok(Math.abs(Math.hypot(stick.state!.dx,stick.state!.dy)-1)<1e-10);
 // Player motion also changes direction even if no pointermove arrives.
 player.x=250;player.y=200;aim();assert.deepEqual([stick.state!.dx,stick.state!.dy],[-1,0]);
});

test('holding near the player stops without overshooting or oscillating',()=>{
 const stick=new MovementStick(),world=createBattle(newRun('scavenger','full',0,'cursor-arrival'));
 world.obstacles=[];world.encounter.nextSpawn=1000;world.weapons=[];
 const target={x:world.player.x+20,y:world.player.y};stick.begin(1,'mouse',0,target.x,target.y,true);
 for(let i=0;i<180;i++){
  const previous=world.player.x;stick.aimMouse(world.player,target);
  stepBattle(world,{x:stick.state!.dx,y:stick.state!.dy,dash:false,overload:false},1/60);
  assert.ok(world.player.x>=previous&&world.player.x<=target.x);
 }
 assert.ok(target.x-world.player.x<=8);assert.equal(stick.state!.dx,0);assert.equal(stick.state!.dy,0);
});

test('touch retains the original anchor, analog speed and continuous held movement',()=>{
 const stick=new MovementStick();stick.begin(1,'touch',0,100,100,true);
 stick.move(1,142,100,1);assert.deepEqual([stick.state!.dx,stick.state!.dy],[1,0]);
 // A finger moving back toward the center is still on the right side of its joystick.
 stick.move(1,121,100,1);assert.deepEqual([stick.state!.dx,stick.state!.dy],[.5,0]);
 stick.aimMouse({x:0,y:0},{x:-100,y:0});assert.equal(stick.state!.dx,.5);
 assert.deepEqual([stick.state!.x,stick.state!.y],[100,100]);
 stick.move(1,100,100,1);assert.deepEqual([stick.state!.dx,stick.state!.dy],[0,0]);
 stick.move(1,79,100,1);assert.deepEqual([stick.state!.dx,stick.state!.dy],[-.5,0]);
 stick.move(1,79,100,1);assert.deepEqual([stick.state!.dx,stick.state!.dy],[-.5,0]);
});

test('mouse release without pointerup and lifecycle cancellation never leave stuck movement',()=>{
 for(const buttons of [0,2,4]){
  const stick=new MovementStick();stick.begin(1,'mouse',0,0,0,true);stick.move(1,100,0,1);
  assert.equal(stick.move(1,110,0,buttons),true);assert.equal(stick.state,null);
 }
 const stick=new MovementStick();stick.begin(1,'mouse',0,0,0,true);stick.move(1,0,-100,1);
 stick.clear();assert.equal(stick.move(1,0,-200,1),false);assert.equal(stick.state,null);
 stick.begin(1,'mouse',0,40,50,true);assert.deepEqual([stick.state!.dx,stick.state!.dy],[0,0]);
});

test('second touch cannot take over movement or cancel independent focus targeting',()=>{
 const stick=new MovementStick(),focus=new FocusGesture();
 assert.equal(stick.begin(2,'touch',0,300,100,false),false);
 assert.equal(stick.begin(1,'touch',0,30,100,true),true);
 assert.equal(stick.begin(2,'touch',0,300,100,true),false);
 focus.begin(2,300,100,0);stick.move(1,51,100,1);
 assert.equal(stick.state!.dx,.5);assert.equal(stick.move(2,400,100,1),false);
 assert.equal(stick.end(2),false);assert.equal(stick.state!.id,1);
 assert.deepEqual(focus.take(400),{x:300,y:100});
 assert.equal(stick.end(1),true);assert.equal(stick.state,null);
});
