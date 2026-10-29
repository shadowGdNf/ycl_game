import test from 'node:test';
import assert from 'node:assert/strict';
import {MODULES,MODULE_BY_ID} from '../src/content.ts';
import {TIERS,moduleValue,moduleValues,damageScale,equipmentPrice,offerTier,rollShopTier,shopTierChances} from '../src/rarity.ts';
import * as economy from '../src/economy.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
import {createBattle,stepBattle,spawnEnemy} from '../src/combat.ts';
import {equipmentDescription} from '../src/equipment-ui.ts';
import {trainingRun,TRAINING_PRESETS} from '../src/training.ts';
import type {Tier,Run,Item} from '../src/types.ts';
const idle={x:0,y:0,dash:false,overload:false};
function shop():Run {const r=economy.newRun('scavenger','full',0,'RARITY-QA');r.wave=9;r.gold=1000;r.power=24;r.unlockedCorners=[0,1,2,3];r.shop=[{id:'W01',tier:1,locked:false},{id:'W02',tier:2,locked:false},{id:'S01',tier:3,locked:false},{id:'U01',tier:4,locked:false}];return r;}
function spare(r:Run,id:string,tier:Tier=1):Item {const item={uid:`i${r.nextUid++}`,id,tier,x:-1,y:-1,rotation:0,stored:true};r.items.push(item);return item;}

