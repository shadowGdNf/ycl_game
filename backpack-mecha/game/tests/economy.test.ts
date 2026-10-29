import test from 'node:test';
import assert from 'node:assert/strict';
import type {BattleResult,Item,Run} from '../src/types.ts';
import {DEMO_IDS,MODULE_BY_ID,WAVES} from '../src/content.ts';
import * as e from '../src/economy.ts';

function result(r:Run,won=true):BattleResult {return {won,hp:100,shield:20,elapsed:WAVES[r.wave-1].duration,insuranceUsed:false,rng:12345,stats:{damageByModule:{W01:100},damageTakenBy:{},kills:10,killedBudget:20,goldEarned:WAVES[r.wave-1].bonus*.7,maxChain:2,damageTaken:0}};}
function progress(r:Run,takeScrap=false):void {
 if(r.eventId&&!r.eventResolved)assert.equal(e.resolveEvent(r,-1).ok,true);
 assert.equal(e.startWave(r).ok,true);
 assert.equal(e.resolveBattle(r,result(r)).ok,true);
 while(['reward','expansion','protocol'].includes(r.phase)){
  if(r.phase==='reward')assert.equal(e.chooseReward(r,takeScrap?-1:0).ok,true);
  else if(r.phase==='expansion')assert.equal(e.chooseExpansion(r,[0,1,2,3].filter(c=>!r.unlockedCorners.includes(c)).slice(0,2)).ok,true);
  else assert.equal(e.chooseProtocol(r,r.protocolOptions[0]).ok,true);
 }
}
function shopRun():Run {const r=e.newRun('scavenger','full',0,'shop-test');progress(r);return r;}
function item(r:Run,id:string,stored=true,tier:1|2|3=1):Item {const x={uid:`i${r.nextUid++}`,id,tier,x:-1,y:-1,rotation:0,stored};r.items.push(x);return x;}
function eventRun(id:string):Run {const r=shopRun();r.wave=id==='EV03'?7:3;r.maxTier=id==='EV03'?2:1;r.eventId=id;r.eventResolved=false;r.extra={};return r;}

test('new run uses mode restrictions, legal linked starter, independent deterministic streams',()=>{
 for(const mode of ['prototype','demo','full'] as const){const a=e.newRun('hive',mode,4,'same');const b=e.newRun('hive',mode,4,'same');assert.deepEqual(a,b);assert.equal(e.validateLoadout(a).ok,true);assert.equal(a.gold,40);assert.equal(a.shop.length,0);assert.equal(a.difficulty,mode==='full'?4:0);assert.equal(a.chassis,mode==='full'?'hive':'scavenger');assert.equal(new Set(Object.values(a.rng)).size,4);}
 assert.equal(e.newRun('bulwark','demo',2,'seed').chassis,'bulwark');
 assert.deepEqual(e.newRun('scavenger','full',0,''),e.newRun('scavenger','full',0,'backpack-mecha'));
});

test('placement is atomic, corners are locked, rotation uses quarter turns',()=>{
 const r=e.newRun('scavenger','full',0,'layout');const gun=r.items[0],before=structuredClone(r);
 assert.equal(e.placeItem(r,gun.uid,0,0,0).ok,false);assert.deepEqual(r,before);
 assert.equal(e.placeItem(r,gun.uid,1,0,1).ok,false); // overlaps the connected support below.
 assert.equal(e.getCells({...gun,x:2,y:2,rotation:1}).length,2);
 assert.deepEqual(e.getCells({...gun,x:2,y:2,rotation:1}),[{x:2,y:2},{x:2,y:3}]);
 assert.equal(e.placeItem(r,gun.uid,3,2,1).ok,true);assert.equal(e.validateLoadout(r).ok,false);
 assert.equal(e.autoPack(r).ok,true);assert.equal(e.validateLoadout(r).ok,true);
});

test('connections enforce orthogonal adjacency, compatibility and two slots per weapon',()=>{
 const r=e.newRun('scavenger','full',0,'connections');r.items=[];
 const gun=item(r,'W01',false),a=item(r,'S01',false),b=item(r,'S02',false),c=item(r,'S07',false),electric=item(r,'S05',false);
 Object.assign(gun,{x:1,y:1});Object.assign(a,{x:1,y:2});Object.assign(b,{x:1,y:0});Object.assign(c,{x:2,y:0});Object.assign(electric,{x:0,y:1});
 assert.equal(e.setLink(r,a.uid,gun.uid).ok,true);assert.equal(e.setLink(r,b.uid,gun.uid).ok,true);
 assert.equal(e.setLink(r,c.uid,gun.uid).ok,false);assert.equal(e.setLink(r,electric.uid,gun.uid).ok,false);
 assert.equal(e.storeItem(r,a.uid).ok,true);assert.equal(e.setLink(r,c.uid,gun.uid).ok,true);
 Object.assign(r.items.find(i=>i.uid===b.uid)!,{x:3,y:0});assert.equal(e.setLink(r,b.uid,gun.uid).ok,false);
});

