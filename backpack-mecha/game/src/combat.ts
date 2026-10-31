import {contains} from './hazards.ts';
export {contains} from './hazards.ts';
import {bossAttackSlot} from './boss-patterns.ts';
import {guardBossTurn} from './boss-safety.ts';
import {moduleValue,TIER_EFFECTS,damageScale} from './rarity.ts';
import {CHASSIS_BY_ID, MODULE_BY_ID, ENEMY_BY_ID, BOSS_BY_ID} from './content.ts';
import {activeSupports} from './economy.ts';
import {scrapPerCost,chassisStats} from './progression.ts';
import {chassisSkill} from './skills.ts';
import {nextRandom} from './random.ts';
import {ARENA,BOSS_DAMAGE_SCALE,availableBudget,bossPhase,bossTurn,bossPursuitSpeed,chooseEnemy,circleHitsRect,clearPath,createEncounter,findPath,traversable} from './encounters.ts';
import type {AttackPlan,EncounterState,SpawnSpec} from './encounters.ts';
import type {BattleView,BattleResult,Run,InputFrame,EnemyView,BulletView,ZoneView,WeaponView,Point,CombatStats,CombatEvent,Tier} from './types.ts';

type DamageKind='ballistic'|'water'|'electric'|'fire'|'oil'|'ice'|'melee'|'explosion'|'drone';
interface BurnLayer {expires:number;next:number;weapon:string;damage:number}
export interface EnemyState extends EnemyView {
 armor:number;speed:number;damage:number;cost:number;reward:number;born:number;dead:boolean;
 cooldown:number;contactAt:number;path:Point[];pathAt:number;aiUntil:number;healingUntil:number;
 affix:number;oilUntil:number;oilAt:number;chill:number;chillUntil:number;chillStrength:number;
 frozen:number;wet:number;burns:BurnLayer[];stagger:number;staggerUntil:number;vulnerableUntil:number;
 summon:boolean;exposed:boolean;offsetX:number;charge?:{vx:number;vy:number;until:number;damage:number;radius:number};
}
export interface WeaponState extends WeaponView {tier:Tier;supports:Record<string,Tier>;target?:number;targetUntil:number;rectifierAt:number;springUsed:boolean;fuseAt:Record<string,number>;droneCount:number}
export interface BulletState extends BulletView {kind:DamageKind;weaponUid?:string;factor:number;shot:number;hitAt:Record<string,number>;pierce:number;bounces:number;bounceFactor:number;traveled:number;range:number;target?:Point;slow:number;applyStatus:boolean;source:string}
export interface ZoneState extends ZoneView {plan:AttackPlan;sourceId?:number;source:string;delay:number;age:number;pulse:number;triggered:boolean;spawn?:SpawnSpec;originalAngle:number}
export interface BattleState extends BattleView {
 enemies:EnemyState[];bullets:BulletState[];zones:ZoneState[];weapons:WeaponState[];
 rng:number;nextId:number;nextEvent:number;nextShot:number;remainder:number;encounter:EncounterState;
 utilities:Record<string,Tier>;protocols:string[];lastDamage:number;shieldRegen:number;dashBase:number;dashAngle:number;dashOrigin:Point;
 dashReleased:boolean;overloadReleased:boolean;lastDash:number;repairAt:number;repairAmount:number;pickupAt:number;
 capacitorAt:number;capacitorDefense:number;recoveryAt:number;emberHeal:number;emergencyUsed:boolean;decoyAt:number;
 decoy?:Point&{hp:number;until:number};priority?:number;priorityUntil:number;slowUntil:number;slowAmount:number;
 bossClock:number;bossTurn:number;bossCenter?:Point;bossStarted:boolean;bossOverloadWarned:boolean;bossEnraged:boolean;slainGroups:string[];
 failureReason?:string;
 playerVelocity?:Point;
 skillReleased?:boolean;skillPulseAt?:number;
 baseDamage?:number;baseAttackSpeed?:number;
}
interface Hit {base:number;kind:DamageKind;weapon?:WeaponState;factor?:number;direct?:boolean;status?:boolean;secondary?:boolean;origin?:Point;arcFirst?:boolean;oilExplosion?:boolean;source?:string}

const CONFIG={bulletSpeed:800,waterSpeed:650,iceSpeed:650,oilSpeed:550,missileSpeed:500,droneSpeed:720,bulletRadius:4,
 spawnWarning:.75,spawnGrace:.5,hitGrace:.35,pickupBase:60,maxEnemies:70,softEnemies:45,enemyShotSpeed:240};
const clamp=(v:number,min:number,max:number)=>Math.max(min,Math.min(max,v));
const distance=(a:Point,b:Point)=>Math.hypot(a.x-b.x,a.y-b.y);
const angleTo=(a:Point,b:Point)=>Math.atan2(b.y-a.y,b.x-a.x);
const angleDiff=(a:number,b:number)=>Math.atan2(Math.sin(a-b),Math.cos(a-b));
const value=moduleValue;
const scale=damageScale;
const zeros=():CombatStats=>({damageByModule:{},damageTakenBy:{},kills:0,killedBudget:0,goldEarned:0,maxChain:0,damageTaken:0});
function rand(w:BattleState):number {const [state,n]=nextRandom(w.rng);w.rng=state;return n;}
function event(w:BattleState,type:string,p:Point,extra:Partial<CombatEvent>={}):void {
 w.events.push({id:w.nextEvent++,type,at:w.time,x:p.x,y:p.y,...extra});
}
function groupKey(e:EnemyState):string {return e.group||String(e.eid);}
function alive(e:EnemyState):boolean {return !e.dead&&e.hp>0&&e.exposed;}
function support(weapon:WeaponState,id:string):number {return value(id,weapon.supports[id]);}
function utility(w:BattleState,id:string):number {return value(id,w.utilities[id]);}
function protocol(w:BattleState,id:string):boolean {return w.protocols.includes(id);}
function enemySlow(w:BattleState,e:EnemyState):number {return Math.min(e.kind==='boss'?.1:e.kind==='elite'?.25:.4,Math.max(e.oilUntil>w.time?.2:0,e.chill*e.chillStrength));}
function syncBossHP(w:BattleState,e:EnemyState):void {if(e.group)for(const other of w.enemies)if(other.group===e.group)other.hp=e.hp;}

export function createBattle(run:Run):BattleState {
 const growth=chassisStats(run);
 const chassis=CHASSIS_BY_ID[run.chassis];if(!chassis)throw new Error(`Unknown chassis ${run.chassis}`);
 const encounter=createEncounter(run),equipped=run.items.filter(i=>!i.stored),utilities:Record<string,Tier>={};
 for(const item of equipped)if(MODULE_BY_ID[item.id]?.kind==='utility')utilities[item.id]=item.tier;
 const maxShield=chassis.shield+value('U02',utilities.U02)+(run.protocols.includes('P04')?20:0)+Number(run.extra?.temporaryShield||0);
 const speed=chassis.speed*clamp(1+value('U07',utilities.U07)-(utilities.U06?.03:0),.65,1.6);
 const dashBase=Math.max(3.5,chassis.dash-(utilities.U07?TIER_EFFECTS.dashReduction[utilities.U07-1]!:0)+(run.protocols.includes('P04')?.5:0));
 const weapons:WeaponState[]=equipped.filter(i=>MODULE_BY_ID[i.id]?.kind==='weapon').map((i,index)=>({uid:i.uid,id:i.id,tier:i.tier,x:800,y:650,angle:-Math.PI/2,cooldown:.1+index*.05,shotCount:0,
  supports:Object.fromEntries(activeSupports(run).filter(s=>s.link===i.uid).map(s=>[s.id,s.tier])),targetUntil:0,rectifierAt:0,springUsed:true,fuseAt:{},droneCount:0}));
 let drones=0;const droneLimit=weapons.some(w=>w.id==='W18')?9:6;for(const weapon of weapons)if(MODULE_BY_ID[weapon.id].attack==='drone'){weapon.droneCount=Math.min(droneLimit-drones,(weapon.id==='W18'?3:2)+(weapon.supports.S10?1:0));drones+=weapon.droneCount;}
 const world:BattleState={version:1,tick:0,time:0,wave:run.wave,act:encounter.state.wave.act,difficulty:run.difficulty,status:'playing',width:ARENA.width,height:ARENA.height,
  player:{x:800,y:650,hp:clamp(run.hp,0,growth.maxHp),maxHp:growth.maxHp,shield:maxShield,maxShield,radius:14,speed,armor:clamp(chassis.armor+value('U06',utilities.U06),0,60),angle:-Math.PI/2,dashCooldown:0,overloadCooldown:0,dashTime:0,overloadTime:0,invulnerable:0},
  baseDamage:growth.attack/100,baseAttackSpeed:growth.speed/100,
  enemies:[],bullets:[],zones:[],weapons,drops:[],obstacles:encounter.obstacles,events:[],stats:zeros(),chassis:run.chassis,duration:encounter.state.wave.duration,insuranceUsed:run.insuranceUsed,
  rng:run.rng.combat,nextId:1,nextEvent:1,nextShot:1,remainder:0,encounter:encounter.state,utilities,protocols:[...run.protocols],lastDamage:-10,
  shieldRegen:3+(utilities.U02?TIER_EFFECTS.shieldRegen[utilities.U02-1]!:0),dashBase,dashAngle:0,dashOrigin:{x:800,y:650},dashReleased:true,overloadReleased:true,lastDash:-10,
  repairAt:10,repairAmount:0,pickupAt:0,capacitorAt:0,capacitorDefense:0,recoveryAt:0,emberHeal:0,emergencyUsed:false,decoyAt:0,priorityUntil:0,slowUntil:0,slowAmount:0,
  bossClock:2,bossTurn:0,bossStarted:false,bossOverloadWarned:false,bossEnraged:false,slainGroups:[]};
 if(encounter.boss){world.bossId=encounter.boss;world.bossCenter={x:800,y:300};world.bossStarted=true;
  spawnEnemy(world,{id:encounter.boss,x:encounter.boss==='B2B'?655:800,y:300,elite:false,affix:0,reward:false,cost:0,boss:true,group:encounter.boss});
  if(encounter.boss==='B2B'){spawnEnemy(world,{id:encounter.boss,x:945,y:300,elite:false,affix:0,reward:false,cost:0,boss:true,group:encounter.boss});world.enemies[0]!.offsetX=-145;world.enemies[1]!.offsetX=145;}
  if(encounter.boss==='B3B')for(const x of [-150,150]){const e=spawnEnemy(world,{id:encounter.boss,x:800+x,y:300,elite:false,affix:0,reward:false,cost:0,boss:true,group:encounter.boss});e.radius=65;e.offsetX=x;e.exposed=false;}
 }
 event(world,'battle-start',world.player);if(world.player.hp<=0)complete(world,false,'hull');return world;
}

