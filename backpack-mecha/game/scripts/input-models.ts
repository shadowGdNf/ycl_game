/** Synthetic input constraints; these names do not describe human skill levels. */
import {createPilotMemory,decide} from './probe-pilot.ts';
import type {PilotBuild} from './probe-pilot.ts';
import type {BattleView,InputFrame} from '../src/types.ts';

export const INPUT_MODELS={
 frequent:{decisionTicks:6,latencyTicks:0,dashGapTicks:0,overloadGapTicks:0},
 delayed:{decisionTicks:18,latencyTicks:18,dashGapTicks:0,overloadGapTicks:0},
 sparse:{decisionTicks:6,latencyTicks:0,dashGapTicks:720,overloadGapTicks:2700},
} as const;
export type InputModel=keyof typeof INPUT_MODELS;

export function createInputDriver(model:InputModel,build:PilotBuild,index=0,
 choose:typeof decide=decide) {
 const config=INPUT_MODELS[model],memory=createPilotMemory(index);
 let held:InputFrame={x:0,y:0,dash:false,overload:false},nextDash=0,nextOverload=0;
 const pending:{at:number;input:InputFrame}[]=[];
 const stats={decisions:0,queued:0,dashRequests:0,overloadRequests:0,suppressedDash:0,suppressedOverload:0,maxPending:0};
 function input(view:BattleView,tick:number):InputFrame {
  if(tick%config.decisionTicks===0){
   const proposed={...choose(view,build,memory)};stats.decisions++;
   if(proposed.dash&&tick<nextDash){proposed.dash=false;stats.suppressedDash++;}
   if(proposed.overload&&tick<nextOverload){proposed.overload=false;stats.suppressedOverload++;}
   if(proposed.dash){stats.dashRequests++;nextDash=tick+config.dashGapTicks;}
   if(proposed.overload){stats.overloadRequests++;nextOverload=tick+config.overloadGapTicks;}
   pending.push({at:tick+config.latencyTicks,input:proposed});stats.queued++;stats.maxPending=Math.max(stats.maxPending,pending.length);
  }
  while(pending[0]?.at<=tick)held=pending.shift()!.input;
  return held;
 }
 return {input,stats,memory,config};
}