test('reserve and equipped item caps are independent; removing a battery can block battle',()=>{
 const r=e.newRun('scavenger','full',0,'limits');item(r,'W01');item(r,'W01');item(r,'S01');assert.equal(e.storeItem(r,r.items[0].uid).ok,false);
 const duplicate=r.items.find(i=>i.stored&&i.id==='S01')!;assert.equal(e.placeItem(r,duplicate.uid,3,2,0).ok,false);
 r.items=[];r.power=10;r.unlockedCorners=[0,1,2,3];
 for(const id of ['W07','W04','W02','U01','U05'])item(r,id,false);
 assert.equal(e.autoPack(r).ok,true);assert.equal(e.getCapacity(r),12);
 assert.equal(e.storeItem(r,r.items.find(i=>i.id==='U01')!.uid).ok,true);assert.equal(e.getCapacity(r),10);assert.equal(e.validateLoadout(r).ok,false);assert.equal(e.startWave(r).ok,false);
});

test('shop produces distinct category slots, uses independent RNG and never exposes first-act rare modules',()=>{
 const a=shopRun(),b=shopRun();a.gold=b.gold=10000;
 for(let i=0;i<30;i++){
  assert.deepEqual(a.shop,b.shop);assert.equal(new Set(a.shop.map(o=>o.id)).size,4);
  for(const [slot,kind]of ['weapon','support','utility'].entries())assert.equal(MODULE_BY_ID[a.shop[slot].id].kind,kind);
  assert.equal(a.shop.some(o=>MODULE_BY_ID[o.id].rarity==='R'),false);
  a.rng.combat+=17;a.rng.map+=41;
  assert.equal(e.refreshShop(a).ok,true);assert.equal(e.refreshShop(b).ok,true);
 }
 assert.equal(a.refreshes,30);
});

test('lock survives refresh and wave transition, only one offer may be locked',()=>{
 const r=shopRun();r.gold=1000;assert.equal(e.toggleLock(r,0).ok,true);assert.equal(e.toggleLock(r,1).ok,true);assert.deepEqual(r.shop.map(o=>o.locked),[false,true,false,false]);
 const locked=structuredClone(r.shop[1]);assert.equal(e.refreshShop(r).ok,true);assert.deepEqual(r.shop[1],locked);progress(r);assert.deepEqual(r.shop[1],locked);assert.equal(r.refreshes,0);
});

test('failed purchases preserve cash and RNG; successful buying enters reserve',()=>{
 const r=shopRun();r.gold=0;const before=structuredClone(r);assert.equal(e.buy(r,0).ok,false);assert.deepEqual(r,before);
 r.gold=100;const id=r.shop[0].id,price=e.offerPrice(r.shop[0]);assert.equal(e.buy(r,0).ok,true);assert.equal(r.gold,100-price);assert.equal(r.items.at(-1)!.stored,true);assert.equal(r.shop[0].id,'');
 item(r,'W02');item(r,'W03');const full=structuredClone(r);assert.equal(e.buy(r,1).ok,false);assert.deepEqual(r,full);
});

test('sale undo restores the entire transaction chain including purchases and refresh RNG',()=>{
 const r=shopRun();r.gold=300;const before=structuredClone(r),uid=r.items[1].uid;
 assert.equal(e.sell(r,uid).ok,true);assert.equal(e.refreshShop(r).ok,true);assert.equal(e.buy(r,0).ok,true);assert.equal(e.undoSale(r).ok,true);
 const {journal:afterJournal,...afterRules}=r,{journal:beforeJournal,...beforeRules}=before;
 assert.deepEqual(afterRules,beforeRules);assert.equal(afterJournal!.events.at(-1)!.action,'undo-sale');assert.ok(afterJournal!.nextSequence>beforeJournal!.nextSequence);assert.equal(e.undoSale(r).ok,false);
 assert.equal(e.sell(r,uid).ok,true);assert.equal(e.startWave(r).ok,true);assert.equal(e.undoSale(r).ok,false);
});

test('damaged sale and reward journals fail atomically without erasing the active run',()=>{
 const r=shopRun();r.saleUndo=JSON.stringify({phase:'prep',wave:r.wave,seed:r.seed});const before=structuredClone(r);assert.equal(e.undoSale(r).ok,false);assert.deepEqual(r,before);
 for(const journal of ['not json','{}','["missing-kind"]']){const reward=shopRun();reward.phase='reward';reward.rewardOptions=['W01','W02','W03'];reward.extra!.pendingRewardKinds=journal;const before=structuredClone(reward);assert.equal(e.chooseReward(reward,-1).ok,false);assert.deepEqual(reward,before);}
});