/** Useful to deterministic scenario tests and development encounter previews. */
export function spawnEnemy(w:BattleState,spec:SpawnSpec):EnemyState {
 const boss=spec.boss?BOSS_BY_ID[spec.id]:undefined,base=ENEMY_BY_ID[spec.id];
 if(!boss&&!base)throw new Error(`Unknown enemy ${spec.id}`);
 const hpDifficulty=[1,1.1,1.1,1.2,1.3][clamp(w.difficulty,0,4)]!,damageDifficulty=w.difficulty>=4?1.15:w.difficulty>=2?1.1:1;
 const hp=(boss?boss.hp:base!.hp*[1,1.65,2.55][w.act-1]!)*hpDifficulty*(spec.elite?1.8:1);
 const e:EnemyState={eid:w.nextId++,id:spec.id,x:spec.x,y:spec.y,hp,maxHp:hp,radius:boss?.radius||base!.radius,angle:Math.PI/2,kind:boss?'boss':spec.elite?'elite':'normal',phase:1,
  ...(spec.group?{group:spec.group}:{}),armor:(boss?.armor||base?.armor||0)+(spec.elite&&spec.affix===1?10:0),speed:(boss?.speed||base?.speed||0)*(boss?1:[1,1.06,1.1][w.act-1]!)*(spec.elite&&spec.affix===0?1.15:1),
  damage:(boss?20*BOSS_DAMAGE_SCALE:base!.damage)*(boss?1:[1,1.25,1.5][w.act-1]!)*damageDifficulty*(spec.elite?1.2:1),cost:spec.cost,
  reward:spec.reward&&w.encounter.budget>0?scrapPerCost(w.wave)*spec.cost:0,
  born:w.time,dead:false,cooldown:boss?2:.5,contactAt:0,path:[],pathAt:0,aiUntil:0,healingUntil:0,affix:spec.elite?spec.affix:-1,
  oilUntil:0,oilAt:0,chill:0,chillUntil:0,chillStrength:.06,frozen:0,wet:0,burns:[],stagger:0,staggerUntil:0,vulnerableUntil:0,summon:!spec.reward,exposed:true,offsetX:0};
 w.enemies.push(e);event(w,'spawn',e,{targetId:e.eid,source:e.id});return e;
}
function move(w:BattleState,p:Point&{radius:number},dx:number,dy:number):boolean {
 const ox=p.x,oy=p.y;
 const x=clamp(p.x+dx,p.radius,w.width-p.radius);if(traversable({x,y:p.y},p.radius,w.obstacles,w.width,w.height))p.x=x;
 const y=clamp(p.y+dy,p.radius,w.height-p.radius);if(traversable({x:p.x,y},p.radius,w.obstacles,w.width,w.height))p.y=y;
 return Math.abs(p.x-ox-dx)>.1||Math.abs(p.y-oy-dy)>.1;
}
function follow(w:BattleState,e:EnemyState,target:Point,speed:number,dt:number):void {
 let next=target;
 if(clearPath(e,target,w.obstacles,e.radius+2,w.width,w.height)){e.path=[];}
 else{
  if(e.pathAt<=w.time||!e.path.length){e.path=findPath(e,target,w.obstacles,e.radius,w.width,w.height);e.pathAt=w.time+.32+(e.eid%4)*.03;}
  while(e.path.length&&distance(e,e.path[0]!)<8)e.path.shift();
  // Look ahead along the route, so four-way grid search does not become a zigzag gait.
  for(let i=e.path.length-1;i>0;i--)if(clearPath(e,e.path[i]!,w.obstacles,e.radius+2,w.width,w.height)){e.path.splice(0,i);break;}
  next=e.path[0]||target;
 }
 const d=distance(e,next);if(d<1)return;
 const a=angleTo(e,next),step=Math.min(speed*dt,d);
 e.angle=a;if(move(w,e,Math.cos(a)*step,Math.sin(a)*step))e.pathAt=0;
}
function addZone(w:BattleState,plan:AttackPlan,sourceId?:number,source='hazard',spawn?:SpawnSpec):ZoneState {
 const z:ZoneState={id:w.nextId++,x:plan.x,y:plan.y,kind:plan.kind,radius:plan.radius,w:plan.w,h:plan.h,angle:plan.angle,width:plan.width,innerRadius:plan.innerRadius,gapAngle:plan.gapAngle,gapWidth:plan.gapWidth,beat:plan.beat,
  remaining:plan.warning,duration:plan.warning,active:false,color:'#F05B5B',type:'warning',damage:plan.damage,plan:{...plan},sourceId,source,delay:plan.delay||0,age:0,pulse:0,triggered:false,originalAngle:plan.angle,...(spawn?{spawn}:{} )};
 if(plan.sweep){z.kind='cone';z.radius=plan.kind==='line'?plan.w||plan.radius:plan.radius;z.width=Math.min(Math.PI*2,Math.abs(plan.sweep)+(plan.kind==='cone'?plan.width||0:.08));z.angle=plan.angle+plan.sweep/2;}
 w.zones.push(z);event(w,'warning',z,{source});return z;
}
function spawnAt(w:BattleState,id:string,elite=false,reward=true):boolean {
 const def=ENEMY_BY_ID[id]!,radius=def.radius;
 for(let attempt=0;attempt<24;attempt++){
  const a=w.wave===1&&w.time<10?-Math.PI/2+(rand(w)-.5)*.5:rand(w)*Math.PI*2;
  const r=400+rand(w)*150,p={x:w.player.x+Math.cos(a)*r,y:w.player.y+Math.sin(a)*r};
  if(!traversable(p,radius+10,w.obstacles,w.width,w.height)||w.enemies.some(e=>alive(e)&&distance(e,p)<e.radius+radius+12))continue;
  if(w.zones.some(z=>z.delay<=0&&contains(z,p,radius)))continue;
  const spec:SpawnSpec={...p,id,elite,affix:Math.floor(rand(w)*3),reward,cost:def.cost*(elite?2:1)};
  addZone(w,{...p,kind:'circle',radius:radius+12,angle:0,warning:CONFIG.spawnWarning,active:.01,damage:0,effect:'spawn'},undefined,'spawn',spec);return true;
 }
 return false;
}
function tickSpawns(w:BattleState):void {
 if(w.bossId||w.time<w.encounter.nextSpawn)return;w.encounter.nextSpawn=Math.floor(w.time)+1;
 const pending=w.zones.filter(z=>z.spawn).length,count=w.enemies.filter(alive).length+pending;
 if(count>=CONFIG.softEnemies)return;
 let allowance=Math.min(8,availableBudget(w.encounter,w.time)),spent=0;
 while(allowance>0&&w.enemies.length+w.zones.filter(z=>z.spawn).length<CONFIG.maxEnemies){
  const id=w.wave===1&&w.time<10?'E01':chooseEnemy(w.encounter,allowance,rand(w));if(!id)break;
  const cost=ENEMY_BY_ID[id]!.cost;if(cost>allowance||!spawnAt(w,id))break;
  allowance-=cost;spent+=cost;
 }
 w.encounter.spent+=spent;
 if(w.encounter.extraElite&&!w.encounter.eliteQueued&&w.time>w.duration*.45&&w.enemies.filter(e=>e.kind==='elite').length<(w.difficulty>=2?3:2)){
  const id=w.act===1?'E03':w.encounter.mode==='full'?'E07':'E03';
  if(spawnAt(w,id,true,false))w.encounter.eliteQueued=true;
 }
}
function complete(w:BattleState,won:boolean,reason?:string):void {
 if(w.status!=='playing')return;w.status=won?'won':'lost';w.failureReason=reason;
 if(won){for(const drop of w.drops)w.stats.goldEarned+=drop.value;w.drops=[];}
 event(w,won?'victory':'defeat',w.player,{source:reason});
}
function killEnemy(w:BattleState,e:EnemyState,kind:DamageKind,weapon?:WeaponState,oilExplosion=false):void {
 const key=groupKey(e);if(e.dead||w.slainGroups.includes(key))return;
 w.slainGroups.push(key);e.dead=true;e.hp=0;
 if(e.group)for(const other of w.enemies)if(other.group===e.group){other.hp=0;other.dead=true;}
 w.stats.kills++;if(e.reward>0){w.stats.killedBudget+=e.cost;
  const nearby=w.drops.find(d=>distance(d,e)<35);if(nearby)nearby.value+=e.reward;else w.drops.push({id:w.nextId++,x:e.x,y:e.y,value:e.reward});
  event(w,'scrap-drop',e,{amount:e.reward});}
 event(w,'kill',e,{source:weapon?.id||kind,targetId:e.eid,radius:e.radius});
 if(w.utilities.U09&&['water','electric','fire','oil','ice'].includes(kind)&&w.time>=w.recoveryAt){w.player.shield=Math.min(w.player.maxShield,w.player.shield+utility(w,'U09'));w.recoveryAt=w.time+.5;}
 if(oilExplosion&&protocol(w,'P02')&&w.emberHeal<10){const heal=Math.min(1,w.player.maxHp-w.player.hp,10-w.emberHeal);w.player.hp+=heal;w.emberHeal+=heal;}
 if(e.id==='E10')for(let i=0;i<2;i++)if(w.enemies.filter(alive).length+w.zones.filter(z=>z.spawn).length<CONFIG.maxEnemies){
  const p={x:e.x+(i?22:-22),y:e.y},spec:SpawnSpec={...p,id:'E01',elite:false,affix:0,reward:false,cost:0};
  addZone(w,{...p,kind:'circle',radius:20,angle:0,warning:.75,active:.01,damage:0,effect:'spawn'},undefined,'split',spec);}
 if(e.affix===2)addZone(w,{x:e.x,y:e.y,kind:'circle',radius:75,angle:0,warning:.9,active:.15,damage:e.damage},undefined,'elite-pulse');
}
function stagger(w:BattleState,e:EnemyState,amount:number):void {
 if(e.kind!=='boss'||w.time<e.staggerUntil||e.frozen>0)return;
 const shared=w.enemies.find(x=>x.group===e.group&&x.kind==='boss')||e;shared.stagger+=amount;
 if(shared.stagger>=100){shared.stagger=0;shared.frozen=1.5;shared.controlReason='stagger';shared.staggerUntil=w.time+9.5;event(w,'stagger',e,{amount:1.5});}
 for(const other of w.enemies)if(other.group&&other.group===e.group){other.stagger=shared.stagger;other.frozen=shared.frozen;other.controlReason=shared.controlReason;other.staggerUntil=shared.staggerUntil;}
}
function applyStatus(w:BattleState,e:EnemyState,weapon:WeaponState):void {
 if(weapon.id==='W03')e.wet=Math.max(e.wet,3+(protocol(w,'P01')?2:0));
 if(weapon.id==='W06')e.oilUntil=w.time+4;
 if(weapon.id==='W17'||weapon.id==='W05'&&weapon.shotCount%2===0){const layer:BurnLayer={expires:w.time+4,next:w.time+.5,weapon:weapon.uid,damage:1.5};
  if(e.burns.length>=5)e.burns.splice(e.burns.reduce((best,b,i)=>b.expires<e.burns[best]!.expires?i:best,0),1);e.burns.push(layer);}
 if(weapon.id==='W12'||weapon.id==='W16'){
  e.chill++;e.chillUntil=w.time+3;e.chillStrength=weapon.supports.S12?.08:.06;
  if(e.chill>=5){e.chill=0;
   if(e.kind==='boss')stagger(w,e,15+(weapon.supports.S12?TIER_EFFECTS.cryoStagger[weapon.supports.S12-1]!:0));
   else {e.frozen=(e.kind==='elite'?.5:1.2)+support(weapon,'S12');e.controlReason='ice';}}
 }
}
function areaDamage(w:BattleState,p:Point,radius:number,hit:Hit):void {
 const seen:string[]=[];
 for(const e of w.enemies){const key=groupKey(e);if(alive(e)&&distance(e,p)<=radius+e.radius&&!seen.includes(key)){seen.push(key);hitEnemy(w,e,{...hit,origin:p});}}
 event(w,'explosion',p,{amount:radius,radius,source:hit.weapon?.id||hit.kind,color:hit.kind==='oil'?'#F5A24E':'#F6CF86'});
}
/** One resolver for every player-originating damage path, including secondary effects. */
function hitEnemy(w:BattleState,e:EnemyState,hit:Hit):number {
 if(!alive(e)||w.status!=='playing')return 0;
 const weapon=hit.weapon,direct=hit.direct!==false,origin=hit.origin||w.player;
 let add=direct&&weapon?support(weapon,'S01'):0;
 if(w.chassis==='hive')add+=hit.kind==='drone'?.15:weapon&&direct?-.1:0;
 if(direct&&protocol(w,'P03')){const d=distance(w.player,e);add+=d>250?.15:d<120?-.1:0;}
 if(direct&&protocol(w,'P09')&&(e.chill>0||e.frozen>0))add+=.15;
 if(hit.arcFirst&&e.wet>0&&protocol(w,'P01'))add+=.1;
 if(direct&&hit.kind==='drone'&&protocol(w,'P05')&&w.priority===e.eid&&w.priorityUntil>w.time)add+=.2;
 let vulnerable=(hit.kind==='electric'&&e.wet>0?(weapon?.supports.S05?support(weapon,'S05'):.25):0)+(e.vulnerableUntil>w.time?.25:0);
 if(hit.oilExplosion&&e.kind==='boss'&&protocol(w,'P02'))add+=.15;
 const crit=direct&&rand(w)<Math.min(.7,.05+utility(w,'U05'));
 let amount=hit.base*(w.baseDamage??1)*(weapon?scale(weapon.tier):1)*(1+Math.min(2,add))*(hit.factor??1)*(crit?1.5:1)*Math.min(1.75,1+vulnerable)*100/(100+Math.max(0,e.armor-(direct&&weapon?support(weapon,'S07'):0)));
 if(e.id==='E07'&&Math.abs(angleDiff(angleTo(e,origin),e.angle))<Math.PI/3)amount*=.5;
 const actual=Math.min(e.hp,amount);e.hp=Math.max(0,e.hp-amount);syncBossHP(w,e);
 const source=hit.source||weapon?.id||hit.kind;w.stats.damageByModule[source]=(w.stats.damageByModule[source]||0)+actual;
 event(w,crit?'critical':'hit',e,{amount:actual,source,targetId:e.eid,color:MODULE_BY_ID[source]?.color,from:{x:origin.x,y:origin.y},radius:e.radius});
 if(direct&&weapon?.supports.S08&&crit&&w.time>=weapon.rectifierAt){w.player.shield=Math.min(w.player.maxShield,w.player.shield+support(weapon,'S08'));weapon.rectifierAt=w.time+1;}
 if(hit.status&&weapon)applyStatus(w,e,weapon);
 if(hit.kind==='fire'&&!hit.secondary&&e.oilUntil>w.time&&e.oilAt<=w.time){
  e.oilUntil=0;e.oilAt=w.time+2;
  areaDamage(w,e,weapon?.supports.S06?100:80,{base:weapon?.supports.S06?support(weapon,'S06'):18,kind:'oil',weapon,direct:false,secondary:true,oilExplosion:true});
 }
 if(direct&&!hit.secondary&&weapon?.supports.S09&&MODULE_BY_ID[weapon.id]!.tags.includes('爆炸')&&e.burns.length&&(weapon.fuseAt[groupKey(e)]||0)<=w.time){
  weapon.fuseAt[groupKey(e)]=w.time+1;
  if(e.hp>0)hitEnemy(w,e,{base:support(weapon,'S09'),kind:'explosion',weapon,direct:false,secondary:true});
 }
 if(e.hp<=0)killEnemy(w,e,hit.kind,weapon,hit.oilExplosion);
 return actual;
}
/** All enemy damage, including hazards, goes through this protection and death ordering. */
export function damagePlayer(w:BattleState,raw:number,source:string,at:Point=w.player,attack='contact'):number {
 const p=w.player;if(w.status!=='playing'||p.dashTime>0||p.invulnerable>0||raw<=0)return 0;
 const damage=raw*100/(100+p.armor)*(w.capacitorDefense>w.time?.7:1)*(w.chassis==='bulwark'&&(p.skillTime??0)>0?.5:1),beforeShield=p.shield,beforeHP=p.hp;
 const absorbed=Math.min(p.shield,damage);p.shield-=absorbed;p.hp=Math.max(0,p.hp-(damage-absorbed));p.invulnerable=CONFIG.hitGrace;w.lastDamage=w.time;
 const actual=Math.min(damage,beforeShield+beforeHP);w.stats.damageTaken+=actual;w.stats.damageTakenBy[source]=(w.stats.damageTakenBy[source]||0)+actual;
 const byAttack=w.stats.damageTakenByAttack??(w.stats.damageTakenByAttack={});const attackKey=source+':'+attack;byAttack[attackKey]=(byAttack[attackKey]??0)+actual;
 event(w,'player-hit',p,{amount:actual,source,from:{x:at.x,y:at.y},shieldDamage:absorbed,hullDamage:beforeHP-p.hp});
 if(beforeShield>0&&p.shield<=0){event(w,'shield-break',p);
  if(w.utilities.U08&&w.time>=w.capacitorAt){w.capacitorAt=w.time+8;w.capacitorDefense=w.time+1;areaDamage(w,p,150,{base:utility(w,'U08'),kind:'electric',direct:false,secondary:true});}}
 if(protocol(w,'P07')&&!w.emergencyUsed&&beforeHP/p.maxHp>=.35&&p.hp/p.maxHp<.35){w.emergencyUsed=true;p.shield=Math.min(p.maxShield,p.shield+15);}
 if(p.hp<=0){if(w.utilities.U12&&!w.insuranceUsed){w.insuranceUsed=true;p.hp=utility(w,'U12');p.invulnerable=1;event(w,'insurance',p,{amount:p.hp});}else complete(w,false,source);}
 return damage;
}

