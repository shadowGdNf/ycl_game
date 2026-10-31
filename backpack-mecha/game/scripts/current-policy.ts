/** Opt-in current-feature coverage; historical probe policies remain reproducible. */
import type {BattleView,Run} from '../src/types.ts';
import {CHASSIS_BY_ID} from '../src/content.ts';
import {chassisStats} from '../src/progression.ts';
import * as economy from '../src/economy.ts';
import {prepare} from './natural-policy.ts';
import type {Family} from './natural-policy.ts';
import {decide} from './probe-pilot.ts';
import type {PilotBuild,BotMemory} from './probe-pilot.ts';

export const CURRENT_FAMILIES:Family[]=[
 {id:'rapid',name:'转轮穿甲',weapons:['W13','W07','W01'],supports:['S07','S03','S02','S01'],core:['W13','S07'],protocols:['P03','P06']},
 {id:'beam',name:'潮湿光矛',weapons:['W14','W03','W04','W01'],supports:['S05','S02','S01'],core:['W14','W03','S05'],protocols:['P01','P08']},
 {id:'pulse',name:'潮湿脉冲',weapons:['W15','W03','W08','W01'],supports:['S05','S11','S01'],core:['W15','W03','S05'],protocols:['P01','P04']},
 {id:'frost-spread',name:'冰晶散射',weapons:['W16','W12','W01'],supports:['S12','S02','S01'],core:['W16','S12'],protocols:['P09','P06']},
 {id:'mortar',name:'燃油迫击',weapons:['W17','W06','W02','W01'],supports:['S06','S09','S01'],core:['W17','W06','S06'],protocols:['P02','P07']},
 {id:'swarm',name:'突击蜂群',weapons:['W18','W11','W12','W01'],supports:['S10','S02','S01'],core:['W18','S10'],protocols:['P05','P08']},
];

export function prepareCurrent(run:Run,family:Family):void {
 prepare(run,family,{policy:'expanded'});
 if(run.phase!=='prep')return;
 // Spend earned points through production APIs; no granted growth or currency.
 while(chassisStats(run).growth.points){
  const stats=chassisStats(run),stat=run.hp<stats.maxHp*.45?'hp':stats.path.focus;
  if(!economy.upgradeChassis(run,stat).ok)throw Error('Could not allocate an earned specialization point');
 }
 if(run.hp<chassisStats(run).maxHp*.7)economy.repair(run);
 // The old policy ignores duplicate offers. Exercise the actual buy-and-combine path.
 for(let index=0;index<run.shop.length;index++){
  const target=economy.purchaseMergeTargets(run,index).find(i=>!i.stored);
  if(target&&run.gold>=economy.offerPrice(run.shop[index])+24){
   const result=economy.buyAndMerge(run,index,target.uid);if(!result.ok)throw Error(result.reason);
  }
 }
}
export function decideCurrent(view:BattleView,build:PilotBuild,memory:BotMemory){
 const input=decide(view,build,memory),p=view.player;
 const nearby=view.enemies.some(e=>e.hp>0&&Math.hypot(e.x-p.x,e.y-p.y)<(view.chassis==='bulwark'?180:450));
 const need=view.chassis==='scavenger'?p.hp<p.maxHp||view.drops.some(d=>Math.hypot(d.x-p.x,d.y-p.y)<320):
  view.chassis==='kestrel'?input.dash||p.hp<CHASSIS_BY_ID[view.chassis].hp*.5:nearby;
 return {...input,skill:(p.skillCooldown??0)<=0&&need};
}
