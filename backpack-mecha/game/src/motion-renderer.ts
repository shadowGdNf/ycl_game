import type {Art} from './art.ts';
import type {EnemyMotion} from './motion.ts';
import {motionLabel,zoneRole} from './motion.ts';
import type {EnemyView,Lang,ZoneView} from './types.ts';

const TAU=Math.PI*2;
type Context=CanvasRenderingContext2D;
const special=(e:EnemyView)=>e.kind==='boss'||e.id==='E05'||e.id==='E12';
const labelWidths=new Map<string,number>();
const labelTiles=new Map<string,OffscreenCanvas>();
let canCacheLabels=typeof OffscreenCanvas==='function';
function stroke(c:Context,x:number,y:number,dx:number,dy:number):void{c.beginPath();c.moveTo(x,y);c.lineTo(x+dx,y+dy);c.stroke();}
function arrow(c:Context,x:number,y:number,angle:number,length:number):void{
 const ux=Math.cos(angle),uy=Math.sin(angle),endX=x+ux*length,endY=y+uy*length;
 c.beginPath();c.moveTo(x,y);c.lineTo(endX,endY);c.lineTo(endX-ux*7+uy*5,endY-uy*7-ux*5);
 c.moveTo(endX,endY);c.lineTo(endX-ux*7-uy*5,endY-uy*7+ux*5);c.stroke();
}

/** Draw parts in the original atlas perspective. All motion comes from this snapshot. */
export function enemyBody(c:Context,art:Art,key:string,e:EnemyView,m:EnemyMotion,size:number,time:number,reduced:boolean):void {
 const wind=m.stage==='windup',active=m.stage==='active',free=!m.control;
 const amount=wind?m.progress:active?1:0;
 const bob=reduced||!free?0:Math.sin(time*(e.id==='E06'?2.6:8)+e.eid)*Math.min(2,size*.025);
 const recoil=reduced||!free?0:m.hit*size*.025;
 if(!special(e)){
  const tilt=m.control==='impact'?-.045:m.control==='stagger'?.045:reduced||!free?0:Math.sin(time*5+e.eid)*.018;
  art.draw(c,key,e.x-Math.cos(m.angle)*recoil,e.y-size*.08+bob-Math.sin(m.angle)*recoil,size,size,tilt);return;
 }
 c.save();c.translate(e.x-Math.cos(m.angle)*recoil,e.y-size*.08+bob-Math.sin(m.angle)*recoil);
 if(!reduced&&free)c.rotate(Math.sin(time*5+e.eid)*.018);
 if(m.control==='impact')c.rotate(-.045);else if(m.control==='stagger')c.rotate(.045);
 const part=(u:number,v:number,w:number,h:number,x=0,y=0)=>art.part(c,key,x,y,size,size,u,v,w,h);
 if(e.id==='E05'){
  part(0,.3,1,.7);part(0,0,1,.3,0,-size*.045*amount);
  if(wind){c.fillStyle='#ffdca1';for(let i=0;i<4;i++)if(m.progress>i/4)c.fillRect(-size*.17+i*size*.09,-size*.03,size*.045,size*.16);}
 }else if(e.id==='E12'||e.id==='B1A'){
  part(0,.53,1,.47);part(0,0,1,.53,0,wind?size*.045*amount:m.control?size*.025:0);
  if(m.kind==='charge'&&active&&free&&!reduced){
   c.strokeStyle='#cabda1';c.lineWidth=2;c.save();c.rotate(m.angle);
   for(let i=-1;i<=1;i++)stroke(c,-size*.43,i*size*.15,-size*(.12+.04*Math.sin(time*15+i)),0);
   c.restore();
  }
 }else if(e.id==='B1B'){
  part(0,.58,1,.42);
  c.save();c.translate(-size*.12,size*.06);
  const swing=m.kind==='sweep'?(wind?-.1:active?Math.sin(m.angle)*.14:0):m.kind==='pull'?-.04*amount:0;
  c.rotate(free?swing:0);part(0,0,1,.58,size*.12,-size*.06);c.restore();
  if(m.kind==='pull'&&active){c.strokeStyle='#a8dce6';c.lineWidth=2;arrow(c,-size*.35,-size*.12,0,size*.16);arrow(c,size*.35,-size*.12,Math.PI,size*.16);}
 }else if(e.id==='B2A'){
  // Four surrounding regions leave a real opening; the two door halves slide apart.
  part(0,0,1,.42);part(0,.64,1,.36);part(0,.42,.36,.22);part(.64,.42,.36,.22);
  const open=m.weak?.055:m.kind==='fire'?(active?.04:wind?.012*m.progress:0):0;
  c.fillStyle='#15221f';c.fillRect(-size*.14,-size*.07,size*.28,size*.192);
  if(open){c.fillStyle=m.weak?'rgba(124,227,170,.3)':'rgba(255,168,74,.55)';c.beginPath();c.ellipse(0,size*.025,size*.07,size*.06,0,0,TAU);c.fill();}
  part(.36,.42,.14,.22,-size*open,0);part(.5,.42,.14,.22,size*open,0);
  if(m.weak){c.strokeStyle='#bbf4cd';c.lineWidth=1.5;stroke(c,-size*.04,size*.025,size*.08,0);stroke(c,0,-size*.015,0,size*.08);}
 }else if(e.id==='B2B'){
  part(0,.28,1,.72);part(0,0,1,.28,0,wind?-size*.03*m.progress:0);
  if(m.stage==='windup'||m.stage==='active'){
   c.strokeStyle='#9edfe8';c.lineWidth=2;c.beginPath();c.arc(0,-size*.17,size*.16,-Math.PI/2,-Math.PI/2+(wind?m.progress:1)*TAU);c.stroke();
   if(active){c.fillStyle='#e0f7ef';c.fillRect(-size*.07,-size*.21,size*.14,size*.07);}
  }
 }else if(e.id==='B3A'){
  part(0,0,1,.45);part(.33,.45,.34,.55);
  const spread=wind?.025*m.progress:active?.045:0,lift=wind?-.025*m.progress:active?.025:0;
  part(0,.45,.33,.55,-size*spread,size*lift);part(.67,.45,.33,.55,size*spread,size*lift);
  if(m.kind==='beam'&&m.stage!=='idle'){c.fillStyle=active?'#fff3cc':'#efa96a';c.beginPath();c.ellipse(0,-size*.2,size*(wind?.025+.025*m.progress:.065),size*.025,0,0,TAU);c.fill();}
 }else if(e.id==='B3B'){
  const offset=(e as EnemyView&{offsetX?:number}).offsetX??0;
  if(!offset){
   part(.2,0,.6,1);
   const open=(e.phase??1)>=2?.035:0,transition=reduced?1:Math.min(1,Math.max(0,m.phaseAge/.5));
   part(0,0,.2,1,-size*open*transition,0);part(.8,0,.2,1,size*open*transition,0);
  }else art.draw(c,key,0,0,size,size);
  if(m.kind==='bombard'||m.kind==='volley'){
   c.fillStyle=active?'#ffdf9e':'#cf9f77';
   for(let i=-1;i<=1;i++)if(active||m.progress>(i+1)/3)c.fillRect(i*size*.15-size*.025,size*.2,size*.05,size*.07);
  }
 }else art.draw(c,key,0,0,size,size);
 c.restore();
 // These cues are directions and body status, never collision or damage boundaries.
 if(special(e)&&m.stage!=='idle'&&!m.control&&(m.zone||m.kind==='charge')&&['charge','fire','sweep','volley','beam'].includes(m.kind)&&e.id!=='B2B'){
  c.strokeStyle=wind?'#ffe2a5':'#fff0c9';c.lineWidth=2;
  arrow(c,e.x+Math.cos(m.angle)*(size*.42),e.y+Math.sin(m.angle)*(size*.42),m.angle,size*.18);
 }
 if(e.kind==='boss'&&(e.phase??1)>1){
  c.strokeStyle=m.phaseAge<.8?'#f6dba7':'#b8ac91';c.lineWidth=2;
  for(let i=0;i<(e.phase??1);i++)stroke(c,e.x-size*.2+i*size*.12,e.y+size*.35,0,6);
 }
}

