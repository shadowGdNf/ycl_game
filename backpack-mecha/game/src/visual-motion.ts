/** Presentation-only locomotion. Distance drives the gait, logic time drives easing. */
import type {Point} from './types.ts';
export interface Locomotion {x:number;y:number;stride:number;amount:number;lean:number}
export function locomotion(previous:Locomotion|undefined,p:Point,dt:number):Locomotion {
 if(!previous)return {...p,stride:0,amount:0,lean:0};
 if(dt<=0)return previous;
 const dx=p.x-previous.x,dy=p.y-previous.y,distance=Math.hypot(dx,dy);
 // Teleports and reloads do not become a huge stride or body swing.
 const travel=distance<90?distance:0,speed=travel/dt,blend=1-Math.exp(-dt*15);
 const target=Math.min(1,speed/135);
 return {...p,stride:previous.stride+travel/90,amount:previous.amount+(target-previous.amount)*blend,
  lean:previous.lean+(Math.max(-1,Math.min(1,dx/(dt*180)))-previous.lean)*blend};
}
export const easeOut=(v:number)=>1-(1-Math.max(0,Math.min(1,v)))**3;
export const smoothStep=(v:number)=>{const t=Math.max(0,Math.min(1,v));return t*t*(3-2*t);};
