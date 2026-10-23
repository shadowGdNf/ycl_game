import { Game, TOWER_TYPES } from './engine.js';
import { Assets, Renderer, json } from './render.js';
const $ = id => document.getElementById(id);
const icon = name => `<svg aria-hidden="true"><use href="#i-${name}"/></svg>`;
const escapeHTML = text => String(text).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const GAME_ID='xinqicheng-web-campaign',SAVE_KEY=`${GAME_ID}:v1`;
const assets=new Assets(), renderer=new Renderer($('game-canvas'),assets);
const runtimeErrors=[];
let data,scene='loading',game=null,selectedLevel=1,selectedSlot=null,target=null,sceneGeneration=0,resultShown=false;
let save={gameId:GAME_ID,version:1,stars:{},lastLevel:1,sound:true}, storageAvailable=true;
try{const raw=localStorage.getItem(SAVE_KEY);if(raw)save=validateSave(JSON.parse(raw));}catch{storageAvailable=false;}
function validateSave(value){
  if(!value||value.gameId!==GAME_ID||value.version!==1||typeof value.stars!=='object'||value.stars===null||Array.isArray(value.stars))throw new Error('这不是兼容的新启程进度文件。');
  const stars={};for(const [k,v]of Object.entries(value.stars)){const id=Number(k);if(!Number.isInteger(id)||id<1||id>18||!Number.isInteger(v)||v<1||v>3)throw new Error('进度中的关卡或星级超出范围。');stars[id]=v;}
  const lastLevel=Number(value.lastLevel);if(!Number.isInteger(lastLevel)||lastLevel<1||lastLevel>18)throw new Error('进度中的关卡编号无效。');
  return{gameId:GAME_ID,version:1,stars,lastLevel,sound:value.sound!==false};
}
function persist(){try{localStorage.setItem(SAVE_KEY,JSON.stringify(save));storageAvailable=true;}catch{if(storageAvailable)toast('浏览器无法保存进度，可使用「导出进度」保留本次记录。');storageAvailable=false;}}
function on(id,handler){$(id).addEventListener('click',e=>Promise.resolve(handler(e)).catch(fail));}
function fail(error){console.error(error);runtimeErrors.push(String(error?.stack||error));if(game)game.paused=true;toast(`发生错误：${error.message||error}`);}
let toastTimer;function toast(message){$('toast').textContent=message;$('toast').hidden=false;clearTimeout(toastTimer);toastTimer=setTimeout(()=>$('toast').hidden=true,4200);}
function showScene(name){scene=name;for(const id of ['menu','campaign','battle'])$(id).hidden=id!==name;$('loading').hidden=true;requestAnimationFrame(resize);}
function unlocked(id){return id===1||Boolean(save.stars[id-1]);}
function totalStars(){return Object.values(save.stars).reduce((a,b)=>a+b,0);}

class Sound {
  constructor(){this.music=null;this.musicName=null;this.effects=new Map();this.enabled=save.sound;this.activated=false;this.lastEffect=0;}
  activate(){this.activated=true;this.playMusic(scene==='battle'?'battle':'map');}
  playMusic(name){
    if(!this.activated||!this.enabled)return;
    if(this.musicName===name&&this.music){this.music.play().catch(()=>{});return;}
    this.music?.pause();this.musicName=name;this.music=new Audio(`assets/audio/${name}.mp3`);this.music.loop=true;this.music.volume=.24;this.music.play().catch(()=>{});
  }
  effect(name){if(!this.enabled||!this.activated)return;const now=performance.now();if(name==='explosion'&&now-this.lastEffect<130)return;this.lastEffect=now;let a=this.effects.get(name);if(!a){a=new Audio(`assets/audio/${name}.mp3`);a.volume=name==='wave'?.3:.4;this.effects.set(name,a);}a.currentTime=0;a.play().catch(()=>{});}
  toggle(){this.enabled=!this.enabled;save.sound=this.enabled;persist();if(!this.enabled)this.music?.pause();else this.activate();updateSound();toast(this.enabled?'声音已开启':'声音已关闭');}
}
const sound=new Sound();
function updateSound(){for(const b of document.querySelectorAll('.sound-toggle')){b.style.opacity=save.sound?'1':'.45';b.setAttribute('aria-label',save.sound?'关闭声音':'开启声音');b.setAttribute('aria-pressed',String(save.sound));}}

