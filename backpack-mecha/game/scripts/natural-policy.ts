/** A bounded shop policy, not an optimal player or proof of human difficulty. */
import * as economy from '../src/economy.ts';
import {CHASSIS_BY_ID,MODULE_BY_ID} from '../src/content.ts';
import type {Run,Item} from '../src/types.ts';
import {searchPurchase,applyPurchasePlan} from './purchase-search.ts';
import type {PurchasePlan} from './purchase-search.ts';

export interface Family {id:string;name:string;weapons:string[];supports:string[];core:string[];protocols:string[]}
export const FAMILIES:Family[]=[
 {id:'wet',name:'潮湿电链',weapons:['W04','W03','W01'],supports:['S05','S02','S01'],core:['W03','W04','S05'],protocols:['P01','P08']},
 {id:'oil',name:'燃油连爆',weapons:['W05','W06','W10','W02','W01'],supports:['S06','S09','S02','S01'],core:['W05','W06','S06'],protocols:['P02','P07']},
 {id:'ballistic',name:'穿甲齐射',weapons:['W07','W01','W02'],supports:['S03','S07','S02','S01'],core:['W07','S03','U05'],protocols:['P03','P06']},
 {id:'fortress',name:'堡垒震荡',weapons:['W08','W09','W12','W01'],supports:['S11','S12','S01','S08'],core:['W08','W09','S11'],protocols:['P04','P08']},
 {id:'drone',name:'无人机编队',weapons:['W11','W12','W01'],supports:['S10','S02','S01','S12'],core:['W11','S10'],protocols:['P05','P08']},
 {id:'frost',name:'冰霜回弹',weapons:['W12','W01','W02'],supports:['S04','S12','S03','S01'],core:['W12','S04','S12'],protocols:['P09','P06']},
];
type Action={kind:'buy'|'sell'|'pack'|'place';index?:number;uid?:string;x?:number;y?:number;rotation?:number};
function perform(run:Run,action:Action):boolean {
 if(action.kind==='buy')return economy.buy(run,action.index!).ok;
 if(action.kind==='sell')return economy.sell(run,action.uid!).ok;
 if(action.kind==='pack')return economy.autoPack(run).ok;
 return economy.placeItem(run,action.uid!,action.x!,action.y!,action.rotation!).ok;
}
function rulesCopy(run:Run):Run {const {journal,saleUndo,...rules}=run;return structuredClone(rules);}
export function value(id:string,family:Family):number {
 const weapon=family.weapons.indexOf(id),support=family.supports.indexOf(id);
 if(weapon>=0)return 160-weapon*25;
 if(support>=0)return 75-support*8;
 return ({U01:90,U02:95,U06:45,U03:42,U05:48,U07:40} as Record<string,number>)[id]??0;
}
function worth(item:Item,family:Family):number{return value(item.id,family)+(item.tier-1)*12;}
function equipPlan(run:Run,uid:string,actions:Action[]):boolean {
 let positions=economy.placementOptions(run,uid).filter(p=>p.ready);
 if(!positions.length&&economy.autoPack(run).ok){actions.push({kind:'pack'});positions=economy.placementOptions(run,uid).filter(p=>p.ready);}
 const p=positions[0]?.item;if(!p)return false;
 const action:Action={kind:'place',uid,x:p.x,y:p.y,rotation:p.rotation};
 if(!perform(run,action))return false;actions.push(action);return true;
}
export function purchasePlan(run:Run,index:number,family:Family):{actions:Action[];gain:number}|undefined {
 const id=run.shop[index]?.id;if(!id||!value(id,family)||MODULE_BY_ID[id].price>run.gold)return;
 if(run.items.some(i=>i.id===id))return;
 const equipped=run.items.filter(i=>!i.stored).sort((a,b)=>worth(a,family)-worth(b,family));
 const removals:(Item[])[]=[[],...equipped.slice(0,4).map(i=>[i])];
 // Only consider replacing less valuable equipment. The probe never grants missing components.
 for(const remove of removals){
  const gain=value(id,family)-remove.reduce((n,i)=>n+worth(i,family),0);if(gain<=0)continue;
  const draft=rulesCopy(run),actions:Action[]=[];let viable=true;
  for(const item of remove){const action:Action={kind:'sell',uid:item.uid};if(!perform(draft,action)){viable=false;break;}actions.push(action);}
  if(!viable||!economy.buy(draft,index).ok)continue;actions.push({kind:'buy',index});
  if(equipPlan(draft,draft.items.at(-1)!.uid,actions)&&economy.validateLoadout(draft).ok)return {actions,gain};
 }
}
export interface PolicyOptions {policy?:'legacy'|'expanded';onDecision?:(run:Run,stage:string)=>void;onEvent?:(run:Run)=>void}
export function prepare(run:Run,family:Family,options:PolicyOptions={}):void {
 while(['reward','expansion','protocol'].includes(run.phase)){
  options.onDecision?.(run,run.phase);
  if(run.phase==='expansion'){
   if(!economy.chooseExpansion(run,[0,1,2,3].filter(i=>!run.unlockedCorners.includes(i)).slice(0,2)).ok)throw Error('Expansion failed');
  }else if(run.phase==='protocol'){
   const choice=family.protocols.find(id=>run.protocolOptions.includes(id))??run.protocolOptions[0];
   if(!economy.chooseProtocol(run,choice).ok)throw Error('Protocol failed');
  }else {
   const ranked=run.rewardOptions.map((id,index)=>({id,index})).sort((a,b)=>value(b.id,family)-value(a.id,family));
   let chosen=false;
   for(const candidate of ranked){
    if(!value(candidate.id,family)||run.items.some(i=>i.id===candidate.id))continue;
    const draft=rulesCopy(run),actions:Action[]=[];
    if(economy.chooseReward(draft,candidate.index).ok&&equipPlan(draft,draft.items.at(-1)!.uid,actions)){
     if(!economy.chooseReward(run,candidate.index).ok)throw Error('Reward failed');
     for(const a of actions)if(!perform(run,a))throw Error('Reward placement diverged');chosen=true;break;
    }
   }
   if(!chosen&&!economy.chooseReward(run,-1).ok)throw Error('Scrap reward failed');
  }
 }
 if(run.phase!=='prep')return;
 // Avoid optimizing event choices against hidden future random sequences.
 if(run.eventId&&!run.eventResolved){
  if(options.onEvent)options.onEvent(run);
  else if(!economy.resolveEvent(run,-1).ok)throw Error('Event skip failed');
  if(!run.eventResolved)throw Error('Event policy left an unresolved event');
  if(run.phase!=='prep')return prepare(run,family,options);
 }
 if(run.wave===1)return;
 if(run.hp<CHASSIS_BY_ID[run.chassis].hp*.7)economy.repair(run);
 for(let visit=0;visit<3;visit++){
  for(let selection=0;selection<4;selection++){
   options.onDecision?.(run,`shop:${visit}:${selection}`);
   if(options.policy==='expanded'){
    const plans:{plan:PurchasePlan;gain:number}[]=[];
    for(let i=0;i<run.shop.length;i++){
     const id=run.shop[i].id;
     if(family.core.includes(id)&&!run.items.some(item=>item.id===id)){
      const search=searchPurchase(run,i,family.core,id=>value(id,family));
      // This is an explicit preference for forming a core, not a change to game prices.
      if(search.plan){const gain=value(id,family)+100-search.plan.loss;if(gain>0)plans.push({plan:search.plan,gain});}
     }else{
      const old=purchasePlan(run,i,family);
      if(old&&!old.actions.some(a=>a.kind==='sell'&&family.core.includes(run.items.find(i=>i.uid===a.uid)!.id)))
       plans.push({plan:{actions:old.actions as PurchasePlan['actions'],removed:[],loss:0,repacked:false},gain:old.gain});
     }
    }
    plans.sort((a,b)=>b.gain-a.gain);if(!plans[0])break;applyPurchasePlan(run,plans[0].plan);continue;
   }
   const plans=run.shop.map((_,i)=>purchasePlan(run,i,family)).filter((p):p is NonNullable<typeof p>=>!!p).sort((a,b)=>b.gain-a.gain);
   if(!plans[0])break;
   for(const a of plans[0].actions)if(!perform(run,a))throw Error('Shop plan diverged from real API');
  }
  const weapons=run.items.filter(i=>!i.stored&&MODULE_BY_ID[i.id].kind==='weapon').sort((a,b)=>worth(b,family)-worth(a,family));
  for(const weapon of weapons)while((run.items.find(i=>i.uid===weapon.uid)?.tier??3)<run.maxTier){if(!economy.upgrade(run,weapon.uid).ok)break;}
  if(visit===2||run.gold<38||!economy.refreshShop(run).ok)break;
 }
 for(const item of run.items.filter(i=>!i.stored&&MODULE_BY_ID[i.id].kind!=='weapon')){
  if(run.gold<30)break;economy.upgrade(run,item.uid);
 }
 if(!economy.validateLoadout(run).ok)throw Error('Policy produced invalid loadout');
}

export function pilotBuild(run:Run,family:Family):{preferredSurfaceRange:number;melee:boolean} {
 const main=run.items.filter(i=>!i.stored&&MODULE_BY_ID[i.id].kind==='weapon').sort((a,b)=>worth(b,family)-worth(a,family))[0];
 const range=({W08:64,W09:64,W05:140,W06:180,W02:160,W03:260,W04:275,W11:275,W12:210,W07:360} as Record<string,number>)[main?.id]??210;
 return {preferredSurfaceRange:range,melee:range<100};
}
