// Browser reconstruction: recovered balance/path/wave data, independently written simulation.
// The original Lua game and platform services are never evaluated by this module.
export const TOWER_TYPES = {
  archer: { name: '箭塔', caption: '快速射击 · 物理伤害', color: '#e2bf70', cost: 70, range: 165, damage: 5, cooldown: 1, maxLevel: 4, atlas: 'go_towers_archer_kr1' },
  barracks: { name: '兵营', caption: '派出士兵 · 拦截地面敌人', color: '#80b6cf', cost: 70, range: 150, damage: 3, cooldown: 1, maxLevel: 4, atlas: 'go_towers_barrack_kr1' },
  mage: { name: '法师塔', caption: '魔法攻击 · 克制物理护甲', color: '#a8a1ed', cost: 100, range: 160, damage: 7.5, cooldown: 2, maxLevel: 4, atlas: 'go_towers_mage_kr1' },
  artillery: { name: '炮塔', caption: '范围轰炸 · 适合密集敌群', color: '#e59b67', cost: 110, range: 250, damage: 15, cooldown: 3, maxLevel: 4, atlas: 'go_towers_engineer_kr1' }
};
const FALLBACK_TOWERS = {
  archer: { price: [70, 100, 150, 230], basic_attack: { damage_min: [4, 9, 13, 16], damage_max: [6, 13, 18, 26], cooldown: [1, .9, .7, .6], range: [165, 180, 200, 220] } },
  barracks: { price: [70, 110, 160, 220], rally_range: 150, max_soldiers: 3, soldier: { hp: [40, 80, 130, 200], armor: [.1, .2, .3, .4], regen_hp: [3, 6, 10, 13], speed: 75, dead_lifetime: 12, basic_attack: { damage_min: [2, 3, 6, 9], damage_max: [4, 5, 10, 13], cooldown: 1, range: 70 } } },
  mage: { price: [100, 150, 210, 280], basic_attack: { damage_min: [6, 14, 24, 36], damage_max: [9, 24, 43, 66], cooldown: 2, range: [160, 170, 180, 190] } },
  artillery: { price: [110, 170, 240, 310], basic_attack: { damage_min: [12, 30, 52, 80], damage_max: [18, 44, 78, 120], cooldown: 3, range: [250, 265, 280, 300], damage_radius: 60 } }
};
const FALLBACK_HERO = { hp_max: [220,240,260,280,300,320,340,360,380,400], armor: [.05,.1,.15,.2,.25,.3,.35,.4,.45,.5], regen_health: [18,19,21,22,24,26,27,29,30,32], regen_cooldown: 1, dead_lifetime: 30, speed: 55, basic_melee: { damage_min: [10,11,13,14,16,18,19,21,22,24], damage_max: [14,17,19,22,24,26,29,31,34,36], cooldown: 2 } };
const FALLBACK_POWERS = { rain_of_fire: { cooldown: 60, meteor_count: 3, min_spread: 25, max_spread: 40, bullet: { radius: 60, damage_min: 30, damage_max: 45 } }, reinforcements: { soldier: { cooldown: 15, duration: 12, hp_max: 40, armor: 0, max_speed: 64, regen_health: 8, melee_attack: { cooldown: 1, damage_min: 2, damage_max: 4, range: 72 } } } };
const originalTower = { archer: 'archers', barracks: 'knights', mage: 'wizard', artillery: 'catapult' };
const towerType = Object.fromEntries(Object.entries(originalTower).map(([a,b]) => [b,a]));
const distance = (a,b) => Math.hypot(a.x-b.x,a.y-b.y);
const clamp = (v,a,b) => Math.min(b,Math.max(a,v));
const number = (v,fallback=0) => typeof v === 'number' && Number.isFinite(v) ? v : fallback;
const atLevel = (v,level,fallback) => number(Array.isArray(v) ? v[clamp(level-1,0,v.length-1)] : v,fallback);
const validPoint = p => p && Number.isFinite(p.x) && Number.isFinite(p.y);
const finished = p => p === 'won' || p === 'lost';
const damageKind = type => (type & (1|64|2048)) ? 'true' : (type & 4) ? 'magic' : (type & (8|16)) ? 'explosive' : 'physical';
const merge = (a,b) => { const out={...a}; for(const [k,v] of Object.entries(b||{})) out[k]=v && typeof v==='object' && !Array.isArray(v) ? merge(a?.[k]||{},v) : v; return out; };

