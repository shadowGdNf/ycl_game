/** Headless balance evidence. No combat state mutation after createBattle. */
import {readFileSync,writeFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
import assert from 'node:assert/strict';
import {createBattle,stepBattle,battleResult} from '../src/combat.ts';
import {newRun,autoPack,validateLoadout,startWave,getCells,getCapacity,standardCost} from '../src/economy.ts';
import {decide} from './probe-pilot.ts';
import type {BotMemory} from './probe-pilot.ts';
import {BOSS_BY_ID,MODULE_BY_ID,CHASSIS_BY_ID,WAVES,DEMO_IDS} from '../src/content.ts';
import type {BattleView,EnemyView,InputFrame,Item,Mode,Point,Run,Tier,ZoneView} from '../src/types.ts';

type BuildSpec={id:string;name:string;mode:'demo'|'full';act:1|2|3;chassis:string;items:[string,string][];links:Record<string,string>;tiers:Record<string,Tier>;protocols:string[];preferredSurfaceRange:number;melee?:boolean};
type Design={builds:{name:string;items:[string,string][];links:Record<string,string>;protocol:string}[];checks:{builds:{name:string;tiers:Record<string,Tier>}[]}};
const data=JSON.parse(readFileSync(new URL('../assets/source/design-baseline.json',import.meta.url),'utf8')) as Design;
const count=Math.max(1,Math.min(20,Number(process.argv.find(a=>a.startsWith('--seeds='))?.split('=')[1]??10)));
const DT=1/60,DECISION_TICKS=6,DECISION_DT=DT*DECISION_TICKS;
const clamp=(v:number,min:number,max:number)=>Math.max(min,Math.min(max,v));
const distance=(a:Point,b:Point)=>Math.hypot(a.x-b.x,a.y-b.y);
const round=(v:number)=>Math.round(v*1000)/1000;
const sourceNames=['combat.ts','encounters.ts','economy.ts','content.ts','types.ts','journal.ts','version.ts','../scripts/probe-pilot.ts'];
function sourceHashes(){return Object.fromEntries(sourceNames.map(name=>[name,createHash('sha256').update(readFileSync(new URL(`../src/${name}`,import.meta.url))).digest('hex')]));}

const earlyDefinitions=[
 {id:'wet',name:'潮湿电链',ids:['W03','W04','W01','S05','S02','U02','U01'],links:{d:'b',e:'b'},range:275},
 {id:'oil',name:'燃油过渡（无导弹）',ids:['W05','W06','W02','S06','U02','U01'],links:{d:'a'},range:140},
 {id:'ballistic',name:'实弹过渡（无磁轨）',ids:['W01','W02','S03','S07','S02','U02','U01'],links:{c:'a',d:'a',e:'b'},range:210},
 {id:'fortress',name:'堡垒震荡起步',ids:['W08','W09','S11','S01','U02','U06'],links:{c:'a',d:'b'},range:64},
 {id:'drone',name:'单巢无人机起步',ids:['W11','W12','S10','S12','U02','S02'],links:{c:'a',d:'b',f:'a'},range:275},
 {id:'frost',name:'冰霜回弹起步',ids:['W12','W01','S04','S12','S03','U02','U06'],links:{c:'b',d:'a',e:'b'},range:210},
];
const earlyBuilds:BuildSpec[]=earlyDefinitions.map(b=>({id:`act1-${b.id}`,name:b.name,mode:'full',act:1,chassis:'scavenger',items:b.ids.map((id,i)=>[String.fromCharCode(97+i),id]),links:b.links,
 tiers:Object.fromEntries(b.ids.map((_,i)=>[String.fromCharCode(97+i),1])),protocols:[],preferredSurfaceRange:b.range,melee:b.id==='fortress'}));
const fullNames=['wet','oil','ballistic','fortress','drone','frost'];
const fullChassis=['scavenger','scavenger','kestrel','bulwark','hive','kestrel'];
const fullRanges=[275,140,210,64,275,210];
const fullBuilds:BuildSpec[]=data.builds.map((b,i)=>({id:`full-${fullNames[i]}`,name:b.name,mode:'full',act:3,chassis:fullChassis[i],items:b.items,links:b.links,tiers:data.checks.builds.find(c=>c.name===b.name)!.tiers,protocols:b.protocol.split('或'),preferredSurfaceRange:fullRanges[i],melee:i===3}));
const middleBuilds:BuildSpec[]=fullBuilds.map(b=>{
  const copy:BuildSpec={...b,id:b.id.replace('full-','act2-'),act:2,chassis:'scavenger',items:b.items.map(x=>[...x]),links:{...b.links},tiers:Object.fromEntries(Object.entries(b.tiers).map(([k,v])=>[k,Math.min(2,v)])),protocols:b.protocols.slice(0,1)};
  if(b.id==='full-fortress'){copy.items.push(['j','U01']);copy.tiers.j=2;}
  if(b.id==='full-frost'){copy.items=copy.items.filter(([,id])=>id!=='U05');delete copy.tiers.h;}
  return copy;
});
const demoDefinitions=[
 {id:'wet',name:'潮湿电链',ids:['W03','W04','W01','S05','S02','U09','U02','U01','S01'],links:{d:'b',e:'b',i:'c'},protocol:'P01',range:275},
 {id:'oil',name:'燃油持续伤害',ids:['W05','W06','W02','S06','S02','S01','U06','U03','U01'],links:{d:'a',e:'a',f:'c'},protocol:'P02',range:140},
 {id:'ballistic',name:'实弹齐射',ids:['W07','W01','W02','S03','S07','S02','U05','U07','U01'],links:{d:'a',e:'a',f:'b'},protocol:'P03',range:210},
];
const demoBuilds:BuildSpec[]=demoDefinitions.map(b=>({id:`demo-${b.id}`,name:b.name,mode:'demo',act:2,chassis:'scavenger',items:b.ids.map((id,i)=>[String.fromCharCode(97+i),id]),links:b.links,
 tiers:Object.fromEntries(b.ids.map((id,i)=>[String.fromCharCode(97+i),MODULE_BY_ID[id].kind!=='utility'||id==='U01'?2:1])),protocols:[b.protocol],preferredSurfaceRange:b.range}));
const builds=[...earlyBuilds,...middleBuilds,...fullBuilds,...demoBuilds];
const chapterBudget=(act:number)=>round(40+WAVES.filter(w=>w.n<act*4).reduce((n,w)=>n+w.base+w.bonus*.7,0));
const bossIds=(build:BuildSpec)=>build.mode==='demo'?['B2A']:[`B${build.act}A`,`B${build.act}B`];
assert.equal(chapterBudget(1),165.4);assert.equal(chapterBudget(2),399.4);assert.equal(chapterBudget(3),702);

function fixture(build:BuildSpec,boss:string,seed:string):Run{
  const run=newRun(build.chassis,build.mode,0,seed);
  assert.equal(BOSS_BY_ID[boss].act,build.act);
  run.wave=build.act*4;run.power=8+build.act*2;run.maxTier=build.act;
  run.unlockedCorners=build.act===1?[]:build.act===2?[0,1]:[0,1,2,3];run.protocols=[...build.protocols];run.items=[];
  run.bosses[BOSS_BY_ID[boss].act-1]=boss;
  for(const [key,id] of build.items)run.items.push({uid:key,id,tier:build.tiers[key],x:-1,y:-1,rotation:0,stored:false,...(build.links[key]?{link:build.links[key]}:{})});
  assert.ok(build.mode!=='demo'||run.items.every(i=>DEMO_IDS.includes(i.id)),`${build.id}: module unavailable in demo`);
  assert.ok(run.items.every(i=>i.tier<=build.act),`${build.id}: upgrade not unlocked`);
  assert.ok(run.items.every(i=>build.act>=2||MODULE_BY_ID[i.id].rarity!=='R'),`${build.id}: rare module unavailable in act one`);
  assert.ok(run.protocols.length<=build.act-1,`${build.id}: protocol not unlocked`);
  assert.ok(run.items.reduce((n,i)=>n+standardCost(i),0)<=chapterBudget(build.act),`${build.id}: exceeds chapter budget`);
  assert.equal(autoPack(run).ok,true,`${build.id}: packing failed`);
  for(const [support,weapon]of Object.entries(build.links))assert.equal(run.items.find(i=>i.uid===support)?.link,weapon,`${build.id}: support was reassigned`);
  assert.equal(validateLoadout(run).ok,true,`${build.id}: invalid fixture`);
  assert.ok(run.items.reduce((n,i)=>n+getCells(i).length,0)<=19+build.act*2);
  assert.ok(run.items.reduce((n,i)=>n+MODULE_BY_ID[i.id].power,0)<=getCapacity(run));
  assert.equal(startWave(run).ok,true,`${build.id}: cannot enter battle`);
  return run;
}

interface ProbeResult {build:string;name:string;mode:Mode;boss:string;seed:string;chassis:string;won:boolean;status:string;failure?:string;seconds:number;hp:number;shield:number;bossHpRemaining:number;initialBossHp:number;damageDealt:number;damageByModule:Record<string,number>;damageTaken:number;damageTakenBy:Record<string,number>;shots:Record<string,number>;maxBossDamageGapSeconds:number;noSafeCandidateDecisions:number;dashDecisions:number;visibleWarnings:number;checkpoints:{seconds:number;hp:number;shield:number;bossHp:number;damage:number}[];anomalies:string[]}
function runProbe(build:BuildSpec,boss:string,seed:string,index:number):ProbeResult{
  const run=fixture(build,boss,seed),world=createBattle(run),initialBossHp=world.enemies.find(e=>e.kind==='boss')!.maxHp;
  const memory:BotMemory={enemies:new Map(),zones:new Map(),direction:index%2===0?1:-1,lastInput:{x:0,y:0,dash:false,overload:false},noSafeCandidate:0,dashDecisions:0,visibleWarnings:new Set()};
  let input=memory.lastInput,lastBossHp=initialBossHp,lastBossDamage=0,maxGap=0,lastCheckpoint=-30;
  const checkpoints:ProbeResult['checkpoints']=[],anomalies:string[]=[];
  for(let tick=0;tick<60*301&&world.status==='playing';tick++){
    if(tick%DECISION_TICKS===0)input=decide(world,build,memory);
    stepBattle(world,input,DT);
    if(tick%60===0||world.status!=='playing'){
      const bossHp=world.enemies.find(e=>e.kind==='boss')?.hp??0;
      if(bossHp<lastBossHp-.01){maxGap=Math.max(maxGap,world.time-lastBossDamage);lastBossDamage=world.time;lastBossHp=bossHp;}
      if(!Number.isFinite(world.player.hp+world.player.x+world.player.y+bossHp)){anomalies.push('non-finite combat state');break;}
      if(world.time-lastCheckpoint>=30||world.status!=='playing'){
        checkpoints.push({seconds:round(world.time),hp:round(world.player.hp),shield:round(world.player.shield),bossHp:round(bossHp),damage:round(Object.values(world.stats.damageByModule).reduce((a,b)=>a+b,0))});lastCheckpoint=world.time;
      }
    }
  }
  maxGap=Math.max(maxGap,world.time-lastBossDamage);
  const result=battleResult(world),damage=Object.values(result.stats.damageByModule).reduce((a,b)=>a+b,0);
  if(world.time>=299.9)anomalies.push('300-second combat timeout');
  if(damage===0)anomalies.push('no outgoing damage');
  if(maxGap>=30)anomalies.push('at least 30 seconds without boss damage; inspect bot positioning and targeting');
  if(world.status==='playing')anomalies.push('probe stopped without a battle result');
  return {build:build.id,name:build.name,mode:build.mode,boss,seed,chassis:build.chassis,won:result.won,status:world.status,failure:result.reason,seconds:round(result.elapsed),hp:round(result.hp),shield:round(result.shield),bossHpRemaining:round(world.enemies.find(e=>e.kind==='boss')?.hp??0),initialBossHp,damageDealt:round(damage),damageByModule:Object.fromEntries(Object.entries(result.stats.damageByModule).map(([k,v])=>[k,round(v)])),damageTaken:round(result.stats.damageTaken),damageTakenBy:Object.fromEntries(Object.entries(result.stats.damageTakenBy).map(([k,v])=>[k,round(v)])),shots:Object.fromEntries(world.weapons.map(w=>[w.uid+':'+w.id,w.shotCount])),maxBossDamageGapSeconds:round(maxGap),noSafeCandidateDecisions:memory.noSafeCandidate,dashDecisions:memory.dashDecisions,visibleWarnings:memory.visibleWarnings.size,checkpoints,anomalies};
}

const before=sourceHashes(),started=new Date().toISOString();
const results:ProbeResult[]=[];
for(const build of builds){
  for(const boss of bossIds(build)){
    for(let i=0;i<count;i++)results.push(runProbe(build,boss,`balance-probe-v1-${String(i+1).padStart(2,'0')}`,i));
    const group=results.filter(r=>r.build===build.id&&r.boss===boss);
    console.log(`${build.id} / ${boss}: ${group.filter(r=>r.won).length}/${count}, ${round(group.reduce((n,r)=>n+r.seconds,0)/count)} sec mean, ${group.flatMap(r=>r.anomalies).length} anomaly flags`);
  }
}
const mean=(values:number[])=>round(values.reduce((a,b)=>a+b,0)/Math.max(1,values.length));
const summaries=builds.flatMap(build=>bossIds(build).map(boss=>{
  const group=results.filter(r=>r.build===build.id&&r.boss===boss),times=group.map(r=>r.seconds).sort((a,b)=>a-b);
  return {build:build.id,name:build.name,act:build.act,boss,runs:group.length,wins:group.filter(r=>r.won).length,meanSeconds:mean(times),medianSeconds:times.length%2?times[Math.floor(times.length/2)]:round((times[times.length/2-1]+times[times.length/2])/2),minSeconds:times[0],maxSeconds:times.at(-1),meanHp:mean(group.map(r=>r.hp)),meanDamageTaken:mean(group.map(r=>r.damageTaken)),meanBossHpRemaining:mean(group.map(r=>r.bossHpRemaining)),anomalyFlags:group.flatMap(r=>r.anomalies).length};
}));
const after=sourceHashes();
const report={version:2,probe:'visible-state-reactive-v1-chapter-legal',started,finished:new Date().toISOString(),sourceHashes:before,designBaseline:'assets/source/design-baseline.json',sourceChangedDuringRun:JSON.stringify(before)!==JSON.stringify(after),fixedStepSeconds:DT,decisionIntervalSeconds:DECISION_DT,seedsPerGroup:count,runCount:results.length,chapterRunCount:results.filter(r=>r.mode==='full').length,demoRunCount:results.filter(r=>r.mode==='demo').length,
 limits:['Machine policy evidence, not human win-rate or commercial balance.','Pre-equipped fixtures assert chapter rarity, upgrade, grid, power, protocol and standard purchase/upgrade cost limits; they do not prove actual shop acquisition probability.','Budgets use 70% of earned kill pools before each boss: 165.4, 399.4, 702 scrap; free starters and sale refunds are not deducted from fixture cost.','Act one uses no rare railgun/missile: ballistic and oil builds are explicitly transitional. A single drone hive and relay are uncommon and can appear in act one; the double-hive build starts in act two.','No HP/invulnerability edits, damage multipliers, direct victory, clock multipliers, or skipped simulation steps.','The policy sees a 960×720 world-unit viewport and current enemies, previews and hostile projectiles, not future boss plans.','Acts one/two use the initially available scavenger. Act three retains design chassis, assuming prior account unlocks; fixtures start at normal chassis HP and do not model previous-wave damage.'],
 chapterConstraints:[1,2,3].map(act=>({act,maxTier:act,cells:19+act*2,basePower:8+act*2,maxProtocols:act-1,budget:chapterBudget(act),rareAllowed:act>=2})),
 fixtures:builds.map(build=>{const r=fixture(build,bossIds(build)[0],'fixture-list');return {...build,budget:chapterBudget(build.act),cells:r.items.reduce((n,i)=>n+getCells(i).length,0),power:r.items.reduce((n,i)=>n+MODULE_BY_ID[i.id].power,0),capacity:getCapacity(r),cost:r.items.reduce((n,i)=>n+standardCost(i),0),initialHp:CHASSIS_BY_ID[r.chassis].hp,layout:r.items};}),summaries,results};
assert.equal(report.sourceChangedDuringRun,false,'Combat sources changed during the probe; rerun against the settled version.');
writeFileSync(new URL('../qa/balance-probe.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(`Saved ${results.length} real battles to qa/balance-probe.json`);
