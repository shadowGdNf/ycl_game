/** Bounded, visible-inventory search for probes. Never commits a hypothetical layout. */
import * as e from '../src/economy.ts';
import {MODULE_BY_ID} from '../src/content.ts';
import type {Item,Run} from '../src/types.ts';

export type PurchaseAction =
 | {kind:'buy';index:number;placement?:{x:number;y:number;rotation:number}}
 | {kind:'sell'|'store';uid:string}
 | {kind:'place';uid:string;x:number;y:number;rotation:number}
 | {kind:'link';uid:string;target:string}
 | {kind:'pack'};
export interface PurchasePlan {actions:PurchaseAction[];removed:string[];loss:number;repacked:boolean}
export interface PurchaseSearch {
 status:'found'|'unavailable'|'owned'|'insufficient-total-scrap'|'search-exhausted';
 constraints:string[];attempts:number;packAttempts:number;limit:number;truncated:boolean;
 cash:number;price:number;maximumSaleCash:number;plan?:PurchasePlan;
}
export function ruleSnapshot(run:Run):Run {
 const {journal,saleUndo,...rules}=run;
 return structuredClone({...rules,history:[]});
}
export function applyPurchaseAction(run:Run,a:PurchaseAction):boolean {
 switch(a.kind){
  case 'buy':return e.buy(run,a.index,a.placement).ok;
  case 'sell':return e.sell(run,a.uid).ok;
  case 'store':return e.storeItem(run,a.uid).ok;
  case 'place':return e.placeItem(run,a.uid,a.x,a.y,a.rotation).ok;
  case 'link':return e.setLink(run,a.uid,a.target).ok;
  case 'pack':return e.autoPack(run).ok;
 }
}
export function applyPurchasePlan(run:Run,plan:PurchasePlan):void {
 for(const action of plan.actions)if(!applyPurchaseAction(run,action))throw Error(`Purchase witness diverged: ${JSON.stringify(action)}`);
 if(!e.validateLoadout(run).ok)throw Error('Purchase witness ended with an invalid loadout');
}
const active=(r:Run)=>r.items.filter(i=>!i.stored);
const samePosition=(a:Item,b:Item)=>!a.stored&&a.x===b.x&&a.y===b.y&&a.rotation===b.rotation;
const fitsTags=(s:Item,w:Item)=>MODULE_BY_ID[s.id].tags.includes('全部')||MODULE_BY_ID[s.id].tags.some(t=>MODULE_BY_ID[w.id].tags.includes(t));

/** Necessary final-inventory constraints; these do not prove a geometric packing exists. */
function inventoryConstraints(r:Run):string[] {
 const items=active(r),weapons=items.filter(i=>MODULE_BY_ID[i.id].kind==='weapon'),supports=items.filter(i=>MODULE_BY_ID[i.id].kind==='support'),reasons:string[]=[];
 if(!weapons.length||weapons.length>3)reasons.push('weapon-count');
 if(items.reduce((n,i)=>n+MODULE_BY_ID[i.id].power,0)>e.getCapacity(r))reasons.push('power');
 if(items.reduce((n,i)=>n+e.getCells(i).length,0)>21+r.unlockedCorners.length)reasons.push('cell-count');
 if(supports.length>weapons.length*2)reasons.push('support-slot-count');
 if(supports.some(s=>!weapons.some(w=>fitsTags(s,w))))reasons.push('support-tags');
 return reasons;
}

/** Turn a solver's target into legal player operations, including temporary reserve moves. */
function reachLayout(from:Run,target:Run):PurchaseAction[]|undefined {
 const r=ruleSnapshot(from),actions:PurchaseAction[]=[],wanted=active(target);
 for(let step=0;step<wanted.length*4;step++){
  const pending=wanted.filter(t=>!samePosition(r.items.find(i=>i.uid===t.uid)!,t));
  if(!pending.length){
   // Clear before reconnecting so swapping two full weapon slots remains legal.
   for(const t of wanted.filter(i=>MODULE_BY_ID[i.id].kind==='support')){
    const a:PurchaseAction={kind:'link',uid:t.uid,target:''};
    if(!applyPurchaseAction(r,a))return;actions.push(a);
   }
   for(const t of wanted.filter(i=>i.link)){
    const a:PurchaseAction={kind:'link',uid:t.uid,target:t.link!};
    if(!applyPurchaseAction(r,a))return;actions.push(a);
   }
   return e.validateLoadout(r).ok?actions:undefined;
  }
  let changed=false;
  for(const t of pending){
   const a:PurchaseAction={kind:'place',uid:t.uid,x:t.x,y:t.y,rotation:t.rotation};
   if(applyPurchaseAction(r,a)){actions.push(a);changed=true;}
  }
  if(changed)continue;
  const movable=pending.map(t=>r.items.find(i=>i.uid===t.uid)!).filter(i=>!i.stored)
   .sort((a,b)=>Number(a.id==='U01')-Number(b.id==='U01')||e.getCells(b).length-e.getCells(a).length);
  for(const item of movable){
   const a:PurchaseAction={kind:'store',uid:item.uid};
   if(applyPurchaseAction(r,a)){actions.push(a);changed=true;break;}
  }
  if(!changed)return;
 }
}