function targetFor(w:BattleState,weapon:WeaponState):EnemyState|undefined {
 const range=MODULE_BY_ID[weapon.id]!.range||400;
 const valid=(e:EnemyState)=>alive(e)&&distance(e,w.player)<=range+e.radius;
 const priority=w.priorityUntil>w.time?w.enemies.find(e=>e.eid===w.priority&&valid(e)):undefined;if(priority)return priority;
 const previous=weapon.targetUntil>w.time?w.enemies.find(e=>e.eid===weapon.target&&valid(e)):undefined;if(previous)return previous;
 const target=w.enemies.filter(valid).sort((a,b)=>distance(w.player,a)-distance(w.player,b)||a.eid-b.eid)[0];
 weapon.target=target?.eid;weapon.targetUntil=w.time+.4;return target;
}
function makeBullet(w:BattleState,p:Point,angle:number,speed:number,base:number,kind:DamageKind,weapon?:WeaponState,extra:Partial<BulletState>={}):BulletState {
 const range=weapon?MODULE_BY_ID[weapon.id]!.range||400:900;
 const b:BulletState={eid:w.nextId++,x:p.x,y:p.y,vx:Math.cos(angle)*speed,vy:Math.sin(angle)*speed,radius:CONFIG.bulletRadius,damage:base,life:range/speed,
  color:weapon?MODULE_BY_ID[weapon.id]!.color:'#EF7869',owner:weapon?'player':'enemy',weapon:weapon?.id,weaponUid:weapon?.uid,kind,factor:1,shot:w.nextShot++,hitAt:{},pierce:1,
  bounces:weapon?.supports.S04?2:0,bounceFactor:weapon?support(weapon,'S04'):0,traveled:0,range,slow:0,applyStatus:true,source:weapon?.id||'projectile',...extra};
 if(b.bounces)b.life=range/speed*3;w.bullets.push(b);return b;
}
function fireWeapon(w:BattleState,weapon:WeaponState,target:EnemyState,extra=false):void {
 const def=MODULE_BY_ID[weapon.id]!,origin=w.player,a=angleTo(origin,target);weapon.angle=a;weapon.x=origin.x;weapon.y=origin.y;
 if(!extra)weapon.shotCount++;
 let factor=1;if(weapon.supports.S11&&w.time-w.lastDash<=2&&!weapon.springUsed){factor=1+TIER_EFFECTS.springDamage[weapon.supports.S11-1]!;weapon.springUsed=true;}
 event(w,'fire',origin,{source:weapon.id,targetId:target.eid,angle:a,to:{x:target.x,y:target.y},radius:(def.range||100)*(1+support(weapon,'S11'))});
 if(def.attack==='beam'){
  let length=def.range!;while(length>0&&!clearPath(origin,{x:origin.x+Math.cos(a)*length,y:origin.y+Math.sin(a)*length},w.obstacles,0))length-=8;
  const end={x:origin.x+Math.cos(a)*length,y:origin.y+Math.sin(a)*length};w.events[w.events.length-1].radius=length;
  const seen=new Set<string>();for(const enemy of w.enemies.filter(e=>alive(e)&&segmentDistance(e,origin,end)<=e.radius+5&&distance(e,origin)<=length+e.radius).sort((x,y)=>distance(x,origin)-distance(y,origin))){
   if(seen.has(groupKey(enemy)))continue;seen.add(groupKey(enemy));hitEnemy(w,enemy,{base:def.damage!,kind:'electric',weapon,factor});if(seen.size>=5)break;
  }
 }else if(def.attack==='pulse'){
  areaDamage(w,origin,def.range!,{base:def.damage!,kind:'electric',weapon,factor});
 }else if(weapon.id==='W04'){
  const maximum=Math.min(5,3+(target.wet>0?1:0)+(weapon.supports.S05?1:0)),seen:string[]=[];let current:EnemyState|undefined=target,previous:Point=origin;
  for(let chain=0;chain<maximum&&current;chain++){
   seen.push(groupKey(current));event(w,'arc',previous,{targetId:current.eid,source:weapon.id,color:def.color,to:{x:current.x,y:current.y}});
   hitEnemy(w,current,{base:chain===0?10:6,kind:'electric',weapon,factor,status:true,arcFirst:chain===0});previous={x:current.x,y:current.y};
   current=w.enemies.filter(e=>alive(e)&&!seen.includes(groupKey(e))&&distance(e,previous)<=140).sort((x,y)=>distance(x,previous)-distance(y,previous)||x.eid-y.eid)[0];
  }
  w.stats.maxChain=Math.max(w.stats.maxChain,seen.length);
 }else if(weapon.id==='W05'||weapon.id==='W08'||weapon.id==='W09'){
  const range=(def.range||100)*(1+support(weapon,'S11')),angle=weapon.id==='W09'?Math.PI*2:weapon.id==='W05'?Math.PI/2:Math.PI*2/3;
  const seen:string[]=[];let hits=0;
  for(const e of [...w.enemies].sort((x,y)=>distance(x,origin)-distance(y,origin))){const key=groupKey(e);
   if(!alive(e)||seen.includes(key)||distance(e,origin)>range+e.radius||Math.abs(angleDiff(angleTo(origin,e),a))>angle/2)continue;
   if(weapon.id==='W09'&&hits>=6)break;seen.push(key);hits++;
   hitEnemy(w,e,{base:def.damage||0,kind:weapon.id==='W05'?'fire':'melee',weapon,factor,status:true});
   if(weapon.id==='W08'&&alive(e)){if(e.kind==='boss')stagger(w,e,20);else{const dir=angleTo(origin,e),push=e.kind==='elite'?20:40;move(w,e,Math.cos(dir)*push,Math.sin(dir)*push);}}
  }
  const z=addZone(w,{...origin,kind:weapon.id==='W09'?'circle':'cone',radius:range,angle:a,width:angle,warning:0,active:.12,damage:0});z.type='friendly';z.active=true;z.remaining=.12;z.duration=.12;z.color=def.color;
 }else if(def.attack==='drone'){
  for(let i=0;i<weapon.droneCount;i++){
   const orbit=w.time*1.2+(i/Math.max(1,weapon.droneCount))*Math.PI*2+(w.weapons.indexOf(weapon)%2?Math.PI/3:0),p={x:origin.x+Math.cos(orbit)*48,y:origin.y+Math.sin(orbit)*48};
   makeBullet(w,p,angleTo(p,target),CONFIG.droneSpeed,weapon.id==='W18'?5:4,'drone',weapon,{factor:weapon.supports.S10?support(weapon,'S10'):1});
  }
 }else{
  const split=Boolean(weapon.supports.S03)&&def.tags.includes('单弹');
  const count=weapon.id==='W02'?5:weapon.id==='W16'?4:split?2:1,spread=weapon.id==='W02'?Math.PI*2/9:weapon.id==='W16'?Math.PI*5/18:split?.14:0;
  const speed=weapon.id==='W03'?CONFIG.waterSpeed:['W12','W16'].includes(weapon.id)?CONFIG.iceSpeed:weapon.id==='W06'?CONFIG.oilSpeed:['W10','W17'].includes(weapon.id)?CONFIG.missileSpeed:weapon.id==='W07'?1700:CONFIG.bulletSpeed;
  const kind:DamageKind=weapon.id==='W03'?'water':['W12','W16'].includes(weapon.id)?'ice':weapon.id==='W06'?'oil':weapon.id==='W10'?'explosion':weapon.id==='W17'?'fire':'ballistic';
  for(let i=0;i<count;i++){
   const angle=a+(count>1?(i/(count-1)-.5)*spread:0),base=weapon.id==='W02'?5:weapon.id==='W16'?4:def.damage||0;
   // Start collision travel at the body center; a visual muzzle offset must never skip an overlapping enemy.
   makeBullet(w,{x:origin.x,y:origin.y},angle,speed,base,kind,weapon,
    {factor:factor*(split?support(weapon,'S03'):1),pierce:weapon.id==='W07'?3:1,...(['W06','W10','W17'].includes(weapon.id)?{target:{x:target.x,y:target.y},radius:6}:{} )});
  }
 }
 if(!extra&&w.utilities.U10&&def.attack!=='drone'&&weapon.shotCount%utility(w,'U10')===0)fireWeapon(w,weapon,target,true);
}
function tickWeapons(w:BattleState,dt:number):void {
 for(const weapon of w.weapons){weapon.x=w.player.x;weapon.y=w.player.y;weapon.cooldown=Math.max(0,weapon.cooldown-dt);if(weapon.cooldown>1e-8||w.status!=='playing')continue;
  const target=targetFor(w,weapon);if(!target)continue;
  fireWeapon(w,weapon,target);
  let speed=support(weapon,'S02')+(w.player.overloadTime>0?.35:0)+(protocol(w,'P07')&&w.player.hp/w.player.maxHp<.35?.2:0);
  if(protocol(w,'P06')&&w.time-w.lastDash<=3&&MODULE_BY_ID[weapon.id]!.tags.includes('实弹'))speed+=.2;
  weapon.cooldown=Math.max(weapon.id==='W13'?.04:.08,(MODULE_BY_ID[weapon.id]!.interval||1)/((w.baseAttackSpeed??1)*(1+Math.min(1.5,speed))));
 }
}
function segmentDistance(p:Point,a:Point,b:Point):number {
 const dx=b.x-a.x,dy=b.y-a.y,t=clamp(((p.x-a.x)*dx+(p.y-a.y)*dy)/(dx*dx+dy*dy||1),0,1);
 return Math.hypot(p.x-a.x-dx*t,p.y-a.y-dy*t);
}
function tickBullets(w:BattleState,dt:number):void {
 for(const b of w.bullets){if(b.life<=0||w.status!=='playing')continue;const before={x:b.x,y:b.y};b.life-=dt;b.x+=b.vx*dt;b.y+=b.vy*dt;b.traveled+=Math.hypot(b.vx,b.vy)*dt;
  const weapon=b.weaponUid?w.weapons.find(a=>a.uid===b.weaponUid):undefined;
  if(b.target&&distance(before,b.target)<=Math.hypot(b.vx,b.vy)*dt+7){
   areaDamage(w,b.target,weapon?.id==='W17'?105:b.kind==='oil'?70:75,{base:b.damage,kind:b.kind,weapon,factor:b.factor,status:true});b.life=0;continue;
  }
  const wallX=b.x<b.radius||b.x>w.width-b.radius,wallY=b.y<b.radius||b.y>w.height-b.radius,obstacle=w.obstacles.find(r=>circleHitsRect(b,b.radius,r));
  if(wallX||wallY||obstacle){
   if(b.bounces>0){b.bounces--;b.factor*=b.bounceFactor;b.traveled=0;
    if(wallX||obstacle&&!circleHitsRect({x:before.x,y:b.y},b.radius,obstacle))b.vx*=-1;
    else if(wallY||obstacle)b.vy*=-1;b.x=clamp(before.x,b.radius,w.width-b.radius);b.y=clamp(before.y,b.radius,w.height-b.radius);event(w,'ricochet',b,{source:b.weapon});
   }else {if(b.target&&weapon)areaDamage(w,b,weapon?.id==='W17'?105:b.kind==='oil'?70:75,{base:b.damage,kind:b.kind,weapon,factor:b.factor,status:true});b.life=0;}continue;
  }
  if(b.traveled>b.range){if(b.target&&weapon)areaDamage(w,b,weapon?.id==='W17'?105:b.kind==='oil'?70:75,{base:b.damage,kind:b.kind,weapon,factor:b.factor,status:true});b.life=0;continue;}
  if(b.owner==='enemy'){
   if(w.decoy&&w.decoy.until>w.time&&segmentDistance(w.decoy,before,b)<16+b.radius){w.decoy.hp-=b.damage;b.life=0;continue;}
   if(segmentDistance(w.player,before,b)<w.player.radius+b.radius){const taken=damagePlayer(w,b.damage,b.source,b,'projectile');if(taken>0&&b.slow>0){w.slowUntil=w.time+2;w.slowAmount=b.slow;}b.life=0;}
  }else if(!b.target){
   // Sort only actual contacts. Dense volleys previously sorted every living enemy
   // for every projectile, even when the swept segment touched nothing.
   const contacts=w.enemies.filter(e=>alive(e)&&(b.hitAt[groupKey(e)]??-100)<=w.time-.3&&segmentDistance(e,before,b)<=e.radius+b.radius);
   for(const e of contacts.sort((a,z)=>distance(before,a)-distance(before,z)||a.eid-z.eid)){
    const key=groupKey(e);if((b.hitAt[key]??-100)>w.time-.3||segmentDistance(e,before,b)>e.radius+b.radius)continue;
    b.hitAt[key]=w.time;hitEnemy(w,e,{base:b.damage,kind:b.kind,weapon,factor:b.factor,status:b.applyStatus,origin:before});
    b.pierce--;if(weapon?.id==='W07')b.factor*=.75;
    if(b.pierce<=0){if(b.bounces>0&&weapon?.id!=='W07'){b.pierce=1;break;}b.life=0;break;}
   }
  }
 }
 w.bullets=w.bullets.filter(b=>b.life>0);
}


