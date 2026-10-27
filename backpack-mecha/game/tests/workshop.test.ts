import test from 'node:test';
import assert from 'node:assert/strict';
import * as e from '../src/economy.ts';
import {MODULE_BY_ID} from '../src/content.ts';
import type {BattleResult,Run} from '../src/types.ts';

/** Economy fixture only; combat evidence is produced by natural-probe.ts. */
const outcome:BattleResult={won:true,hp:90,shield:5,elapsed:40,insuranceUsed:false,stats:{damageByModule:{W01:100},damageTakenBy:{E01:10},kills:5,killedBudget:5,goldEarned:4,maxChain:0,damageTaken:10}};
function shop():Run {const r=e.newRun('scavenger','full',0,'preview');e.startWave(r);e.resolveBattle(r,outcome);return r;}

test('all placement previews agree with real actions, including rotation, power and links, without changing the run',()=>{
 const r=shop(),uid=r.items[1].uid;e.storeItem(r,uid);const before=structuredClone(r);
 for(let rotation=0;rotation<4;rotation++)for(let y=-1;y<6;y++)for(let x=-1;x<6;x++){
  const preview=e.previewPlacement(r,uid,x,y,rotation),actual=structuredClone(r),result=e.placeItem(actual,uid,x,y,rotation);
  assert.equal(preview.ok,result.ok);assert.equal(preview.reason,result.reason);
  if(result.ok){assert.equal(preview.ready,e.validateLoadout(actual).ok);assert.equal(preview.linkedWeapon?.uid,actual.items.find(i=>i.uid===uid)?.link);}
 }
 assert.deepEqual(r,before);
});

test('purchase preview exposes full-reserve direct placements without charging or consuming RNG',()=>{
 const r=shop();r.shop[0]={id:'U04',locked:false};
 for(const [n,id]of ['W02','W03','W12'].entries())r.items.push({uid:`reserve${n}`,id,tier:1,x:-1,y:-1,rotation:0,stored:true});
 const before=structuredClone(r),preview=e.previewPurchase(r,0);
 assert.equal(preview.canReserve,false);assert.equal(preview.result.ok,true);assert.ok(preview.placements.length>0);assert.deepEqual(r,before);
 const p=preview.placements[0].item!;assert.equal(e.buy(r,0,{x:p.x,y:p.y,rotation:p.rotation}).ok,true);
 assert.equal(r.gold,before.gold-MODULE_BY_ID.U04.price);assert.equal(r.items.at(-1)?.stored,false);
});

test('unaffordable purchase and disconnected support distinguish affordability, fit and battle readiness',()=>{
 const r=shop();r.gold=0;r.shop[0]={id:'S10',locked:false};const before=structuredClone(r),preview=e.previewPurchase(r,0);
 assert.equal(preview.result.ok,false);assert.ok(preview.placements.length>0);assert.ok(preview.placements.every(p=>!p.ready&&!p.linkedWeapon));assert.deepEqual(r,before);
 r.phase='battle';assert.equal(e.previewPurchase(r,0).result.ok,false);assert.equal(e.previewPlacement(r,r.items[0].uid,1,0,0).ok,false);
});
