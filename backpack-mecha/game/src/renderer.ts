import {Art} from './art.ts';
import {motionFrame,zoneRole,zoneVisible,chargeContactRadius} from './motion.ts';
import type {EnemyMotion} from './motion.ts';
import {enemyBody,enemyControl,enemyMotionLabel,zonePath,zoneSymbols} from './motion-renderer.ts';
import {CHASSIS_BY_ID,MODULE_BY_ID} from './content.ts';
import {drawCombatEffect,drawProjectile,drawHazardEnergy,effectLife} from './feedback.ts';
import {locomotion,easeOut} from './visual-motion.ts';
import type {Locomotion} from './visual-motion.ts';
import type {BattleView,CombatEvent,EnemyView,Lang,Point,WeaponView,ZoneView} from './types.ts';

type Options={lang:Lang;reducedMotion:boolean;colorAssist:boolean;target?:Point};
type Effect={event:CombatEvent;born:number;life:number;end?:Point;label?:number;labelBorn?:number};
type LegPose={x:number;y:number;angle:number};
type WalkPose={left:LegPose;right:LegPose;rise:number;lean:number};
const pose=(lx:number,ly:number,la:number,rx:number,ry:number,ra:number,rise:number,lean:number):WalkPose=>({left:{x:lx,y:ly,angle:la},right:{x:rx,y:ry,angle:ra},rise,lean});
// Contact, passing, opposite contact, opposite passing. These are runtime poses,
// not sixteen additional painted frames; each direction has an explicit cycle.
const WALK_POSES:readonly (readonly WalkPose[])[]=[
  [ // Down.
    pose(-.8,2.2,-.055,.8,-2.2,.045,0,-.018),
    pose(0,-1,0,0,.8,0,-1.3,0),
    pose(.8,-2.2,.045,-.8,2.2,-.055,0,.018),
    pose(0,.8,0,0,-1,0,-1.3,0),
  ],
  [ // Right.
    pose(2.7,-.6,-.085,-2.7,.8,.085,0,.022),
    pose(.2,-1.8,-.025,-.2,.5,.025,-1.1,.008),
    pose(-2.7,.8,.085,2.7,-.6,-.085,0,-.022),
    pose(-.2,.5,.025,.2,-1.8,-.025,-1.1,-.008),
  ],
  [ // Up.
    pose(.6,-2,-.04,-.6,2,.055,0,.016),
    pose(0,.7,0,0,-1.2,0,-1.2,0),
    pose(-.6,2,.055,.6,-2,-.04,0,-.016),
    pose(0,-1.2,0,0,.7,0,-1.2,0),
  ],
  [ // Left.
    pose(-2.7,-.6,.085,2.7,.8,-.085,0,-.022),
    pose(-.2,-1.8,.025,.2,.5,-.025,-1.1,-.008),
    pose(2.7,.8,-.085,-2.7,-.6,.085,0,.022),
    pose(.2,.5,-.025,-.2,-1.8,.025,-1.1,.008),
  ],
];
function walkPose(direction:number,time:number):WalkPose{
  const cycle=WALK_POSES[direction]??WALK_POSES[0],phase=((time/.48)%1+1)%1*4,index=Math.floor(phase),f=phase-index,t=f*f*(3-2*f);
  const a=cycle[index],b=cycle[(index+1)%4],mix=(x:number,y:number)=>x+(y-x)*t;
  const leg=(x:LegPose,y:LegPose):LegPose=>({x:mix(x.x,y.x),y:mix(x.y,y.y),angle:mix(x.angle,y.angle)});
  return {left:leg(a.left,b.left),right:leg(a.right,b.right),rise:mix(a.rise,b.rise),lean:mix(a.lean,b.lean)};
}
const TAU=Math.PI*2;
const clamp=(v:number,a:number,b:number)=>Math.max(a,Math.min(b,v));
const CHASSIS=['scavenger','bulwark','kestrel','hive'];
const PALETTE={ink:'#101b24',cream:'#e8dfc9',orange:'#f39443',cyan:'#48d1c4',danger:'#f05b5b'};
function facing(angle:number):number{
  const x=Math.cos(angle),y=Math.sin(angle);
  return Math.abs(x)>Math.abs(y)?(x>=0?1:3):(y>=0?0:2);
}
function rounded(ctx:CanvasRenderingContext2D,x:number,y:number,w:number,h:number,r=4):void{
  ctx.beginPath();ctx.roundRect(x,y,w,h,r);
}