async function boot(){
  try{
    $('retry-load').hidden=true;$('load-status').textContent='正在展开远征地图…';
    const [mechanics]=await Promise.all([json('data/mechanics.json'),assets.init()]);data=mechanics;
    $('load-bar').style.width='70%';
    const [models,scenery]=await Promise.all([json('data/render-models.json'),json('data/scenery.json')]);renderer.models=models.models;assets.scenery=scenery;
    $('load-bar').style.width='100%';selectedLevel=unlocked(save.lastLevel)?save.lastLevel:1;
    $('continue-game').hidden=totalStars()===0;updateSound();showScene('menu');
    if(!storageAvailable)toast('此浏览器的存储不可用，游玩后可在地图中导出进度。');
  }catch(error){console.error(error);$('load-status').textContent=`加载失败：${error.message}`;$('retry-load').hidden=false;}
}
on('retry-load',boot);
function renderLevelList(){
  $('total-stars').textContent=totalStars();
  $('level-list').replaceChildren();
  for(const level of data.levels){const button=document.createElement('button');button.className=`level-card${selectedLevel===level.id?' selected':''}${unlocked(level.id)?'':' locked'}`;button.dataset.level=level.id;button.setAttribute('aria-label',`第${level.id}关 ${level.name.replace(/^\d+\.\s*/,'')}${unlocked(level.id)?'':' 尚未解锁'}`);button.setAttribute('aria-pressed',String(selectedLevel===level.id));button.innerHTML=`<span class="num">${String(level.id).padStart(2,'0')}</span><strong>${escapeHTML(level.name.replace(/^\d+\.\s*/,''))}</strong><span class="stars">${[1,2,3].map(n=>`<span class="${n<=(save.stars[level.id]||0)?'earned':''}">★</span>`).join('')}</span>${unlocked(level.id)?'':'<span class="lock">未解锁</span>'}`;button.onclick=()=>selectLevel(level.id).catch(fail);$('level-list').append(button);}
}
async function selectLevel(id){
  selectedLevel=id;const level=data.levels.find(l=>l.id===id);renderLevelList();
  $('level-number').textContent=String(id).padStart(2,'0');$('level-title').textContent=level.name.replace(/^\d+\.\s*/,'');$('level-history').textContent=level.history;$('level-region').textContent=id<=6?'王国边境':id<=12?'深入险境':'决战之路';$('level-waves').textContent=level.waves.length;$('level-gold').textContent=level.gold;
  $('start-level').disabled=!unlocked(id);$('start-level').innerHTML=unlocked(id)?`进入战场 ${icon('arrow')}`:'完成上一关后解锁';$('level-lock-tip').textContent=unlocked(id)?'点击建造点部署防线，准备好后召唤第一波。':'先完成前一关的战役，继续向王国深处进军。';
  const ctx=$('level-preview').getContext('2d');ctx.fillStyle='#233d32';ctx.fillRect(0,0,700,384);
  await assets.group(`go_stage${String(id).padStart(2,'0')}_bg`);if(selectedLevel===id)assets.background(ctx,id,700,384);
}
async function openCampaign(){if(game)game.paused=true;showScene('campaign');sound.playMusic('map');await selectLevel(selectedLevel);}
on('open-campaign',()=>{sound.activate();return openCampaign();});
on('continue-game',()=>{sound.activate();return startLevel(unlocked(save.lastLevel)?save.lastLevel:1);});
on('back-menu',()=>{showScene('menu');sound.playMusic('map');$('continue-game').hidden=totalStars()===0;});
on('start-level',()=>startLevel(selectedLevel));

