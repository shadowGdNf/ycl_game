import * as economy from '../src/economy.ts';
import {MODULE_BY_ID} from '../src/content.ts';
import {value} from './natural-policy.ts';
import type {Family} from './natural-policy.ts';
import type {Run} from '../src/types.ts';

export type EventPreference='skip'|'first'|'second';
export interface BranchRecord {wave:number;kind:'event'|'route';id?:string;requested:number;accepted:boolean;reason?:string;goldBefore:number;goldAfter:number;hpBefore:number;hpAfter:number}

/** Uses only current offers and the same target selectors as the workshop UI. */
export function resolvePreferredEvent(run:Run,family:Family,preference:EventPreference,records:BranchRecord[]):void {
 if(!run.eventId||run.eventResolved)return;
 const id=run.eventId;
 for(const choice of preference==='skip'?[-1]:preference==='first'?[0,1,-1]:[1,0,-1]){
  const previousExtra=structuredClone(run.extra??{});
  run.extra??={};
  if(choice===0&&id==='EV03'){
   const candidate=run.items.filter(i=>i.tier===1).sort((a,b)=>value(b.id,family)-value(a.id,family))[0];
   if(candidate)run.extra.eventTargetUid=candidate.uid;
  }
  if(choice===0&&id==='EV05'){
   // Keep an equipped weapon; dismantle a spare or a low-value non-weapon first.
   const candidate=run.items.filter(i=>i.stored||MODULE_BY_ID[i.id].kind!=='weapon').sort((a,b)=>value(a.id,family)-value(b.id,family))[0];
   if(candidate)run.extra.eventTargetUid=candidate.uid;
  }
  if(choice===0&&id==='EV06'){
   const weapon=run.items.filter(i=>!i.stored&&MODULE_BY_ID[i.id].kind==='weapon').sort((a,b)=>value(b.id,family)-value(a.id,family))[0];
   if(weapon)run.extra.eventTargetTag=MODULE_BY_ID[weapon.id].tags[0];
  }
  const goldBefore=run.gold,hpBefore=run.hp,result=economy.resolveEvent(run,choice);
  records.push({wave:run.wave,kind:'event',id,requested:choice,accepted:result.ok,reason:result.reasonEn,goldBefore,goldAfter:run.gold,hpBefore,hpAfter:run.hp});
  if(result.ok)return;
  run.extra=previousExtra;
 }
 throw Error('Event could not be resolved through normal APIs');
}

export function chooseRiskRoute(run:Run,route:0|1|2,records:BranchRecord[]):void {
 if(route===0||run.wave===1||run.wave%4===0)return;
 const goldBefore=run.gold,hpBefore=run.hp,result=economy.setRoute(run,route);
 records.push({wave:run.wave,kind:'route',requested:route,accepted:result.ok,reason:result.reasonEn,goldBefore,goldAfter:run.gold,hpBefore,hpAfter:run.hp});
 // An event can already supply risk. A rejected second contract stays rejected.
 if(!result.ok&&run.route!==0)throw Error('Rejected risk route changed the route');
}
