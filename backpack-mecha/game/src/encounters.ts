import {BOSS_BY_ID, ENEMY_BY_ID, WAVES} from './content.ts';
import {nextRandom} from './random.ts';
import type {Mode, Point, Rect, Run, WaveDef} from './types.ts';

export const ARENA={width:1600,height:1200};
export const BOSS_DAMAGE_SCALE=1.5;
export interface SpawnSpec extends Point {id:string;elite:boolean;affix:number;reward:boolean;cost:number;boss?:boolean;group?:string}
export interface EncounterState {mode:Mode;budget:number;spent:number;nextSpawn:number;extraElite:boolean;eliteQueued:boolean;wave:WaveDef;variant:number}
export interface AttackPlan extends Point {
 kind:'circle'|'rect'|'cone'|'ring'|'line'; warning:number;active:number;damage:number;
 radius:number;angle:number;width?:number;w?:number;h?:number;innerRadius?:number;
 delay?:number;period?:number;effect?:'damage'|'charge'|'pull'|'projectile'|'spawn'|'conveyor'|'fire'|'drill'|'mortar';
 count?:number;enemy?:string;limit?:number;speed?:number;spread?:number;projectileRadius?:number;
 length?:number;sweep?:number;grow?:number;slow?:number;target?:Point;spawnHp?:number;spawnDamage?:number;
}
export interface BossTurn {plans:AttackPlan[];duration:number;recovery:number}
const layouts:Rect[][]=[
 [{x:320,y:240,w:180,h:100},{x:1100,y:860,w:180,h:100},{x:1100,y:240,w:100,h:160},{x:400,y:830,w:100,h:170}],
 [{x:320,y:330,w:120,h:270},{x:1160,y:600,w:120,h:270},{x:700,y:160,w:200,h:90},{x:700,y:950,w:200,h:90}],
 [{x:280,y:260,w:240,h:100},{x:1080,y:260,w:240,h:100},{x:280,y:840,w:240,h:100},{x:1080,y:840,w:240,h:100}],
 [{x:430,y:270,w:110,h:180},{x:1060,y:750,w:110,h:180},{x:1060,y:270,w:110,h:180},{x:430,y:750,w:110,h:180}],
];
const factoryLayouts:Rect[][]=[
 [{x:260,y:200,w:120,h:600},{x:1220,y:400,w:120,h:600},{x:600,y:200,w:400,h:100},{x:600,y:900,w:400,h:100}],
 [{x:280,y:270,w:340,h:110},{x:980,y:820,w:340,h:110},{x:1120,y:270,w:140,h:280},{x:340,y:650,w:140,h:280}],
 [{x:420,y:440,w:180,h:260},{x:1000,y:440,w:180,h:260},{x:650,y:170,w:300,h:90},{x:650,y:950,w:300,h:90}],
 [{x:260,y:300,w:260,h:130},{x:1080,y:300,w:260,h:130},{x:380,y:820,w:220,h:140},{x:1000,y:820,w:220,h:140}],
];
const portLayouts:Rect[][]=[
 [{x:300,y:200,w:250,h:150},{x:1050,y:200,w:250,h:150},{x:300,y:850,w:250,h:150},{x:1050,y:850,w:250,h:150}],
 [{x:270,y:330,w:350,h:80},{x:980,y:330,w:350,h:80},{x:270,y:790,w:350,h:80},{x:980,y:790,w:350,h:80}],
 [{x:300,y:220,w:150,h:150},{x:1150,y:220,w:150,h:150},{x:300,y:830,w:150,h:150},{x:1150,y:830,w:150,h:150},{x:700,y:170,w:200,h:80},{x:700,y:950,w:200,h:80}],
 [{x:650,y:180,w:300,h:110},{x:650,y:910,w:300,h:110},{x:300,y:490,w:190,h:210},{x:1110,y:490,w:190,h:210}],
];
export function createEncounter(run:Run):{state:EncounterState;obstacles:Rect[];boss?:string} {
 const wave=WAVES.find(w=>w.n===run.wave);
 if(!wave)throw new Error(`Unknown wave ${run.wave}`);
 const [,v]=nextRandom((run.rng.map^Math.imul(run.wave,2654435761))>>>0);
 const variant=Math.floor(v*4),risk=run.route===1||Number(run.extra?.eventBudgetBonus||0)>0;
 const difficultyBudget=[1,1.05,1.05,1.10,1.15][Math.min(4,Math.max(0,run.difficulty))]!;
 const budget=Math.ceil(wave.budget*difficultyBudget*(risk?1.15:1));
 const extraElite=run.route===2||Boolean(run.extra?.eventExtraElite);
 let boss:string|undefined;
 if(wave.kind==='boss'){
  boss=run.mode==='full'?(run.bosses[wave.act-1]||`B${wave.act}A`):`B${wave.act}A`;
  if(!BOSS_BY_ID[boss])boss=`B${wave.act}A`;
 }
 return {state:{mode:run.mode,budget,spent:0,nextSpawn:0,extraElite,eliteQueued:false,wave:{...wave},variant},
  obstacles:boss?[]:[layouts,factoryLayouts,portLayouts][wave.act-1]![variant]!.map(r=>({...r})),...(boss?{boss}:{})};
}
export function availableBudget(enc:EncounterState,time:number):number {
 const p=Math.max(0,Math.min(1,time/enc.wave.duration));
 const fraction=p<.25?p*.8:p<.75?.2+(p-.25):.7+(p-.75)*1.2;
 return Math.max(0,Math.floor(enc.budget*fraction+.000001)-enc.spent);
}
export function enemyPool(wave:number,mode:Mode):string[] {
 const ids=wave===1?['E01','E02']:wave===2?['E01','E02','E04']:
 wave<=4?['E01','E02','E03','E04','E05']:wave<=6?['E01','E02','E03','E04','E05','E06','E07']:
 wave<=8?['E01','E02','E03','E04','E05','E06','E07','E08','E09']:
 ['E01','E02','E03','E04','E05','E06','E07','E08','E09','E10','E11','E12'];
 if(mode==='full'){if(wave>=2)ids.push('E13');if(wave>=3)ids.push('E14');if(wave>=5)ids.push('E15');if(wave>=7)ids.push('E16');}
 return ids.filter(id=>mode==='full'||Number(id.slice(1))<=(mode==='prototype'?5:6));
}
export function chooseEnemy(enc:EncounterState,allowance:number,random:number):string|undefined {
 const pool=enemyPool(enc.wave.n,enc.mode).filter(id=>ENEMY_BY_ID[id]!.cost<=allowance);
 if(!pool.length)return undefined;
 const weights=pool.map(id=>{
  const e=ENEMY_BY_ID[id]!,act=enc.wave.act;
  const group=['E01','E02','E13'].includes(id)?'chase':['E04','E11','E14','E16'].includes(id)?'ranged':['E06','E09'].includes(id)?'support':'heavy';
  const weight=({chase:[.65,.4,.3],ranged:[.2,.25,.25],support:[0,.2,.2],heavy:[.15,.15,.25]}[group])[act-1]!;
  return Math.max(.01,weight)/e.cost;
 });
 let at=random*weights.reduce((a,b)=>a+b,0);
 for(let i=0;i<pool.length;i++){at-=weights[i]!;if(at<=0)return pool[i];}
 return pool[pool.length-1];
}
export function insideArena(p:Point,r:number,width=ARENA.width,height=ARENA.height):boolean {
 return p.x>=r&&p.y>=r&&p.x<=width-r&&p.y<=height-r;
}
export function circleHitsRect(p:Point,r:number,b:Rect):boolean {
 const x=Math.max(b.x,Math.min(p.x,b.x+b.w)),y=Math.max(b.y,Math.min(p.y,b.y+b.h));
 return (p.x-x)**2+(p.y-y)**2<r*r;
}
export function traversable(p:Point,r:number,obstacles:Rect[],width=ARENA.width,height=ARENA.height):boolean {
 return insideArena(p,r,width,height)&&!obstacles.some(b=>circleHitsRect(p,r,b));
}
/** Conservative swept-circle visibility, including clearance around obstacle corners. */
export function clearPath(start:Point,end:Point,obstacles:Rect[],radius:number,width=1600,height=1200):boolean {
 if(!insideArena(end,radius,width,height))return false;
 const dx=end.x-start.x,dy=end.y-start.y;
 for(const b of obstacles){
  let lo=0,hi=1;
  for(const [p,d,min,max] of [[start.x,dx,b.x-radius,b.x+b.w+radius],[start.y,dy,b.y-radius,b.y+b.h+radius]]){
   if(Math.abs(d)<1e-8){if(p<min||p>max){lo=2;break;}}
   else{const a=(min-p)/d,z=(max-p)/d;lo=Math.max(lo,Math.min(a,z));hi=Math.min(hi,Math.max(a,z));}
  }
  if(lo<=hi&&hi>=0&&lo<=1)return false;
 }
 return true;
}
type NavigationGrid={cols:number;rows:number;open:Uint8Array;queue:Int32Array;previous:Int32Array};
// Geometry is static in a battle. Cache passability, not routes or moving targets.
// Weak keys release a finished battle; the signature also handles edited test arenas.
const navigationGrids=new WeakMap<Rect[],{signature:string;grids:Map<number,NavigationGrid>}>();
function navigationGrid(obstacles:Rect[],radius:number,width:number,height:number):NavigationGrid {
 const signature=`${width},${height}:`+obstacles.map(r=>`${r.x},${r.y},${r.w},${r.h}`).join(';');
 let entry=navigationGrids.get(obstacles);
 if(!entry||entry.signature!==signature){entry={signature,grids:new Map()};navigationGrids.set(obstacles,entry);}
 const cached=entry.grids.get(radius);if(cached)return cached;
 const cols=Math.ceil(width/50),rows=Math.ceil(height/50),count=cols*rows,open=new Uint8Array(count);
 for(let i=0;i<count;i++)open[i]=Number(traversable({x:(i%cols+.5)*50,y:(Math.floor(i/cols)+.5)*50},radius+3,obstacles,width,height));
 const grid={cols,rows,open,queue:new Int32Array(count),previous:new Int32Array(count)};
 if(entry.grids.size>=24)entry.grids.clear();entry.grids.set(radius,grid);return grid;
}
/** Shared navigation service; AI never changes collision rules. Paths are plain JSON. */
export function findPath(start:Point,end:Point,obstacles:Rect[],radius:number,width=1600,height=1200):Point[] {
 if(!obstacles.length)return [{x:end.x,y:end.y}];
 const size=50,{cols,rows,open,queue,previous:prev}=navigationGrid(obstacles,radius,width,height);
 const toCell=(p:Point)=>Math.min(rows-1,Math.max(0,Math.floor(p.y/size)))*cols+Math.min(cols-1,Math.max(0,Math.floor(p.x/size)));
 const center=(i:number)=>({x:(i%cols+.5)*size,y:(Math.floor(i/cols)+.5)*size});
 const a=toCell(start),target=toCell(end);prev.fill(-2);prev[a]=-1;queue[0]=a;let head=0,tail=1,best=a,bestD=Infinity;
 while(head<tail){const here=queue[head++]!,p=center(here),d=(p.x-end.x)**2+(p.y-end.y)**2;
  if(d<bestD){best=here;bestD=d;}if(here===target){best=here;break;}
  for(const [dx,dy] of [[1,0],[-1,0],[0,1],[0,-1]]){const x=here%cols+dx!,y=Math.floor(here/cols)+dy!;
   if(x<0||y<0||x>=cols||y>=rows)continue;const next=y*cols+x;
   if(prev[next]!==-2||!open[next])continue;
   prev[next]=here;queue[tail++]=next;
  }
 }
 const path:Point[]=[];let node=best;
 while(node!==a&&node>=0){path.push(center(node));node=prev[node]!;}
 path.reverse();if(best===target)path.push({x:end.x,y:end.y});return path;
}
const toward=(a:Point,b:Point)=>Math.atan2(b.y-a.y,b.x-a.x);
function circle(p:Point,radius:number,warning:number,damage:number,extra:Partial<AttackPlan>={}):AttackPlan {
 return {...p,kind:'circle',radius,angle:0,warning,active:.12,damage,...extra};
}
function cone(p:Point,angle:number,radius:number,width:number,warning:number,damage:number,extra:Partial<AttackPlan>={}):AttackPlan {
 return {...p,kind:'cone',radius,width,angle,warning,active:.12,damage,...extra};
}
function landings(p:Point,count:number,spread:number,radius:number,warning:number,damage:number,extra:Partial<AttackPlan>={}):AttackPlan[] {
 return Array.from({length:count},(_,i)=>circle({x:Math.max(radius+30,Math.min(1570-radius,p.x+Math.cos(i*Math.PI*2/count)*spread)),y:Math.max(radius+30,Math.min(1170-radius,p.y+Math.sin(i*Math.PI*2/count)*spread))},radius,warning,damage,extra));
}
/** Pursuit remains slower than the slowest chassis; dashes and charges are separate. */
export function bossPursuitSpeed(base:number,phase:number,difficulty=0,enraged=false):number {
 return base*(1.6+.08*Math.max(0,phase-1)+.04*Math.max(0,Math.min(4,difficulty))+(enraged?.1:0));
}
/** Complete boss choreography. All damage is resolved by combat.ts, never here. */
export function bossTurn(id:string,phase:number,index:number,boss:Point,player:Point,difficulty=0,enraged=false):BossTurn {
 phase=Math.max(1,Math.min(['B1A','B1B','B2B'].includes(id)?2:3,phase));
 const difficultyLevel=Math.max(0,Math.min(4,difficulty)),a=toward(boss,player),slot=index%3;
 const speedScale=1.12+.08*(phase-1)+.05*difficultyLevel+(enraged?.12:0);
 const fan=(origin:Point,angle:number,count:number,spread:number,speed:number,damage:number,warning=.85,delay=0):AttackPlan=>
  cone(origin,angle,600,spread,warning,damage,{active:.08,effect:'projectile',count,spread,speed,delay,projectileRadius:5});
 let plans:AttackPlan[]=[],recovery=.75;
 if(id==='B1A'){
  if(slot===0){const charge:AttackPlan={...boss,kind:'rect',radius:0,w:660,h:90,angle:a,warning:1,active:1.1,damage:20,effect:'charge',speed:540,target:{...player}};plans=[charge];recovery=.85;
   if(phase>=2){plans.push({...charge,warning:.8,delay:2.15,target:{...player}});recovery=1;}}
  if(slot===1){plans=[cone(boss,a,220,Math.PI*2/3,.8,18),fan(boss,a,phase===1?5:7,1.65,310,10)];recovery=.65;}
  if(slot===2){plans=[...landings(player,phase===1?5:7,110,45,.8,12),fan(boss,a,phase===1?5:7,1.45,310,10)];recovery=.8;}
 }else if(id==='B1B'){
  if(slot===0){plans=[circle(boss,450,1,0,{active:1.65,effect:'pull',speed:110}),circle(boss,165,2.65,22),fan(boss,a,phase===1?5:7,1.8,320,10,.85,.8)];recovery=.8;}
  if(slot===1){plans=[cone(boss,a-Math.PI/2,280,Math.PI/5,.9,18,{active:1.25,innerRadius:100,sweep:Math.PI,period:.5})];
   if(phase>=2)plans.push(cone(boss,a+Math.PI/2,280,Math.PI/5,.8,18,{delay:2.2,active:1.25,innerRadius:100,sweep:-Math.PI,period:.5}));}
  if(slot===2)plans=[circle(boss,75,1,0,{effect:'spawn',enemy:'E02',count:phase===1?3:4,limit:8}),fan(boss,a,phase===1?6:8,1.65,320,10,.85,.3)];
 }else if(id==='B2A'){
  if(slot===0){plans=[cone(boss,a,360,Math.PI/2,1,12,{active:1.35,period:.5})];recovery=.85;
   if(phase>=2)plans.push(...landings(player,3,95,50,1.1,16,{delay:2.4,effect:'fire',active:4,period:.5}));}
  if(slot===1)plans=[...landings(player,4+phase,125,50,1.1,16,{effect:'fire',active:4,period:.5}),fan(boss,a,3+phase*2,1.8,330,12,1,.2)];
  if(slot===2){plans=[...landings(boss,phase===1?4:6,145,65,.8,20),circle(player,70,1.1,20,{effect:'mortar',delay:.25})];recovery=.85;}
 }else if(id==='B2B'){
  if(slot===0)plans=[{x:boss.x-145,y:boss.y,kind:'line',radius:0,angle:0,w:290,h:22,warning:1,active:1.65,damage:16,period:.5},circle(player,65,1.1,16,{delay:.35})];
  if(slot===1){const count=phase===1?6:8;for(let i=0;i<count;i++)plans.push({...boss,x:boss.x+(i%2===0?-145:145),kind:'circle',radius:70,angle:a+(i%2)*Math.PI/count,warning:.8,delay:i*.26,active:.08,damage:12,effect:'projectile',count,spread:Math.PI*2,speed:330});}
  if(slot===2)plans=[circle(boss,90,1,0,{effect:'spawn',enemy:'E05',count:phase===1?2:3,limit:6}),fan(boss,a,phase===1?5:7,1.8,330,12,.85,.3)];
 }else if(id==='B3A'){
  const s=phase===1?index%2:slot;
  if(s===0){plans=[{...boss,kind:'line',radius:0,w:800,h:36,angle:a-.7,warning:1,active:1.25,damage:14,sweep:1.4,period:.5}];
   if(phase>=3){plans.push(circle(player,80,1,24,{delay:2.3}));plans.push(circle(player,20,.6,14,{delay:3.4,kind:'ring',active:2,grow:250,innerRadius:0,period:.5}));}}
  if(s===1)plans=[circle(player,80,1,24),circle(player,20,.6,14,{delay:1.1,kind:'ring',active:2,grow:250,innerRadius:0,period:.5}),fan(boss,a,5+phase*2,1.9,350,12,.9,.35)];
  if(s===2){plans=[{x:0,y:350,kind:'rect',radius:0,w:1600,h:120,angle:0,warning:1,active:3,damage:0,effect:'conveyor',speed:75},
   {x:1600,y:850,kind:'rect',radius:0,w:1600,h:120,angle:Math.PI,warning:1,active:3,damage:0,effect:'conveyor',speed:75},
   circle(boss,90,1,0,{effect:'spawn',enemy:'E01',count:5,limit:10})];
   for(let i=0;i<3;i++)plans.push(fan(boss,a+(i-1)*.12,7,2,350,12,.85,.2+i*.3));}
  recovery=.9;
 }else if(id==='B3B'){
  if(slot===0){plans=[280,800,1320].map(x=>({x,y:0,kind:'rect' as const,radius:0,w:1200,h:135,angle:Math.PI/2,warning:1.3,active:.15,damage:24}));
   if(phase>=2)plans.push(...[360,880,1400].map(x=>({x,y:0,kind:'rect' as const,radius:0,w:1200,h:135,angle:Math.PI/2,warning:1.1,delay:.7,active:.15,damage:24})));}
  if(slot===1)plans=[circle(boss,120,1,0,{effect:'spawn',enemy:'E02',count:4+phase,limit:10,spawnHp:30,spawnDamage:8}),fan(boss,a,5+phase*2,2,340,10,1,.25)];
  if(slot===2){for(let i=0;i<5+phase;i++)plans.push(fan(boss,a,9+phase*2,Math.PI*5/3,340,10,1,i*.26));recovery=.95;}
 }
 for(const plan of plans){
  plan.damage*=BOSS_DAMAGE_SCALE;
  if(plan.spawnDamage)plan.spawnDamage*=BOSS_DAMAGE_SCALE;
  if(plan.effect==='projectile')plan.speed!*=speedScale;
  // Keep the traveled charge length inside the painted lane when speeding it up.
  if(plan.effect==='charge'){plan.speed!*=speedScale;plan.active/=speedScale;}
  if(plan.grow)plan.grow*=speedScale;
 }
 recovery=Math.max(.4,recovery*.8/(1+.1*(phase-1)+.08*difficultyLevel+(enraged?.2:0)));
 // Lingering fire and conveyors continue after the cast; they must not stall the next turn.
 const duration=plans.reduce((max,p)=>Math.max(max,(p.delay||0)+p.warning+(p.effect==='fire'||p.effect==='conveyor'?Math.min(.15,p.active):p.active)),0);
 return {plans,duration,recovery};
}
export function bossPhase(id:string,fraction:number):number {
 if(id==='B1A'||id==='B2B')return fraction<=.5?2:1;
 if(id==='B1B')return fraction<=.55?2:1;
 if(id==='B2A')return fraction<=.3?3:fraction<=.6?2:1;
 if(id==='B3A')return fraction<=.3?3:fraction<=.65?2:1;
 return fraction<=.35?3:fraction<=.7?2:1;
}
