import test from 'node:test';
import assert from 'node:assert/strict';
import * as e from '../src/economy.ts';
import type {Run,BattleResult} from '../src/types.ts';
import {MODULES,ENEMY_BY_ID} from '../src/content.ts';
import {freshProfile,sanitizeSave} from '../src/storage.ts';
import {createBattle,damagePlayer,spawnEnemy} from '../src/combat.ts';
import {workshopMarkup} from '../src/ui-workshop.ts';
import {mergeImpact,shopAdvice,buildSteps,weaponRole} from '../src/workshop-insights.ts';
import {mainThreat,damageSourceName} from '../src/combat-report.ts';
import {CURRENT_FAMILIES,prepareCurrent,decideCurrent} from '../scripts/current-policy.ts';
import {chassisStats} from '../src/progression.ts';
import {createPilotMemory} from '../scripts/probe-pilot.ts';

const win=(r:Run):BattleResult=>({won:true,hp:r.hp,shield:r.shield,elapsed:40,insuranceUsed:false,stats:{damageByModule:{W01:100},damageTakenBy:{},kills:5,killedBudget:0,goldEarned:0,maxChain:0,damageTaken:0}});
const complete=(r:Run)=>{assert.ok(e.startWave(r).ok);assert.ok(e.resolveBattle(r,win(r)).ok);};
function shop(){const r=e.newRun('scavenger','full',0,'DEV21-SHOP');complete(r);return r;}
const markup=(r:Run,selected=undefined as Run['items'][number]|undefined)=>workshopMarkup(r,{lang:'zh',selected,pendingBuy:-1,undo:false,tab:'shop',icon:()=>'',placement:'',event:'',tutorial:false});
const reload=(r:Run)=>sanitizeSave(JSON.parse(JSON.stringify({version:1,profile:freshProfile(),run:r,battle:null,savedAt:1}))).run!;

