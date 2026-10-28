import test from 'node:test';
import assert from 'node:assert/strict';
import * as e from '../src/economy.ts';
import {supportFeedback,supportBenefit,connectionLesson,workshopHints} from '../src/workshop.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';

test('first connection survives reload, follows undo state, and can be skipped permanently',()=>{
 const r=e.newRun('scavenger','full',0,'lesson');r.wave=2;const uid=r.items[1].uid;
 e.storeItem(r,uid);const before=structuredClone(r);
 assert.equal(connectionLesson(r,false,''),'select');assert.equal(connectionLesson(r,false,uid),'place');
 const p=e.placementOptions(r,uid).find(p=>p.ready)!.item!;assert.ok(e.placeItem(r,uid,p.x,p.y,p.rotation).ok);
 assert.equal(connectionLesson(r,false,uid),'ready');assert.equal(connectionLesson(before,false,uid),'place');
 const profile=freshProfile(),save=sanitizeSave({version:1,profile,run:r,battle:null,savedAt:1});
 assert.equal(connectionLesson(save.run!,save.profile.tutorial,''),'ready');
 profile.tutorial=true;const skipped=sanitizeSave({version:1,profile,run:r,battle:null,savedAt:1});
 assert.equal(connectionLesson(skipped.run!,skipped.profile.tutorial,uid),'hidden');
});
test('feedback distinguishes reserves, adjacency, explicit unlink, incompatible tags and exhausted slots',()=>{
 const r=e.newRun('scavenger','full',0,'feedback'),coil=r.items[1],weapon=r.items[0];
 assert.equal(supportFeedback(r,coil.uid,'en')!.status,'active');
 e.setLink(r,coil.uid,'');assert.equal(supportFeedback(r,coil.uid,'en')!.status,'disconnected');
 e.placeItem(r,coil.uid,0,3,0);assert.equal(supportFeedback(r,coil.uid,'zh')!.status,'not-adjacent');
 e.storeItem(r,coil.uid);assert.equal(supportFeedback(r,coil.uid,'zh')!.status,'reserve');
 e.placeItem(r,coil.uid,0,1,0);
 delete r.items[1].link;
 r.items.push({uid:'gear',id:'S02',tier:1,x:3,y:0,rotation:0,stored:false,link:weapon.uid},{uid:'wedge',id:'S07',tier:1,x:2,y:1,rotation:0,stored:false,link:weapon.uid});
 assert.equal(supportFeedback(r,coil.uid,'en')!.status,'slots-full');assert.equal(e.setLink(r,coil.uid,weapon.uid).ok,false);
 r.items[1].id='S10';assert.equal(supportFeedback(r,coil.uid,'en')!.status,'incompatible');
 r.items=r.items.filter(i=>i.uid!==weapon.uid);assert.equal(supportFeedback(r,coil.uid,'en')!.status,'no-weapon');
});
test('connection benefit uses current tiers and never treats power overload as ready',()=>{
 const r=e.newRun('scavenger','full',0,'benefit'),before=structuredClone(r),uid=r.items[1].uid;
 const a=supportFeedback(r,uid,'zh')!;assert.match(a.detail,/8 → 9.6/);assert.match(a.detail,/不含护甲/);assert.deepEqual(r,before);
 r.items[1].tier=2;r.items[0].tier=2;r.maxTier=2;
 const b=supportFeedback(r,uid,'en')!;assert.match(b.benefit,/27%/);assert.match(b.detail,/10.8 → 13.72/);
 r.power=2;assert.equal(supportFeedback(r,uid,'en')!.status,'power');assert.equal(e.validateLoadout(r).ok,false);
});
test('contextual hints remain limited and reflect an actual missing complement',()=>{
 const r=e.newRun('scavenger','full',0,'hints');r.items[0].id='W03';
 assert.match(workshopHints(r,'en').join(' '),/Wet/);
 r.items.push({uid:'arc',id:'W04',tier:1,x:2,y:2,rotation:0,stored:false});
 assert.ok(!workshopHints(r,'en').join(' ').includes('Wet'));assert.ok(workshopHints(r,'zh').length<=2);
});
test('conditional support benefits keep the current tier and the trigger restrictions',()=>{
 const item=e.newRun('scavenger','full',0,'conditional').items[1];
 const spring=supportBenefit({...item,id:'S11',tier:2},'en');
 assert.match(spring,/27%/);assert.match(spring,/within 2s/);assert.match(spring,/55%/);
 const frost=supportBenefit({...item,id:'S12',tier:3},'zh');
 assert.match(frost,/40%/);assert.match(frost,/0.4 秒/);assert.match(frost,/额外 9 失衡/);
});
