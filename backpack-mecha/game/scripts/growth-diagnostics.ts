import {createHash} from 'node:crypto';
import {MODULE_BY_ID} from '../src/content.ts';
import * as e from '../src/economy.ts';
import type {Run} from '../src/types.ts';
import {purchasePlan,value} from './natural-policy.ts';
import type {Family} from './natural-policy.ts';
import {ruleSnapshot,searchPurchase} from './purchase-search.ts';
import type {PurchaseSearch} from './purchase-search.ts';

export interface GrowthDecision {
 key:string;seed:string;family:string;wave:number;stage:string;id:string;source:'shop'|'reward';
 snapshot:Run;legacyPlanAvailable?:boolean;readyWithoutSales?:boolean;canAffordWithoutSales:boolean;
 expanded?:PurchaseSearch;note?:string;
}
export function createGrowthDiagnostics(family:Family,limit=512){
 const records:GrowthDecision[]=[],seen=new Set<string>();let dropped=0;
 function observe(run:Run,stage:string):void {
  const missing=family.core.filter(id=>!run.items.some(i=>i.id===id&&!i.stored));
  const offers=run.phase==='reward'?run.rewardOptions.map((id,index)=>({id,index,source:'reward' as const})):
   run.phase==='prep'?run.shop.map((o,index)=>({id:o.id,index,source:'shop' as const})):[];
  for(const {id,index,source}of offers.filter(o=>missing.includes(o.id))){
   const snapshot=ruleSnapshot(run),key=createHash('sha256').update(JSON.stringify({snapshot,id,source})).digest('hex');
   if(seen.has(key))continue;seen.add(key);
   if(records.length>=limit){dropped++;continue;}
   if(source==='reward'){
    records.push({key,seed:run.seed,family:family.id,wave:run.wave,stage,id,source,snapshot,canAffordWithoutSales:true,
     note:'Reward observed; expanded purchase search does not assess reward replacement. Inspect the following actions.'});continue;
   }
   const legacy=purchasePlan(run,index,family),preview=e.previewPurchase(run,index);
   records.push({key,seed:run.seed,family:family.id,wave:run.wave,stage,id,source,snapshot,
    legacyPlanAvailable:!!legacy,readyWithoutSales:preview.placements.some(p=>p.ready),canAffordWithoutSales:run.gold>=MODULE_BY_ID[id].price,
    expanded:searchPurchase(run,index,family.core,id=>value(id,family))});
  }
 }
 function summary(){
  const shop=records.filter(r=>r.source==='shop');
  return {recorded:records.length,dropped,rewardObservations:records.length-shop.length,
   legacyMissedWitnesses:shop.filter(r=>!r.legacyPlanAvailable&&r.expanded?.status==='found').length,
   noTotalBudget:shop.filter(r=>r.expanded?.status==='insufficient-total-scrap').length,
   boundedSearchUnresolved:shop.filter(r=>r.expanded?.status==='search-exhausted').length,
   constraintOccurrences:Object.fromEntries([...new Set(shop.flatMap(r=>r.expanded?.constraints??[]))].sort().map(key=>[key,shop.filter(r=>r.expanded?.constraints.includes(key)).length]))};
 }
 return {records,observe,summary};
}