export function enemyControl(c:Context,e:EnemyView,m:EnemyMotion,size:number):void {
 if(!m.control)return;
 c.save();c.translate(e.x,e.y);c.lineWidth=2;
 if(m.control==='ice'){
  c.fillStyle='rgba(152,222,243,.18)';c.strokeStyle='#a4e7f7';c.beginPath();
  for(let i=0;i<6;i++){const a=i*TAU/6-Math.PI/6,x=Math.cos(a)*size*.48,y=Math.sin(a)*size*.44;i?c.lineTo(x,y):c.moveTo(x,y);}c.closePath();c.fill();c.stroke();
  c.translate(size*.35,-size*.38);for(let i=0;i<3;i++){c.rotate(Math.PI/3);stroke(c,-6,0,12,0);}
 }else if(m.control==='stagger'){
  c.strokeStyle='#efd992';for(let i=-1;i<=1;i++){const x=i*size*.22,y=-size*.46-Math.abs(i)*3;stroke(c,x-4,y,8,0);stroke(c,x,y-4,0,8);}
 }else{
  c.strokeStyle=m.control==='impact'?'#ffc193':'#d5dcde';
  for(const side of [-1,1]){const x=side*size*.48;stroke(c,x,-size*.2,0,size*.4);stroke(c,x,-size*.2,-side*7,0);stroke(c,x,size*.2,-side*7,0);}
 }
 c.restore();
}