async function startLevel(id){
  if(!unlocked(id))return;
  const generation=++sceneGeneration;const level=data.levels.find(l=>l.id===id);selectedLevel=id;
  if(game)game.paused=true;closeModal();showScene('battle');$('battle-stage').textContent=`战役 ${String(id).padStart(2,'0')} / 18`;$('battle-name').textContent=level.name.replace(/^\d+\.\s*/,'');
  $('battle-banner').textContent='正在准备战场…';$('battle-banner').hidden=false;$('next-wave').disabled=true;
  try{
    const candidate=new Game(level,data.enemies,{...data,seed:703+id});
    await assets.stage({...level,waves:candidate.campaignWaves||level.waves},data,p=>{$('battle-banner').textContent=`正在准备战场 ${Math.round(p*100)}%`;});
    if(generation!==sceneGeneration)return;
    game=candidate;resultShown=false;selectedSlot=null;setTarget(null);renderer.selected=null;renderer.setZoom(1);$('zoom-reset').textContent='1×';
    save.lastLevel=id;persist();sound.activate();sound.playMusic('battle');$('battle-banner').hidden=true;$('battle-tip').hidden=false;$('battle-tip').textContent='点击金色建造点，建立第一道防线。';
    refreshSelection();refreshHUD();resize();renderer.render(game);
    if(innerHeight>innerWidth)toast('横屏可获得更大视野；也可以用 ＋ 放大战场、拖动查看。');
  }catch(error){fail(error);$('battle-banner').textContent='素材加载失败，请返回地图后重试。';$('battle-banner').hidden=false;}
}

function setTarget(mode){target=mode;renderer.target=mode;renderer.pointer=null;$('target-hint').hidden=!mode;if(mode)$('target-hint').querySelector('span').textContent=mode==='meteor'?'选择火雨落点':mode==='reinforcements'?'选择援军部署位置':mode==='rally'?'选择兵营范围内的集结点':'选择英雄前进的位置';for(const key of ['hero','meteor','reinforcements'])$(key).classList.toggle('active',mode===key);}
function selectSlot(id){selectedSlot=id;renderer.selected=id;setTarget(null);refreshSelection();}
function refreshSelection(){
  const tower=game?.towers.find(t=>t.id===selectedSlot);$('selection').classList.toggle('open',Boolean(tower));$('close-selection').hidden=!tower;$('build-options').replaceChildren();$('tower-actions').hidden=true;$('enemy-info').hidden=true;$('field-guide').hidden=Boolean(tower);
  if(!tower){$('selection-label').textContent='指挥中心';$('selection-title').textContent='守住王国';$('selection-copy').textContent='点击战场上的建造点选择防御塔。搭配远程火力和士兵，截住每一支敌军。';return;}
  $('selection-label').textContent=`建造点 ${tower.id}`;
  if(!tower.type){
    if(tower.blocked){$('selection-title').textContent='清理建造点';$('selection-copy').textContent='清理障碍后，可在这里建立防线。';$('tower-actions').hidden=false;$('tower-actions').innerHTML=`<div class="tower-controls"><button id="clear-slot" class="primary">清理 · ${game.clearCost?.(tower)??100} 金币</button></div>`;on('clear-slot',()=>{if(game.clearBlocked?.(tower.id)){sound.effect('build');refreshSelection();}else toast(game.lastError||'金币不足，暂时无法清理。');});return;}
    $('selection-title').textContent='建立防线';$('selection-copy').textContent='选择防御塔。建造后可继续升级，提升伤害与射程。';
    Object.entries(TOWER_TYPES).forEach(([type,def],i)=>{const stats=game.towerStats({type,level:1});const button=document.createElement('button');button.className='build-card';button.dataset.tower=type;button.setAttribute('aria-label',`建造${def.name} ${stats.cost}金币`);button.innerHTML=`<canvas width="100" height="100"></canvas><span class="build-label"><b>${escapeHTML(def.name)}</b><small>${escapeHTML(def.caption.split(' · ')[0])}</small></span><span class="price">${stats.cost}</span><kbd>${i+1}</kbd>`;button.disabled=game.gold<stats.cost||game.paused;button.onclick=()=>build(type);$('build-options').append(button);const ctx=button.querySelector('canvas').getContext('2d');ctx.save();ctx.translate(50,75);renderer.tower(ctx,{type,level:1,x:0,y:768},game.time);ctx.restore();});
  }else{
    const def=TOWER_TYPES[tower.type],stats=game.towerStats(tower),max=game.maxTowerLevel?.(tower)??4;
    $('selection-title').textContent=`${def.name} · ${tower.level} 级`;$('selection-copy').textContent=def.caption;$('tower-actions').hidden=false;
    $('tower-actions').innerHTML=`<div class="tower-stat-row"><span>平均伤害</span><b>${Math.round(stats.damage)}</b></div><div class="tower-stat-row"><span>攻击范围</span><b>${Math.round(stats.range)}</b></div><div class="tower-controls"><button id="upgrade-tower" class="primary" ${tower.level>=max?'disabled':''}>${tower.level>=max?'已达本关最高等级':`升级 · ${game.upgradeCost(tower)} 金币`}</button>${tower.type==='barracks'?'<button id="rally-tower" class="quiet-btn">调整集结点</button>':''}<button id="sell-tower" class="quiet-btn sell-btn">出售 · +${game.sellValue(tower)}</button></div>`;
    on('upgrade-tower',()=>{if(game.upgrade(tower.id)){sound.effect('build');refreshSelection();}else toast(game.lastError||'金币不足，暂时无法升级。');});
    if(tower.type==='barracks')on('rally-tower',()=>{setTarget('rally');$('selection').classList.remove('open');});
    on('sell-tower',()=>{if(game.sell(tower.id)){toast('防御塔已出售。');refreshSelection();}});
  }
}
function build(type){if(selectedSlot===null)return;if(game.build(selectedSlot,type)){sound.effect('build');$('battle-tip').hidden=true;refreshSelection();refreshHUD();}else toast(game.lastError||'金币不足或当前无法建造。');}
on('close-selection',()=>selectSlot(null));on('cancel-target',()=>setTarget(null));
for(const type of ['hero','meteor','reinforcements'])on(type,()=>{if(!game||game.paused||['won','lost'].includes(game.phase))return;if(type!=='hero'&&game.spells[type]>0){toast('技能正在冷却。');return;}selectedSlot=null;renderer.selected=null;refreshSelection();setTarget(target===type?null:type);});
on('next-wave',()=>{if(game?.callWave()){$('battle-tip').hidden=true;refreshHUD();}});
on('speed',()=>{if(!game)return;const n=game.speed===1?2:game.speed===2?3:1;game.setSpeed?game.setSpeed(n):game.speed=n;$('speed').textContent=`${game.speed}×`;});

