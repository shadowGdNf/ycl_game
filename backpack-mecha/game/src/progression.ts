/** Scrap per unit of enemy cost. Later waves never dilute an individual kill. */
export const scrapPerCost=(wave:number):number=>.4+.12*(Math.max(1,Math.min(12,Math.floor(wave)||1))-1);
export const waveScrapLimit=(wave:number,budget:number):number=>budget*scrapPerCost(wave);
import {CHASSIS_BY_ID} from './content.ts';
import type {ChassisGrowth,GrowthStat,Run} from './types.ts';

export const MAX_LEVEL=12;
export const GROWTH_PATHS:Record<string,{name:string;en:string;hp:number;speed:number;attack:number;focus:GrowthStat}>={
 scavenger:{name:'全能回收',en:'Versatile salvage',hp:8,speed:4,attack:5,focus:'attack'},
 bulwark:{name:'重装壁垒',en:'Armored bastion',hp:14,speed:2,attack:4,focus:'hp'},
 kestrel:{name:'疾速连射',en:'Rapid assault',hp:5,speed:7,attack:3,focus:'speed'},
 hive:{name:'蜂群火控',en:'Swarm fire control',hp:6,speed:3,attack:8,focus:'attack'},
};
export const freshGrowth=():ChassisGrowth=>({level:1,xp:0,points:0,choices:{hp:0,speed:0,attack:0}});
export const levelXP=(level:number)=>35+(level-1)*15;
/** Old saves begin at level one. Invalid optional growth never destroys a campaign. */
export function normalizeGrowth(raw:unknown):ChassisGrowth {
 const g=raw as ChassisGrowth|undefined;
 if(!g||!Number.isInteger(g.level)||g.level<1||g.level>MAX_LEVEL||!Number.isInteger(g.xp)||g.xp<0||g.xp>=levelXP(g.level)||!Number.isInteger(g.points)||g.points<0||!g.choices)return freshGrowth();
 const counts=[g.choices.hp,g.choices.speed,g.choices.attack];
 if(counts.some(n=>!Number.isInteger(n)||n<0)||counts.reduce((a,b)=>a+b,0)+g.points!==g.level-1)return freshGrowth();
 return {level:g.level,xp:g.level===MAX_LEVEL?0:g.xp,points:g.points,choices:{...g.choices}};
}
export function chassisStats(run:Pick<Run,'chassis'|'growth'>){
 const g=normalizeGrowth(run.growth),path=GROWTH_PATHS[run.chassis],steps=g.level-1;
 return {maxHp:CHASSIS_BY_ID[run.chassis].hp+path.hp*(steps+g.choices.hp),attack:100+path.attack*(steps+g.choices.attack),speed:100+path.speed*(steps+g.choices.speed),growth:g,path};
}
/** Victory settles XP exactly once through the existing battle transaction. */
export function awardExperience(run:Run,kills:number):number {
 const before=chassisStats(run),g=normalizeGrowth(run.growth);
 g.xp+=30+run.wave*5+Math.min(60,Math.max(0,Math.floor(Number.isFinite(kills)?kills:0)));
 while(g.level<MAX_LEVEL&&g.xp>=levelXP(g.level)){g.xp-=levelXP(g.level);g.level++;g.points++;}
 if(g.level===MAX_LEVEL)g.xp=0;run.growth=g;
 run.hp=Math.min(chassisStats(run).maxHp,run.hp+chassisStats(run).maxHp-before.maxHp);
 return g.level-before.growth.level;
}