function difficultyDamage(w:BattleState):number{return w.difficulty>=4?1.15:w.difficulty>=2?1.1:1;}
function triggerZone(w:BattleState,z:ZoneState):void {
 const plan=z.plan,source=w.enemies.find(e=>e.eid===z.sourceId);
 if(z.spawn){spawnEnemy(w,z.spawn);z.remaining=0;return;}
 event(w,'enemy-attack',z,{source:z.source,targetId:z.sourceId,angle:z.angle,radius:z.radius,cue:plan.effect??z.kind,shape:plan.kind,w:plan.w,h:plan.h,width:plan.width,innerRadius:plan.innerRadius,gapAngle:plan.gapAngle,gapWidth:plan.gapWidth});
 if(plan.effect==='spawn'){
  const existing=w.enemies.filter(e=>alive(e)&&e.id===plan.enemy&&e.summon).length,count=Math.min(plan.count||1,(plan.limit||8)-existing,CONFIG.maxEnemies-w.enemies.filter(alive).length);
  for(let i=0;i<count;i++){const a=(i/Math.max(1,count))*Math.PI*2,p={x:clamp(z.x+Math.cos(a)*120,40,w.width-40),y:clamp(z.y+Math.sin(a)*120,40,w.height-40)};
   const s:SpawnSpec={...p,id:plan.enemy||'E01',elite:false,affix:0,reward:false,cost:0};const e=spawnEnemy(w,s);if(plan.spawnHp)e.hp=e.maxHp=plan.spawnHp*[1,1.1,1.1,1.2,1.3][clamp(w.difficulty,0,4)]!;if(plan.spawnDamage)e.damage=plan.spawnDamage*difficultyDamage(w);}
  z.remaining=0;
 }else if(plan.effect==='projectile'){
  const count=plan.count||1,spread=plan.spread||0;
  for(let i=0;i<count;i++){const offset=count<=1?0:spread>=Math.PI*2-.01?i/count*spread:((i/(count-1))-.5)*spread;
   makeBullet(w,z,z.angle+offset,plan.speed||CONFIG.enemyShotSpeed,plan.damage,'ballistic',undefined,{owner:'enemy',source:z.source,slow:plan.slow||0,radius:plan.projectileRadius||5,life:5,range:1200});}
  event(w,'enemy-fire',z,{source:z.source,targetId:z.sourceId,angle:z.angle});z.remaining=0;
 }else if(plan.effect==='charge'&&source){source.charge={vx:Math.cos(z.angle)*(plan.speed||260),vy:Math.sin(z.angle)*(plan.speed||260),until:w.time+plan.active,damage:plan.damage,radius:(plan.h||source.radius*2)/2};}
 else if(plan.effect==='drill'&&source){source.x=z.x;source.y=z.y;source.aiUntil=0;source.path=[];}
}
function tickZones(w:BattleState,dt:number):void {
 for(const z of w.zones){if(w.status!=='playing')break;
  if(z.type==='friendly'){z.remaining-=dt;continue;}
  if(z.delay>0){z.delay-=dt;if(z.delay<=0&&z.plan.effect==='charge'){
    const e=w.enemies.find(e=>e.eid===z.sourceId);if(e){z.x=e.x;z.y=e.y;z.angle=z.plan.lockTarget?z.plan.angle:angleTo(e,w.player);z.originalAngle=z.angle;z.plan.x=z.x;z.plan.y=z.y;z.plan.angle=z.angle;}}
   continue;}
  if(z.sourceId!==undefined&&!w.enemies.some(e=>e.eid===z.sourceId&&alive(e))&&z.plan.effect!=='fire'){z.remaining=0;continue;}
  z.remaining-=dt;
  if(z.active&&z.remaining<=0&&z.source==='B2A'&&z.kind==='cone'&&z.plan.effect!=='projectile')for(const e of w.enemies)if(e.id==='B2A')e.vulnerableUntil=w.time+3;
  if(!z.active){if(z.remaining>0)continue;z.active=true;z.type='hazard';z.duration=z.plan.active;z.remaining=z.plan.active;z.age=0;z.kind=z.plan.kind;z.radius=z.plan.radius;z.width=z.plan.width;z.angle=z.plan.angle;triggerZone(w,z);}
  if(z.remaining<=0)continue;z.age+=dt;
  if(z.plan.sweep)z.angle=z.originalAngle+z.plan.sweep*Math.min(1,z.age/z.plan.active);
  if(z.plan.grow){z.radius=z.plan.radius+z.plan.grow*z.age;z.innerRadius=Math.max(0,z.radius-22);}
  if(z.plan.effect==='charge')continue;
  if(z.plan.effect==='pull'&&contains(z,w.player,w.player.radius)){const a=angleTo(w.player,z);move(w,w.player,Math.cos(a)*(z.plan.speed||60)*dt,Math.sin(a)*(z.plan.speed||60)*dt);continue;}
  if(z.plan.effect==='conveyor'&&contains(z,w.player,w.player.radius)){move(w,w.player,Math.cos(z.angle)*(z.plan.speed||50)*dt,Math.sin(z.angle)*(z.plan.speed||50)*dt);continue;}
  // Check moving hazards every simulation tick. The interval limits successful
  // damage, not collision sampling: a sweep must not pass through a player
  // between global pulse times without hitting them.
  z.pulse=Math.max(0,z.pulse-dt);
  if(z.pulse<=0&&contains(z,w.player,w.player.radius)){
   const amount=z.plan.effect==='fire'&&z.triggered?6*BOSS_DAMAGE_SCALE*difficultyDamage(w):z.plan.damage;
   if(damagePlayer(w,amount,z.source,z,z.kind)>0)z.pulse=z.plan.period||1000;
  }
  if(z.source==='E05'&&!z.triggered){const e=w.enemies.find(e=>e.eid===z.sourceId);if(e){e.dead=true;e.hp=0;event(w,'enemy-explosion',e,{source:e.id,targetId:e.eid,amount:z.radius});}}
  z.triggered=true;
 }
 w.zones=w.zones.filter(z=>z.delay>0||z.remaining>0);
}