test('pending post-battle rewards never expose last wave offers and shopping opens after claiming',()=>{
 const r=shop();complete(r);assert.equal(r.phase,'reward');assert.equal(r.wave,3);assert.equal(r.shop.length,4);
 const before=structuredClone(r),html=markup(r);
 assert.match(html,/领取战利品/);assert.match(html,/data-action="pending-reward"/);
 for(const action of ['preview-buy','refresh','repair','lock'])assert.ok(!html.includes(`data-action="${action}"`),action);
 assert.equal(e.buy(r,0).ok,false);assert.equal(e.buyAndMerge(r,0,r.items[0].uid).ok,false);assert.deepEqual(r,before);
 const restored=reload(r);assert.equal(restored.phase,'reward');assert.deepEqual(restored.rewardOptions,r.rewardOptions);
 assert.ok(e.chooseReward(restored,-1).ok);assert.ok(e.shopAccess(restored).ok);assert.match(markup(restored),/data-action="preview-buy"/);
 const index=restored.shop.findIndex(o=>e.offerPrice(o)<=restored.gold),price=e.offerPrice(restored.shop[index]),gold=restored.gold;
 assert.ok(e.previewPurchase(restored,index).result.ok);assert.ok(e.buy(restored,index).ok);assert.equal(restored.gold,gold-price);assert.equal(restored.shop[index].id,'');
});
test('queued rewards, event rewards, expansion and protocol choices keep the shop phase consistent',()=>{
 const queue=shop();assert.ok(e.setRoute(queue,2).ok);complete(queue);
 assert.ok(e.chooseReward(queue,-1).ok);assert.equal(queue.phase,'reward');assert.equal(e.shopAccess(queue).ok,false);
 assert.ok(e.chooseReward(queue,-1).ok);assert.ok(e.shopAccess(queue).ok);
 const event=shop();event.wave=3;event.eventId='EV01';event.eventResolved=false;event.gold=500;
 const offers=structuredClone(event.shop);assert.ok(e.resolveEvent(event,0).ok);assert.equal(e.shopAccess(event).ok,false);
 assert.ok(e.chooseReward(event,-1).ok);assert.deepEqual(event.shop,offers);assert.ok(e.shopAccess(event).ok);
 const boss=shop();boss.wave=4;complete(boss);assert.equal(boss.phase,'expansion');assert.match(markup(boss),/完成背包扩容/);
 assert.ok(!markup(boss).includes('data-action="preview-buy"'));assert.ok(e.chooseExpansion(boss,[0,1]).ok);
 assert.equal(boss.phase,'protocol');assert.match(markup(boss),/选择战术协议/);assert.ok(e.chooseProtocol(boss,boss.protocolOptions[0]).ok);assert.ok(e.shopAccess(boss).ok);
});
test('inventory combining remains available during pending rewards; full-reserve buy-and-combine works afterward',()=>{
 const r=shop();r.items.push({uid:'copy',id:'W01',tier:1,x:-1,y:-1,rotation:0,stored:true});complete(r);
 assert.ok(e.previewMerge(r,r.items[0].uid).ok);assert.ok(e.merge(r,r.items[0].uid).ok);assert.equal(r.phase,'reward');
 assert.ok(e.chooseReward(r,-1).ok);r.gold=500;r.shop[0]={id:'W01',tier:2,locked:false};
 for(let i=0;i<3;i++)r.items.push({uid:`reserve${i}`,id:'U02',tier:1,x:-1,y:-1,rotation:0,stored:true});
 const gold=r.gold,price=e.offerPrice(r.shop[0]);assert.ok(e.buyAndMerge(r,0,r.items[0].uid).ok);
 assert.equal(r.items[0].tier,3);assert.equal(r.items.filter(i=>i.stored).length,3);assert.equal(r.gold,gold-price);
 const once=structuredClone(r);assert.equal(e.buyAndMerge(r,0,r.items[0].uid).ok,false);assert.deepEqual(r,once);
});
test('the first connection remains visible and quick controls do not duplicate Auto equip',()=>{
 const r=shop(),uid=r.items[1].uid;assert.ok(e.storeItem(r,uid).ok);const coil=r.items.find(i=>i.uid===uid)!;
 let html=markup(r,coil);assert.match(html,/2 \/ 3/);
 const quick=html.split('<div class="quick-equip">')[1].split('<div class="rack">')[0];assert.equal((quick.match(/data-action="equip"/g)??[]).length,1);
 assert.ok(e.equipItem(r,coil.uid).ok);html=markup(r,r.items.find(i=>i.uid===coil.uid));assert.match(html,/3 \/ 3 · 连接已生效/);
});
test('merge preview compares equipped output and freed resources without mutating inventory',()=>{
 const r=shop();r.items=[{...r.items[0],x:1,y:0},{...r.items[0],uid:'other',x:1,y:2}];
 const before=structuredClone(r),impact=mergeImpact(r,r.items[0].uid)!;
 assert.deepEqual(r,before);assert.equal(impact.beforeOutput,2);assert.equal(impact.afterOutput,1.35);assert.ok(Math.abs(impact.outputChange!+32.5)<1e-8);
 assert.equal(impact.beforeWeapons,2);assert.equal(impact.afterWeapons,1);assert.equal(impact.freedCells,2);assert.equal(impact.freedPower,2);
 r.items[1].stored=true;assert.ok(Math.abs(mergeImpact(r,r.items[0].uid)!.outputChange!-35)<1e-8);
 r.items[0].stored=true;assert.equal(mergeImpact(r,r.items[0].uid)!.outputChange,undefined);
 r.items[0].stored=false;r.shop[0]={id:'W01',tier:1,locked:false};const buy=mergeImpact(r,r.items[0].uid,0)!;assert.equal(buy.afterWeapons,buy.beforeWeapons);assert.equal(buy.freedCells,0);
});
test('all weapons have roles and combo advice uses equipped parts and active supports',()=>{
 for(const m of MODULES.filter(m=>m.kind==='weapon'))for(const lang of ['zh','en'] as const)assert.ok(weaponRole(m.id,lang));
 const r=shop();r.items=[{...r.items[0],id:'W06'}];assert.match(shopAdvice(r,'W17','zh'),/补齐燃油连爆/);
 r.items[0].stored=true;assert.equal(shopAdvice(r,'W17','zh'),'');
 r.items=[{...shop().items[0],id:'W18'},{uid:'relay',id:'S10',tier:1,x:4,y:4,rotation:0,stored:true}];
 assert.match(buildSteps(r,'zh').join(' '),/可寻找/);assert.ok(!buildSteps(r,'zh').join(' ').includes('已接通'));
});
test('attack details record actual damage only and localize threats across save and settlement',()=>{
 const r=shop();assert.ok(e.startWave(r).ok);const world=createBattle(r);
 damagePlayer(world,10,'E04',world.player,'projectile');assert.equal(world.stats.damageTakenByAttack?.['E04:projectile'],10);
 damagePlayer(world,10,'E04',world.player,'projectile');assert.equal(world.stats.damageTakenByAttack?.['E04:projectile'],10);
 assert.ok(e.resolveBattle(r,{...win(r),stats:world.stats}).ok);
 const saved=reload(r),threat=mainThreat(saved.stats,'zh')!;assert.equal(threat.name,ENEMY_BY_ID.E04.name);assert.equal(threat.attack,'弹丸');assert.match(threat.advice,/横向/);
 assert.equal(mainThreat({ ...saved.stats,damageTakenByAttack:undefined},'en')!.attack,undefined);
 assert.equal(mainThreat({...saved.stats,damageTakenBy:{B2A:25}},'zh')!.name,'熔炉蟹');assert.notEqual(damageSourceName('unknown-code','zh'),'unknown-code');
});
test('current-feature policy covers all new weapons and uses earned growth and each chassis skill',()=>{
 const ids=new Set(CURRENT_FAMILIES.flatMap(f=>f.weapons));for(let n=13;n<=18;n++)assert.ok(ids.has('W'+n));
 for(const chassis of ['scavenger','bulwark','kestrel','hive']){
  const r=e.newRun(chassis,'full',0,'CURRENT-'+chassis);complete(r);const earned=chassisStats(r).growth.points;assert.ok(earned>0);
  prepareCurrent(r,CURRENT_FAMILIES[0]);assert.equal(chassisStats(r).growth.points,0);assert.equal(Object.values(chassisStats(r).growth.choices).reduce((a,b)=>a+b,0),earned);
  const world=createBattle(r);world.player.hp=1;
  spawnEnemy(world,{id:'E01',x:world.player.x+30,y:world.player.y,elite:false,affix:0,reward:false,cost:0});
  const input=decideCurrent(world,{preferredSurfaceRange:180},createPilotMemory());assert.equal(input.skill,true,chassis);
  // Verify skill request remains an ordinary input; effect execution is covered by combat skill tests.
  assert.equal(decideCurrent({...world,player:{...world.player,skillCooldown:10}},{preferredSurfaceRange:180},createPilotMemory()).skill,false);
 }
});
