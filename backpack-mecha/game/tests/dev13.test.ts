import test from 'node:test';
import assert from 'node:assert/strict';
import * as econ from '../src/economy.ts';
import {chassisStats,awardExperience,MAX_LEVEL,normalizeGrowth} from '../src/progression.ts';
import {MODULES,MODULE_BY_ID} from '../src/content.ts';
import {createBattle,stepBattle,spawnEnemy,battleResult} from '../src/combat.ts';
import {sanitizeSave,freshProfile} from '../src/storage.ts';
import {equipmentDescription} from '../src/equipment-ui.ts';
import type {Item,Run} from '../src/types.ts';
const make=(chassis='scavenger')=>econ.newRun(chassis,'full',0,'DEV13');
const item=(id:string,x:number,y:number,stored=false,uid=id):Item=>({id,uid,x,y,tier:1,rotation:0,stored});
const idle={x:0,y:0,dash:false,overload:false};
function scene(id:string,chassis='scavenger'){
 const r=make(chassis);r.items=[item(id,1,1)];const w=createBattle(r);w.obstacles=[];w.encounter.nextSpawn=1000;w.player.invulnerable=1000;
 return {r,w};
}
function dummy(w:ReturnType<typeof createBattle>,x=950,y=650){const e=spawnEnemy(w,{id:'E03',x,y,cost:0,elite:false,affix:0,reward:false});e.hp=e.maxHp=10000;e.armor=0;e.speed=0;e.damage=0;return e;}