function tickEnemyStatuses(w:BattleState,dt:number):void {
 for(const e of [...w.enemies]){if(!alive(e))continue;
  e.wet=Math.max(0,e.wet-dt);e.frozen=Math.max(0,e.frozen-dt);if(!e.frozen)delete e.controlReason;if(e.chillUntil<=w.time)e.chill=0;
  for(const layer of [...e.burns]){
   if(layer.next<=w.time&&layer.next<=layer.expires){layer.next+=.5;const weapon=w.weapons.find(v=>v.uid===layer.weapon);
    hitEnemy(w,e,{base:layer.damage,kind:'fire',weapon,direct:false});}
  }
  e.burns=e.burns.filter(b=>b.expires>w.time);
 }
}
function tickEnemies(w:BattleState,dt:number):void {
 for(const e of [...w.enemies]){
  if(!alive(e)||e.frozen>0)continue;
  if(e.charge&&e.charge.until>w.time){const slow=1-enemySlow(w,e),blocked=move(w,e,e.charge.vx*dt*slow,e.charge.vy*dt*slow);
   e.angle=Math.atan2(e.charge.vy,e.charge.vx);
   if(e.kind==='boss'&&w.bossCenter){w.bossCenter.x=e.x;w.bossCenter.y=e.y;}
   if(blocked){e.charge.until=0;e.frozen=e.kind==='boss'?2:1.5;e.controlReason='impact';event(w,'stagger',e,{source:e.id,amount:e.frozen});}continue;}
  if(e.kind==='boss')continue;
  e.cooldown=Math.max(0,e.cooldown-dt);
  const target=w.decoy&&w.decoy.until>w.time&&w.decoy.hp>0?w.decoy:w.player,d=distance(e,target),a=angleTo(e,target);
  const speed=e.speed*(1-enemySlow(w,e));
  if(e.healingUntil>w.time){for(const other of w.enemies)if(alive(other)&&other.kind!=='boss'&&other.eid!==e.eid&&distance(e,other)<220)other.hp=Math.min(other.maxHp,other.hp+6*dt);continue;}
  if(e.aiUntil>w.time)continue;
  const sight=clearPath(e,target,w.obstacles,5,w.width,w.height);
  const aim=(lead:number)=>angleTo(e,{x:target.x+(target===w.player?(w.playerVelocity?.x??0)*lead:0),y:target.y+(target===w.player?(w.playerVelocity?.y??0)*lead:0)});
  if(e.id==='E04'||e.id==='E09'||e.id==='E07'){
   const tether=e.id==='E09',guard=e.id==='E07',range=guard?430:420;
   if(d<=range&&sight&&e.cooldown<=0){e.angle=aim(tether?.2:.12);e.cooldown=tether?3.2:guard?3.4:2.4;e.aiUntil=w.time+.7;
    addZone(w,{x:e.x,y:e.y,kind:guard||tether?'cone':'line',radius:guard||tether?range:0,width:guard?.26:tether?.18:undefined,w:range,h:12,angle:e.angle,warning:.7,active:.05,damage:e.damage*(guard?.65:1),effect:'projectile',count:tether?2:guard?3:1,spread:tether?.14:guard?.22:0,speed:tether?240:280,slow:tether?.3:0,projectileRadius:tether?7:5},e.eid,e.id);
   }else if(d>range*.65||!sight)follow(w,e,target,speed,dt);
   else if(d<150&&!guard){e.angle=a;const blocked=move(w,e,-Math.cos(a)*speed*dt,-Math.sin(a)*speed*dt);if(blocked)move(w,e,-Math.sin(a)*speed*dt,Math.cos(a)*speed*dt);}
   else e.angle=a;
  }else if(e.id==='E05'){
   if(d<95&&e.cooldown<=0){e.aiUntil=w.time+2;e.cooldown=1000;addZone(w,{x:e.x,y:e.y,kind:'circle',radius:70,angle:0,warning:.8,active:.1,damage:e.damage},e.eid,e.id);}
   else follow(w,e,target,speed,dt);
  }else if(e.id==='E06'){
   const ally=w.enemies.filter(o=>alive(o)&&o.kind!=='boss'&&o.eid!==e.eid).sort((a,b)=>(a.hp/a.maxHp)-(b.hp/b.maxHp)||distance(e,a)-distance(e,b))[0];
   if(ally){if(distance(e,ally)>160)follow(w,e,ally,speed,dt);if(e.cooldown<=0&&distance(e,ally)<220){e.cooldown=3;e.healingUntil=w.time+2;event(w,'heal',e,{source:e.id,targetId:ally.eid});}}
   else if(d<=400&&sight&&e.cooldown<=0){e.angle=a;e.cooldown=3.5;e.aiUntil=w.time+.8;
    addZone(w,{...e,kind:'line',radius:0,w:400,h:10,angle:a,warning:.8,active:.05,damage:8*difficultyDamage(w),effect:'projectile',count:1,speed:220},e.eid,e.id);
   }else if(d>260||!sight)follow(w,e,target,speed,dt);else e.angle=a;
  }else if(e.id==='E08'){
   if(e.cooldown<=0&&d<650){e.cooldown=5;e.aiUntil=w.time+1.1;
    addZone(w,{x:target.x,y:target.y,kind:'circle',radius:48,angle:0,warning:1,active:.1,damage:e.damage,effect:'drill'},e.eid,e.id);}
   else follow(w,e,target,speed,dt);
  }else if(e.id==='E10'){
   if(e.cooldown<=0&&d<550){e.cooldown=4.5;e.aiUntil=w.time+1.1;e.angle=a;
    addZone(w,{x:target.x,y:target.y,kind:'circle',radius:62,angle:0,warning:1.1,active:.15,damage:e.damage*.85,effect:'mortar'},e.eid,e.id);
   }else if(d>250)follow(w,e,target,speed,dt);else e.angle=a;
  }else if(e.id==='E11'){
   if(e.cooldown<=0&&d<560&&sight){e.cooldown=3.6;e.aiUntil=w.time+.9;e.angle=aim(.2);
    addZone(w,{x:e.x,y:e.y,kind:'cone',radius:560,width:1.05,angle:e.angle,warning:.9,active:.05,damage:e.damage*.8,effect:'projectile',count:5,spread:1.05,speed:240,projectileRadius:7},e.eid,e.id);
   }else if(d>350||!sight)follow(w,e,target,speed,dt);
   else {e.angle=a;if(d<180)move(w,e,-Math.cos(a)*speed*dt,-Math.sin(a)*speed*dt);}
  }else if(e.id==='E13'){
   // Approach from alternating flanks, then commit to a short, dodgeable lunge.
   if(d<285&&sight&&e.cooldown<=0){e.cooldown=3.4;e.aiUntil=w.time+.95;e.angle=a;
    addZone(w,{x:e.x,y:e.y,kind:'rect',radius:0,w:240,h:28,angle:a,warning:.6,active:.6,damage:e.damage,effect:'charge',speed:400},e.eid,e.id);
   }else {const side=e.eid%2?1:-1,flank=a+side*(d>130?.6:0);follow(w,e,{x:target.x-Math.cos(flank)*75,y:target.y-Math.sin(flank)*75},speed,dt);}
  }else if(e.id==='E14'){
   if(d<740&&sight&&e.cooldown<=0){e.cooldown=4.4;e.aiUntil=w.time+1.5;e.angle=aim(.12);
    addZone(w,{x:e.x,y:e.y,kind:'line',radius:0,w:740,h:10,angle:e.angle,warning:1.25,active:.05,damage:e.damage,effect:'projectile',count:1,speed:620,projectileRadius:4},e.eid,e.id);
   }else if(d>580||!sight)follow(w,e,target,speed,dt);
   else {e.angle=a;if(d<300)move(w,e,-Math.cos(a)*speed*dt,-Math.sin(a)*speed*dt);}
  }else if(e.id==='E15'){
   if(e.cooldown<=0&&d<540){e.cooldown=5.2;e.aiUntil=w.time+1.2;e.angle=a;
    // Two stationary mines straddle the marked position, leaving a central escape lane.
    for(const side of [-1,1]){const p={x:clamp(target.x-Math.sin(a)*side*95,60,w.width-60),y:clamp(target.y+Math.cos(a)*side*95,60,w.height-60)};
     if(traversable(p,38,w.obstacles))addZone(w,{...p,kind:'circle',radius:48,angle:0,warning:1.2,active:2.2,damage:e.damage,period:1,effect:'mortar'},e.eid,e.id);}
   }else if(d>360||!sight)follow(w,e,target,speed,dt);else e.angle=a;
  }else if(e.id==='E16'){
   if(e.cooldown<=0&&d<500){e.cooldown=4.8;e.aiUntil=w.time+1.3;e.angle=a;
    addZone(w,{x:e.x,y:e.y,kind:'circle',radius:90,angle:a,warning:1,active:.05,damage:e.damage,effect:'projectile',count:10,spread:Math.PI*2,speed:185,projectileRadius:6},e.eid,e.id);
   }else if(d>300||!sight)follow(w,e,target,speed,dt);else e.angle=a;
  }else if(e.id==='E12'){
   if(e.cooldown<=0&&d<650){e.cooldown=6;e.aiUntil=w.time+2.5;e.angle=a;
    addZone(w,{x:e.x,y:e.y,kind:'rect',radius:0,w:390,h:65,angle:a,warning:1,active:1.5,damage:e.damage,effect:'charge',speed:260},e.eid,e.id);}
   else follow(w,e,target,speed,dt);
  }else follow(w,e,target,speed,dt);
 }
 // Soft separation uses the same world collision helper, so crowds cannot push units through walls.
 for(let i=0;i<w.enemies.length;i++){const a=w.enemies[i]!;if(!alive(a)||a.kind==='boss')continue;
  for(let j=i+1;j<w.enemies.length;j++){const b=w.enemies[j]!;if(!alive(b)||b.kind==='boss')continue;
   const d=distance(a,b),minimum=(a.radius+b.radius)*.85;if(d>=minimum)continue;const angle=d>.001?angleTo(b,a):((a.eid*1.7+b.eid)%6.28),push=Math.min(2,(minimum-d)/2);
   move(w,a,Math.cos(angle)*push,Math.sin(angle)*push);move(w,b,-Math.cos(angle)*push,-Math.sin(angle)*push);
  }
 }
}
function tickBoss(w:BattleState,dt:number):void {
 if(!w.bossId)return;const bodies=w.enemies.filter(e=>e.kind==='boss'&&!e.dead),root=bodies[0];if(!root)return;
 const overload=[90,110,130][w.act-1]!;
 if(w.time>=overload-10&&!w.bossOverloadWarned){w.bossOverloadWarned=true;event(w,'boss-overload-warning',root,{amount:10});}
 if(w.time>=overload&&!w.bossEnraged){w.bossEnraged=true;event(w,'boss-overload',root);}
 if(root.frozen>0)return;w.bossClock-=dt;
 if(w.bossClock<=0){
  const phase=bossPhase(w.bossId,root.hp/root.maxHp);
  if(phase!==root.phase){event(w,'phase',root,{amount:phase,source:root.id});for(const b of bodies){b.phase=phase;if(b.id==='B3B'&&b.offsetX)b.exposed=phase>=2;}}
  const sequence=Math.floor(w.bossTurn/6)*6+bossAttackSlot(w.bossTurn),proposed=bossTurn(w.bossId,phase,sequence,w.bossCenter||root,w.player,w.difficulty,w.bossEnraged,w.playerVelocity);
  const turn=proposed.combo?guardBossTurn(w,proposed):proposed;
  if(!turn){w.bossClock=.6;return;}w.bossTurn++;
  if(turn.combo){const [name,en,hint,hintEn]=turn.combo;w.bossIntent={name,en,hint,hintEn,recoverAt:w.time+turn.duration,until:w.time+turn.duration+turn.recovery};}else delete w.bossIntent;
  for(const plan of turn.plans)addZone(w,{...plan,damage:plan.damage*(w.difficulty>=4?1.15:w.difficulty>=2?1.1:1)},root.eid,w.bossId);
  w.bossClock=turn.duration+turn.recovery;
 }else if(!(w.bossIntent&&w.time<w.bossIntent.until)&&!w.zones.some(z=>z.sourceId===root.eid&&z.plan.effect!=='fire'&&z.plan.effect!=='conveyor')&&(!root.charge||root.charge.until<=w.time)){
  const center=w.bossCenter||root,a=angleTo(center,w.player),d=distance(center,w.player),speed=bossPursuitSpeed(root.speed,root.phase,w.difficulty,w.bossEnraged)*(1-enemySlow(w,root));
  if(d>240){center.x=clamp(center.x+Math.cos(a)*speed*dt,190,w.width-190);center.y=clamp(center.y+Math.sin(a)*speed*dt,150,w.height-150);}
  for(const e of bodies){e.x=center.x+e.offsetX;e.y=center.y;e.angle=a;}
 }
}
function contactDamage(w:BattleState):void {
 for(const e of w.enemies){if(!alive(e)||e.frozen>0||w.time-e.born<CONFIG.spawnGrace||w.time<e.contactAt||e.damage<=0)continue;
  if(w.decoy&&w.decoy.until>w.time&&e.kind!=='boss'&&distance(e,w.decoy)<e.radius+16){w.decoy.hp-=e.damage;e.contactAt=w.time+1;continue;}
  const charging=e.charge&&e.charge.until>w.time;
  if(distance(e,w.player)<(charging?e.charge!.radius:e.radius)+w.player.radius&&damagePlayer(w,charging?e.charge!.damage:e.damage,e.id,e,charging?'charge':'contact')>0)e.contactAt=w.time+1;
 }
}
function activateSkill(w:BattleState):void {
 const p=w.player,skill=chassisSkill(w.chassis);p.skillCooldown=skill.cooldown;p.skillTime=skill.duration;
 event(w,'skill',p,{source:w.chassis,color:skill.color,radius:w.chassis==='scavenger'?320:w.chassis==='bulwark'?180:65});
 if(w.chassis==='scavenger'){const heal=Math.min(6,p.maxHp-p.hp);p.hp+=heal;if(heal>0)event(w,'heal',p,{amount:heal,source:'skill-scavenger'});}
 if(w.chassis==='bulwark')areaDamage(w,p,180,{base:36,kind:'melee',direct:false,source:'skill-bulwark'});
 if(w.chassis==='kestrel'){p.dashCooldown=0;p.invulnerable=Math.max(p.invulnerable,.45);}
 if(w.chassis==='hive')w.skillPulseAt=w.time;
}
function tickSkill(w:BattleState):void {
 if(w.chassis!=='hive'||(w.player.skillTime??0)<=1e-8||w.time+1e-8<(w.skillPulseAt??0))return;
 w.skillPulseAt=w.time+.6/(w.baseAttackSpeed??1);
 for(let i=0;i<3;i++){
  let target:EnemyState|undefined,best=Infinity;
  for(const e of w.enemies){if(!alive(e))continue;const d=distance(w.player,e);if(d>450+e.radius)continue;
   if(e.eid===w.priority&&w.priorityUntil>w.time){target=e;break;}if(d<best){target=e;best=d;}}
  if(!target)break;
  const a=w.time*1.8+i*Math.PI*2/3,origin={x:w.player.x+Math.cos(a)*62,y:w.player.y+Math.sin(a)*62};
  event(w,'arc',origin,{source:'skill-hive',to:{x:target.x,y:target.y},color:chassisSkill('hive').color,targetId:target.eid});
  hitEnemy(w,target,{base:6,kind:'drone',direct:false,source:'skill-hive',origin});
 }
}
function tickPlayer(w:BattleState,input:InputFrame,dt:number):void {
 const p=w.player,wasDashing=p.dashTime>0,previous={x:p.x,y:p.y};
 p.dashCooldown=Math.max(0,p.dashCooldown-dt);p.overloadCooldown=Math.max(0,p.overloadCooldown-dt);p.dashTime=Math.max(0,p.dashTime-dt);p.overloadTime=Math.max(0,p.overloadTime-dt);p.invulnerable=Math.max(0,p.invulnerable-dt);
 p.skillCooldown=Math.max(0,(p.skillCooldown??0)-dt);p.skillTime=Math.max(0,(p.skillTime??0)-dt);
 if(input.target){const chosen=w.enemies.filter(alive).sort((a,b)=>distance(a,input.target!)-distance(b,input.target!))[0];if(chosen&&distance(chosen,input.target)<chosen.radius+55){w.priority=chosen.eid;w.priorityUntil=w.time+2;}}
 if(w.priorityUntil<=w.time||!w.enemies.some(e=>e.eid===w.priority&&alive(e)))w.priority=undefined;
 if(wasDashing&&p.dashTime===0&&w.utilities.U11&&w.time>=w.decoyAt){w.decoyAt=w.time+10;w.decoy={...w.dashOrigin,hp:TIER_EFFECTS.decoyHP[w.utilities.U11-1]!,until:w.time+utility(w,'U11')};event(w,'decoy',w.decoy);}
 if(w.decoy&&(w.decoy.until<=w.time||w.decoy.hp<=0))w.decoy=undefined;
 const length=Math.hypot(input.x,input.y),x=length>1?input.x/length:input.x,y=length>1?input.y/length:input.y;
 if(input.skill&&w.skillReleased!==false&&p.skillCooldown<=0)activateSkill(w);
 w.skillReleased=!input.skill;
 if(input.dash&&w.dashReleased&&p.dashCooldown<=0){w.dashAngle=length>.01?Math.atan2(y,x):p.angle;p.dashTime=.18;p.dashCooldown=w.dashBase;w.dashOrigin={x:p.x,y:p.y};w.lastDash=w.time;
  for(const weapon of w.weapons)weapon.springUsed=false;event(w,'dash',p);}
 if(input.overload&&w.overloadReleased&&p.overloadCooldown<=0){p.overloadTime=4;p.overloadCooldown=20;event(w,'overload',p);}
 w.dashReleased=!input.dash;w.overloadReleased=!input.overload;
 if(p.dashTime>0){p.angle=w.dashAngle;move(w,p,Math.cos(w.dashAngle)*p.speed*3.2*dt,Math.sin(w.dashAngle)*p.speed*3.2*dt);}
 else {const slow=w.slowUntil>w.time?w.slowAmount:0,boost=w.chassis==='kestrel'&&p.skillTime>0?1.35:1;if(length>.01)p.angle=Math.atan2(y,x);move(w,p,x*p.speed*(1-slow)*boost*dt,y*p.speed*(1-slow)*boost*dt);}
 w.playerVelocity={x:(p.x-previous.x)/dt,y:(p.y-previous.y)/dt};
 if(w.time-w.lastDamage>=4)p.shield=Math.min(p.maxShield,p.shield+w.shieldRegen*dt);
 if(w.utilities.U03&&w.time>=w.repairAt){w.repairAt+=10;const cap=TIER_EFFECTS.repairCap[w.utilities.U03-1]!,heal=Math.max(0,Math.min(utility(w,'U03'),p.maxHp-p.hp,cap-w.repairAmount));p.hp+=heal;w.repairAmount+=heal;if(heal)event(w,'heal',p,{amount:heal,source:'U03'});}
 const pickup=Math.max((w.chassis==='scavenger'?90:CONFIG.pickupBase)+utility(w,'U04'),w.chassis==='scavenger'&&p.skillTime>0?320:0);
 w.drops=w.drops.filter(drop=>{if(distance(drop,p)>pickup)return true;w.stats.goldEarned+=drop.value;event(w,'pickup',drop,{amount:drop.value,to:{x:p.x,y:p.y}});
  if(w.utilities.U04&&w.time>=w.pickupAt){p.dashCooldown=Math.max(0,p.dashCooldown-.2);w.pickupAt=w.time+1;}return false;});
}
function stepFixed(w:BattleState,input:InputFrame,dt:number):void {
 if(w.status!=='playing')return;
 if(!w.bossId&&w.time+dt>=w.duration-1e-8){w.time=w.duration;w.tick++;complete(w,true);return;}
 w.time+=dt;w.tick++;
 if(w.bossId&&w.time>=300){complete(w,false,'timeout');return;}
 tickPlayer(w,input,dt);tickSpawns(w);tickEnemyStatuses(w,dt);tickEnemies(w,dt);tickBoss(w,dt);tickSkill(w);tickWeapons(w,dt);tickBullets(w,dt);tickZones(w,dt);contactDamage(w);
 if(w.status==='playing'&&w.bossStarted&&!w.enemies.some(e=>e.kind==='boss'&&e.hp>0&&!e.dead))complete(w,true);
 w.enemies=w.enemies.filter(e=>!e.dead);
 w.events=w.events.filter(e=>e.at>=w.time-2).slice(-350);
}
/** Fixed 60Hz simulation. Rendering frequency does not alter combat rules or random draws. */
export function stepBattle(w:BattleState,input:InputFrame,dt=1/60):void {
 if(w.status!=='playing'||!Number.isFinite(dt)||dt<=0)return;
 w.remainder+=dt;
 while(w.remainder>=1/60-1e-10&&w.status==='playing'){w.remainder=Math.max(0,w.remainder-1/60);stepFixed(w,input,1/60);}
}
export function battleResult(w:BattleState):BattleResult {
 return {won:w.status==='won',hp:w.player.hp,shield:w.player.shield,stats:JSON.parse(JSON.stringify(w.stats)) as CombatStats,elapsed:w.time,insuranceUsed:w.insuranceUsed,rng:w.rng,...(w.failureReason?{reason:w.failureReason}:{})};
}