// The manual groups contain support enemies, while boss entities are created by
// level Lua. These explicit descriptors preserve those bosses in the reconstruction.
const BOSS_ENTRIES = {
  8: [{ enemy:'enemy_boss_stage_08',path:6,lane:3,node:1,time:0 }],
  10: [{ enemy:'enemy_boss_stage_10',path:4,lane:1,node:75,time:0 }],
  11: [{ enemy:'enemy_boss_stage_11',path:1,lane:1,node:30,time:0,arena:true }],
  13: [{ enemy:'enemy_boss_stage_13',path:11,lane:1,node:8,time:0,arena:true }],
  15: [{ enemy:'enemy_boss_stage_15',path:1,lane:1,node:50,time:0 }],
  18: [{ enemy:'enemy_stage_18_veznan_illusion',path:1,lane:1,time:0,arena:true },{ enemy:'enemy_stage_18_veznan_illusion',path:12,lane:1,time:0,arena:true },{ enemy:'enemy_stage_18_veznan_illusion',path:22,lane:1,time:1.5,arena:true }]
};
export function campaignWaves(level) {
  const result=(level.waves||[]).map(w=>({...w,spawns:w.spawns.map(s=>({...s})),events:[...(w.events||[])],kind:'regular'}));
  const groups=(level.manualWaves||[]).filter(w=>/^boss/i.test(String(w.id)));
  if (groups.length || BOSS_ENTRIES[level.id]) {
    let offset=0; const spawns=[],events=[];
    for(const w of groups) {
      for(const s of w.spawns||[])spawns.push({...s,time:offset+number(s.time),manualGroup:w.id});
      for(const e of w.events||[])events.push({...e,time:offset+number(e.time),manualGroup:w.id});
      offset+=Math.max(number(w.duration),...w.spawns.map(s=>number(s.time)),0)+Math.max(0,number(w.interval));
    }
    for(const boss of BOSS_ENTRIES[level.id]||[])spawns.push({...boss,boss:true,arenaDuration:boss.arena ? offset : 0});
    result.push({id:'boss',label:'首领战',kind:'boss',interval:15,duration:offset,spawns:spawns.sort((a,b)=>a.time-b.time),events,manualGroups:groups.map(w=>w.id)});
    if(Number(level.id)===18) result.push({id:'boss-real',label:'卫兹南真身',kind:'boss',interval:8,duration:0,spawns:[{enemy:'enemy_stage_18_veznan',path:22,lane:1,node:1,time:0,boss:true}],events:[]});
  }
  return result;
}

