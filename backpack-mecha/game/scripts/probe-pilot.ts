/** Observable-state pilot shared by fixture and natural-growth probes. */
import {contains} from '../src/combat.ts';
import {traversable} from '../src/encounters.ts';
import type {BattleView, EnemyView, InputFrame, Point, ZoneView} from '../src/types.ts';
export interface PilotBuild {preferredSurfaceRange:number;melee?:boolean}
const clamp=(v:number,min:number,max:number)=>Math.max(min,Math.min(max,v));
const distance=(a:Point,b:Point)=>Math.hypot(a.x-b.x,a.y-b.y);
type Observed={p:Point;time:number};
type ZoneObserved={angle:number;radius:number;time:number};
type SensorEnemy=EnemyView&{vx:number;vy:number};
type SensorZone=ZoneView&{angleRate:number;radiusRate:number};
export type BotMemory={enemies:Map<number,Observed>;zones:Map<number,ZoneObserved>;direction:number;lastInput:InputFrame;noSafeCandidate:number;dashDecisions:number;visibleWarnings:Set<number>};

export function createPilotMemory(index=0):BotMemory{return {enemies:new Map(),zones:new Map(),direction:index%2===0?1:-1,lastInput:{x:0,y:0,dash:false,overload:false},noSafeCandidate:0,dashDecisions:0,visibleWarnings:new Set()};}
function sensors(view:BattleView,memory:BotMemory){
  // Matches a 960×720 world-unit viewport. Nothing outside it influences the policy.
  const camera={x:clamp(view.player.x-480,0,view.width-960),y:clamp(view.player.y-360,0,view.height-720)};
  const visible=(p:Point,r=0)=>p.x+r>=camera.x&&p.x-r<=camera.x+960&&p.y+r>=camera.y&&p.y-r<=camera.y+720;
  const enemies:SensorEnemy[]=view.enemies.filter(e=>e.hp>0&&e.exposed!==false&&visible(e,e.radius)).map(e=>{
    const previous=memory.enemies.get(e.eid),dt=previous?view.time-previous.time:0;
    const v=dt>0&&dt<.25?{x:(e.x-previous!.p.x)/dt,y:(e.y-previous!.p.y)/dt}:{x:0,y:0};
    memory.enemies.set(e.eid,{p:{x:e.x,y:e.y},time:view.time});
    return {...e,vx:clamp(v.x,-500,500),vy:clamp(v.y,-500,500)};
  });
  const zones:SensorZone[]=view.zones.filter(z=>z.type!=='friendly'&&(z.delay??0)<=0&&visible(z,Math.max(z.radius,z.w??0,z.h??0))).map(z=>{
    memory.visibleWarnings.add(z.id);const previous=memory.zones.get(z.id),dt=previous?view.time-previous.time:0;
    const angleRate=dt>0&&dt<.25?clamp(Math.atan2(Math.sin(z.angle-previous!.angle),Math.cos(z.angle-previous!.angle))/dt,-4,4):0;
    const radiusRate=dt>0&&dt<.25?clamp((z.radius-previous!.radius)/dt,-300,300):0;
    memory.zones.set(z.id,{angle:z.angle,radius:z.radius,time:view.time});return {...z,angleRate,radiusRate};
  });
  const bullets=view.bullets.filter(b=>b.owner==='enemy'&&visible(b,b.radius)&&distance(b,view.player)<550);
  return {enemies,zones,bullets};
}