test('duplicate combination, standard sale value and once-per-shop repairs',()=>{
 const r=shopRun();r.gold=500;assert.equal(e.upgrade(r,r.items[0].uid).ok,false);item(r,'W01');
 assert.equal(e.upgrade(r,r.items[0].uid).ok,true);assert.equal(r.gold,500);assert.equal(e.standardCost(r.items[0]),42);assert.equal(e.upgrade(r,r.items[0].uid).ok,false);
 r.hp=50;assert.equal(e.repair(r).ok,true);assert.equal(r.hp,80);assert.equal(r.gold,482);assert.equal(e.repair(r).ok,false);
 const price=e.standardCost(r.items[0]);assert.equal(e.sell(r,r.items[0].uid).ok,true);assert.equal(r.gold,482+Math.floor(price*.5));
});

test('shop pity guarantees a compatible support and locked free slot defers tag guarantee',()=>{
 const r=shopRun();r.gold=1000;r.shopPity=2;assert.equal(e.refreshShop(r).ok,true);
 assert.equal(MODULE_BY_ID[r.shop[3].id].kind,'support');assert.ok(MODULE_BY_ID[r.shop[3].id].tags.some(t=>['全部','实弹','单弹'].includes(t)));
 assert.equal(e.toggleLock(r,3).ok,true);r.extra!.guaranteedSupportTag='电';assert.equal(e.refreshShop(r).ok,true);assert.equal(r.extra!.guaranteedSupportTag,'电');
 assert.equal(e.toggleLock(r,3).ok,true);assert.equal(e.refreshShop(r).ok,true);assert.equal(r.extra!.guaranteedSupportTag,undefined);assert.ok(MODULE_BY_ID[r.shop[3].id].tags.some(t=>['全部','电'].includes(t)));
});

test('prototype ends on wave four; demo ends on eight without third-act rewards',()=>{
 for(const [mode,last]of [['prototype',4],['demo',8]] as const){const r=e.newRun('scavenger',mode,0,'campaign');
  while(r.phase!=='won'){progress(r);if(r.phase!=='won')assert.ok(r.items.every(i=>mode!=='demo'||DEMO_IDS.includes(i.id)));}
  assert.equal(r.wave,last);assert.equal(r.maxTier,4);assert.equal(r.power,mode==='prototype'?10:12);assert.equal(r.unlockedCorners.length,mode==='prototype'?0:2);assert.equal(r.protocols.length,mode==='prototype'?0:1);assert.equal(r.eventsSeen.length,0);
  assert.equal(e.startWave(r).ok,false);assert.equal(e.resolveBattle(r,result(r)).ok,false);
  if(mode==='demo')assert.ok(Math.abs(r.gold-479.4)<1e-9);
 }
});

test('full campaign awards sequential expansion and protocols, unique events, and one final settlement',()=>{
 const r=e.newRun('scavenger','full',0,'full-run');
 while(r.phase!=='won')progress(r,true);
 assert.equal(r.wave,12);assert.equal(r.unlockedCorners.length,4);assert.equal(r.power,14);assert.equal(r.maxTier,4);assert.equal(r.protocols.length,2);assert.equal(new Set(r.protocols).size,2);assert.equal(r.eventsSeen.length,2);assert.notEqual(r.eventsSeen[0],r.eventsSeen[1]);assert.ok(Math.abs(r.gold-838)<1e-8);assert.equal(r.rng.combat,12345);
 const final=structuredClone(r);assert.equal(e.resolveBattle(r,result(r)).ok,false);assert.deepEqual(r,final);
});

test('loss does not award survival income or advance; lethal zero HP overrides a won flag',()=>{
 const r=e.newRun('scavenger','full',0,'loss');assert.equal(e.startWave(r).ok,true);const b=result(r);b.hp=0;assert.equal(e.resolveBattle(r,b).ok,true);assert.equal(r.phase,'lost');assert.equal(r.wave,1);assert.equal(r.gold,48.4);
});