function refreshHUD(){
  if(!game)return;$('hud-lives').textContent=game.lives;$('hud-gold').textContent=Math.floor(game.gold);$('hud-wave').textContent=`${game.wave} / ${game.totalWaves??game.level.waves.length}`;$('speed').textContent=`${game.speed}×`;
  const total=game.totalWaves??game.level.waves.length;const canCall=!game.paused&&game.wave<total&&!game.queue.length&&!['won','lost'].includes(game.phase);$('next-wave').disabled=!canCall;
  $('next-wave').querySelector('span').textContent=game.wave===0?'召唤第一波':game.wave===total?'最后一波':game.phase==='waiting'?`下一波 · ${Math.max(0,Math.ceil(game.countdown))}秒`:`召唤第 ${game.wave+1} 波`;
  for(const key of ['meteor','reinforcements']){const seconds=Math.ceil(game.spells[key]);$(key).querySelector('.cooldown').textContent=seconds>0?seconds:'';$(key).disabled=seconds>0||game.paused;}
  $('hero-status').textContent=game.hero.hp>0?`生命 ${Math.ceil(game.hero.hp)} / ${game.hero.maxHp}`:`回归倒计时 ${Math.ceil(game.hero.respawn)}秒`;
  $('hero').disabled=game.hero.hp<=0||game.paused;
  for(const b of document.querySelectorAll('[data-tower]'))b.disabled=game.gold<game.towerStats({type:b.dataset.tower,level:1}).cost||game.paused;
  const selection=game.towers.find(t=>t.id===selectedSlot);if(selection?.type){if($('sell-tower'))$('sell-tower').textContent=`出售 · +${game.sellValue(selection)}`;if($('upgrade-tower'))$('upgrade-tower').disabled=game.paused||selection.level>=game.maxTowerLevel(selection)||game.gold<game.upgradeCost(selection);}
}
function processEvents(){for(const e of game.events.splice(0)){if(e.type==='wave'){sound.effect('wave');banner(`第 ${e.wave} 波敌军来袭`);}else if(e.type==='impact')sound.effect('explosion');else if(e.type==='hero-down')toast('英雄正在恢复，稍后将重返战场。');else if(e.type==='leak')toast(`敌人突破防线，损失 ${e.lives} 点生命。`);else if(e.type==='won'||e.type==='lost')showResult(e.type==='won');}}
let bannerTimer;function banner(text){$('battle-banner').textContent=text;$('battle-banner').hidden=false;clearTimeout(bannerTimer);bannerTimer=setTimeout(()=>$('battle-banner').hidden=true,2100);}
function showResult(won){if(resultShown)return;resultShown=true;setTarget(null);if(won){save.stars[game.level.id]=Math.max(save.stars[game.level.id]||0,game.stars);save.lastLevel=Math.min(18,game.level.id+1);persist();}const next=game.level.id+1;openModal(`<div class="result"><p class="eyebrow">${won?'VICTORY':'TRY AGAIN'}</p><h2>${won?'王国因你而守住':'防线失守'}</h2><p>${escapeHTML(game.level.name)}</p>${won?`<div class="result-stars">${[1,2,3].map(n=>`<span class="${n<=game.stars?'earned':''}">${icon('star')}</span>`).join('')}</div>`:'<p>调整防御塔的位置，善用援军与火雨，再战一次。</p>'}<div class="result-stats"><div><b>${game.kills}</b><span>击败敌人</span></div><div><b>${game.lives}</b><span>剩余生命</span></div><div><b>${Math.floor(game.time/60)}:${String(Math.floor(game.time%60)).padStart(2,'0')}</b><span>战役用时</span></div></div><button id="result-primary" class="primary">${won&&next<=18?'继续下一关':'重新挑战'}</button><button id="result-map" class="quiet-btn">返回远征地图</button></div>`,false);on('result-primary',()=>startLevel(won&&next<=18?next:game.level.id));on('result-map',()=>{selectedLevel=won?Math.min(18,next):game.level.id;closeModal();return openCampaign();});}