test('a horizontal reserve weapon fits the only vertical gap without manual rotation',()=>{
 const r=make();r.power=99;r.unlockedCorners=[0,1,2,3];
 // Fill 23 cells using unique supports/utilities, leaving only (4,1) and (4,2).
 r.items=['S01','S03','S06','S08','S09','S11','U03','U06','U07','U10','U11'].map((id,n)=>item(id,n%2*2,Math.floor(n/2)));
 r.items=r.items.slice(0,10); // twenty cells in columns 0..3
 r.items.push(item('S02',4,0),item('S05',4,3),item('S07',4,4),item('W01',-1,-1,true));
 assert.equal(econ.previewPlacement(r,'W01',4,1,0).ok,false);
 const before=structuredClone(r),preview=econ.previewSmartPlacement(r,'W01',4,1,0);assert.ok(preview.ok);assert.ok(preview.autoRotated);assert.equal(preview.swappedUid,undefined);assert.deepEqual(r,before);
 assert.ok(econ.moveItem(r,'W01',4,1,0).ok);assert.deepEqual(econ.getCells(r.items.at(-1)!),[{x:4,y:1},{x:4,y:2}]);assert.equal(econ.validateLoadout(r).ok,true);
});
test('board swaps and full-reserve replacements are atomic and reconnect supports',()=>{
 const r=make();r.items=[item('W01',1,1),item('W03',1,3),item('S01',1,2),item('W12',-1,-1,true),item('U04',-1,-1,true),item('U05',-1,-1,true)];
 assert.ok(econ.moveItem(r,'W01',1,3,0).ok);assert.equal(r.items.find(i=>i.id==='W03')!.y,1);assert.equal(econ.activeSupports(r).length,1);
 assert.ok(econ.moveItem(r,'W12',1,3,0).ok);assert.equal(r.items.filter(i=>i.stored).length,3);assert.ok(r.items.find(i=>i.id==='W01')!.stored);assert.ok(!r.items.find(i=>i.id==='W12')!.stored);
 assert.ok(econ.swapWithReserve(r,'W12','W01').ok);assert.ok(!r.items.find(i=>i.id==='W01')!.stored);
 const before=structuredClone(r);assert.equal(econ.storeItem(r,'W01').ok,false);assert.deepEqual(r,before);
 r.phase='battle';const locked=structuredClone(r);assert.equal(econ.moveItem(r,'W01',1,1,0).ok,false);assert.deepEqual(r,locked);
});
test('invalid swaps preserve every item, currency, RNG and links; previews match commits',()=>{
 const r=make();r.items=[item('W01',1,0),item('W02',2,2),item('U02',0,2),item('W12',-1,-1,true)];
 const before=structuredClone(r);
 for(let rotation=0;rotation<4;rotation++)for(let y=-1;y<6;y++)for(let x=-1;x<6;x++){
  const preview=econ.previewSmartPlacement(r,'W12',x,y,rotation),actual=structuredClone(r),result=econ.moveItem(actual,'W12',x,y,rotation);
  assert.equal(preview.ok,result.ok);if(result.ok)assert.deepEqual(actual.items,preview.items);else assert.deepEqual(actual,r);
 }
 assert.deepEqual(r,before);
 const blocked=make();blocked.items=[item('W02',-1,-1,true),item('W01',1,0),item('W03',3,0)];const original=structuredClone(blocked);
 assert.equal(econ.moveItem(blocked,'W02',0,0,0).ok,false);assert.deepEqual(blocked,original);
});
test('spatial edits can recover an overpowered bag; auto equip never ejects gear',()=>{
 const r=make();r.power=0;assert.ok(econ.moveItem(r,r.items[0].uid,2,2,0).ok);assert.equal(econ.validateLoadout(r).ok,false);
 r.items.push(item('W03',-1,-1,true));const before=r.items.length;assert.ok(econ.equipItem(r,'W03').ok);assert.equal(r.items.length,before);assert.equal(r.items.filter(i=>i.stored).length,0);
});
test('victory gives XP once, grows all three base stats and restores only added HP',()=>{
 const r=make();r.hp=50;econ.startWave(r);const outcome=battleResult(createBattle(r));outcome.won=true;outcome.stats.kills=20;
 assert.ok(econ.resolveBattle(r,outcome).ok);assert.equal(r.growth!.level,2);assert.equal(r.growth!.points,1);assert.equal(r.hp,58);assert.deepEqual([chassisStats(r).maxHp,chassisStats(r).attack,chassisStats(r).speed],[108,105,104]);
 const before=structuredClone(r);assert.equal(econ.resolveBattle(r,outcome).ok,false);assert.deepEqual(r,before);
 assert.ok(econ.upgradeChassis(r,'hp').ok);assert.equal(r.hp,66);assert.equal(chassisStats(r).maxHp,116);assert.equal(r.growth!.points,0);assert.equal(econ.upgradeChassis(r,'attack').ok,false);
 const lost=make();econ.startWave(lost);econ.resolveBattle(lost,{...outcome,won:false});assert.equal(lost.growth!.level,1);
});
test('four chassis have distinct growth paths; allocation is saved, bounded and battle-locked',()=>{
 const paths=new Set<string>();for(const chassis of ['scavenger','bulwark','kestrel','hive']){
  const r=make(chassis);awardExperience(r,20);const stats=chassisStats(r);paths.add(JSON.stringify([stats.path.hp,stats.path.speed,stats.path.attack]));assert.ok(econ.upgradeChassis(r,stats.path.focus).ok);
  const saved=sanitizeSave({version:1,profile:freshProfile(),run:r,battle:null,savedAt:1});assert.deepEqual(saved.run!.growth,r.growth);
  for(let n=0;n<100;n++)awardExperience(r,10000);assert.equal(r.growth!.level,MAX_LEVEL);assert.equal(r.growth!.xp,0);assert.equal(r.growth!.points+Object.values(r.growth!.choices).reduce((a,b)=>a+b,0),11);
  r.phase='battle';const before=structuredClone(r);assert.equal(econ.upgradeChassis(r,'hp').ok,false);assert.deepEqual(r,before);
 }assert.equal(paths.size,4);
 assert.equal(normalizeGrowth({level:2,xp:0,points:999,choices:{hp:0,speed:0,attack:0}}).level,1);
});
test('upgraded HP, damage and attack speed affect real combat and survive old/new snapshots',()=>{
 const low=scene('W01'),high=scene('W01');awardExperience(high.r,20);econ.upgradeChassis(high.r,'attack');high.w=createBattle(high.r);high.w.obstacles=[];high.w.encounter.nextSpawn=1000;
 for(const {w} of [low,high]){dummy(w);stepBattle(w,idle,.4);}assert.ok(high.w.stats.damageByModule.W01>low.w.stats.damageByModule.W01);assert.ok(high.w.weapons[0].cooldown<low.w.weapons[0].cooldown);assert.equal(high.w.player.maxHp,108);
 high.r.phase='battle';const saved=sanitizeSave({version:1,profile:freshProfile(),run:high.r,battle:high.w,savedAt:1});assert.deepEqual(JSON.parse(JSON.stringify(saved.battle)),JSON.parse(JSON.stringify(high.w)));
 delete low.r.growth;delete low.w.baseDamage;delete low.w.baseAttackSpeed;low.r.phase='battle';const old=sanitizeSave({version:1,profile:freshProfile(),run:low.r,battle:low.w,savedAt:1});assert.equal(old.run!.phase,'battle');assert.equal(old.run!.growth!.level,1);
});
test('six new weapons have current-tier descriptions and execute distinct attacks',()=>{
 assert.equal(MODULES.filter(m=>m.kind==='weapon').length,18);
 for(const id of ['W13','W14','W15','W16','W17','W18']){
  for(const tier of [1,2,3,4] as const)for(const lang of ['zh','en'] as const)assert.ok(equipmentDescription({id,tier},lang).length>30);
  const {w}=scene(id);const e=dummy(w);stepBattle(w,idle,.9);assert.ok(w.stats.damageByModule[id]>0,id);
  if(id==='W13')assert.ok(w.weapons[0].shotCount>=6);
  if(id==='W16')assert.ok(e.chill>0||e.frozen>0);
  if(id==='W17')assert.ok(e.burns.length>0);
  if(id==='W18')assert.equal(w.weapons[0].droneCount,3);
 }
});
test('beam pierces a line but not cover; pulse hits surrounding enemies; mortar ignites oil',()=>{
 const beam=scene('W14').w;const a=dummy(beam,900),b=dummy(beam,1020),c=dummy(beam,1140);beam.obstacles=[{x:1080,y:610,w:30,h:80}];stepBattle(beam,idle,.12);assert.ok(a.hp<10000&&b.hp<10000);assert.equal(c.hp,10000);
 const pulse=scene('W15').w;const front=dummy(pulse,920),back=dummy(pulse,680),far=dummy(pulse,1150);stepBattle(pulse,idle,.12);assert.ok(front.hp<10000&&back.hp<10000);assert.equal(far.hp,10000);
 const mortar=scene('W17').w;const target=dummy(mortar);target.oilUntil=10;stepBattle(mortar,idle,.6);assert.equal(target.oilUntil,0);assert.ok(target.burns.length>0);assert.ok(mortar.events.some(e=>e.type==='explosion'));
});
test('new drone module uses relay, hive damage and priority protocol',()=>{
 const {r}=scene('W18','hive');r.items.push(item('S10',0,1));assert.ok(econ.autoPack(r).ok);const w=createBattle(r);w.obstacles=[];w.encounter.nextSpawn=1000;assert.equal(w.weapons[0].droneCount,4);assert.equal(w.weapons[0].supports.S10,1);dummy(w);stepBattle(w,idle,.5);assert.ok(w.stats.damageByModule.W18>0);
});