export class Game {
  constructor(level,catalog={},options={}) {
    if(!level || !Array.isArray(level.paths) || !Array.isArray(level.waves))throw new Error('关卡数据不完整');
    this.level=level; this.catalog=catalog; this.options=options;
    this.difficulty=['easy','normal','hard','impossible'].indexOf(options.difficulty??'normal');
    if(this.difficulty<0)this.difficulty=clamp(Math.trunc(number(options.difficulty,2))-1,0,3);
    this.phase='ready';this.paused=false;this.speed=1;this.time=0;
    this.gold=number(level.gold,200);this.lives=number(level.lives,20);this.initialLives=this.lives;
    this.wave=0;this.kills=0;this.earned=0;this.countdown=0;this.nextId=1;this.rng=Number.isInteger(options.seed)?options.seed>>>0:703;
    this.enemies=[];this.units=[];this.projectiles=[];this.effects=[];this.queue=[];this.eventQueue=[];this.events=[];this.actions=[];
    this.lastError='';this.errors=[];this.notices=[];this.notice=this.notices;
    this.limitations=['基础战斗由 JavaScript 重构；不是原 Lua 引擎执行。','包含四种基础塔与一名英雄；英雄升级/被动、专属塔技能和敌人特殊能力尚未完整恢复。','普通与手动波的静态出兵及显式首领已保留；关卡事件触发的额外出兵、首领阶段、机关和演出尚未等价实现。'];
    this.campaignWaves=campaignWaves(level);this.totalWaves=this.campaignWaves.length;
    this.currentWaveEnd=Infinity;this.currentWaveData=null;this._waitingPrepared=false;
    this.spells={meteor:0,reinforcements:0};
    this.powers=merge(FALLBACK_POWERS,options.powers||{});
    this.spellStats={meteor:{cooldown:number(this.powers.rain_of_fire.cooldown,60)},reinforcements:{cooldown:number(this.powers.reinforcements.soldier.cooldown,15),duration:number(this.powers.reinforcements.soldier.duration,12)}};
    this.paths=new Map();this.pathDefinitions=new Map(level.paths.map(p=>[p.id,p]));
    for(const p of level.paths) {
      const lanes=p.lanes?.length?p.lanes:[p.points];
      for(let i=0;i<lanes.length;i++) {
        const points=lanes[i];if(!points || points.length<2 || points.some(p=>!validPoint(p)))throw new Error(`关卡 ${level.id} 的路径 ${p.id} 无效`);
        const lengths=[0];for(let j=1;j<points.length;j++)lengths.push(lengths[j-1]+distance(points[j],points[j-1]));
        this.paths.set(`${p.id}:${i+1}`,{id:p.id,lane:i+1,points,lengths,total:lengths.at(-1)});
      }
    }
    this.connections=new Map();
    for(const [key,value] of Object.entries(level.pathConnections||{}))if(value!=null) {
      const from=Array.isArray(level.pathConnections)?Number(key)+1:Number(key);
      if(!this.paths.has(`${from}:1`)||!this.paths.has(`${value}:1`))throw new Error(`关卡 ${level.id} 路径连接 ${from} → ${value} 无效`);
      this.connections.set(from,Number(value));
    }
    for(const id of this.connections.keys()) {const seen=new Set();let next=id;while(this.connections.has(next)){if(seen.has(next))throw new Error('路径连接形成循环');seen.add(next);next=this.connections.get(next);}}
    this.towers=(level.towerSlots||[]).map((s,i)=>({...s,id:s.id??i,type:null,level:0,invested:0,timer:0,spawnTimer:0,recruits:[],blocked:Boolean(s.blocked),rally:s.rally?{...s.rally}:this.nearestPath(s)}));
    for(const t of this.towers)if(t.existingTower) {
      const match=/^tower_(archers|knights|wizard|catapult)_lvl([1-4])/.exec(t.existingTower);
      if(match){t.type=towerType[match[1]];t.level=Number(match[2]);t.invested=0;t.gift=true;if(t.type==='barracks')this.recruit(t);}
      else {t.blocked=true;this.notices.push(`未实现的原有防御塔：${t.existingTower}`);}
    }
    const h=merge(FALLBACK_HERO,options.heroes?.hero_gerald||{}),l=clamp(Math.trunc(number(options.heroLevel,1)),1,10),a=h.basic_melee;
    const initial=this.nearestPath(this.towers.find(t=>!t.blocked)||{x:512,y:384});
    const hp=atLevel(h.hp_max,l,220);
    this.hero={id:'hero',template:'hero_gerald',kind:'hero',level:l,x:initial.x,y:initial.y,home:{...initial},hp,maxHp:hp,armor:atLevel(h.armor,l,.05),damageMin:atLevel(a.damage_min,l,10),damageMax:atLevel(a.damage_max,l,14),damage:(atLevel(a.damage_min,l,10)+atLevel(a.damage_max,l,14))/2,attackCooldown:number(a.cooldown,2),cooldown:0,speed:number(h.speed,55),regen:atLevel(h.regen_health,l,18)/number(h.regen_cooldown,1),regenDelay:3,respawnDuration:number(h.dead_lifetime,30),respawn:0,target:null,engaged:null,meleeRange:70,lastCombat:-Infinity};
    this.units.push(this.hero);
    this._enemyStatsCache=new Map();
    for(const w of this.campaignWaves)for(const s of w.spawns)if(!this.paths.has(`${s.path}:1`))throw new Error(`关卡 ${level.id} 波次缺少路径 ${s.path}`);
    const skipped=this.campaignWaves.reduce((n,w)=>n+(w.events||[]).filter(e=>e.command==='event').length,0);
    if(skipped)this.notices.push(`该关 ${skipped} 条场景脚本事件（含额外出兵与机关）仅保留事件记录，行为尚未等价实现。`);
    if(groupsTutorial(level))this.notices.push('原教程脚本由网页操作提示替代，教程专用四名强盗不加入普通战役波次。');
  }
  random(){this.rng=(Math.imul(this.rng,1664525)+1013904223)>>>0;return this.rng/4294967296;}
  roll(min,max){return Math.floor(min+this.random()*(Math.max(min,max)-min+1));}
  emit(type,data={}){this.events.push({type,...data});}
  log(type,data={}){this.actions.push({time:+this.time.toFixed(2),type,...data});}
  fail(reason){this.lastError=reason;return false;}
  actionable(){if(this.paused)return this.fail('请先继续游戏');if(finished(this.phase))return this.fail('本局已结束');this.lastError='';return true;}
  setPaused(value){if(finished(this.phase))return false;this.paused=Boolean(value);return true;}
  setSpeed(value){if(![1,2,3].includes(value))return this.fail('不支持的游戏速度');this.speed=value;return true;}
  validNode(path,index){return !(Array.isArray(this.level.invalidPathRanges)?this.level.invalidPathRanges:[]).some(r=>Number(r.path_id)===path.id&&index+1>=r.from&&index+1<=r.to);}
  nearestPath(point,origin=null,maxRange=Infinity){
    let best=null,d=Infinity;
    for(const path of this.paths.values())if(path.lane===1)for(let i=0;i<path.points.length;i++) {
      const p=path.points[i];if(!this.validNode(path,i)||p.x<0||p.x>this.level.width||p.y<0||p.y>this.level.height||(origin&&distance(origin,p)>maxRange))continue;
      const nd=distance(point,p);if(nd<d){best=p;d=nd;}
    }
    return best?{x:best.x,y:best.y}:{x:clamp(number(point.x,512),0,number(this.level.width,1024)),y:clamp(number(point.y,384),0,number(this.level.height,768))};
  }
  towerStats(tower){
    const base=TOWER_TYPES[tower.type];if(!base)return null;
    const l=tower.level||1,recovered=merge(FALLBACK_TOWERS[tower.type],this.options.towers?.[originalTower[tower.type]]?.stats||{}),attack=recovered.basic_attack||recovered.soldier.basic_attack;
    const damageMin=atLevel(attack.damage_min,l,base.damage),damageMax=atLevel(attack.damage_max,l,base.damage);
    return {...base,cost:atLevel(recovered.price,1,base.cost),prices:recovered.price,range:tower.type==='barracks'?number(recovered.rally_range,150):atLevel(attack.range,l,base.range),rallyRange:number(recovered.rally_range,150),damage:(damageMin+damageMax)/2,damageMin,damageMax,cooldown:atLevel(attack.cooldown,l,base.cooldown),area:number(attack.damage_radius,0),soldier:recovered.soldier,maxSoldiers:number(recovered.max_soldiers,3)};
  }
  maxTowerLevel(tower){
    const type=typeof tower==='string'?tower:tower?.type;if(!originalTower[type])return 0;
    let max=4;for(const lock of this.level.lockedTowers||[]){const m=new RegExp(`^tower_${originalTower[type]}_lvl([1-4])$`).exec(lock);if(m)max=Math.min(max,Number(m[1])-1);}return max;
  }
  upgradeCost(tower){if(!tower?.type||tower.level>=this.maxTowerLevel(tower))return Infinity;return atLevel(this.towerStats(tower).prices,tower.level+1,Infinity);}
  sellValue(tower){return this.wave===0?tower.invested:Math.round(tower.invested*.6);}
  clearCost(slot){const t=typeof slot==='object'?slot:this.towers.find(t=>String(t.id)===String(slot));if(!t?.blocked)return 0;const m=/terrain_(\d)_/.exec(t.template||'');return ({1:60,2:100,3:120})[Number(m?.[1])]??100;}
  clearBlocked(slotId){if(!this.actionable())return false;const t=this.towers.find(t=>String(t.id)===String(slotId));if(!t?.blocked||t.existingTower)return this.fail('此位置无法清理');const cost=this.clearCost(t);if(this.gold<cost)return this.fail('金币不足');this.gold-=cost;t.blocked=false;this.log('clear-blocked',{slotId:t.id,cost});this.emit('build',{x:t.x,y:t.y});return true;}
  build(slotId,type){
    if(!this.actionable())return false;const t=this.towers.find(t=>String(t.id)===String(slotId));
    if(!t||!TOWER_TYPES[type])return this.fail('无效的建造位置');if(t.type)return this.fail('此处已有防御塔');if(t.blocked)return this.fail('请先清理障碍');if(this.maxTowerLevel(type)<1)return this.fail('本关暂未开放此防御塔');
    const cost=this.towerStats({type,level:1}).cost;if(this.gold<cost)return this.fail('金币不足');this.gold-=cost;Object.assign(t,{type,level:1,invested:cost,timer:.16,gift:false,recruits:[]});
    this.emit('build',{x:t.x,y:t.y});this.log('build',{slotId:t.id,tower:type,cost});if(type==='barracks')this.recruit(t);return true;
  }
  upgrade(slotId){
    if(!this.actionable())return false;const t=this.towers.find(t=>String(t.id)===String(slotId));if(!t?.type)return this.fail('请先建造防御塔');if(t.level>=this.maxTowerLevel(t))return this.fail('已达到本关等级上限');const cost=this.upgradeCost(t);if(this.gold<cost)return this.fail('金币不足');
    this.gold-=cost;t.invested+=cost;t.level++;t.timer=Math.min(t.timer,.2);
    for(const u of this.units.filter(u=>u.tower===t.id)){const s=this.soldierStats(t);Object.assign(u,s,{hp:s.maxHp});}
    this.emit('build',{x:t.x,y:t.y});this.log('upgrade',{slotId:t.id,level:t.level,cost});return true;
  }
  sell(slotId){
    if(!this.actionable())return false;const t=this.towers.find(t=>String(t.id)===String(slotId));if(!t?.type)return this.fail('此处没有防御塔');const refund=this.sellValue(t);this.gold+=refund;this.units=this.units.filter(u=>u.tower!==t.id);
    Object.assign(t,{type:null,level:0,invested:0,recruits:[],existingTower:null,gift:false});this.log('sell',{slotId:t.id,refund});this.emit('coin');return true;
  }
  soldierStats(t){const s=this.towerStats(t),r=s.soldier;return {maxHp:atLevel(r.hp,t.level,40),damage:s.damage,damageMin:s.damageMin,damageMax:s.damageMax,armor:atLevel(r.armor,t.level,.1),attackCooldown:s.cooldown,speed:number(r.speed,75),regen:atLevel(r.regen_hp,t.level,3),regenDelay:3,respawnDuration:number(r.dead_lifetime,12),meleeRange:number(r.basic_attack.range,70)};}
  recruit(t){
    const stats=this.soldierStats(t),max=this.towerStats(t).maxSoldiers;
    const occupied=new Set(this.units.filter(u=>u.tower===t.id).map(u=>u.slot));
    for(let i=0;i<max;i++)if(!occupied.has(i)&&!(t.recruits||[]).some(r=>r.slot===i&&r.at>this.time)){
      const home={x:t.rally.x+(i-1)*12,y:t.rally.y+(i%2)*9};this.units.push({id:this.nextId++,kind:'soldier',tower:t.id,slot:i,x:t.x,y:t.y,...stats,hp:stats.maxHp,cooldown:0,target:{...home},home,engaged:null,lastCombat:-Infinity});
    }
    t.recruits=(t.recruits||[]).filter(r=>r.at>this.time);t.spawnTimer=stats.respawnDuration;
  }
  rally(slotId,point){
    if(!this.actionable()||!validPoint(point))return false;const t=this.towers.find(t=>String(t.id)===String(slotId));if(!t||t.type!=='barracks')return this.fail('请选择兵营');const range=this.towerStats(t).rallyRange;
    if(distance(t,point)>range)return this.fail('集结点超出兵营范围');const p=this.nearestPath(point,t,range);if(distance(t,p)>range)return this.fail('范围内没有可用道路');t.rally=p;
    for(const u of this.units.filter(u=>u.tower===t.id)){u.home={x:p.x+(u.slot-1)*12,y:p.y+(u.slot%2)*9};u.target={...u.home};u.engaged=null;}
    this.log('rally',{slotId:t.id,...p});return true;
  }
  moveHero(point){if(!this.actionable()||!validPoint(point))return false;if(this.hero.hp<=0)return this.fail('英雄正在恢复');this.hero.target={x:clamp(point.x,0,this.level.width),y:clamp(point.y,0,this.level.height)};this.hero.home={...this.hero.target};this.hero.engaged=null;this.log('hero',this.hero.target);return true;}
  callWave(){
    if(!this.actionable())return false;if(this.wave>=this.totalWaves)return this.fail('所有波次已派出');
    if(this.queue.length||(this.wave>0&&!this._waitingPrepared))return this.fail('当前波次仍在出兵');
    const reward=this.wave>0&&this.countdown>0?Math.round(this.countdown):0;this.gold+=reward;
    const data=this.campaignWaves[this.wave++];this.phase='playing';this.countdown=0;this._waitingPrepared=false;this.currentWaveData=data;
    this.currentWaveEnd=this.time+Math.max(0,number(data.duration),...data.spawns.map(s=>number(s.time)));
    this.queue=data.spawns.map((s,i)=>({...s,at:this.time+Math.max(0,number(s.time)),order:i})).sort((a,b)=>a.at-b.at||a.order-b.order);
    this.eventQueue=(data.events||[]).map((e,i)=>({...e,at:this.time+Math.max(0,number(e.time)),order:i})).sort((a,b)=>a.at-b.at||a.order-b.order);
    this.log('wave',{wave:this.wave,id:data.id,kind:data.kind,reward});this.emit(data.kind==='boss'?'boss-wave':'wave',{wave:this.wave,label:data.label});return true;
  }
  enemyStats(name,seen=new Set()){
    if(this._enemyStatsCache.has(name))return this._enemyStatsCache.get(name);
    if(seen.has(name))throw new Error('敌人继承关系形成循环');seen.add(name);const meta=this.catalog[name];if(!meta)throw new Error(`缺少敌人数据：${name}`);
    const parent=this.catalog[meta.base]?this.enemyStats(meta.base,seen):{};let stats=merge(parent,meta.stats||meta);
    if(name==='enemy_stage_18_veznan_illusion'||name==='enemy_stage_18_veznan')stats=merge(stats,stats.boss||{});
    if(name==='enemy_stage_18_veznan')stats=merge(stats,stats.real||{});
    this._enemyStatsCache.set(name,stats);return stats;
  }
  spawn(data){
    const meta=this.catalog[data.enemy];if(!meta)throw new Error(`缺少敌人：${data.enemy}`);const stats=this.enemyStats(data.enemy);
    const lane=data.lane>0?data.lane:1+Math.floor(this.random()*(this.pathDefinitions.get(data.path)?.lanes?.length||1));
    const path=this.paths.get(`${data.path}:${lane}`)||this.paths.get(`${data.path}:1`);if(!path)throw new Error(`关卡 ${this.level.id} 缺少路径 ${data.path}:${lane}`);
    const boss=Boolean(data.boss||meta.base==='boss'||/^enemy_boss_|^enemy_stage_18_veznan/.test(data.enemy));
    const val=(v,f)=>atLevel(v,this.difficulty+1,f),hp=val(stats.hp_max??stats.hp??stats.health,45),a=stats.basic_attack||stats.melee_attack||{};
    const node=clamp(Math.trunc(number(data.node,1))-1,0,path.points.length-2),progress=path.lengths[node];
    const e={id:this.nextId++,template:data.enemy,name:meta.name||data.enemy,meta,boss,flying:Boolean(meta.flying||stats.flying),path,pathId:path.id,lane:path.lane,progress,segment:node+1,x:path.points[node].x,y:path.points[node].y,hp,maxHp:hp,speed:val(stats.speed??stats.max_speed,37),armor:clamp(val(stats.armor,0),0,1),magicArmor:clamp(val(stats.magicArmor??stats.magic_armor,0),0,1),gold:val(stats.gold??stats.bounty,boss?(data.enemy.includes('veznan')?0:1):5),damageMin:val(a.damage_min??stats.damage_min,1),damageMax:val(a.damage_max??stats.damage_max,2),damage:val(a.damage_max??stats.damage_max,2),damageType:damageKind(number(a.damage_type,2)),attackCooldown:val(a.cooldown,1),attackArea:val(a.damage_radius,0),lives:val(stats.lives_cost??stats.lives,boss?999:1),cooldown:0,burn:0,facing:1,age:0,route:[path.id],holdUntil:this.time+number(data.arenaDuration),blockerId:null};
    this.enemies.push(e);if(boss)this.emit('boss',{enemy:e.template,name:e.name});return e;
  }
  hit(enemy,damage,type='physical'){
    if(enemy.hp<=0||!Number.isFinite(damage)||damage<0)return 0;
    const armor=type==='magic'?enemy.magicArmor:type==='true'?0:type==='explosive'?enemy.armor*.5:enemy.armor;
    const actual=Math.max(0,Math.floor(Math.round(damage)*(1-clamp(armor,0,1))));enemy.hp-=actual;if(actual)enemy.flash=.12;
    if(enemy.hp<=0){this.gold+=enemy.gold;this.earned+=enemy.gold;this.kills++;this.effects.push({type:'coin',x:enemy.x,y:enemy.y,value:enemy.gold,life:.8,total:.8},{type:'death',x:enemy.x,y:enemy.y,life:.45,total:.45,color:'#b5c890'});this.emit('kill',{enemy:enemy.template,boss:enemy.boss});}
    return actual;
  }
  cast(type,point){
    if(!this.actionable()||!validPoint(point))return false;if(!Object.hasOwn(this.spells,type))return this.fail('未知技能');if(this.spells[type]>0)return this.fail('技能正在冷却');
    if(point.x<0||point.x>this.level.width||point.y<0||point.y>this.level.height)return this.fail('请选择战场内的位置');
    if(type==='meteor'){
      const r=this.powers.rain_of_fire,b=r.bullet;this.spells.meteor=this.spellStats.meteor.cooldown;
      for(let i=0;i<number(r.meteor_count,3);i++){const angle=this.random()*Math.PI*2,radius=number(r.min_spread,25)+this.random()*(number(r.max_spread,40)-number(r.min_spread,25));this.projectiles.push({type:'meteor',x:point.x-180+i*26,y:point.y+300+i*36,targetX:point.x+Math.cos(angle)*radius,targetY:point.y+Math.sin(angle)*radius,damage:this.roll(number(b.damage_min,30),number(b.damage_max,45)),duration:.6+i*.12,elapsed:0,area:number(b.radius,60)});}
    }else{
      const s=this.powers.reinforcements.soldier,a=s.melee_attack,p=this.nearestPath(point);if(distance(p,point)>85)return this.fail('援军需要部署在道路附近');this.spells.reinforcements=this.spellStats.reinforcements.cooldown;
      for(let i=0;i<2;i++){const home={x:p.x+(i-.5)*16,y:p.y};this.units.push({id:this.nextId++,kind:'reinforcement',...home,home,hp:number(s.hp_max,40),maxHp:number(s.hp_max,40),damage:(a.damage_min+a.damage_max)/2,damageMin:number(a.damage_min,2),damageMax:number(a.damage_max,4),armor:number(s.armor),speed:number(s.max_speed,64),regen:number(s.regen_health,8),regenDelay:3,meleeRange:number(a.range,72),attackCooldown:number(a.cooldown,1),cooldown:0,engaged:null,lastCombat:-Infinity,expiry:this.time+number(s.duration,12)});}
      this.effects.push({type:'ring',x:p.x,y:p.y,life:.7,total:.7,color:'#7bbcd3'});
    }
    this.log(type,{...point});this.emit('spell',{spell:type});return true;
  }
  nextPathState(path){
    const id=this.connections.get(path.id);if(!id)return null;const next=this.paths.get(`${id}:${path.lane}`)||this.paths.get(`${id}:1`);let index=0;
    // Tunnel entities in these source levels explicitly reappear at the destination start.
    // Other connections use nearest-node handoff (all/path_db.lua:1481).
    if(![7,12,18].includes(Number(this.level.id))){let d=Infinity;next.points.forEach((p,i)=>{const nd=distance(path.points.at(-1),p);if(nd<d){index=i;d=nd;}});index=Math.min(index+1,next.points.length-2);}
    return {path:next,progress:next.lengths[index],segment:index+1};
  }
  remainingDistance(e){let total=e.path.total-e.progress,p=e.path,guard=0;while(this.connections.has(p.id)&&guard++<this.paths.size){const n=this.nextPathState(p);total+=n.path.total-n.progress;p=n.path;}return total;}
  positionEnemy(e){while(e.segment<e.path.points.length-1&&e.path.lengths[e.segment]<e.progress)e.segment++;const a=e.path.points[e.segment-1],b=e.path.points[e.segment],t=(e.progress-e.path.lengths[e.segment-1])/Math.max(.00001,e.path.lengths[e.segment]-e.path.lengths[e.segment-1]);const x=a.x+(b.x-a.x)*t;if(Math.abs(x-e.x)>.05)e.facing=x>e.x?1:-1;e.x=x;e.y=a.y+(b.y-a.y)*t;}
  advanceEnemy(e,dt){
    e.progress+=e.speed*dt;
    while(e.progress>=e.path.total){const carry=e.progress-e.path.total,next=this.nextPathState(e.path);if(next){const from=e.path.id;Object.assign(e,next,{pathId:next.path.id,lane:next.path.lane});e.progress+=carry;e.route.push(e.path.id);this.emit('path-transition',{id:e.id,from,to:e.path.id});}else{e.hp=-Infinity;this.lives=Math.max(0,this.lives-e.lives);this.emit('leak',{lives:e.lives,enemy:e.template});if(this.lives<=0){this.phase='lost';this.emit('lost');}return;}}
    this.positionEnemy(e);
  }
  damageUnit(u,e){const reduction=e.damageType==='true'?0:e.damageType==='magic'?(u.magicArmor||0):e.damageType==='explosive'?(u.armor||0)*.5:(u.armor||0);const raw=this.roll(e.damageMin,e.damageMax);u.hp-=Math.max(0,raw-Math.floor(raw*reduction));u.lastCombat=this.time;if(u.hp<=0&&u.kind==='hero'){u.respawn=u.respawnDuration;u.target=null;u.engaged=null;this.emit('hero-down');}}
  update(dt){if(this.paused||finished(this.phase)||!Number.isFinite(dt)||dt<=0)return;let remaining=Math.min(.25,dt)*this.speed;while(remaining>1e-8&&!finished(this.phase)){const step=Math.min(1/30,remaining);this.tick(step);remaining-=step;}}
  tick(dt){
    this.time+=dt;for(const key of Object.keys(this.spells))this.spells[key]=Math.max(0,this.spells[key]-dt);
    while(this.queue.length&&this.queue[0].at<=this.time+1e-8)this.spawn(this.queue.shift());
    while(this.eventQueue.length&&this.eventQueue[0].at<=this.time+1e-8){const e=this.eventQueue.shift();this.emit('stage-event',{command:e.command,parameters:e.parameters||[],manualGroup:e.manualGroup});}
    for(const e of this.effects)e.life-=dt;this.effects=this.effects.filter(e=>e.life>0);
    // Each defender engages one enemy; several defenders may attack the same enemy.
    // Original enemy.max_blockers defaults to nil (all/components.lua:456).
    for(const u of this.units){u.cooldown=Math.max(0,u.cooldown-dt);u.attacking=false;u.moving=false;
      if(u.kind==='hero'&&u.hp<=0){u.respawn-=dt;if(u.respawn<=0){u.hp=u.maxHp;u.x=u.home.x;u.y=u.home.y;this.emit('hero-return');}continue;}
      if(u.hp<=0||(u.expiry&&u.expiry<=this.time))continue;
      if(u.target&&distance(u,u.target)>2){const d=distance(u,u.target);u.facing=Math.sign(u.target.x-u.x)||1;u.x+=(u.target.x-u.x)/d*Math.min(d,dt*u.speed);u.y+=(u.target.y-u.y)/d*Math.min(d,dt*u.speed);u.moving=true;u.engaged=null;continue;}
      u.target=null;
      let target=this.enemies.find(e=>e.id===u.engaged&&e.hp>0&&!e.flying&&distance(e,u)<u.meleeRange+16);
      if(!target)target=this.enemies.filter(e=>e.hp>0&&!e.flying&&distance(u,e)<u.meleeRange&&distance(u.home,e)<u.meleeRange+25).sort((a,b)=>distance(u,a)-distance(u,b))[0];
      if(target){u.engaged=target.id;u.lastCombat=this.time;const d=distance(u,target);u.facing=Math.sign(target.x-u.x)||1;
        if(d>20){u.x+=(target.x-u.x)/d*Math.min(d-18,dt*u.speed);u.y+=(target.y-u.y)/d*Math.min(d-18,dt*u.speed);u.moving=true;}
        else{u.attacking=true;if(u.cooldown<=0){this.hit(target,this.roll(u.damageMin,u.damageMax));u.cooldown=u.attackCooldown;this.effects.push({type:'slash',x:target.x,y:target.y,life:.17,total:.17});}}
      }else{u.engaged=null;if(this.time-u.lastCombat>u.regenDelay)u.hp=Math.min(u.maxHp,u.hp+dt*u.regen);if(distance(u,u.home)>3)u.target={...u.home};}
    }
    for(const e of this.enemies){if(e.hp<=0)continue;e.age+=dt;e.flash=Math.max(0,(e.flash||0)-dt);e.cooldown-=dt;
      const blocker=!e.flying&&this.units.find(u=>u.hp>0&&u.engaged===e.id&&distance(e,u)<=26&&(!u.expiry||u.expiry>this.time));e.blocked=Boolean(blocker);e.blockerId=blocker?.id??null;
      if(blocker){if(e.cooldown<=0){if(e.attackArea>0){for(const u of this.units)if(u.hp>0&&distance(u,blocker)<=e.attackArea)this.damageUnit(u,e);}else this.damageUnit(blocker,e);e.cooldown=e.attackCooldown;}}
      else if(this.time>=e.holdUntil)this.advanceEnemy(e,dt);
      if(this.phase==='lost')break;
    }
    for(const u of this.units)if(u.hp<=0&&u.kind==='soldier'){const t=this.towers.find(t=>t.id===u.tower);if(t)t.recruits.push({slot:u.slot,at:this.time+u.respawnDuration});}
    this.units=this.units.filter(u=>u.kind==='hero'||u.hp>0&&(!u.expiry||u.expiry>this.time));
    for(const t of this.towers){if(!t.type)continue;if(t.type==='barracks'){this.recruit(t);continue;}t.timer-=dt;if(t.timer>0)continue;const s=this.towerStats(t);
      const target=this.enemies.filter(e=>e.hp>0&&(t.type!=='artillery'||!e.flying)&&distance(t,e)<=s.range).sort((a,b)=>this.remainingDistance(a)-this.remainingDistance(b))[0];if(!target)continue;
      t.timer=s.cooldown;t.lastShot=this.time;t.facing=target.x>t.x?1:-1;this.projectiles.push({type:t.type,x:t.x,y:t.y+48,target,targetX:target.x,targetY:target.y,damage:this.roll(s.damageMin,s.damageMax),duration:t.type==='mage'?.2:t.type==='artillery'?.65:.35,elapsed:0,area:t.type==='artillery'?s.area:0});this.emit('shoot',{tower:t.type});
    }
    for(const p of this.projectiles){p.elapsed+=dt;if(p.target?.hp>0&&!p.area){p.targetX=p.target.x;p.targetY=p.target.y;}if(p.elapsed>=p.duration){if(p.area){for(const e of this.enemies)if(e.hp>0&&distance(e,{x:p.targetX,y:p.targetY})<=p.area&&(p.type==='meteor'||!e.flying))this.hit(e,p.damage,p.type==='meteor'?'true':'explosive');this.effects.push({type:'blast',x:p.targetX,y:p.targetY,radius:p.area,life:.55,total:.55,color:p.type==='meteor'?'#ff9b46':'#dfb585'});this.emit('impact');}else if(p.target?.hp>0)this.hit(p.target,p.damage,p.type==='mage'?'magic':'physical');}}
    this.projectiles=this.projectiles.filter(p=>p.elapsed<p.duration);this.enemies=this.enemies.filter(e=>e.hp>0);if(this.phase==='lost')return;
    if(this.wave>0&&!this.queue.length&&this.time>=this.currentWaveEnd){
      const clear=!this.enemies.length,needClear=this.currentWaveData?.kind==='boss'||this.campaignWaves[this.wave]?.kind==='boss'||this.currentWaveData?.events?.some(e=>e.command==='wait_signal'&&e.parameters?.[0]==='all_enemies_died');
      if(this.wave===this.totalWaves){if(clear){this.phase='won';this.emit('won',{stars:this.stars});}}
      else if(!this._waitingPrepared&&(!needClear||clear)){this._waitingPrepared=true;this.phase='waiting';this.countdown=number(this.campaignWaves[this.wave].interval,12);this.emit('clear',{enemiesRemaining:this.enemies.length});}
    }
    if(this.phase==='waiting'&&this.countdown>=0){this.countdown=Math.max(0,this.countdown-dt);if(this.countdown<=1e-8)this.callWave();}
  }
  get stars(){return this.lives>=this.initialLives*.8?3:this.lives>=this.initialLives*.5?2:1;}
  snapshot(){return {level:this.level.id,phase:this.phase,paused:this.paused,wave:this.wave,totalWaves:this.totalWaves,gold:this.gold,lives:this.lives,enemies:this.enemies.length,kills:this.kills,towers:this.towers.filter(t=>t.type).map(t=>({id:t.id,type:t.type,level:t.level})),time:+this.time.toFixed(2),hero:{hp:Math.round(this.hero.hp),x:Math.round(this.hero.x),y:Math.round(this.hero.y),level:this.hero.level,respawn:Math.max(0,this.hero.respawn)},spells:{...this.spells},waveKind:this.currentWaveData?.kind||'regular'};}
}
function groupsTutorial(level){return (level.manualWaves||[]).some(w=>!/^boss/i.test(String(w.id)));}
