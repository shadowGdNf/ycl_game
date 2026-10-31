import {Renderer} from '/game/js/renderer.js';
import {WorkshopRenderer} from '/game/js/workshop-renderer.js';
import {trainingRun,TRAINING_PRESETS} from '/game/js/training.js';
import {activeSupports,validateLoadout,getCells} from '/game/js/economy.js';
import {createBattle,stepBattle} from '/game/js/combat.js';
import {MODULE_BY_ID,CHASSIS_BY_ID,BOSS_BY_ID} from '/game/js/content.js';
import {CHASSIS_SKILLS} from '/game/js/skills.js';
import {combatSound} from '/game/js/audio.js';
import {decide,createPilotMemory} from '/pilot.js';

const out=document.querySelector('#out'),c=out.getContext('2d'),game=document.querySelector('#game');
const renderer=new Renderer(game);await renderer.load();
const cream='#f3ecd8',cyan='#74ead5',orange='#ffad61',ink='#0a161e';
const font='"PingFang SC","Heiti SC",sans-serif';
const canvas=(w,h)=>{const el=document.createElement('canvas');el.width=w;el.height=h;return el;};
const bag=canvas(750,750),workshop=new WorkshopRenderer(),portraits={};
for(const id of Object.keys(CHASSIS_BY_ID)){portraits[id]=canvas(360,360);renderer.portrait(portraits[id],id);}
const icons=new Map();function icon(id){if(!icons.has(id)){const el=canvas(128,128);renderer.icon(el,id);icons.set(id,el);}return icons.get(id);}
function text(s,x,y,size=24,color=cream,weight=600,align='left'){c.font=`${weight} ${size}px ${font}`;c.fillStyle=color;c.textAlign=align;c.textBaseline='alphabetic';c.fillText(s,x,y);}
function box(x,y,w,h,color){c.fillStyle=color;c.fillRect(x,y,w,h);}
function grid(t){box(0,0,1280,720,ink);c.strokeStyle='#24404a66';c.lineWidth=1;for(let x=-80;x<1380;x+=64){c.beginPath();c.moveTo(x+t*4%64,0);c.lineTo(x+t*4%64,720);c.stroke();}for(let y=0;y<720;y+=64){c.beginPath();c.moveTo(0,y);c.lineTo(1280,y);c.stroke();}const g=c.createRadialGradient(700,300,50,700,300,760);g.addColorStop(0,'#20515a66');g.addColorStop(1,'#08131fdd');c.fillStyle=g;c.fillRect(0,0,1280,720);}
function strap(label,color=cyan){box(42,35,4,20,color);text(label,58,51,17,color,650);text('背包机甲',1238,51,18,cream,650,'right');}
function lower(title,sub,color=cyan){const g=c.createLinearGradient(0,480,0,720);g.addColorStop(0,'#08141a00');g.addColorStop(.42,'#08141ae6');g.addColorStop(1,'#08141aff');c.fillStyle=g;c.fillRect(0,480,1280,240);box(46,574,5,90,color);text(title,68,615,42,cream,800);text(sub,70,655,21,color,500);}
const electric=TRAINING_PRESETS[1].modules,fire=TRAINING_PRESETS[2].modules;
const drone=['W11','W18','S10','S01','U01','U02'];
const battery=['W13','W14','W17','S01','U01','U02'];
export const scenes=[
 {id:'hook',duration:5,chassis:'kestrel',boss:'B2B',modules:battery,tier:3,warm:4,title:'把火力，装进背包。',sub:'自动开火 · 手动走位 · 极限生存',chapter:'BACKPACK MECHA',hp:.74},
 {id:'brand',duration:3,type:'brand'},
 {id:'assembly',duration:10,type:'assembly'},
 {id:'electric',duration:6,chassis:'scavenger',modules:electric,tier:3,warm:17,title:'潮湿 × 电弧，连锁清场',sub:'水压枪 + 电弧线圈 + 导电触点',chapter:'01 / 背包决定你的火力'},
 {id:'fire',duration:6,chassis:'bulwark',modules:fire,tier:3,warm:16,title:'燃油 × 烈焰，点燃战场',sub:'油罐弹射器 + 喷火器 + 燃油催化器',chapter:'01 / 背包决定你的火力',color:orange},
 {id:'drone',duration:6,chassis:'hive',modules:drone,tier:3,warm:18,title:'无人机编队，全面出击',sub:'无人机巢 + 突击蜂群 + 指令中继',chapter:'01 / 背包决定你的火力'},
 ...['scavenger','bulwark','kestrel','hive'].map((chassis,i)=>({id:'skill-'+chassis,duration:4,chassis,modules:[electric,['W08','W15','S08','S01','U02','U06'],['W13','W14','S01','S02','U01','U02'],drone][i],tier:2,warm:12,title:CHASSIS_BY_ID[chassis].name+' / '+CHASSIS_SKILLS[chassis].name,sub:['修复机体，磁吸回收','范围震荡，铁壁减伤','重置冲刺，加速突围','召唤援护，蜂群集火'][i],chapter:'02 / 四种机体 · 四种专属技能',skill:true,color:CHASSIS_SKILLS[chassis].color})),
 {id:'boss-roller',duration:6,chassis:'bulwark',boss:'B1A',modules:['W08','W15','S08','S01','U02','U06'],tier:2,warm:1.5,title:'迎战「压路王」',sub:'躲开冲锋，抓住反击窗口',chapter:'03 / 正面迎战机械巨兽',color:orange},
 {id:'boss-crab',duration:6,chassis:'kestrel',boss:'B2A',modules:battery,tier:2,warm:3,title:'突破「熔炉蟹」',sub:'穿越火海，让火力持续倾泻',chapter:'03 / 正面迎战机械巨兽',color:orange,hp:.7},
 {id:'boss-carrier',duration:6,chassis:'hive',boss:'B3B',modules:drone,tier:3,warm:3,title:'挑战「轨道母舰」',sub:'多段攻势，考验你的最后一套构筑',chapter:'03 / 正面迎战机械巨兽',color:orange,hp:.48},
 {id:'end',duration:6,type:'end'}
];
let offset=0;for(const s of scenes){s.start=offset;offset+=s.duration;}
window.duration=offset;window.scenes=scenes;
let current=-1,state,run,memory,lastEvent=0,localFrame=0,assemblyRun,fullBag;
const soundEvents=[],evidence=[];
const defaultInput={x:0,y:0,dash:false,overload:false};
function advance(skill=false){const input=decide(state,{preferredSurfaceRange:state.weapons.some(w=>['W05','W08','W15'].includes(w.id))?130:235},memory);input.skill=skill;stepBattle(state,input);return input;}
function init(index){
 current=index;localFrame=0;const s=scenes[index];
 if(s.type==='assembly'){
  const prepared=trainingRun({chassis:'scavenger',boss:'B3A',difficulty:1,tier:3,power:24,modules:electric});if(!prepared.ok)throw Error(prepared.reason);
  assemblyRun=prepared.run;fullBag=structuredClone(assemblyRun.items);assemblyRun.items=[];return;
 }
 if(s.type)return;
 const prepared=trainingRun({chassis:s.chassis,boss:s.boss||'B3A',difficulty:1,tier:s.tier,power:24,modules:s.modules});
 if(!prepared.ok)throw Error(`${s.id}: ${prepared.reason}`);run=prepared.run;
 if(!s.boss){run.wave=11;delete run.extra.training;}
 if(!validateLoadout(run).ok)throw Error('Illegal trailer loadout');
 state=createBattle(run);memory=createPilotMemory(index);
 if(s.hp)for(const e of state.enemies.filter(e=>e.kind==='boss'))e.hp=e.maxHp*s.hp;
 for(let i=0;i<Math.round(s.warm*60);i++)advance();
 lastEvent=state.nextEvent-1;
 evidence.push({id:s.id,loadout:s.modules,valid:true,supports:activeSupports(run).map(s=>({module:s.id,weapon:run.items.find(i=>i.uid===s.link)?.id})),startHp:state.player.hp,startStatus:state.status,warmup:s.warm,initialBossHpFraction:s.hp||1,skills:0,events:0});
}
function bossBar(){const bosses=state.enemies.filter(e=>e.kind==='boss'&&!e.dead&&e.exposed!==false);if(!bosses.length)return;const e=bosses[0];text(BOSS_BY_ID[e.id].name,640,92,19,cream,700,'center');box(420,105,440,8,'#070f16cc');box(420,105,440*Math.max(0,e.hp/e.maxHp),8,orange);}
function gameplay(s,t){
 for(let j=0;j<2;j++)advance(s.skill&&localFrame===18&&j===0);
 renderer.draw(state,{lang:'zh',reducedMotion:false,colorAssist:false});
 c.drawImage(game,0,0,1280,720);
 const g=c.createLinearGradient(0,0,0,130);g.addColorStop(0,'#08141ae6');g.addColorStop(1,'#08141a00');c.fillStyle=g;c.fillRect(0,0,1280,130);
 strap(s.chapter,s.color);bossBar();lower(s.title,s.sub,s.color);
 const itemIds=s.modules.filter(id=>MODULE_BY_ID[id].kind==='weapon');itemIds.forEach((id,i)=>{box(1058+i*58,595,52,52,'#0b2028cc');c.drawImage(icon(id),1060+i*58,597,48,48);});
 text('武器组合',1235,674,13,'#b5c7c7',500,'right');
 if(s.skill){c.drawImage(portraits[s.chassis],20,355,180,180);if(t>.6&&t<3.8){box(505,141,270,39,'#0a1b23d9');text(CHASSIS_SKILLS[s.chassis].name+' · 已发动',640,167,20,s.color,700,'center');}}
 for(const e of state.events){if(e.id<=lastEvent)continue;lastEvent=e.id;const sound=combatSound(e);if(sound)soundEvents.push({time:s.start+t,type:sound,source:e.source||''});const ev=evidence.at(-1);ev.events++;if(e.type==='skill')ev.skills++;}
 if(localFrame===s.duration*30-1)Object.assign(evidence.at(-1),{endHp:state.player.hp,endStatus:state.status,kills:state.stats.kills,remainingBosses:state.enemies.filter(e=>e.kind==='boss'&&!e.dead).length});
 localFrame++;
}
function assembly(t){
 grid(t);strap('01 / 背包组合武器');
 text('每一格，',58,176,46,cream,800);text('都能改变战局。',58,236,46,cream,800);
 const ordered=['W03','W04','S05','S01','U02','U01'];
 const count=Math.min(6,Math.max(0,Math.floor((t-.4)/1.15)+1));
 const visible=ordered.slice(0,count);
 assemblyRun.items=fullBag.filter(item=>visible.includes(item.id)).map(item=>({...item}));
 const selected=assemblyRun.items.find(i=>i.id===visible.at(-1));
 workshop.draw(bag,assemblyRun,{time:t,reduced:false,ready:true,selected:selected?.uid||'',placements:[],icon:(el,id)=>renderer.icon(el,id)});
 c.save();c.shadowColor='#000a';c.shadowBlur=30;c.drawImage(bag,660,120,540,540);c.restore();
 text('5 × 5 背包',660,93,20,cyan);text('武器 · 支持 · 功能',1200,93,17,'#a9bcc0',500,'right');
 const phase=t<3?'01  装入武器':t<5.6?'02  相邻连接':'03  组合成型';
 text(phase,60,314,23,cyan,700);
 const names=ordered.slice(0,count).map(id=>MODULE_BY_ID[id].name);
 for(let i=0;i<Math.min(4,names.length);i++){const id=ordered[i];c.drawImage(icon(id),52,345+i*58,48,48);text(names[i],112,378+i*58,21,cream,500);}
 box(58,606,533,1,'#507079');text(t<5.6?'摆放模块，让支持件与武器相邻':'连接生效：潮湿电链构筑',58,642,21,t<5.6?'#bed0cf':cyan);
 text('你的背包，就是你的战术。',58,684,16,'#91a9ae',500);
 const prev=Math.min(6,Math.max(0,Math.floor((t-1/30-.4)/1.15)+1));if(count>prev)soundEvents.push({time:8+t,type:count<3?'click':'connect',source:''});
}
function titleCard(t,end=false){
 grid(t);const fade=Math.min(1,t*2);c.globalAlpha=fade;
 text('BACKPACK  MECHA',640,end?97:163,22,cyan,650,'center');
 text('背包机甲',640,end?182:273,92,cream,850,'center');
 text('拼出你的火力。杀出机械重围。',640,end?238:332,27,'#d6e2db',550,'center');
 const ids=['scavenger','bulwark','kestrel','hive'];for(let i=0;i<4;i++){const x=290+i*233,y=end?402:510;const bob=Math.sin(t*2+i)*5;c.drawImage(portraits[ids[i]],x-132,y-142+bob,264,264);if(end)text(CHASSIS_BY_ID[ids[i]].name,x,544,22,cream,600,'center');}
 if(end){box(414,590,452,58,cyan);text('即刻试玩 · 免费网页游戏',640,628,25,ink,750,'center');text('shadowgdnf.github.io/ycl_game/backpack-mecha/game/dist/',640,683,16,'#aac1c3',500,'center');}
 else{text('背包构筑  /  四种机体  /  六大首领',640,674,20,cyan,600,'center');}
 c.globalAlpha=1;
}
window.renderFrame=(frame)=>{
 const time=frame/30,index=scenes.findIndex(s=>time>=s.start&&time<s.start+s.duration);if(index<0)throw Error('Frame outside timeline');
 if(index!==current)init(index);const s=scenes[index],t=time-s.start;c.clearRect(0,0,1280,720);
 if(s.type==='assembly')assembly(t);else if(s.type)titleCard(t,s.type==='end');else gameplay(s,t);
 // Four-frame dip at cuts keeps game action dominant and avoids expensive transitions.
 if(index>0&&t<.133)box(0,0,1280,720,`rgba(7,17,24,${Math.max(0,.45*(1-t/.133))})`);
 if(time>75.3)box(0,0,1280,720,`rgba(7,17,24,${Math.min(1,(time-75.3)/.7)})`);
 return out.toDataURL('image/jpeg',.95).split(',')[1];
};
window.captureReport=()=>({duration:offset,fps:30,width:1280,height:720,scenes,evidence,soundEvents});
window.ready=true;