/** Labels render after hazards, with a CSS-size floor for narrow viewports. */
export function enemyMotionLabel(c:Context,e:EnemyView,m:EnemyMotion,size:number,scale:number,lang:Lang,view:{x:number;y:number;w:number;h:number},dpr=1):void {
 if(!special(e)&&!m.control)return;
 if(e.id==='B3B'&&(e as EnemyView&{offsetX?:number}).offsetX)return;
 if(e.x+size/2<view.x||e.x-size/2>view.x+view.w||e.y+size/2<view.y||e.y-size/2>view.y+view.h)return;
 const label=motionLabel(m,lang);if(!label)return;
 const font=Math.max(11,10/scale),y=Math.max(view.y+font,Math.min(view.y+view.h-font,e.y-size*.63-font*.6));
 c.save();c.font=`bold ${font}px sans-serif`;c.textAlign='center';c.textBaseline='middle';
 const cacheKey=`${font}/${label}`;let width=labelWidths.get(cacheKey);
 if(width===undefined){width=c.measureText(label).width+12;if(labelWidths.size>=256)labelWidths.clear();labelWidths.set(cacheKey,width);}
 const x=Math.max(view.x+width/2+3,Math.min(view.x+view.w-width/2-3,e.x));
 const ink=m.control==='ice'?'#b5eafa':m.weak?'#8ee9c1':m.control?'#f0d7ac':m.stage==='windup'?'#ffe0a6':'#f3ebd7';
 // Cache whole labels, not a new offscreen canvas for every enemy/frame. Older
 // browsers fall back to direct text; at most 48 raster labels stay resident.
 if(canCacheLabels){
  const density=Math.max(1,scale*dpr),key=`${cacheKey}/${ink}/${density}`;let tile=labelTiles.get(key);
  if(!tile)try{
   const next=new OffscreenCanvas(Math.ceil(width*density),Math.ceil(font*1.4*density)),t=next.getContext('2d');
   if(t){t.scale(density,density);t.fillStyle='rgba(12,24,31,.93)';t.beginPath();t.roundRect(0,0,width,font*1.4,3);t.fill();t.font=c.font;t.textAlign='center';t.textBaseline='middle';t.fillStyle=ink;t.fillText(label,width/2,font*.7);
    if(labelTiles.size>=48)labelTiles.delete(labelTiles.keys().next().value!);labelTiles.set(key,next);tile=next;
   }else canCacheLabels=false;
  }catch{canCacheLabels=false;}
  if(tile){c.drawImage(tile,x-width/2,y-font*.7,width,font*1.4);c.restore();return;}
 }
 c.fillStyle='rgba(12,24,31,.93)';c.beginPath();c.roundRect(x-width/2,y-font*.7,width,font*1.4,3);c.fill();
 c.fillStyle=ink;c.fillText(label,x,y);c.restore();
}

/** Same inner/outer geometry as combat.contains, including the crane's safe inner arc. */
export function zonePath(c:Context,z:ZoneView):void {
 c.beginPath();
 if(z.kind==='circle')c.arc(0,0,z.radius,0,TAU);
 else if(z.kind==='ring'){c.arc(0,0,z.radius,0,TAU);c.arc(0,0,z.innerRadius??Math.max(0,z.radius-22),0,TAU,true);}
 else if(z.kind==='cone'){
  const spread=z.width??Math.PI/2,inner=z.innerRadius??0;
  c.moveTo(Math.cos(-spread/2)*inner,Math.sin(-spread/2)*inner);
  c.arc(0,0,z.radius,-spread/2,spread/2);
  if(inner)c.arc(0,0,inner,spread/2,-spread/2,true);else c.lineTo(0,0);
  c.closePath();
 }else c.rect(0,-(z.h??z.width??20)/2,z.w??z.radius,z.h??z.width??20);
}

export function zoneSymbols(c:Context,z:ZoneView,scale:number):void {
 const role=zoneRole(z);c.lineWidth=2;
 if(role==='force'){
  c.strokeStyle='#a8dce6';
  if(z.plan?.effect==='pull')for(let i=0;i<4;i++){const a=i*TAU/4,r=z.radius*.65;arrow(c,Math.cos(a)*r,Math.sin(a)*r,a+Math.PI,24);}
  else for(let x=35;x<(z.w??z.radius);x+=100)arrow(c,x,0,0,24);
 }else if(role==='spawn'){
  c.strokeStyle='#c4d9b5';stroke(c,-8,0,16,0);stroke(c,0,-8,0,16);
 }else if(z.kind==='line'){
  c.strokeStyle=z.active?'#fff1c5':'#ffc9aa';for(const x of [0,z.w??z.radius]){c.beginPath();c.arc(x,0,6,0,TAU);c.stroke();}
 }
 if(!z.active&&role==='damage'){
  // Keep the exclamation at the origin, outside an annulus's intentionally empty center.
  if((z.innerRadius??0)>0)return;
  c.fillStyle='#ffe5c7';c.font=`bold ${Math.max(12,10/scale)}px sans-serif`;c.textAlign='center';c.textBaseline='middle';c.fillText('!',0,0);
 }
}