export function decide(view:BattleView,build:PilotBuild,memory:BotMemory):InputFrame{
  const p=view.player,{enemies,zones,bullets}=sensors(view,memory);
  const bosses=enemies.filter(e=>e.kind==='boss').sort((a,b)=>distance(p,a)-distance(p,b));
  const closeMob=enemies.filter(e=>e.kind!=='boss'&&distance(p,e)<150).sort((a,b)=>distance(p,a)-distance(p,b))[0];
  const target=closeMob??bosses[0]??enemies.sort((a,b)=>distance(p,a)-distance(p,b))[0];
  const preferred=target?.kind==='boss'?build.preferredSurfaceRange:Math.min(160,build.preferredSurfaceRange);
  const toTarget=target?Math.atan2(target.y-p.y,target.x-p.x):Math.atan2(view.height*.4-p.y,view.width*.5-p.x);
  const orbit=toTarget+memory.direction*Math.PI/2;
  const anyCurrentDanger=zones.some(z=>contains(z,p,p.radius+6)&&(z.active||z.remaining<.5))||bullets.some(b=>distance(b,p)<90)||enemies.some(e=>distance(e,p)<e.radius+p.radius+30);
  const candidates:{x:number;y:number;dash:boolean;score:number;danger:number}[]=[];
  for(const dash of [false,true]){
    if(dash&&(p.dashCooldown>0||p.dashTime>0||(!anyCurrentDanger&&!build.melee)))continue;
    for(let i=-1;i<16;i++){
      if(dash&&i===-1)continue;
      const angle=i*TAU/16,x=i<0?0:Math.cos(angle),y=i<0?0:Math.sin(angle);
      const pos=(t:number)=>{const travel=p.speed*(dash?Math.min(t,.18)*3.2+Math.max(0,t-.18):t);return {x:p.x+x*travel,y:p.y+y*travel};};
      let score=dash?(build.melee?22:65):0,danger=0;
      const end=pos(.75),margin=Math.min(end.x,view.width-end.x,end.y,view.height-end.y);
      if(!traversable(end,p.radius+8,view.obstacles,view.width,view.height))score+=100000;
      score+=Math.max(0,85-margin)*2;
      if(target){const predicted={x:target.x+target.vx*.35,y:target.y+target.vy*.35};const surface=distance(end,predicted)-target.radius;score+=.022*(surface-preferred)**2;score-=14*(x*Math.cos(orbit)+y*Math.sin(orbit));}
      else score+=distance(end,{x:view.width*.5,y:view.height*.4})*.3;
      for(const e of enemies){
        for(const t of [.15,.4,.75]){
          const q=pos(t),ep={x:e.x+e.vx*t,y:e.y+e.vy*t};const gap=distance(q,ep)-e.radius-p.radius;
          if(gap<10&&!(dash&&t<=.18))danger+=900+Math.max(0,10-gap)*35;
          else if(gap<35)score+=(35-gap)*2;
        }
      }
      for(const z of zones){
        if((z.damage??0)<=0)continue; // zero-damage visible utility fields do not injure the player.
        const times=z.active?[.12,.35,.65]:[Math.min(.8,Math.max(.12,z.remaining))];
        for(const t of times){
          if(z.active&&z.remaining<t)continue;if(dash&&t<=.18)continue;
          const q=pos(t),predicted={...z,angle:z.angle+z.angleRate*t,radius:Math.max(0,z.radius+z.radiusRate*t),innerRadius:z.innerRadius===undefined?undefined:Math.max(0,z.innerRadius+z.radiusRate*t)};
          if(contains(predicted,q,p.radius+8))danger+=z.active||z.remaining<=.8?1700:450;
        }
      }
      for(const b of bullets){
        const vx=b.vx-x*p.speed,vy=b.vy-y*p.speed,rx=b.x-p.x,ry=b.y-p.y;
        const t=clamp(-(rx*vx+ry*vy)/Math.max(1,vx*vx+vy*vy),0,.75);
        if(dash&&t<=.18)continue;
        const q=pos(t),bp={x:b.x+b.vx*t,y:b.y+b.vy*t};const gap=distance(q,bp)-p.radius-b.radius;
        if(gap<7)danger+=1300+(7-gap)*18;
      }
      // Preserve direction slightly to avoid jitter without reading future attacks.
      score-=2*(x*memory.lastInput.x+y*memory.lastInput.y);candidates.push({x,y,dash,score:score+danger,danger});
    }
  }
  candidates.sort((a,b)=>a.score-b.score||Number(a.dash)-Number(b.dash));
  if(candidates.every(c=>c.danger>=900))memory.noSafeCandidate++;
  const best=candidates[0];if(best.dash)memory.dashDecisions++;
  const input:InputFrame={x:best.x,y:best.y,dash:best.dash,overload:p.overloadCooldown<=0&&Boolean(target),...(target?{target:{x:target.x,y:target.y}}:{})};
  memory.lastInput=input;return input;
}
const TAU=Math.PI*2;

