/** Authored two-beat combinations. A beat is announced before its fixed target can hurt. */
import type {AttackPlan,BossTurn} from './encounters.ts';
import type {Point} from './types.ts';
export const BOSS_COMBOS:Record<string,[string,string,string,string][]>={
 B1A:[['碾压夹击','Pincer charge','侧躲碾压，再离开侧翼落点','Sidestep the charge, then leave the flank markers'],['交叉裂地','Crossed fault','先横移，再换向躲开第二道裂地','Sidestep, then change direction for the second fault'],['震环追击','Ring pursuit','沿震环缺口移动，急停或变向躲预判炮击','Use the ring opening; brake or turn away from the predicted mortar']],
 B1B:[['磁吸吊砸','Magnetic drop','逆着牵引走，避开两侧吊砸','Walk against the pull and avoid the flank drops'],['双臂绞索','Twin hooks','避开摆臂，再侧躲预判方向的直线钩索','Dodge the arm, then sidestep the predicted hook lane'],['电环钩索','Arc and hook','穿过电环缺口，侧躲直线钩索','Use the ring gap and sidestep the hook lane']],
 B2A:[['分流焚烧','Split furnace','两道火流中间有通道，炮击落下前换位','Use the corridor between flames, then move off the mortar'],['熔墙逼位','Slag fences','沿熔墙之间移动，躲开脚下落点','Move between the slag fences and leave the ground marker'],['炉心开合','Furnace pulse','先避开近身爆发，再横移穿过侧向缺口','Leave the inner burst, then move sideways to the ring gap']],
 B2B:[['交叉锁线','Cross lock','两机依次锁线，第二道预判行进方向','The second twin predicts your movement; change direction'],['双环落雷','Twin rings','沿两个缺口穿行，急停或变向避开预判落雷','Use both ring openings; brake or turn away from the predicted impact'],['夹击电网','Pincer grid','先穿弹幕空隙，再离开横向电网','Pass between shots, then leave the horizontal grid']],
 B3A:[['折返扫描','Return scan','先跟随扫描背侧，再避开反向扫描','Follow behind the first sweep, then avoid its return'],['震环点名','Ring marks','沿缺口走，连续落点不会追踪你','Use the gap; the marked impacts do not track you'],['流水线切割','Conveyor cut','借传送带换位，留意横向切割线','Use the conveyors to reposition; watch the cutting lane']],
 B3B:[['棋盘接力','Grid relay','先躲横向轰炸，再横移避开纵向轰炸','Dodge the horizontal strikes, then sidestep the vertical one'],['封锁与点名','Barrage marks','找弹幕缺口，离开已经锁定的轰炸点','Find the barrage gap and leave the locked bomb markers'],['侧舷交火','Broadside crossfire','侧舷锁线后不再追踪，绕开随后落点','Sidestep the fixed broadsides and the following impact']],
};
export const bossAttackSlot=(turn:number)=>[0,3,1,4,2,5][turn%6]!;
const angle=(a:Point,b:Point)=>Math.atan2(b.y-a.y,b.x-a.x);
const clamp=(n:number,a:number,b:number)=>Math.max(a,Math.min(b,n));
const offset=(p:Point,a:number,d:number):Point=>({x:clamp(p.x+Math.cos(a)*d,50,1550),y:clamp(p.y+Math.sin(a)*d,50,1150)});
export function comboTurn(id:string,phase:number,index:number,boss:Point,player:Point,velocity:Point={x:0,y:0}):BossTurn|undefined {
 const slot=index%6-3;if(slot<0||!BOSS_COMBOS[id])return;
 const a=angle(boss,player),side=Math.floor(index/6)%2?-1:1,center={x:800,y:600};
 // Leading is fixed when the cast starts: braking or reversing defeats the prediction.
 const target=(delay:number):Point=>({x:clamp(player.x+velocity.x*(1.15+delay),50,1550),y:clamp(player.y+velocity.y*(1.15+delay),50,1150)});
 const circle=(p:Point,r:number,delay=0,beat:1|2=1):AttackPlan=>({...p,kind:'circle',radius:r,angle:0,warning:1.15,active:.15,damage:18,delay,beat,effect:'mortar'});
 const line=(p:Point,angle:number,length:number,delay=0,beat:1|2=1):AttackPlan=>({...p,kind:'line',radius:0,angle,w:length,h:46,warning:1.15,active:.3,damage:18,delay,beat});
 const ring=(p:Point,gap:number,delay=0,beat:1|2=1):AttackPlan=>({...p,kind:'ring',radius:90,innerRadius:58,angle:0,warning:1.25,active:2.4,damage:14,grow:170,gapAngle:gap,gapWidth:Math.PI*.42,delay,beat,period:.5});
 const fan=(p:Point,aim:number,delay=0,beat:1|2=1):AttackPlan=>({...p,kind:'cone',radius:650,angle:aim,width:1.8,warning:1.15,active:.08,damage:12,effect:'projectile',count:5+phase,spread:1.8,speed:330,delay,beat});
 let plans:AttackPlan[]=[];
 if(id==='B1A'){
  if(slot===0)plans=[{...line(boss,a,650),kind:'rect',h:90,active:1,damage:20,effect:'charge',speed:540,lockTarget:true},...[-1,1].map(s=>circle(offset(player,a+Math.PI/2,s*165),60,.5,2))];
  if(slot===1){const back=offset(player,a,-300),left=offset(back,a+Math.PI/2,130),right=offset(back,a+Math.PI/2,-130);plans=[line(left,angle(left,player),700),line(right,angle(right,target(.65)),700,.65,2)];}
  if(slot===2)plans=[ring(boss,a+side*.65),circle(target(.8),65,.8,2)];
 }else if(id==='B1B'){
  if(slot===0)plans=[{...circle(boss,400),damage:0,effect:'pull',speed:85,active:1.6},...[-1,1].map(s=>circle(offset(target(.35),a+Math.PI/2,s*100),65,.35,2))];
  if(slot===1)plans=[{...circle(boss,310),kind:'cone',angle:a-side*.9,width:.35,innerRadius:120,active:1.15,sweep:side*1.25,effect:'damage'}, line(boss,angle(boss,target(.7)),800,.7,2)];
  if(slot===2)plans=[ring(boss,a),line(boss,angle(boss,target(.7)),800,.7,2)];
 }else if(id==='B2A'){
  if(slot===0)plans=[...[-1,1].map(s=>({...circle(boss,440),kind:'cone' as const,angle:a+s*.66,width:.48,active:1.5,effect:'damage' as const,period:.5})),circle(target(.65),60,.65,2)];
  if(slot===1)plans=[...[-1,1].map(s=>({...line({x:clamp(player.x+s*170,65,1535),y:clamp(player.y-230,40,700)},Math.PI/2,460),effect:'fire' as const,active:2.5,period:.5})),circle(target(.65),65,.65,2)];
  if(slot===2)plans=[{...circle(boss,190),effect:'damage'},ring(boss,a+side*.85,.45,2)];
 }else if(id==='B2B'){
  const left={x:boss.x-145,y:boss.y},right={x:boss.x+145,y:boss.y};
  if(slot===0)plans=[line(left,angle(left,player),850),line(right,angle(right,target(.55)),850,.55,2)];
  if(slot===1)plans=[ring(left,angle(left,player)),ring(right,angle(right,player)),circle(target(.85),60,.85,2)];
  if(slot===2)plans=[fan(left,angle(left,player)-.18),fan(right,angle(right,player)+.18),line({x:0,y:target(.75).y},0,1600,.75,2)];
 }else if(id==='B3A'){
  if(slot===0)plans=[{...line(boss,a-side*.8,720),h:30,active:1.3,sweep:side*1.05,period:.5},{...line(boss,a+side*.8,720,1,2),h:30,active:1.3,sweep:-side*1.05,period:.5}];
  if(slot===1)plans=[ring(boss,a),...[0,1,2].map(i=>circle(offset(target(.4+i*.4),angle(player,center),i*45),48,.4+i*.4,2))];
  if(slot===2)plans=[...[-1,1].map(s=>({...line({x:s<0?0:1600,y:clamp(player.y+s*160,130,1070)},s<0?0:Math.PI,1600),h:100,damage:0,active:2.3,effect:'conveyor' as const,speed:75})),line({x:0,y:target(.65).y},0,1600,.65,2)];
 }else if(id==='B3B'){
  if(slot===0)plans=[...[-1,1].map(s=>({...line({x:0,y:clamp(player.y+s*180,90,1110)},0,1600),h:110,kind:'rect' as const})),{...line({x:target(.65).x,y:0},Math.PI/2,1200,.65,2),h:110,kind:'rect'}];
  if(slot===1)plans=[{...fan(boss,a+Math.PI),spread:Math.PI*5/3,width:Math.PI*5/3,count:11+phase},circle(target(.4),70,.4,2),circle(target(1),60,1,2)];
  if(slot===2)plans=[line({x:40,y:250},angle({x:40,y:250},player),1800),line({x:1560,y:950},angle({x:1560,y:950},player),1800),circle(target(.75),75,.75,2)];
 }
 return {plans,duration:0,recovery:1.1,combo:BOSS_COMBOS[id][slot]};
}
