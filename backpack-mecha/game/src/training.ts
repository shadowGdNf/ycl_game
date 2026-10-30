import type {Run,Tier,Result,Profile,Item} from './types.ts';
import {MODULE_BY_ID,CHASSIS_BY_ID,BOSS_BY_ID} from './content.ts';
import {newRun,autoPack,equipItem,getCells,validateLoadout} from './economy.ts';

export interface TrainingSetup {chassis:string;boss:string;difficulty:number;tier:Tier;power:number;modules:string[];layout?:Item[]}
export const TRAINING_PRESETS=[
 {name:'铆钉齐射',en:'Rivet battery',modules:['W01','W02','S01','S02','U01','U02']},
 {name:'潮湿电链',en:'Wet circuit',modules:['W03','W04','S01','S05','U01','U02']},
 {name:'燃油连爆',en:'Oil ignition',modules:['W05','W06','S01','S06','U01','U02']},
 {name:'堡垒震荡',en:'Impact rig',modules:['W08','S08','S01','U02','U06']},
 {name:'无人机群',en:'Drone wing',modules:['W11','S10','S01','U01','U02']},
 {name:'冰霜回弹',en:'Frost ricochet',modules:['W12','S12','S04','U01','U02']},
];
export function chassisUnlocked(profile:Profile,id:string):boolean{return !!CHASSIS_BY_ID[id]&&(profile.settings.unlockAll===true||profile.unlocked.includes(id));}
export function difficultyLimit(profile:Profile):number{return profile.settings.unlockAll?4:profile.maxDifficulty;}
/** A fresh throwaway run. Never reads or mutates a career save or profile. */
export function trainingRun(setup:TrainingSetup):Result&{run?:Run}{
 const fail=(reason:string,reasonEn:string)=>({ok:false,reason,reasonEn});
 if(!CHASSIS_BY_ID[setup.chassis]||!BOSS_BY_ID[setup.boss])return fail('请选择机体与首领','Choose a chassis and boss');
 if(![0,1,2,3,4].includes(setup.difficulty)||![1,2,3,4].includes(setup.tier)||![10,14,18,24].includes(setup.power))return fail('训练参数无效','Invalid training settings');
 if(setup.modules.length>12||new Set(setup.modules).size!==setup.modules.length||setup.modules.some(id=>!MODULE_BY_ID[id]))return fail('请选择 1–12 件不同模块','Choose 1–12 different modules');
 if(setup.modules.filter(id=>MODULE_BY_ID[id].kind==='weapon').length>3)return fail('最多选择三件武器','Choose up to three weapons');
 const r=newRun(setup.chassis,'full',setup.difficulty,`BOSS-LAB-${setup.boss}`);
 r.wave=BOSS_BY_ID[setup.boss].act*4;r.bosses[BOSS_BY_ID[setup.boss].act-1]=setup.boss;r.power=setup.power;r.maxTier=4;r.gold=0;r.unlockedCorners=[0,1,2,3];
 r.extra={training:true};r.items=setup.modules.map(id=>({uid:`lab-${id}`,id,tier:setup.tier,x:0,y:0,rotation:0,stored:false}));
 if(setup.layout){
  if(setup.layout.length!==setup.modules.length||new Set(setup.layout.map(i=>i.id)).size!==setup.modules.length||setup.layout.some(i=>!setup.modules.includes(i.id)||i.stored))return fail('自定义装配与所选模块不一致','Custom layout must match the selected modules.');
  r.items=setup.layout.map(i=>({...i,tier:setup.tier}));
  return {...validateLoadout(r),run:r};
 }
 if(r.items.reduce((sum,item)=>sum+getCells(item).length,0)>25)return fail('超过 25 格，请减少模块','More than 25 cells. Remove modules');
 if(r.items.length){const result=autoPack(r);if(!result.ok)return result;}
 return {...validateLoadout(r),run:r};
}

/** Selecting a new module preserves every existing position. Only that module is fitted. */
export function toggleTrainingModule(setup:TrainingSetup,id:string):Result&{setup?:TrainingSetup}{
 if(!MODULE_BY_ID[id])return {ok:false,reason:'找不到模块','reasonEn':'Module not found.'};
 const prepared=trainingRun(setup),r=prepared.run;if(!r)return prepared;
 const removing=setup.modules.includes(id);
 if(removing){r.items=r.items.filter(i=>i.id!==id);for(const i of r.items)if(i.link&&!r.items.some(w=>w.uid===i.link))delete i.link;}
 else{
  if(r.items.length>=12)return {ok:false,reason:'最多选择 12 件模块',reasonEn:'Choose up to 12 modules.'};
  const uid=`lab-${id}`;r.items.push({uid,id,tier:setup.tier,x:-1,y:-1,rotation:0,stored:true});
  const equipped=equipItem(r,uid);if(!equipped.ok)return {...equipped,reason:'没有合适空位或武器已达上限；请先调整位置、整理或移除模块',reasonEn:'No suitable space, or three weapons already equipped. Rearrange or remove a module first.'};
 }
 return {ok:true,setup:{...setup,modules:r.items.map(i=>i.id),layout:structuredClone(r.items)}};
}