/** Keeps existing core parts, removes at most two others, and bounds expensive packing. */
export function searchPurchase(run:Run,index:number,core:string[],score:(id:string)=>number,limit=48,packLimit=8):PurchaseSearch {
 const id=run.shop[index]?.id,m=MODULE_BY_ID[id],maximumSaleCash=run.gold+run.items.reduce((n,i)=>n+Math.floor(e.standardCost(i)*.5),0);
 const out:PurchaseSearch={status:'search-exhausted',constraints:[],attempts:0,packAttempts:0,limit,truncated:false,cash:run.gold,price:m?.price??0,maximumSaleCash};
 if(!m||run.phase!=='prep'||run.wave===1){out.status='unavailable';return out;}
 if(run.items.some(i=>i.id===id)){out.status='owned';return out;}
 if(run.gold<m.price)out.constraints.push('cash-before-sale');
 if(run.items.filter(i=>i.stored).length>=3)out.constraints.push('reserve-full');
 if(maximumSaleCash<m.price){out.status='insufficient-total-scrap';return out;}
 const candidates=run.items.filter(i=>!core.includes(i.id)).sort((a,b)=>score(a.id)-score(b.id)||a.uid.localeCompare(b.uid));
 const removals:Item[][]=[[]];
 for(let i=0;i<candidates.length;i++){
  removals.push([candidates[i]]);
  for(let j=i+1;j<candidates.length;j++)removals.push([candidates[i],candidates[j]]);
 }
 const loss=(items:Item[])=>items.reduce((n,i)=>n+score(i.id)+(i.tier-1)*12,0);
 removals.sort((a,b)=>loss(a)-loss(b)||a.length-b.length);
 for(const remove of removals){
  if(out.attempts>=limit){out.truncated=true;break;}out.attempts++;
  const draft=ruleSnapshot(run),actions:PurchaseAction[]=[];
  let viable=true;
  for(const item of remove){const a:PurchaseAction={kind:'sell',uid:item.uid};if(!applyPurchaseAction(draft,a)){viable=false;break;}actions.push(a);}
  if(!viable||draft.gold<m.price)continue;
  // Preview the desired inventory before doing geometric work. This draft is never committed.
  const desired=ruleSnapshot(draft),candidate:Item={uid:`i${draft.nextUid}`,id,tier:1,x:0,y:0,rotation:0,stored:false};
  desired.items.push(candidate);
  const constraints=inventoryConstraints(desired);
  if(!remove.length)out.constraints.push(...constraints);
  if(constraints.length)continue;
  const ready=e.previewPurchase(draft,index).placements.find(p=>p.ready);
  if(ready?.item){
   const a:PurchaseAction={kind:'buy',index,placement:{x:ready.item.x,y:ready.item.y,rotation:ready.item.rotation}};
   if(applyPurchaseAction(draft,a)&&e.validateLoadout(draft).ok){
    out.status='found';out.plan={actions:[...actions,a],removed:remove.map(i=>i.uid),loss:loss(remove),repacked:false};return out;
   }
  }
  if(!remove.length)out.constraints.push('no-ready-placement-in-current-layout');
  // A hypothetical pack is only a target. The returned witness must replay from the
  // real purchased-to-reserve state using public economy APIs, including rack limits.
  if(out.packAttempts>=packLimit){out.truncated=true;continue;}out.packAttempts++;
  if(!e.buy(draft,index).ok)continue;
  const purchased=draft.items.at(-1)!;
  const target=ruleSnapshot(draft);target.items.find(i=>i.uid===purchased.uid)!.stored=false;
  if(!e.autoPack(target).ok)continue;
  const moves=reachLayout(draft,target);if(!moves)continue;
  out.status='found';out.plan={actions:[...actions,{kind:'buy',index},...moves],removed:remove.map(i=>i.uid),loss:loss(remove),repacked:true};return out;
 }
 return out;
}