test('all 36 modules have finite growing rarity stats, prices and descriptions',()=>{
 for(const m of MODULES){let previous=0,price=0;
  for(const tier of TIERS){const cost=equipmentPrice(m.id,tier);assert.ok(cost>price,m.id);price=cost;
   const stat=m.kind==='weapon'?m.damage!*damageScale(tier):moduleValue(m.id,tier);assert.ok(Number.isFinite(stat),m.id);
   if(tier>1)assert.ok(m.id==='U10'?stat<previous:stat>previous,m.id);previous=stat;
   for(const lang of ['zh','en'] as const){const text=equipmentDescription({id:m.id,tier},lang);assert.ok(text.trim().length>0);assert.ok(!/undefined|NaN/.test(text),text);}
  }
  if(m.kind!=='weapon')assert.equal(moduleValues(m.id).length,4);
 }
});
test('two matching copies combine freely through all four rarities for all module kinds',()=>{
 for(const id of ['W01','S01','U01'])for(const tier of [1,2,3] as Tier[]){
  const r=shop();r.items=[];const a=spare(r,id,tier),b=spare(r,id,tier),before=structuredClone(r);
  const preview=economy.previewMerge(r,a.uid);assert.ok(preview.ok);assert.deepEqual(r,before);
  assert.ok(economy.merge(r,a.uid).ok);assert.equal(r.items.length,1);assert.equal(r.items[0].uid,a.uid);assert.equal(r.items[0].tier,tier+1);assert.equal(r.gold,before.gold);assert.deepEqual(r.rng,before.rng);assert.ok(!r.items.some(i=>i.uid===b.uid));
 }
});
test('invalid or max-rarity merges never consume money, items or RNG',()=>{
 for(const [id,tier,phase] of [['W01',2,'prep'],['W02',1,'prep'],['W01',1,'battle'],['W01',4,'prep']] as const){
  const r=shop(),target=r.items[0];if(tier===4)target.tier=4;const donor=spare(r,id,tier);r.phase=phase;const before=structuredClone(r);
  assert.equal(economy.merge(r,target.uid,donor.uid).ok,false);assert.deepEqual(r,before);
 }
 const r=shop(),before=structuredClone(r);assert.equal(economy.merge(r,r.items[0].uid,r.items[0].uid).ok,false);assert.deepEqual(r,before);
});
test('merging from reserve preserves equipped UID, position and attached support',()=>{
 const r=shop(),base={...r.items[0]},material=spare(r,'W01');
 const preview=economy.previewMerge(r,material.uid);assert.equal(preview.item?.uid,base.uid);
 assert.ok(economy.merge(r,material.uid).ok);const kept=r.items.find(i=>i.uid===base.uid)!;
 assert.deepEqual({x:kept.x,y:kept.y,rotation:kept.rotation,stored:kept.stored},{x:base.x,y:base.y,rotation:base.rotation,stored:false});
 assert.equal(r.items.find(i=>i.id==='S01')?.link,base.uid);assert.ok(economy.validateLoadout(r).ok);
});
test('buy-and-combine works with a full reserve, charges once and cannot replay',()=>{
 const r=shop(),target=r.items[0];spare(r,'W03');spare(r,'U03');spare(r,'U04');const gold=r.gold;
 assert.equal(economy.buy(r,0).ok,false);assert.ok(economy.buyAndMerge(r,0,target.uid).ok);
 assert.equal(r.gold,gold-24);assert.equal(r.items.filter(i=>i.stored).length,3);assert.equal(r.items.find(i=>i.uid===target.uid)?.tier,2);assert.equal(r.shop[0].id,'');
 const after=structuredClone(r);assert.equal(economy.buyAndMerge(r,0,target.uid).ok,false);assert.deepEqual(r,after);
});
test('combining two equipped weapons reports detached supports without blocking deployment',()=>{
 const r=shop();r.items=[
  {uid:'first',id:'W01',tier:1,x:0,y:0,rotation:0,stored:false},
  {uid:'second',id:'W01',tier:1,x:3,y:3,rotation:0,stored:false},
  {uid:'coil',id:'S01',tier:1,x:3,y:4,rotation:0,stored:false,link:'second'},
 ];
 assert.ok(economy.validateLoadout(r).ok);
 const before=structuredClone(r),preview=economy.previewMerge(r,'first');assert.ok(preview.ok);assert.deepEqual(preview.disconnected,['coil']);assert.deepEqual(r,before);
 assert.ok(economy.merge(r,'first').ok);assert.equal(r.items.length,2);assert.equal(r.items.find(i=>i.uid==='coil')?.link,undefined);assert.equal(economy.inactiveSupports(r).length,1);assert.ok(economy.startWave(structuredClone(r)).ok);
 assert.ok(economy.autoPack(r).ok);assert.equal(economy.inactiveSupports(r).length,0);assert.ok(economy.startWave(r).ok);
});
test('high rarity reserve and direct-board purchases carry their tier and use the displayed price',()=>{
 for(const direct of [false,true]){const r=shop();r.items=[];const offer=r.shop[1],cost=economy.offerPrice(offer),gold=r.gold;
  const preview=economy.previewPurchase(r,1);assert.ok(preview.result.ok);assert.ok(preview.placements.every(p=>p.item?.tier===2));
  const p=preview.placements.find(p=>p.ready)!.item!;assert.ok(economy.buy(r,1,direct?{x:p.x,y:p.y,rotation:p.rotation}:undefined).ok);
  assert.equal(r.items[0].tier,2);assert.equal(r.gold,gold-cost);assert.equal(r.items[0].stored,!direct);
 }
 const poor=shop();poor.gold=119;const before=structuredClone(poor);assert.equal(economy.buy(poor,3).ok,false);assert.deepEqual(poor,before);
});
test('shop odds grow by wave; generated rare offers preserve tier when locked',()=>{
 for(let wave=1;wave<=12;wave++){const chances=shopTierChances(wave);assert.ok(Math.abs(chances.reduce((a,b)=>a+b,0)-1)<1e-12);
  const counts=[0,0,0,0];for(let i=0;i<10000;i++)counts[rollShopTier(wave,(i+.5)/10000)-1]++;
  chances.forEach((p,i)=>assert.ok(Math.abs(counts[i]/10000-p)<.00011));
  if(wave<5)assert.equal(counts[2],0);if(wave<9)assert.equal(counts[3],0);
 }
 const r=shop();r.wave=12;r.gold=100000;const counts=[0,0,0,0];
 for(let i=0;i<400;i++){delete r.journal;r.history=[];assert.ok(economy.refreshShop(r).ok);r.shop.forEach(o=>counts[offerTier(o)-1]++);}
 assert.ok(counts[1]>counts[0]&&counts[1]>counts[2]&&counts[2]>counts[3]&&counts[3]>0,counts.join(','));
 r.shop[0]={id:'W01',tier:4,locked:true};const locked={...r.shop[0]};assert.ok(economy.refreshShop(r).ok);assert.deepEqual(r.shop[0],locked);
});
test('legacy offers default to Common; Legendary inventory, offers and battles survive saving',()=>{
 const legacy=shop();delete legacy.shop[0].tier;legacy.maxTier=1;
 const old=sanitizeSave({version:1,profile:freshProfile(),run:legacy,battle:null,savedAt:1});assert.ok(old.run);assert.equal(offerTier(old.run!.shop[0]),1);
 const r=shop();r.items.forEach(i=>i.tier=4);assert.ok(economy.startWave(r).ok);const w=createBattle(r);
 const restored=sanitizeSave(JSON.parse(JSON.stringify({version:1,profile:freshProfile(),run:r,battle:w,savedAt:1})));
 assert.equal(restored.run?.items[0].tier,4);assert.equal(restored.run?.shop[3].tier,4);assert.ok(restored.battle);assert.ok(restored.run?.journal);
});
test('all Legendary presets start and simulate without undefined tier effects',()=>{
 for(const preset of TRAINING_PRESETS){const result=trainingRun({chassis:'scavenger',boss:'B1A',difficulty:0,tier:4,power:24,modules:preset.modules});assert.ok(result.ok,result.reason);const w=createBattle(result.run!);w.player.invulnerable=100;
  stepBattle(w,{...idle,dash:true},1/60);stepBattle(w,idle,12);
  const scan=(v:unknown):void=>{if(typeof v==='number')assert.ok(Number.isFinite(v));else if(v&&typeof v==='object')Object.values(v).forEach(scan);};scan(w);
 }
});
test('weapon rarity changes actual damage and utility rarity changes combat capacities',()=>{
 const damage:number[]=[];
 for(const tier of TIERS){const r=shop();r.items=[{...r.items[0],tier}];r.wave=2;const w=createBattle(r);w.obstacles=[];w.encounter.nextSpawn=1000;
  const target=spawnEnemy(w,{id:'E01',x:950,y:650,elite:false,affix:0,reward:false,cost:0});target.hp=target.maxHp=1000;target.speed=0;
  stepBattle(w,idle,.35);damage.push(w.stats.damageByModule.W01);
 }
 assert.deepEqual(damage.map(n=>Number(n.toFixed(2))),[8,10.8,14.4,19.2]);
 const r=shop();r.items=[{...r.items[0],tier:4},{uid:'battery',id:'U01',tier:4,x:1,y:1,rotation:0,stored:false},{uid:'shield',id:'U02',tier:4,x:1,y:2,rotation:0,stored:false}];
 assert.equal(economy.getCapacity(r),29);assert.equal(economy.getShieldCapacity(r),80);assert.equal(createBattle(r).player.maxShield,80);
});
test('insurance fuse cannot be renewed by combining higher rarity copies',()=>{
 const r=shop();r.items=[];const a=spare(r,'U12',3);spare(r,'U12',3);r.insuranceUsed=true;assert.ok(economy.merge(r,a.uid).ok);assert.equal(r.insuranceUsed,true);
});
test('Legendary dash, decoy and repair secondary effects use their fourth-tier values',()=>{
 for(const id of ['U03','U07','U11']){
  const r=shop();r.wave=2;r.hp=60;r.items=[r.items[0],{uid:'utility',id,tier:4,x:1,y:2,rotation:0,stored:false}];assert.ok(economy.validateLoadout(r).ok);
  const w=createBattle(r);w.obstacles=[];w.encounter.nextSpawn=1000;w.player.invulnerable=100;
  stepBattle(w,{x:1,y:0,dash:true,overload:false},1/60);stepBattle(w,idle,.25);
  if(id==='U11'){assert.equal(w.decoy?.hp,48);assert.ok(w.decoy!.until>w.time+5.8);}
  if(id==='U07'){assert.ok(Number.isFinite(w.player.speed));assert.equal(w.dashBase,3.6);}
  stepBattle(w,idle,10);
  assert.ok(Number.isFinite(w.player.hp));assert.ok(Number.isFinite(w.player.dashCooldown));
  if(id==='U03')assert.equal(w.player.hp,62.4);
 }
});
