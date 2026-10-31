import type {Item,Lang,Run} from './types.ts';
import {MODULE_BY_ID,label} from './content.ts';
import {damageScale,offerTier} from './rarity.ts';
import {activeSupports,getCells,previewMerge,purchaseMergeTargets} from './economy.ts';

export function pendingPreparation(run:Run,lang:Lang):string {
 const en=lang==='en';
 if(run.phase==='reward')return en?'Claim salvage':'领取战利品';
 if(run.phase==='expansion')return en?'Expand backpack':'完成背包扩容';
 if(run.phase==='protocol')return en?'Choose a protocol':'选择战术协议';
 return '';
}

export function weaponRole(id:string,lang:Lang):string {
 const roles:Record<string,[string,string]>={
  W01:['单体 · 连射','Single target · rapid'],W02:['近距 · 清群','Close range · crowd'],
  W03:['潮湿 · 联动','Wet · combo'],W04:['电链 · 清群','Chain · crowd'],
  W05:['燃烧 · 清群','Burn · crowd'],W06:['油污 · 联动','Oil · combo'],
  W07:['穿透 · 远距','Piercing · long range'],W08:['近战 · 失衡','Melee · stagger'],
  W09:['近战 · 清群','Melee · crowd'],W10:['爆炸 · 清群','Blast · crowd'],
  W11:['无人机 · 持续','Drones · sustained'],W12:['冰霜 · 控制','Frost · control'],
  W13:['单体 · 高攻速','Single target · rapid'],W14:['穿透 · 电伤','Piercing · electric'],
  W15:['近距 · 电伤','Close range · electric'],W16:['冰霜 · 清群','Frost · crowd'],
  W17:['燃烧 · 爆炸','Burn · blast'],W18:['无人机 · 持续','Drones · sustained'],
 };
 const role=roles[id];return role?role[lang==='en'?1:0]:'';
}

const RECIPES=[
 {name:['潮湿电击','Wet electricity'],parts:[['W03'],['W04','W14','W15']]},
 {name:['燃油连爆','Oil ignition'],parts:[['W06'],['W05','W17']]},
 {name:['穿甲实弹','Armor-piercing rounds'],parts:[['W01','W02','W07','W13'],['S07']]},
 {name:['冲刺震荡','Dash impact'],parts:[['W08','W09'],['S11']]},
 {name:['无人机编队','Drone formation'],parts:[['W11','W18'],['S10']]},
 {name:['冰霜控制','Frost control'],parts:[['W12','W16'],['S12']]},
];
/** Only equipped weapons and actually connected supports count as active combinations. */
function activeIds(run:Run):Set<string>{
 const supports=new Set(activeSupports(run).map(i=>i.uid));
 return new Set(run.items.filter(i=>!i.stored&&(MODULE_BY_ID[i.id].kind!=='support'||supports.has(i.uid))).map(i=>i.id));
}
export function buildSteps(run:Run,lang:Lang):string[] {
 const ids=activeIds(run),en=lang==='en';
 return RECIPES.flatMap(recipe=>{
  const present=recipe.parts.filter(part=>part.some(id=>ids.has(id))).length;
  if(!present)return [];
  const title=recipe.name[en?1:0];
  if(present===recipe.parts.length)return [en?`${title}: active`:`${title}：已接通`];
  const missing=recipe.parts.find(part=>!part.some(id=>ids.has(id)))!;
  const names=missing.map(id=>label(MODULE_BY_ID[id],lang)).join(' / ');
  return [en?`${title}: look for ${names}`:`${title}：可寻找${names}`];
 }).slice(0,2);
}
export function shopAdvice(run:Run,id:string,lang:Lang):string {
 const m=MODULE_BY_ID[id],ids=activeIds(run),en=lang==='en';
 const recipe=RECIPES.find(r=>r.parts.some(p=>p.includes(id)&&!p.some(x=>ids.has(x)))&&r.parts.some(p=>!p.includes(id)&&p.some(x=>ids.has(x))));
 if(recipe)return en?`Complements ${recipe.name[1]}${m.kind==='support'?' · link required':''}`:`补齐${recipe.name[0]}${m.kind==='support'?' · 需连接':''}`;
 if(m.kind==='support'){
  const weapon=run.items.find(i=>!i.stored&&MODULE_BY_ID[i.id].kind==='weapon'&&(m.tags.includes('全部')||m.tags.some(tag=>MODULE_BY_ID[i.id].tags.includes(tag))));
  return weapon?(en?`Matches ${label(MODULE_BY_ID[weapon.id],lang)} · link required`:`适配${label(MODULE_BY_ID[weapon.id],lang)} · 需连接`):(en?'Needs a matching weapon':'需要兼容武器');
 }
 return '';
}

export interface MergeImpact {
 beforeWeapons:number;afterWeapons:number;freedCells:number;freedPower:number;
 beforeOutput:number;afterOutput:number;outputChange?:number;weapon:boolean;
}
/** Same-model baseline output only: no guessed armor, targeting or support multipliers. */
export function mergeImpact(run:Run,uid:string,shopIndex?:number):MergeImpact|undefined {
 const target=run.items.find(i=>i.uid===uid);if(!target)return;
 let after:Item[];
 if(shopIndex!==undefined){
  if(!purchaseMergeTargets(run,shopIndex).some(i=>i.uid===uid))return;
  after=run.items.map(i=>i.uid===uid?{...i,tier:(offerTier(run.shop[shopIndex])+1) as Item['tier']}:i);
 }else{
  const result=previewMerge(run,uid);if(!result.ok||!result.item)return;
  after=run.items.filter(i=>i.uid!==result.consumedUid).map(i=>i.uid===result.item!.uid?result.item!:i);
 }
 const equipped=(items:Item[])=>items.filter(i=>!i.stored);
 const weapons=(items:Item[])=>equipped(items).filter(i=>MODULE_BY_ID[i.id].kind==='weapon').length;
 const cells=(items:Item[])=>equipped(items).reduce((s,i)=>s+getCells(i).length,0);
 const power=(items:Item[])=>equipped(items).reduce((s,i)=>s+MODULE_BY_ID[i.id].power,0);
 const output=(items:Item[])=>equipped(items).filter(i=>i.id===target.id).reduce((s,i)=>s+damageScale(i.tier),0);
 const beforeOutput=output(run.items),afterOutput=output(after);
 return {beforeWeapons:weapons(run.items),afterWeapons:weapons(after),freedCells:cells(run.items)-cells(after),freedPower:power(run.items)-power(after),
  beforeOutput,afterOutput,...(beforeOutput?{outputChange:(afterOutput/beforeOutput-1)*100}:{}),weapon:MODULE_BY_ID[target.id].kind==='weapon'};
}