test('all eight event branches are atomic and target-based actions require explicit selection',()=>{
 const exchange=eventRun('EV01');assert.equal(e.resolveEvent(exchange,0).ok,true);assert.equal(exchange.phase,'reward');assert.equal(exchange.eventResolved,true);assert.ok(exchange.rewardOptions.every(id=>MODULE_BY_ID[id].rarity==='U'));const shop=structuredClone(exchange.shop);assert.equal(e.chooseReward(exchange,0).ok,true);assert.equal(exchange.phase,'prep');assert.deepEqual(exchange.shop,shop);assert.equal(e.resolveEvent(exchange,0).ok,false);
 const battery=eventRun('EV02');battery.hp=15;const before=structuredClone(battery);assert.equal(e.resolveEvent(battery,0).ok,false);assert.deepEqual(battery,before);battery.hp=16;assert.equal(e.resolveEvent(battery,0).ok,true);assert.equal(battery.hp,1);
 const bench=eventRun('EV03');assert.equal(e.resolveEvent(bench,0).ok,false);bench.extra!.eventTargetUid=bench.items[0].uid;assert.equal(e.resolveEvent(bench,0).ok,true);assert.equal(bench.items[0].tier,2);
 const rescue=eventRun('EV04');assert.equal(e.setRoute(rescue,1).ok,true);assert.equal(e.resolveEvent(rescue,0).ok,false);assert.equal(e.setRoute(rescue,0).ok,true);assert.equal(e.resolveEvent(rescue,0).ok,true);assert.equal(rescue.extra!.eventExtraElite,1);assert.equal(e.setRoute(rescue,2).ok,false);
 const dismantle=eventRun('EV05');assert.equal(e.resolveEvent(dismantle,0).ok,false);const old=dismantle.gold;dismantle.extra!.eventTargetUid=dismantle.items[1].uid;assert.equal(e.resolveEvent(dismantle,0).ok,true);assert.equal(dismantle.gold,old+13);assert.equal(dismantle.items.length,1);
 const shipment=eventRun('EV06');assert.equal(e.resolveEvent(shipment,0).ok,false);shipment.extra!.eventTargetTag='实弹';assert.equal(e.resolveEvent(shipment,0).ok,true);assert.equal(shipment.extra!.guaranteedSupportTag,'实弹');assert.equal(e.refreshShop(shipment).ok,true);assert.equal(shipment.extra!.guaranteedSupportTag,'实弹');progress(shipment);assert.equal(shipment.extra!.guaranteedSupportTag,undefined);
 const station=eventRun('EV07');assert.equal(e.resolveEvent(station,1).ok,true);assert.equal(e.startWave(station).ok,true);assert.equal(station.shield,35);assert.equal(e.resolveBattle(station,result(station)).ok,true);assert.equal(station.extra!.temporaryShield,undefined);
 const shortcut=eventRun('EV08');assert.equal(e.resolveEvent(shortcut,0).ok,true);assert.equal(shortcut.extra!.eventBudgetBonus,.15);const gold=shortcut.gold;assert.equal(e.startWave(shortcut).ok,true);assert.equal(e.resolveBattle(shortcut,result(shortcut)).ok,true);assert.ok(Math.abs(shortcut.gold-gold-(36+16*.7+30))<1e-9);assert.equal(shortcut.extra!.eventBudgetBonus,undefined);
});

test('an elite reward and scheduled module reward both resolve without duplicate currency',()=>{
 const r=shopRun();assert.equal(e.setRoute(r,2).ok,true);assert.equal(e.startWave(r).ok,true);assert.equal(e.resolveBattle(r,result(r)).ok,true);assert.equal(r.phase,'reward');
 assert.equal(e.chooseReward(r,-1).ok,true);assert.equal(r.phase,'reward');assert.ok(r.rewardOptions.every(id=>MODULE_BY_ID[id].rarity==='U'));assert.equal(e.chooseReward(r,-1).ok,true);assert.equal(r.phase,'prep');assert.equal(e.chooseReward(r,-1).ok,false);
});

test('three demo builds fit 23 cells, 12 base power, tier II and the 399.4 scrap budget',()=>{
 const builds=[
  {name:'wet',ids:['W03','W04','W01','S05','S02','U09','U02','U01','S01']},
  {name:'oil',ids:['W05','W06','W02','S06','S02','S01','U06','U03','U01']},
  {name:'ballistic',ids:['W07','W01','W02','S03','S07','S02','U05','U07','U01']},
 ];
 for(const build of builds){const r=e.newRun('scavenger','demo',0,build.name);r.wave=7;r.power=12;r.maxTier=2;r.unlockedCorners=[0,1];r.items=[];
  for(const id of build.ids)item(r,id,false,MODULE_BY_ID[id].kind!=='utility'||id==='U01'?2:1);
  const cost=r.items.reduce((n,i)=>n+e.standardCost(i),0);assert.ok(cost<=399.4,`${build.name}: ${cost}`);assert.equal(e.autoPack(r).ok,true,build.name);assert.equal(e.validateLoadout(r).ok,true);assert.ok(r.items.reduce((n,i)=>n+e.getCells(i).length,0)<=23);assert.ok(r.items.every(i=>DEMO_IDS.includes(i.id)));
 }
});