let modalClosable=true,modalResume=false;
function openModal(html,closable=true,resume=false){$('modal-content').innerHTML=html;modalClosable=closable;modalResume=resume;$('modal-close').hidden=!closable;if(!$('modal').open)$('modal').showModal();}
function closeModal(){if($('modal').open)$('modal').close();if(modalResume&&game&&!['won','lost'].includes(game.phase)){game.paused=false;modalResume=false;refreshHUD();}modalClosable=true;}
on('modal-close',closeModal);$('modal').addEventListener('cancel',e=>{e.preventDefault();if(modalClosable)closeModal();});
function pause(){if(!game||['won','lost'].includes(game.phase))return;if($('modal').open){closeModal();return;}game.paused=true;refreshHUD();openModal(`<p class="eyebrow">TAKE A BREATH</p><h2>战斗已暂停</h2><p>防线会在这里等你。准备好后继续指挥。</p><button id="resume-game" class="primary">继续战斗</button><button id="restart-game" class="quiet-btn">重新开始本关</button><button id="pause-map" class="quiet-btn">返回远征地图</button>`,true,true);on('resume-game',closeModal);on('restart-game',()=>{modalResume=false;return startLevel(game.level.id);});on('pause-map',()=>{modalResume=false;closeModal();return openCampaign();});}
on('pause',pause);on('battle-map',pause);
function help(){const resume=scene==='battle'&&game&&!game.paused;if(resume)game.paused=true;openModal(`<p class="eyebrow">FIELD MANUAL</p><h2>指挥官手册</h2><div class="help-row"><b>建造防线</b><span>点击金色「＋」建造点，选择防御塔。再次选中防御塔可升级、出售或调整兵营集结点。</span></div><div class="help-row"><b>英雄与技能</b><span>先点击底部的英雄、火雨或援军，再点击战场上的目标位置。</span></div><div class="help-row"><b>电脑操作</b><span>1–4 建塔 · Q 火雨 · W 援军 · E 英雄 · N 下一波 · 空格 / P 暂停 · Esc 取消</span></div><div class="help-row"><b>手机操作</b><span>所有操作都支持触控。可用双指或 ＋ / − 缩放，放大后拖动战场。横屏视野更开阔。</span></div><div class="help-row"><b>保存进度</b><span>通关星级自动保存在当前浏览器。地图中可导出进度，换设备后导入；战斗中途不保存。</span></div>`,true,resume);}
for(const b of document.querySelectorAll('.help-open'))b.onclick=help;
on('about-open',()=>openModal(`<p class="eyebrow">ABOUT THIS EDITION</p><h2>新启程 · 网页战役</h2><p>基于所提供 APK 中恢复的原画面、音频、18 关地图、路径与波次数据，重建的浏览器塔防版本。</p><p>当前可使用四类基础防御塔、杰拉尔德、火雨与援军。支持触控、键盘、存档导入和导出。</p><p class="about-note">这是本地网页重构版本，并非原 APK 的完整等价移植。复杂 Boss 阶段、关卡机关、其他英雄与塔、技能树、剧情流程及其他挑战模式尚未完整还原。部分时序和战斗规则由网页运行层实现。不会连接原游戏的账户、支付或统计服务。</p>`));
for(const b of document.querySelectorAll('.sound-toggle'))b.onclick=()=>sound.toggle();
for(const b of document.querySelectorAll('.fullscreen'))b.onclick=async()=>{try{if(document.fullscreenElement)await document.exitFullscreen();else await document.documentElement.requestFullscreen();try{await screen.orientation.lock('landscape');}catch{}}catch{toast('当前浏览器不支持全屏，可使用浏览器的全屏或横屏模式。');}};