/** Canvas presentation only. All gameplay, collision, damage and clocks come from BattleView. */
export class Renderer {
  private ctx:CanvasRenderingContext2D;
  private art=new Art();
  private scale=1;
  private camera={x:0,y:0};
  private cssWidth=720;
  private cssHeight=720;
  private dpr=1;
  private lastTime=-1;
  private lastPlayer:Point|null=null;
  private movement=0;
  private lastFacing=0;
  private previousFacing=0;
  private facingBlend=1;
  private playerGait:Locomotion|undefined;
  private enemyGaits=new Map<number,Locomotion>();
  private attackBlend=new Map<number,number>();
  private effects:Effect[]=[];
  private seenEvents=new Set<number>();
  private shotTimes=new Map<string,{count:number;at:number}>();
  private deathVisualStart:number|null=null;
  private options:Options={lang:'zh',reducedMotion:false,colorAssist:false};
  private canvas:HTMLCanvasElement;
  constructor(canvas:HTMLCanvasElement){
    this.canvas=canvas;
    const ctx=canvas.getContext('2d');if(!ctx)throw new Error('Canvas 2D is unavailable');this.ctx=ctx;
  }
  load():Promise<void>{return this.art.load();}
  private resize():void{
    const bounds=this.canvas.getBoundingClientRect();
    this.cssWidth=Math.max(1,bounds.width||this.canvas.width||720);
    this.cssHeight=Math.max(1,bounds.height||this.canvas.height||720);
    this.dpr=Math.min(2,globalThis.devicePixelRatio||1);
    const w=Math.round(this.cssWidth*this.dpr),h=Math.round(this.cssHeight*this.dpr);
    if(this.canvas.width!==w||this.canvas.height!==h){this.canvas.width=w;this.canvas.height=h;}
    this.ctx.setTransform(this.dpr,0,0,this.dpr,0,0);this.ctx.imageSmoothingEnabled=true;this.ctx.imageSmoothingQuality='high';
  }
  toWorld(clientX:number,clientY:number):Point{
    const rect=this.canvas.getBoundingClientRect();
    return {x:(clientX-rect.left)/this.scale+this.camera.x,y:(clientY-rect.top)/this.scale+this.camera.y};
  }
  draw(state:BattleView,options:Options):void{
    this.options=options;this.resize();this.art.prepareEnvironment();
    const ctx=this.ctx;
    ctx.clearRect(0,0,this.cssWidth,this.cssHeight);
    this.scale=Math.min(this.cssWidth,this.cssHeight)/720;
    const vw=this.cssWidth/this.scale,vh=this.cssHeight/this.scale;
    this.camera.x=vw>=state.width?(state.width-vw)/2:clamp(state.player.x-vw/2,0,state.width-vw);
    this.camera.y=vh>=state.height?(state.height-vh)/2:clamp(state.player.y-vh/2,0,state.height-vh);
    if(state.time<this.lastTime||this.lastTime<0){this.effects=[];this.seenEvents.clear();this.shotTimes.clear();this.lastPlayer=null;this.deathVisualStart=null;this.playerGait=undefined;this.enemyGaits.clear();this.attackBlend.clear();this.movement=0;this.facingBlend=1;}
    if(state.status==='lost'&&state.player.hp<=0){if(this.deathVisualStart===null)this.deathVisualStart=performance.now();}else this.deathVisualStart=null;
    const dt=clamp(state.time-this.lastTime,0,.1);this.lastTime=state.time;
    if(this.lastPlayer){
      const dx=state.player.x-this.lastPlayer.x,dy=state.player.y-this.lastPlayer.y;
      if(Math.hypot(dx,dy)>.15){const next=facing(Math.atan2(dy,dx));if(next!==this.lastFacing){this.previousFacing=this.lastFacing;this.lastFacing=next;this.facingBlend=0;}}
    }
    this.playerGait=locomotion(this.playerGait,state.player,dt);this.movement=this.playerGait.amount;this.facingBlend=Math.min(1,this.facingBlend+dt/.12);
    for(const e of state.enemies)this.enemyGaits.set(e.eid,locomotion(this.enemyGaits.get(e.eid),e,dt));
    const aliveIds=new Set(state.enemies.map(e=>e.eid));for(const id of this.enemyGaits.keys())if(!aliveIds.has(id)){this.enemyGaits.delete(id);this.attackBlend.delete(id);}
    this.lastPlayer={x:state.player.x,y:state.player.y};
    for(const w of state.weapons){const old=this.shotTimes.get(w.uid);if(!old||old.count!==w.shotCount)this.shotTimes.set(w.uid,{count:w.shotCount,at:state.time});}
    this.captureEvents(state);
    if(!options.reducedMotion){
      const hit=state.events.filter(e=>(e.type==='player-hit'||e.type==='shield-break')&&state.time-e.at>=0&&state.time-e.at<.18).at(-1);
      if(hit){const age=state.time-hit.at,power=(1-age/.18)*(hit.type==='shield-break'?4:2.8);this.camera.x-=Math.sin(age*95)*power;this.camera.y-=Math.cos(age*73)*power*.65;}
    }
    ctx.fillStyle='#101b24';ctx.fillRect(0,0,this.cssWidth,this.cssHeight);
    ctx.save();ctx.scale(this.scale,this.scale);ctx.translate(-this.camera.x,-this.camera.y);
    this.floor(state);
    ctx.save();ctx.beginPath();ctx.rect(0,0,state.width,state.height);ctx.clip();
    for(const zone of state.zones)if(zone.type==='friendly')this.zone(zone,state.time,false);
    for(const drop of state.drops)this.drop(drop.x,drop.y,state.time,drop.id);
    const entities=state.enemies.filter(e=>(e as EnemyView&{exposed?:boolean}).exposed!==false&&e.hp>0).sort((a,b)=>a.y-b.y||a.eid-b.eid);
    const motions=motionFrame(state);
    for(const [id,m] of motions){const goal=m.control?0:m.stage==='windup'?m.progress:m.stage==='active'?1:0;const before=this.attackBlend.get(id)??goal;
      m.intensity=before+(goal-before)*(1-Math.exp(-dt*18));this.attackBlend.set(id,m.intensity);}
    let playerDrawn=false;
    for(const enemy of entities){
      if(!playerDrawn&&enemy.y>state.player.y){this.player(state);playerDrawn=true;}
      this.enemy(enemy,state.time,motions.get(enemy.eid)!);
    }
    if(!playerDrawn)this.player(state);
    for(const bullet of state.bullets)drawProjectile(ctx,bullet,state.time,options.reducedMotion);
    this.drawEffects(state.time);
    this.playerFeedback(state);
    // Warning geometry is authoritative and always above friendly effects.
    for(const damage of [false,true])for(const zone of state.zones)if(zone.type!=='friendly'&&(zoneRole(zone)==='damage')===damage&&zoneVisible(state,zone))this.zone(zone,state.time,true);
    for(const e of entities){const radius=chargeContactRadius(e,state.time);if(radius===undefined)continue;ctx.strokeStyle='#ffd1aa';ctx.lineWidth=3;ctx.beginPath();ctx.arc(e.x,e.y,radius,0,TAU);ctx.stroke();}
    const view={...this.camera,w:vw,h:vh};
    for(const e of entities)enemyMotionLabel(ctx,e,motions.get(e.eid)!,e.kind==='boss'?e.radius*2.3:Math.max(28,e.radius*2.8),this.scale,options.lang,view,this.dpr);
    if(options.target)this.target(options.target,state.time);
    this.edgeWarnings(state,vw,vh);
    ctx.restore();ctx.restore();
    this.screenFeedback(state);
    this.hud(state);
  }
  private floor(state:BattleView):void{
    const ctx=this.ctx;
    const colors=['#263640','#342e2a','#242f3d'];ctx.fillStyle=colors[(state.act-1)%3];ctx.fillRect(0,0,state.width,state.height);
    const tile=256;
    const left=Math.max(0,Math.floor(this.camera.x/tile)*tile),top=Math.max(0,Math.floor(this.camera.y/tile)*tile);
    const right=Math.min(state.width,this.camera.x+this.cssWidth/this.scale+tile),bottom=Math.min(state.height,this.camera.y+this.cssHeight/this.scale+tile);
    ctx.save();ctx.globalAlpha=.72;
    for(let y=top;y<bottom;y+=tile)for(let x=left;x<right;x+=tile)this.art.tile(ctx,`floor.${state.act}`,x,y,tile,tile);
    ctx.restore();ctx.fillStyle='rgba(15,28,35,.22)';ctx.fillRect(0,0,state.width,state.height);
    ctx.strokeStyle='#74817c';ctx.lineWidth=6;ctx.strokeRect(3,3,state.width-6,state.height-6);
    ctx.strokeStyle='#14222a';ctx.lineWidth=12;ctx.strokeRect(12,12,state.width-24,state.height-24);
    for(const o of state.obstacles){
      ctx.fillStyle='rgba(0,0,0,.28)';rounded(ctx,o.x+6,o.y+9,o.w,o.h,5);ctx.fill();
      ctx.save();rounded(ctx,o.x,o.y,o.w,o.h,4);ctx.clip();
      this.art.tile(ctx,'floor.4',o.x,o.y,o.w,o.h);
      ctx.fillStyle=state.act===2?'rgba(127,65,33,.35)':'rgba(24,50,62,.25)';ctx.fillRect(o.x,o.y,o.w,o.h);
      ctx.restore();ctx.strokeStyle='#101b24';ctx.lineWidth=4;rounded(ctx,o.x,o.y,o.w,o.h,4);ctx.stroke();
      ctx.strokeStyle='#7f8273';ctx.lineWidth=2;ctx.beginPath();ctx.moveTo(o.x+5,o.y+5);ctx.lineTo(o.x+o.w-5,o.y+5);ctx.stroke();
      ctx.fillStyle='#b39b65';
      for(const [x,y] of [[o.x+7,o.y+7],[o.x+o.w-7,o.y+7],[o.x+7,o.y+o.h-7],[o.x+o.w-7,o.y+o.h-7]]){ctx.beginPath();ctx.arc(x,y,2,0,TAU);ctx.fill();}
    }
  }
  private shadow(x:number,y:number,w:number,h:number,alpha=.28):void{
    const c=this.ctx;c.save();c.translate(x,y);c.scale(w,h);
    const fade=c.createRadialGradient(0,0,0,0,0,1);
    fade.addColorStop(0,`rgba(4,10,15,${alpha})`);
    fade.addColorStop(.45,`rgba(4,10,15,${alpha*.7})`);
    fade.addColorStop(1,'rgba(4,10,15,0)');
    c.fillStyle=fade;c.fillRect(-1,-1,2,2);c.restore();
  }
  private mech(ctx:CanvasRenderingContext2D,id:string,x:number,y:number,size:number,time:number,dir:number,moving:number,dashing=false,gaitTime=time):void{
    if(!CHASSIS.includes(id))id='scavenger';
    const unit=size/64;
    const walk=walkPose(dir,gaitTime),amount=this.options.reducedMotion||dashing?0:clamp(moving,0,1);
    const bob=this.options.reducedMotion?0:(walk.rise*amount+Math.sin(time*2)*.4)*unit;
    const lean=this.options.reducedMotion?0:(dashing?.10:walk.lean*amount);
    ctx.save();ctx.translate(x,y);ctx.rotate(lean);
    this.art.draw(ctx,`${id}.backpack`,0,-14*unit,39*unit,39*unit,0,.96);
    // Split the existing leg-pair sprite at its waist center in the renderer.
    // The torso covers the joint, while each foot follows its own key pose.
    for(const side of dir===3?[1,0]:[0,1]){
      const leg=side===0?walk.left:walk.right;
      ctx.save();ctx.translate(leg.x*unit*amount,(10+leg.y*amount)*unit);ctx.rotate(leg.angle*amount);
      ctx.scale(dir===1||dir===3?.88:1,1);ctx.beginPath();ctx.rect(side===0?-24*unit:0,-20*unit,24*unit,45*unit);ctx.clip();
      this.art.draw(ctx,`${id}.legs`,0,0,40*unit,29*unit);ctx.restore();
    }
    this.art.draw(ctx,`${id}.body.${dir}`,0,-9*unit+bob,53*unit,50*unit);
    if(dir===2)this.art.draw(ctx,`${id}.backpack`,0,-11*unit+bob,31*unit,33*unit);
    ctx.restore();
  }
  private player(state:BattleView):void{
    const ctx=this.ctx,p=state.player,t=state.time;
    this.shadow(p.x,p.y+16,26,10,.38);
    if(this.deathVisualStart!==null){
      const age=this.options.reducedMotion?1:(performance.now()-this.deathVisualStart)/1000;
      const keyframes=[0,.08,.2,.38,.62,.85];
      const step=Math.min(5,Math.floor(age/.085));
      ctx.save();ctx.translate(p.x,p.y+step*1.8);ctx.rotate(keyframes[step]);ctx.globalAlpha=1-step*.065;
      this.mech(ctx,state.chassis,0,0,64,0,this.lastFacing,0);ctx.restore();return;
    }
    if(p.dashTime>0&&!this.options.reducedMotion){
      for(let i=3;i>=1;i--){ctx.save();ctx.globalAlpha=.14*(4-i);this.mech(ctx,state.chassis,p.x-Math.cos(p.angle)*i*12,p.y-Math.sin(p.angle)*i*12,62,t,this.lastFacing,0,true);ctx.restore();}
    }
    if(p.shield>0){
      ctx.strokeStyle=p.invulnerable>0?'#c1fff4':'rgba(72,209,196,.42)';ctx.lineWidth=p.invulnerable>0?3:1.5;
      ctx.beginPath();ctx.ellipse(p.x,p.y-3,34,39,0,0,TAU);ctx.stroke();
    }
    // Preserve combat order so drone muzzle positions match their drawn orbit.
    const guns=state.weapons.slice(0,3);
    for(let i=0;i<guns.length;i++)if(Math.sin(guns[i].angle)<0)this.weapon(guns[i],i,p,t);
    const gaitTime=(this.playerGait?.stride??0)*.48,blend=this.options.reducedMotion?1:easeOut(this.facingBlend);
    if(blend<1){ctx.save();ctx.globalAlpha=1-blend;this.mech(ctx,state.chassis,p.x,p.y,64,t,this.previousFacing,this.movement,p.dashTime>0,gaitTime);ctx.restore();}
    ctx.save();ctx.globalAlpha=blend;this.mech(ctx,state.chassis,p.x,p.y,64,t,this.lastFacing,this.movement,p.dashTime>0,gaitTime);ctx.restore();
    const hurt=state.events.filter(e=>e.type==='player-hit'&&t-e.at>=0&&t-e.at<.15).at(-1);
    if(hurt&&!this.options.reducedMotion)this.art.flash(ctx,`${state.chassis}.body.${this.lastFacing}`,p.x,p.y-9,53,50,(1-(t-hurt.at)/.15)*.65,(hurt.hullDamage??1)>0?'#ffe1c4':'#b7fff4');
    for(let i=0;i<guns.length;i++)if(Math.sin(guns[i].angle)>=0)this.weapon(guns[i],i,p,t);
    if(p.overloadTime>0){
      ctx.save();ctx.strokeStyle='#f8c16c';ctx.lineWidth=2;ctx.setLineDash([6,5]);ctx.lineDashOffset=-t*18;ctx.beginPath();ctx.arc(p.x,p.y,44,0,TAU);ctx.stroke();ctx.restore();
    }
    if(p.invulnerable>0&&p.dashTime<=0){ctx.save();ctx.strokeStyle='#fff0cc';ctx.lineWidth=2;ctx.globalAlpha=.55;ctx.beginPath();ctx.ellipse(p.x,p.y-5,28,32,0,0,TAU);ctx.stroke();ctx.restore();}
    // Thin ground ring anchors the visual body to the collision center.
    ctx.strokeStyle='rgba(72,209,196,.5)';ctx.lineWidth=1;ctx.beginPath();ctx.ellipse(p.x,p.y+12,18,5,0,0,Math.PI);ctx.stroke();
  }
  private weapon(w:WeaponView,index:number,p:Point,time:number):void{
    const ctx=this.ctx;const mounts=[{x:-21,y:0},{x:21,y:0},{x:0,y:-29}];const m=mounts[index];
    const shot=this.shotTimes.get(w.uid),age=shot?time-shot.at:99;
    const recoil=this.options.reducedMotion||!w.shotCount||age<0||age>.22?0:(1-easeOut(age/.22))*(w.id==='W07'||w.id==='W08'?7:4);
    let angle=w.angle;
    if(w.id==='W08'&&age<.3)angle+=Math.sin(age/.3*Math.PI)*.9;
    if(w.id==='W09')angle+=time*9;
    const x=p.x+m.x-Math.cos(angle)*recoil,y=p.y+m.y-Math.sin(angle)*recoil;
    const big=w.id==='W08'||w.id==='W07';this.art.draw(ctx,w.id,x,y,big?40:34,big?32:27,angle,1,Math.cos(angle)<0);
    if(age<.085&&w.shotCount>0&&w.id!=='W11'&&w.id!=='W09'){
      ctx.save();ctx.translate(x+Math.cos(angle)*19,y+Math.sin(angle)*19);ctx.rotate(angle);ctx.globalAlpha=1-age/.085;ctx.fillStyle=MODULE_BY_ID[w.id]?.color??'#ffe4ae';
      ctx.beginPath();ctx.moveTo(0,-4);ctx.lineTo(12,0);ctx.lineTo(0,4);ctx.closePath();ctx.fill();ctx.restore();
    }
    if(w.id==='W11'){
      const count=(w as WeaponView&{droneCount?:number}).droneCount??2;
      for(let n=0;n<count;n++){const a=time*1.2+n*TAU/Math.max(1,count)+(index%2?Math.PI/3:0);const dx=p.x+Math.cos(a)*48,dy=p.y+Math.sin(a)*48;this.shadow(dx,dy+7,7,3,.2);this.art.draw(ctx,'W11',dx,dy,20,20,w.angle);}
    }
  }
  private enemy(e:EnemyView,time:number,m:EnemyMotion):void{
    const c=this.ctx,boss=e.kind==='boss';
    const size=boss?e.radius*2.3:Math.max(28,e.radius*2.8);
    this.shadow(e.x,e.y+size*.25,size*.38,size*.14,boss?.42:.28);
    const offset=(e as EnemyView&{offsetX?:number}).offsetX??0;
    const key=e.id==='B2B'?`B2B.${offset<0?'left':'right'}`:e.id==='B3B'&&offset!==0?`B3B.${offset<0?'left':'right'}`:e.id;
    enemyBody(c,this.art,key,e,m,size,time,this.options.reducedMotion,this.enemyGaits.get(e.eid));
    if(m.hit>0&&!this.options.reducedMotion)this.art.flash(c,key,e.x,e.y-size*.08,size,size,m.hit*.62);
    enemyControl(c,e,m,size);
    if(e.shielded){c.strokeStyle='#ffce8a';c.lineWidth=3;c.beginPath();c.arc(e.x,e.y,e.radius+7,e.angle-Math.PI/3,e.angle+Math.PI/3);c.stroke();}
    if(e.wet){c.fillStyle='#7dd8ef';for(let i=0;i<2;i++){c.beginPath();c.ellipse(e.x-size*.3+i*9,e.y-size*.42,2.5,4,0,0,TAU);c.fill();}}
    if(e.burns?.length){c.fillStyle='#ffae58';c.font='bold 10px sans-serif';c.textAlign='center';c.fillText(`♨ ${e.burns.length}`,e.x,e.y-size*.47-9);}
    if(this.options.colorAssist){c.fillStyle='#ffe1c3';c.font='bold 9px sans-serif';c.textAlign='center';c.fillText(boss?'◆':e.kind==='elite'?'◇':'▲',e.x,e.y+size*.34);}
    if(!boss&&(e.hp<e.maxHp||e.kind==='elite')){
      const w=Math.max(22,size*.65);c.fillStyle='#111c23';rounded(c,e.x-w/2,e.y-size*.53-6,w,5,2);c.fill();
      c.fillStyle=e.kind==='elite'?'#e9b269':'#d16b58';rounded(c,e.x-w/2,e.y-size*.53-6,w*clamp(e.hp/e.maxHp,0,1),5,2);c.fill();
    }
    if(boss&&e.stagger){
      c.fillStyle='#1b252a';rounded(c,e.x-30,e.y+size*.4,60,4,2);c.fill();
      c.fillStyle='#eed897';rounded(c,e.x-30,e.y+size*.4,60*clamp(e.stagger/100,0,1),4,2);c.fill();
    }
  }
  private zone(z:ZoneView,time:number,warning:boolean):void{
    if(((z as ZoneView&{delay?:number}).delay??0)>0)return;
    const c=this.ctx,progress=clamp(1-z.remaining/Math.max(.001,z.duration),0,1);
    const role=zoneRole(z),damage=role==='damage',charge=z.plan?.effect==='charge';
    c.save();c.translate(z.x,z.y);c.rotate(z.angle);zonePath(c,z);
    const color=damage?(z.active?'#ffd1aa':'#f88478'):role==='force'?'#83c6d8':'#b1cea0';
    c.fillStyle=warning?color:z.color;c.globalAlpha=warning?(charge&&z.active?.06:z.active?.2:.07+progress*.12):.12;c.fill('evenodd');c.globalAlpha=1;
    if(warning)drawHazardEnergy(c,z,time,this.options.reducedMotion);
    zonePath(c,z);
    c.strokeStyle=warning?color:z.color;c.lineWidth=warning?(z.active&&!charge?3:2):1.5;
    if(warning&&(!z.active||!damage||charge))c.setLineDash(damage?[10,6]:[3,7]);c.stroke();c.setLineDash([]);
    if(warning&&!z.active&&(z.innerRadius??0)===0){
      c.strokeStyle=color;c.lineWidth=2;c.beginPath();c.arc(0,0,18,-Math.PI/2,-Math.PI/2+progress*TAU);c.stroke();
    }
    if(warning)zoneSymbols(c,z,this.scale);
    if(warning&&damage&&this.options.colorAssist&&(z.innerRadius??0)===0){c.strokeStyle='#ffe8c5';c.lineWidth=1;c.beginPath();c.moveTo(-5,-5);c.lineTo(5,5);c.moveTo(5,-5);c.lineTo(-5,5);c.stroke();}
    c.restore();
  }
  private drop(x:number,y:number,time:number,id:number):void{
    const c=this.ctx;const bob=this.options.reducedMotion?0:Math.sin(time*3+id)*2;
    c.save();c.translate(x,y+bob);c.rotate(Math.PI/4);c.fillStyle='#17262c';c.fillRect(-5,-5,10,10);c.fillStyle='#e8c47c';c.fillRect(-3,-3,6,6);c.strokeStyle='#ffefb4';c.lineWidth=1;c.strokeRect(-3,-3,6,6);c.restore();
  }
  private captureEvents(state:BattleView):void{
    const visible=new Set(['fire','hit','critical','arc','player-hit','shield-break','kill','explosion','enemy-explosion','enemy-attack','enemy-fire','dash','overload','phase','stagger','heal','defeat']);
    for(const event of state.events){
      if(this.seenEvents.has(event.id))continue;this.seenEvents.add(event.id);
      if(state.time-event.at>1.2||!visible.has(event.type))continue;
      const visualEvent={...event};
      // Older saves stored a player hit at the attacker, not the hurt body.
      if(event.type==='player-hit'&&!event.from){visualEvent.from={x:event.x,y:event.y};visualEvent.x=state.player.x;visualEvent.y=state.player.y;}
      const target=event.targetId!==undefined?state.enemies.find(e=>e.eid===event.targetId):undefined;
      const next:Effect={event:visualEvent,born:event.at,life:effectLife(event),end:event.to??(target?{x:target.x,y:target.y}:undefined),
        label:['hit','critical','player-hit'].includes(event.type)?event.amount:undefined,labelBorn:event.at};
      // Merge shotgun numbers, while each real contact still gets its own spark.
      if(next.label&&event.targetId!==undefined&&['hit','critical'].includes(event.type)){
        for(let i=this.effects.length-1;i>=0;i--){const old=this.effects[i];if(event.at-old.born>.14)break;
          if(old.label&&old.event.targetId===event.targetId&&event.at-(old.labelBorn??old.born)<.14&&['hit','critical'].includes(old.event.type)){
            next.label+=old.label;next.labelBorn=old.labelBorn??old.born;old.label=undefined;break;
          }
        }
      }
      this.effects.push(next);
    }
    this.effects=this.effects.filter(f=>state.time-f.born<f.life).slice(-240);
    if(this.seenEvents.size>1200)this.seenEvents=new Set(state.events.map(e=>e.id));
  }
  private drawEffects(time:number):void{
    for(const f of this.effects)drawCombatEffect(this.ctx,f.event,time-f.born,f.life,this.options.reducedMotion,this.options.lang,this.scale,f.label,f.end);
  }
  private screenFeedback(state:BattleView):void{
    const hit=state.events.filter(e=>e.type==='player-hit'&&state.time-e.at>=0&&state.time-e.at<.45).at(-1);if(!hit)return;
    const c=this.ctx,k=1-(state.time-hit.at)/.45,shield=!(hit.hullDamage??1);
    c.save();c.strokeStyle=shield?'#65dfd0':'#ff8c69';c.globalAlpha=(this.options.reducedMotion?.35:.55)*k;c.lineWidth=6;
    c.strokeRect(3,3,this.cssWidth-6,this.cssHeight-6);c.restore();
  }
  private target(point:Point,time:number):void{
    const c=this.ctx;c.save();c.translate(point.x,point.y);c.strokeStyle='#f5df9b';c.lineWidth=2;
    const r=19+(this.options.reducedMotion?0:Math.sin(time*4)*2);
    for(let i=0;i<4;i++){const a=i*Math.PI/2;c.beginPath();c.arc(0,0,r,a-.22,a+.22);c.stroke();}c.restore();
  }
  private playerFeedback(state:BattleView):void{
    const hit=state.events.filter(e=>e.type==='player-hit'&&state.time-e.at<.7).at(-1);
    const broken=state.events.some(e=>e.type==='shield-break'&&state.time-e.at<1.1);
    if(!hit&&!broken)return;
    const c=this.ctx,p=state.player;c.save();c.translate(p.x,p.y);
    if(hit){
      c.strokeStyle='#ffc3a0';c.lineWidth=3;c.globalAlpha=this.options.reducedMotion?1:Math.max(.25,1-(state.time-hit.at)/.7);
      const direction=Math.atan2((hit.from?.y??hit.y)-p.y,(hit.from?.x??hit.x)-p.x);
      c.beginPath();c.arc(0,0,42,direction-.45,direction+.45);c.stroke();
      if(Math.hypot((hit.from?.x??hit.x)-p.x,(hit.from?.y??hit.y)-p.y)>5){c.rotate(direction);c.fillStyle='#ffc3a0';c.beginPath();c.moveTo(49,0);c.lineTo(40,-6);c.lineTo(40,6);c.closePath();c.fill();c.rotate(-direction);}
    }
    if(broken){
      c.globalAlpha=1;c.fillStyle='#17212a';rounded(c,-60,-77,120,23,4);c.fill();
      c.fillStyle='#ffd3a0';c.font='bold 12px sans-serif';c.textAlign='center';c.fillText(this.options.lang==='zh'?'护盾破裂':'SHIELD BROKEN',0,-61);
    }
    c.restore();
  }
  private edgeWarnings(state:BattleView,vw:number,vh:number):void{
    const c=this.ctx,margin=22/this.scale;
    for(const e of state.enemies){
      if((e as EnemyView&{exposed?:boolean}).exposed===false||e.hp<=0)continue;
      if(e.kind!=='boss'&&e.id!=='E04'&&e.id!=='E11')continue;
      const x=e.x-this.camera.x,y=e.y-this.camera.y;
      if(x>=0&&x<=vw&&y>=0&&y<=vh)continue;
      const px=clamp(x,margin,vw-margin)+this.camera.x,py=clamp(y,margin,vh-margin)+this.camera.y;
      const a=Math.atan2(e.y-py,e.x-px);c.save();c.translate(px,py);c.rotate(a);c.fillStyle='#f4aa87';c.beginPath();c.moveTo(8,0);c.lineTo(-5,-5);c.lineTo(-5,5);c.closePath();c.fill();c.restore();
    }
  }
  private hud(state:BattleView):void{
    const c=this.ctx,w=this.cssWidth,h=this.cssHeight;
    c.save();c.textBaseline='top';
    if(!this.art.ready){c.fillStyle='#f4e8cc';c.textAlign='center';c.font='16px system-ui,sans-serif';c.fillText(this.options.lang==='zh'?'正在装载机甲素材…':'Loading mech artwork…',w/2,h/2);}
    c.restore();
  }
  preview(chassis:string,time=0):void{
    this.resize();const c=this.ctx,w=this.cssWidth,h=this.cssHeight;
    c.clearRect(0,0,w,h);const gradient=c.createRadialGradient(w*.5,h*.45,8,w*.5,h*.5,Math.max(w,h)*.55);gradient.addColorStop(0,'#37515a');gradient.addColorStop(1,'#172a34');c.fillStyle=gradient;c.fillRect(0,0,w,h);
    c.strokeStyle='rgba(130,177,174,.12)';c.lineWidth=1;
    for(let x=0;x<w;x+=32){c.beginPath();c.moveTo(x,0);c.lineTo(x,h);c.stroke();}
    for(let y=0;y<h;y+=32){c.beginPath();c.moveTo(0,y);c.lineTo(w,y);c.stroke();}
    const size=Math.min(w*.56,h*.67,250),x=w*.5,y=h*.56;
    this.shadow(x,y+size*.25,size*.46,size*.16,.36);
    this.mech(c,chassis,x,y,size,time,0,0);
    this.art.draw(c,'W01',x-size*.39,y+size*.02,size*.42,size*.3,-.18);
    this.art.draw(c,'W04',x+size*.39,y-size*.02,size*.4,size*.3,.18);
    c.fillStyle='#9bb9b5';c.font='600 10px system-ui,sans-serif';c.textAlign='center';c.fillText(`RECOVERY UNIT  /  ${String(Math.max(0,CHASSIS.indexOf(chassis))+1).padStart(2,'0')}`,x,h-17);
  }
  icon(canvas:HTMLCanvasElement,id:string):void{
    const ctx=canvas.getContext('2d');if(!ctx)return;const rect=canvas.getBoundingClientRect();
    const w=rect.width||canvas.width||80,h=rect.height||canvas.height||80,dpr=Math.min(2,globalThis.devicePixelRatio||1);
    if(canvas.width!==Math.round(w*dpr)||canvas.height!==Math.round(h*dpr)){canvas.width=Math.round(w*dpr);canvas.height=Math.round(h*dpr);}
    ctx.setTransform(dpr,0,0,dpr,0,0);ctx.clearRect(0,0,w,h);ctx.imageSmoothingEnabled=true;ctx.imageSmoothingQuality='high';
    this.art.draw(ctx,id,w/2,h/2,w*.94,h*.94);
  }
  portrait(canvas:HTMLCanvasElement,chassis:string,direction:0|1|2|3=0):void{
    const ctx=canvas.getContext('2d');if(!ctx)return;const rect=canvas.getBoundingClientRect();
    const w=rect.width||canvas.width||160,h=rect.height||canvas.height||160,dpr=Math.min(2,globalThis.devicePixelRatio||1);
    if(canvas.width!==Math.round(w*dpr)||canvas.height!==Math.round(h*dpr)){canvas.width=Math.round(w*dpr);canvas.height=Math.round(h*dpr);}
    ctx.setTransform(dpr,0,0,dpr,0,0);ctx.clearRect(0,0,w,h);ctx.imageSmoothingEnabled=true;ctx.imageSmoothingQuality='high';
    this.mech(ctx,CHASSIS_BY_ID[chassis]?chassis:'scavenger',w/2,h*.55,Math.min(w,h)*.92,0,direction,0);
  }
}
