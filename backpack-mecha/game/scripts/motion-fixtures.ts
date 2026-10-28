/** Explicit development fixtures. They never open or write a player's save. */
import {mkdirSync,writeFileSync} from 'node:fs';
import {newRun} from '../src/economy.ts';
import {createBattle,spawnEnemy,stepBattle} from '../src/combat.ts';
import type {BattleState} from '../src/combat.ts';
import {motionFrame} from '../src/motion.ts';
import {BOSSES} from '../src/content.ts';

export const idle={x:0,y:0,dash:false,overload:false};
export function fixtureWorld(id:string,phase=1):BattleState {
 const boss=BOSSES.find(b=>b.id===id),run=newRun('scavenger','full',0,'DEV4-MOTION-FIXTURE');
 run.items=[];run.wave=boss?boss.act*4:11;if(boss)run.bosses[boss.act-1]=id;
 const w=createBattle(run);w.player.invulnerable=1000;w.obstacles=[];w.encounter.nextSpawn=1000;
 if(!boss)spawnEnemy(w,{id,x:800,y:id==='E05'?575:390,elite:false,affix:0,reward:false,cost:0});
 for(const e of w.enemies)e.hp=e.maxHp*(phase===1?1:phase===2?.45:.2);
 return w;
}
export interface Fixture {id:string;label:string;provenance:string;world:BattleState}
export function makeFixtures():Fixture[] {
 const fixtures:Fixture[]=[],capture=(id:string,label:string,w:BattleState,provenance='Explicit setup; subsequent attack and phase timing advanced by stepBattle.')=>fixtures.push({id,label,provenance,world:structuredClone(w)});
 for(const id of ['E05','E12',...BOSSES.map(b=>b.id)]){
  const phases=id.startsWith('E')?1:['B1A','B1B','B2B'].includes(id)?2:3;
  for(let phase=1;phase<=phases;phase++){
   const w=fixtureWorld(id,phase),seen=new Set<string>();
   for(let frame=0;frame<60*28&&w.status==='playing';frame++){
    stepBattle(w,idle);const e=w.enemies.find(e=>e.id===id&&e.hp>0),m=e?motionFrame(w).get(e.eid):undefined;
    if(m&&(m.stage==='windup'&&m.progress>=.45||m.stage==='active'&&m.progress>=.1||m.stage==='recover')){
     const key=`${id}-p${phase}-${m.kind}-${m.stage}`;
     if(!seen.has(key)){seen.add(key);capture(key,`${id} · P${phase} · ${m.kind} · ${m.stage}`,w);}
    }
    if(id==='E05'&&w.events.some(e=>e.type==='enemy-explosion')&&!seen.has('explosion')){seen.add('explosion');capture(`${id}-explosion`,`${id} · 爆炸与消失`,w);}
    if(id==='E05'&&!e)break;
   }
  }
 }
 const w=fixtureWorld('E12');w.player.x=1575;w.player.y=450;w.enemies[0].x=1400;w.enemies[0].y=450;
 for(let i=0;i<240;i++){stepBattle(w,idle);if(w.enemies[0]?.controlReason==='impact'){capture('E12-impact','E12 · 实际撞墙硬直',w);break;}}
 const b=fixtureWorld('B1A');b.player.x=1570;b.player.y=300;b.bossCenter={x:1400,y:300};b.enemies[0].x=1400;
 for(let i=0;i<360;i++){stepBattle(b,idle);if(b.enemies[0]?.controlReason==='impact'){capture('B1A-impact','B1A · 实际撞墙硬直',b);break;}}
 for(const cause of ['ice','stagger','unknown'] as const){
  const base=fixtures.find(f=>f.id.startsWith(cause==='stagger'?'B1A-p1-charge-windup':'E12-p1-charge-windup'))!;
  const w=structuredClone(base.world);w.enemies[0].frozen=1.5;
  if(cause!=='unknown')w.enemies[0].controlReason=cause;else delete w.enemies[0].controlReason;
  capture(`control-${cause}`,`控制状态 · ${cause} · 地面预警继续有效`,w,'Explicit control-state / legacy-save fixture, not a naturally played battle.');
 }
 const dense=fixtureWorld('E12');
 for(let i=0;i<38;i++)spawnEnemy(dense,{id:`E${String(i%12+1).padStart(2,'0')}`,x:540+(i%8)*72,y:420+Math.floor(i/8)*70,elite:i%7===0,affix:0,reward:false,cost:0});
 stepBattle(dense,idle,.9);capture('dense-act3','第三章 · 密集敌人',dense,'Synthetic population fixture using the public encounter helpers.');
 const overlap=structuredClone(fixtures.find(f=>f.id.startsWith('B1B-p2-pull-active'))!.world);
 overlap.zones.push(...structuredClone(fixtures.find(f=>f.id.startsWith('B3A-p3-ring-active'))!.world.zones));
 capture('overlap-zones','叠加 · 牵引 / 伤害 / 环内安全区',overlap,'Composite geometry fixture; not a naturally occurring encounter.');
 return fixtures;
}
if(process.argv[1]?.endsWith('/motion-fixtures.ts')){
 const root=process.argv[2]??'/private/tmp/backpack-mecha-dev4-qa';mkdirSync(root,{recursive:true});
 const scenes=makeFixtures();writeFileSync(`${root}/fixtures.json`,JSON.stringify(scenes));
 console.log(`Generated ${scenes.length} explicitly labelled fixtures in ${root}`);
}