on('export-save',()=>{const blob=new Blob([JSON.stringify({...save,exportedAt:new Date().toISOString()},null,2)],{type:'application/json'});const a=document.createElement('a');const url=URL.createObjectURL(blob);a.href=url;a.download='新启程-战役进度.json';a.click();setTimeout(()=>URL.revokeObjectURL(url),1000);});
on('import-save',()=>$('save-file').click());$('save-file').addEventListener('change',async()=>{const file=$('save-file').files[0];if(!file)return;try{if(file.size>65536)throw new Error('进度文件过大（最多64KB）。');const imported=validateSave(JSON.parse(await file.text()));for(const [id,stars]of Object.entries(imported.stars))save.stars[id]=Math.max(save.stars[id]||0,stars);save.lastLevel=unlocked(imported.lastLevel)?imported.lastLevel:save.lastLevel;persist();selectedLevel=save.lastLevel;await selectLevel(selectedLevel);toast('进度已导入，已有星级已保留。');}catch(error){toast(error.message||'无法读取这个进度文件。');}finally{$('save-file').value='';}});

const canvas=$('game-canvas'),pointers=new Map();let drag=null,pinch=null;
canvas.addEventListener('pointerdown',e=>{if(!game)return;canvas.setPointerCapture(e.pointerId);pointers.set(e.pointerId,{x:e.clientX,y:e.clientY});drag={x:e.clientX,y:e.clientY,lastX:e.clientX,lastY:e.clientY,moved:false};if(pointers.size===2){const p=[...pointers.values()];pinch={distance:Math.hypot(p[0].x-p[1].x,p[0].y-p[1].y),zoom:renderer.zoom};drag.moved=true;}renderer.pointer=renderer.position(e.clientX,e.clientY);});
canvas.addEventListener('pointermove',e=>{renderer.pointer=renderer.position(e.clientX,e.clientY);if(!pointers.has(e.pointerId))return;pointers.set(e.pointerId,{x:e.clientX,y:e.clientY});if(pointers.size===2&&pinch){const p=[...pointers.values()];renderer.setZoom(pinch.zoom*Math.hypot(p[0].x-p[1].x,p[0].y-p[1].y)/Math.max(1,pinch.distance));$('zoom-reset').textContent=`${renderer.zoom.toFixed(1)}×`;return;}if(drag&&renderer.zoom>1){if(Math.hypot(e.clientX-drag.x,e.clientY-drag.y)>7)drag.moved=true;if(drag.moved){const r=canvas.getBoundingClientRect();renderer.pan.x+=(e.clientX-drag.lastX)*1400/r.width;renderer.pan.y+=(e.clientY-drag.lastY)*768/r.height;renderer.clampPan();}drag.lastX=e.clientX;drag.lastY=e.clientY;}});
canvas.addEventListener('pointerup',e=>{const tapped=drag&&!drag.moved&&!pinch;pointers.delete(e.pointerId);if(pointers.size===0){pinch=null;drag=null;}if(tapped)battleClick(renderer.position(e.clientX,e.clientY));});
canvas.addEventListener('pointercancel',()=>{pointers.clear();pinch=null;drag=null;});
canvas.addEventListener('wheel',e=>{e.preventDefault();renderer.setZoom(renderer.zoom+(e.deltaY<0?.15:-.15));$('zoom-reset').textContent=`${renderer.zoom.toFixed(1)}×`;},{passive:false});
function battleClick(point){if(!game||game.paused||['won','lost'].includes(game.phase))return;if(target){let ok=false;if(target==='hero')ok=game.moveHero(point);else if(target==='rally')ok=game.rally(selectedSlot,point);else ok=game.cast(target,point);if(ok){setTarget(null);refreshHUD();}else toast(game.lastError||'此位置不可用，请在有效范围内选择。');return;}const t=game.towers.slice().sort((a,b)=>Math.hypot(a.x-point.x,a.y-point.y)-Math.hypot(b.x-point.x,b.y-point.y)).find(t=>Math.hypot(t.x-point.x,(t.y-point.y)*1.2)<(t.type?52:40));selectSlot(t?.id??null);}
for(const [id,amount]of [['zoom-in',.3],['zoom-out',-.3]])on(id,()=>{renderer.setZoom(renderer.zoom+amount);$('zoom-reset').textContent=`${renderer.zoom.toFixed(1)}×`;});on('zoom-reset',()=>{renderer.setZoom(1);$('zoom-reset').textContent='1×';});
document.addEventListener('keydown',e=>{if(scene!=='battle'||/INPUT|TEXTAREA|SELECT/.test(e.target.tagName))return;const key=e.key.toLowerCase();if([' ','p','n','q','w','e','1','2','3','4','escape'].includes(key))e.preventDefault();if($('modal').open){if(modalClosable&&(key===' '||key==='p'))closeModal();return;}if(key==='escape'){setTarget(null);selectSlot(null);}else if(key===' '||key==='p')pause();else if(key==='n')$('next-wave').click();else if(['q','w','e'].includes(key))$({q:'meteor',w:'reinforcements',e:'hero'}[key]).click();else if(/^[1-4]$/.test(key))build(Object.keys(TOWER_TYPES)[Number(key)-1]);});
function resize(){if(scene!=='battle')return;const middle=document.querySelector('.battle-middle');const landscape=innerWidth>innerHeight;const overlay=innerHeight<=540&&landscape;const portrait=innerWidth<=700&&!overlay;const available=middle.clientWidth-(portrait||overlay?0:$('selection').offsetWidth);const width=portrait?available:Math.min(available,middle.clientHeight*1400/768);$('viewport').style.width=`${width}px`;$('viewport').style.height=`${width*768/1400}px`;$('viewport').style.flex='none';}
window.addEventListener('resize',resize);document.addEventListener('visibilitychange',()=>{if(document.hidden){sound.music?.pause();if(scene==='battle'&&game&&!game.paused&&!['won','lost'].includes(game.phase))pause();}else if(sound.enabled&&sound.activated)sound.playMusic(scene==='battle'?'battle':'map');});
let last=performance.now(),hudTime=0;function loop(now){const dt=Math.min((now-last)/1000,.06);last=now;if(scene==='battle'&&game){try{game.update(dt);renderer.render(game);processEvents();hudTime+=dt;if(hudTime>.1){refreshHUD();hudTime=0;}}catch(error){game.paused=true;fail(error);}}requestAnimationFrame(loop);}requestAnimationFrame(loop);
window.__XINQICHENG__=Object.freeze({snapshot:()=>game?.snapshot()||null,scene:()=>scene,errors:()=>[...runtimeErrors],version:'0.1.0'});
window.addEventListener('error',e=>runtimeErrors.push(e.message));window.addEventListener('unhandledrejection',e=>runtimeErrors.push(String(e.reason)));
boot();
