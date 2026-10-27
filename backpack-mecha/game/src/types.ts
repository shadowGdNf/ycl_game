export type Lang='zh'|'en';
export type Mode='prototype'|'demo'|'full';
export type Tier=1|2|3;
export type Point={x:number;y:number};
export type Rect=Point&{w:number;h:number};
export type ModuleKind='weapon'|'support'|'utility';
export interface ModuleDef {id:string;name:string;en:string;kind:ModuleKind;shape:string[];power:number;rarity:'C'|'U'|'R';price:number;effect:string;effectEn:string;tags:string[];color:string;damage?:number;interval?:number;range?:number;attack?:string;values?:number[];[key:string]:unknown}
export interface ChassisDef {id:string;name:string;en:string;hp:number;shield:number;speed:number;armor:number;dash:number;trait:string;traitEn:string;unlock:string}
export interface EnemyDef {id:string;name:string;en:string;act:number;hp:number;armor:number;speed:number;damage:number;cost:number;behavior:string;radius:number}
export interface BossDef {id:string;name:string;en:string;act:number;hp:number;armor:number;radius:number;speed:number;attacks:string[][];phases:string;counter:string}
export interface ProtocolDef {id:string;name:string;en:string;effect:string;effectEn:string;tags:string[]}
export interface EventDef {id:string;name:string;en:string;description:string;descriptionEn:string}
export interface WaveDef {n:number;act:number;kind:'normal'|'boss';duration:number;budget:number;base:number;bonus:number}
export interface Item {uid:string;id:string;tier:Tier;x:number;y:number;rotation:number;stored:boolean;link?:string}
export interface Offer {id:string;locked:boolean}
export interface CombatStats {damageByModule:Record<string,number>;damageTakenBy:Record<string,number>;kills:number;killedBudget:number;goldEarned:number;maxChain:number;damageTaken:number}
export interface RunEvent {
 sequence:number;wave:number;action:string;detail:string;gold:number;hp:number;prepSeconds:number;
 items:Item[];shop:Offer[];protocols:string[];rewardOptions:string[];protocolOptions:string[];eventId?:string;route:0|1|2;
}
export interface WaveRecord {
 wave:number;boss?:string;route:0|1|2;rulesVersion:string;prepSeconds:number;
 start:{hp:number;shield:number;gold:number;items:Item[];protocols:string[]};
 end?:{won:boolean;hp:number;shield:number;gold:number;income:number;seconds:number;reason?:string;stats:CombatStats};
}
export interface FrameRecord {samples:number;milliseconds:number;over50ms:number;maxMs:number;buckets:number[]}
export interface RunJournal {
 version:1;buildVersion:string;rulesVersion:string;startedAtWave:number;partial:boolean;
 nextSequence:number;droppedEvents:number;events:RunEvent[];waves:WaveRecord[];
 prepSeconds:Record<string,number>;frames:Record<string,FrameRecord>;
}
export interface Run {
 version:1;mode:Mode;seed:string;chassis:string;difficulty:number;phase:'prep'|'battle'|'reward'|'protocol'|'expansion'|'won'|'lost';wave:number;gold:number;hp:number;shield:number;power:number;maxTier:Tier;unlockedCorners:number[];items:Item[];shop:Offer[];refreshes:number;shopPity:number;protocols:string[];bosses:string[];nextUid:number;rng:{shop:number;map:number;event:number;combat:number};route:0|1|2;rewardOptions:string[];protocolOptions:string[];eventsSeen:string[];eventId?:string;eventResolved:boolean;insuranceUsed:boolean;stats:CombatStats;elapsed:number;history:string[];saleUndo?:string;extra?:Record<string,number|string|boolean>;journal?:RunJournal;
}
export interface Result {ok:boolean;reason?:string;reasonEn?:string}
export interface BattleResult {won:boolean;hp:number;shield:number;stats:CombatStats;elapsed:number;insuranceUsed:boolean;reason?:string;rng?:number}
export interface InputFrame {x:number;y:number;dash:boolean;overload:boolean;target?:Point}
export interface PlayerView extends Point {hp:number;maxHp:number;shield:number;maxShield:number;radius:number;speed:number;armor:number;angle:number;dashCooldown:number;overloadCooldown:number;dashTime:number;overloadTime:number;invulnerable:number}
export interface EnemyView extends Point {eid:number;id:string;hp:number;maxHp:number;radius:number;angle:number;kind:'normal'|'elite'|'boss';phase:number;shielded?:boolean;stagger?:number;frozen?:number;wet?:number;burns?:unknown[];group?:string;exposed?:boolean;offsetX?:number}
export interface BulletView extends Point {eid:number;vx:number;vy:number;radius:number;damage:number;life:number;color:string;owner:'player'|'enemy';weapon?:string}
export interface ZoneView extends Point {id:number;kind:'circle'|'rect'|'cone'|'ring'|'line';radius:number;w?:number;h?:number;angle:number;width?:number;innerRadius?:number;remaining:number;duration:number;active:boolean;color:string;type:'warning'|'hazard'|'friendly';damage?:number;delay?:number}
export interface WeaponView extends Point {uid:string;id:string;angle:number;cooldown:number;shotCount:number;droneCount?:number}
export interface DropView extends Point {id:number;value:number}
export interface CombatEvent extends Point {id:number;type:string;at:number;amount?:number;color?:string;targetId?:number;source?:string}
export interface BattleView {version:1;tick:number;time:number;wave:number;act:number;difficulty:number;status:'playing'|'won'|'lost';width:number;height:number;player:PlayerView;enemies:EnemyView[];bullets:BulletView[];zones:ZoneView[];weapons:WeaponView[];drops:DropView[];obstacles:Rect[];events:CombatEvent[];stats:CombatStats;bossId?:string;chassis:string;duration:number;insuranceUsed:boolean}
export interface Profile {version:1;language:Lang;unlocked:string[];maxDifficulty:number;codex:string[];connections:string[];best:Record<string,{score:number;seconds:number}>;settings:{sound:boolean;music:boolean;reducedMotion:boolean;leftHanded:boolean;colorAssist:boolean;autoOverload:boolean;volume:number};tutorial:boolean;totalRuns:number;wins:number}
