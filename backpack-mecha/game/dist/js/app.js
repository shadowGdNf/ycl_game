import { MODULES, MODULE_BY_ID, CHASSIS, CHASSIS_BY_ID, BOSS_BY_ID, PROTOCOL_BY_ID, EVENT_BY_ID, WAVES, label } from "./content.js";
import * as economy from "./economy.js";
import { createBattle, stepBattle, battleResult } from "./combat.js";
import { Renderer } from "./renderer.js";
import { loadSave, saveGame, freshProfile, applyProgress, scoreRun } from "./storage.js";
import { GameAudio } from "./audio.js";
import { overloadRequested } from "./input.js";
const $ = (id) => document.getElementById(id);
const escape = (value) => String(value).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
let profile = freshProfile(), run = null, battle = null, screen = 'home', paused = false;
let deferPending = false, terminalElapsed = -1, displayedScreen = '';
let selectedChassis = 'scavenger', selectedMode = 'full', selectedDifficulty = 0, selectedUid = '', pendingBuy = -1, pendingOfferId = '', heldRotation = 0, editUndo = null;
let toastTimer = 0, lastFrame = 0, accumulator = 0, lastSave = 0, lastHud = 0, homeTime = 0, assetsReady = false, tutorialShown = '', activeDialog = '', lastUnlocks = [];
const renderer = new Renderer($('battle-canvas'));
const audio = new GameAudio(profile.settings);
const keys = new Set();
let dashQueued = false, overloadQueued = false, targetQueued, targetMarker, targetUntil = 0;
let joy = null, aimTimer;
let drag = null;
const selectedCorners = new Set();
const t = (zh, en) => profile.language === 'zh' ? zh : en;
const name = (obj) => label(obj, profile.language);
const tier = (n) => ['I', 'II', 'III'][n - 1] ?? 'I';
const kind = (k) => k === 'weapon' ? t('武器', 'WEAPON') : k === 'support' ? t('支持', 'SUPPORT') : t('功能', 'UTILITY');
const stageName = (act) => [t('废料堆场', 'Scrap Yard'), t('熔炼工厂', 'Foundry'), t('轨道货港', 'Orbital Port')][act - 1];
const formatTime = (n) => `${Math.floor(n / 60).toString().padStart(2, '0')}:${Math.floor(n % 60).toString().padStart(2, '0')}`;
function seed() { return 'RIG-' + Math.random().toString(36).slice(2, 8).toUpperCase(); }
let homeSeed = seed();
function toast(message) { $('toast').textContent = message; $('toast').classList.add('show'); window.clearTimeout(toastTimer); toastTimer = window.setTimeout(() => $('toast').classList.remove('show'), 3500); }
function persist() { void saveGame({ version: 1, profile, run, battle, savedAt: Date.now() }).then(ok => { const warn = $('save-warning'); warn.hidden = ok; if (!ok)
    warn.textContent = t('浏览器保存不可用；本次游戏仍可继续。', 'Browser storage unavailable. You can keep playing this session.'); }); }
function applySettings() { document.documentElement.lang = profile.language === 'zh' ? 'zh-CN' : 'en'; document.body.classList.toggle('reduced-motion', profile.settings.reducedMotion); document.body.classList.toggle('left-handed', profile.settings.leftHanded); $('codex-button').textContent = t('图鉴', 'Codex'); $('settings-button').textContent = t('设置', 'Settings'); $('language-button').textContent = t('EN', '中文'); $('station-label').textContent = t('回收站 07', 'DEPOT 07'); audio.configure(profile.settings); }
function showScreen(id) { if (displayedScreen !== id) {
    displayedScreen = id;
    window.scrollTo(0, 0);
} for (const key of ['home', 'prep', 'battle', 'result'])
    $(key + '-screen').hidden = key !== id; document.body.classList.toggle('battle-active', id === 'battle'); }
function drawIcons(root = document) { if (!assetsReady)
    return; root.querySelectorAll('canvas[data-icon]').forEach(c => renderer.icon(c, c.dataset.icon)); root.querySelectorAll('canvas[data-portrait]').forEach(c => renderer.portrait(c, c.dataset.portrait)); }
function canvasIcon(id, cls = '') { return `<canvas class="${cls}" width="128" height="128" data-icon="${escape(id)}" aria-label="${escape(name(MODULE_BY_ID[id]))}"></canvas>`; }
function unlockReason(id) { return id === 'bulwark' ? t('完成第一章解锁', 'Clear Act I to unlock') : id === 'kestrel' ? t('三章通关解锁', 'Complete a full run to unlock') : t('使用无人机击败第二章 Boss', 'Defeat an Act II boss with drones'); }
function renderHome() {
    showScreen('home');
    audio.stop();
    audio.music('home');
    applySettings();
    const c = CHASSIS_BY_ID[selectedChassis];
    $('home-screen').innerHTML = `<div class="home-layout"><div class="home-intro"><div class="eyebrow">FIELD NOTES / 001 <span class="orange">&nbsp; · &nbsp; ${t('废铁也有第二次机会', 'A SECOND LIFE FOR SCRAP')}</span></div><h1>${t('把废铁，<br>装成<em>王牌。</em>', 'Small pack.<br><em>Big firepower.</em>')}</h1><p class="lead">${t('空间有限，组合无限。拼好你的机甲，穿过失控的回收工厂，把每一次失败变成新的打法。', 'Build a better machine from what you find. Fit your weapons, discover a synergy, and take back the runaway factories.')}</p><div class="hero-rig"><canvas id="hero-portrait" width="640" height="480" data-portrait="${c.id}"></canvas><div class="rig-caption"><strong>${escape(name(c))}</strong>${t('模块化回收机体', 'MODULAR SALVAGE RIG')}<br>UNIT / ${String(CHASSIS.indexOf(c) + 1).padStart(2, '0')}</div></div></div><div class="launch-panel"><div class="panel-heading"><h2>${t('选择你的机体', 'Choose your chassis')}</h2><span class="serial">ASSEMBLY / 01</span></div><div class="chassis-list">${CHASSIS.map(ch => `<button class="chassis ${ch.id === c.id ? 'selected' : ''}" data-action="chassis" data-id="${ch.id}" aria-pressed="${ch.id === c.id}" title="${escape(profile.unlocked.includes(ch.id) ? name(ch) : unlockReason(ch.id))}"><canvas width="192" height="192" data-portrait="${ch.id}"></canvas><span>${escape(name(ch))}</span>${profile.unlocked.includes(ch.id) ? '' : '<b class="lock-mark">◇</b>'}</button>`).join('')}</div><div class="chassis-description"><strong>${escape(name(c))}</strong><p>${escape(profile.language === 'zh' ? c.trait : c.traitEn)}</p><div class="mini-stats"><span>HP ${c.hp}</span><span>${t('护盾', 'SHIELD')} ${c.shield}</span><span>${t('移速', 'SPEED')} ${c.speed}</span></div></div><div class="launch-fields"><label class="field">${t('远征长度', 'EXPEDITION')}<select id="mode-select"><option value="full" ${selectedMode === 'full' ? 'selected' : ''}>${t('三章远征 · 约15分钟', 'Full expedition · ~15 min')}</option><option value="demo" ${selectedMode === 'demo' ? 'selected' : ''}>${t('两章试炼 · 约10分钟', 'Two-act trial · ~10 min')}</option><option value="prototype" ${selectedMode === 'prototype' ? 'selected' : ''}>${t('首章训练 · 约4分钟', 'Act I training · ~4 min')}</option></select></label><label class="field">${t('警戒等级', 'THREAT LEVEL')}<select id="difficulty-select">${Array.from({ length: 5 }, (_, i) => `<option value="${i}" ${i === selectedDifficulty ? 'selected' : ''} ${i > profile.maxDifficulty || selectedMode !== 'full' && i > 0 ? 'disabled' : ''}>${i === 0 ? t('0 · 标准', '0 · Standard') : i + ' · ' + t('警戒', 'Alert')}${i > profile.maxDifficulty ? ' ◇' : ''}</option>`).join('')}</select></label><label class="field wide">${t('远征种子 · 可分享相同路线', 'SEED · SHARE THE SAME EXPEDITION')}<input id="seed-input" maxlength="48" value="${escape(homeSeed)}" spellcheck="false"></label></div><button class="primary large" data-action="new-run"><span>${t('启动远征', 'BEGIN EXPEDITION')}</span><span>↗</span></button>${run && !['won', 'lost'].includes(run.phase) ? `<button class="continue" data-action="continue">${t('继续上次远征', 'Continue expedition')} · ${t('第', 'Wave ')}${run.wave}${t('场', '')}</button>` : ''}<p class="milestone">${t('自动攻击 · 手动走位 · 局间拼装 · 随时暂停', 'Auto fire · Manual movement · Build between waves · Pause anytime')}</p></div></div><div class="home-foot"><div><strong>36 ${t('件模块', 'MODULES')}</strong>${t('为每一格找到用途', 'EVERY CELL COUNTS')}</div><div><strong>06 ${t('条构筑路线', 'BUILD FAMILIES')}</strong>${t('在随机中找到组合', 'FIND YOUR SYNERGY')}</div><div><strong>03 ${t('座失控工厂', 'ROGUE FACTORIES')}</strong>${t('六种首领，三场决战', 'SIX BOSSES. THREE SHOWDOWNS.')}</div><div><strong>${String(profile.wins).padStart(2, '0')} ${t('次归来', 'RETURNS')}</strong>${t('带回经验，再次出发', 'REBUILD. RETURN. REPEAT.')}</div></div>`;
    drawIcons($('home-screen'));
}
function selectedItem() { return run?.items.find(i => i.uid === selectedUid); }
function describe(item) { const m = MODULE_BY_ID[item.id]; const detail = profile.language === 'zh' ? m.effect : m.effectEn; const damage = m.kind === 'weapon' && m.damage !== undefined ? `<span>${t('当前基础伤害', 'Current base damage')} ${(m.damage * [1, 1.35, 1.8][item.tier - 1]).toFixed(1)}</span> · ` : ''; return `${damage}${escape(detail)}`; }
function renderPrep() {
    if (!run)
        return;
    showScreen('prep');
    applySettings();
    const r = run, c = CHASSIS_BY_ID[r.chassis], wave = WAVES[r.wave - 1], act = Math.ceil(r.wave / 4), total = r.mode === 'full' ? 12 : r.mode === 'demo' ? 8 : 4;
    audio.stop();
    audio.music('home');
    const equipped = r.items.filter(i => !i.stored), power = equipped.reduce((n, i) => n + MODULE_BY_ID[i.id].power, 0), check = economy.validateLoadout(r), selected = selectedItem();
    const boss = BOSS_BY_ID[r.bosses[act - 1]];
    $('prep-screen').innerHTML = `<div class="prep-wrap"><div class="run-strip"><div><div class="eyebrow">${t('休整 /', 'WORKSHOP /')} ${escape(stageName(act))} <span class="orange">${String(r.wave).padStart(2, '0')} / ${total}</span></div><div class="wave-track" style="margin-top:12px">${Array.from({ length: total }, (_, i) => `<span class="wave-dot ${i + 1 < r.wave ? 'done' : i + 1 === r.wave ? 'current' : ''} ${(i + 1) % 4 === 0 ? 'boss' : ''}" title="${i + 1}"></span>`).join('')}</div></div><div class="run-resources"><span>HP <b>${Math.ceil(r.hp)}</b> / ${c.hp}</span><span>${t('护盾', 'SHIELD')} ${economy.getShieldCapacity(r)}</span><span class="scrap">⬡ ${Math.floor(r.gold)}</span></div></div><div class="workshop-grid"><div class="workbench"><div class="panel-heading"><h2>${t('装配台', 'Your loadout')}</h2><span class="serial">RIG / ${escape(name(c))}</span></div><div class="board-meta"><span>${t('电力', 'POWER')} <b class="${power > economy.getCapacity(r) ? 'invalid' : ''}">${power} / ${economy.getCapacity(r)}</b></span><span>${t('空间', 'CELLS')} <b>${equipped.reduce((n, i) => n + economy.getCells(i).length, 0)} / ${21 + r.unlockedCorners.length}</b></span><span>${t('武器', 'WEAPONS')} <b>${equipped.filter(i => MODULE_BY_ID[i.id].kind === 'weapon').length} / 3</b></span></div><div class="board-holder"><div class="board-axis"><span>A</span><span>B</span><span>C</span><span>D</span><span>E</span></div><canvas id="backpack-canvas" width="750" height="750" aria-label="${t('5乘5背包，点击模块选择，拖动或点击空格放置', '5 by 5 backpack. Select an item and tap an empty cell, or drag to place.')}" tabindex="0"></canvas></div><div class="board-actions"><button data-action="rotate">↻ ${t('旋转', 'Rotate')} <small>R</small></button><button data-action="autopack">▦ ${t('自动整理', 'Arrange')}</button><button data-action="undo-edit" ${editUndo ? '' : 'disabled'}>↶ ${t('撤销', 'Undo')}</button>${pendingBuy >= 0 ? `<button data-action="cancel-buy">${t('取消购买', 'Cancel')}</button>` : ''}</div><div class="rack"><div class="rack-title">${t('备件架 · 选择后点击背包放入', 'RESERVE · SELECT, THEN PLACE IN BACKPACK')}</div><div class="rack-slots">${Array.from({ length: 3 }, (_, i) => { const item = r.items.filter(v => v.stored)[i]; return item ? `<button class="rack-slot filled ${item.uid === selectedUid ? 'selected' : ''}" data-action="select" data-uid="${item.uid}">${canvasIcon(item.id)}<span>${escape(name(MODULE_BY_ID[item.id]))}<br>${tier(item.tier)}</span></button>` : '<div class="rack-slot">＋</div>'; }).join('')}</div></div><div class="detail-panel">${selected ? `<div class="detail-title"><span>${escape(name(MODULE_BY_ID[selected.id]))} <small>${tier(selected.tier)}</small></span><span class="eyebrow">${kind(MODULE_BY_ID[selected.id].kind)}</span></div><p>${describe(selected)}</p><div class="detail-actions">${selected.stored ? '' : `<button data-action="store">↓ ${t('移入备件', 'To reserve')}</button>`}<button data-action="upgrade" ${selected.tier >= r.maxTier ? 'disabled' : ''}>${t('升级', 'Upgrade')} ⬡ ${Math.ceil(MODULE_BY_ID[selected.id].price * (selected.tier === 1 ? .75 : 1.25))}</button><button data-action="sell">${t('出售', 'Sell')} +${Math.floor(economy.standardCost(selected) * .5)}</button>${MODULE_BY_ID[selected.id].kind === 'support' && !selected.stored ? `<select id="link-select" aria-label="${t('连接武器', 'Linked weapon')}"><option value="">${t('选择相邻武器', 'Link adjacent weapon')}</option>${equipped.filter(i => MODULE_BY_ID[i.id].kind === 'weapon').map(w => `<option value="${w.uid}" ${selected.link === w.uid ? 'selected' : ''}>${escape(name(MODULE_BY_ID[w.id]))} ${w.uid}</option>`).join('')}</select>` : ''}</div>` : `<div class="detail-title">${pendingBuy >= 0 ? t('选择一个空位完成购买', 'Choose a cell to complete purchase') : t('每一格，都是一个选择。', 'Every cell is a choice.')}</div><p>${t('支持模块与武器边缘相邻才会生效。每把武器最多连接两件支持；青色连线表示连接成功。', 'Supports must touch a compatible weapon along an edge. Each weapon accepts two supports; a cyan line shows an active connection.')}</p>`}</div><p class="help-inline">${t('拖动移动 · 点击空格放置 · R旋转 · 战斗期间不能换装', 'Drag to move · Tap empty cell to place · R to rotate · Loadout locks during battle')}</p></div><div class="shop-panel"><div class="panel-heading"><h2>${t('废料交易所', 'Salvage exchange')}</h2><div class="shop-tools"><button data-action="repair">${t('维修', 'Repair')} ${Math.ceil([18, 24, 30][act - 1] * (r.difficulty >= 3 ? 1.25 : 1))}</button><button data-action="refresh">↻ ${t('刷新', 'Roll')} ${Math.min(10, (r.refreshes + 1) * 2)}</button></div></div><div class="shop-grid">${r.shop.map((o, index) => { const m = MODULE_BY_ID[o.id]; return m ? `<article class="shop-card ${o.locked ? 'locked' : ''}"><button class="lock-offer" data-action="lock" data-index="${index}" aria-label="${t('锁定商品', 'Lock offer')}">${o.locked ? '◆' : '◇'}</button><span class="item-category">${kind(m.kind)} / ${'•'.repeat({ C: 1, U: 2, R: 3 }[m.rarity])}</span>${canvasIcon(m.id)}<h3>${escape(name(m))}</h3><p>${escape(profile.language === 'zh' ? m.effect : m.effectEn)}</p><div class="price-row"><span class="orange">⬡ ${m.price}</span><button class="cyan-button" data-action="buy" data-index="${index}" ${r.gold < m.price || r.wave === 1 ? 'disabled' : ''}>${t('购入', 'Acquire')}</button></div></article>` : `<article class="shop-card sold">${t('已售出', 'SOLD')}</article>`; }).join('')}</div>${r.saleUndo ? `<button style="width:100%;margin-top:10px" data-action="undo-sale">↶ ${t('撤销上次出售及后续交易', 'Undo sale and later transactions')}</button>` : ''}${renderEvent()}<div class="next-contract"><div class="eyebrow">NEXT CONTRACT / ${String(r.wave).padStart(2, '0')}</div><h3>${wave.kind === 'boss' ? `${t('首领战', 'BOSS')} · ${escape(name(boss))}` : `${escape(stageName(act))} · ${wave.duration}${t('秒生存', 's survival')}`}</h3><p>${wave.kind === 'boss' ? t('观察红色预警，躲过攻击后利用空窗输出。', 'Read the red telegraphs and strike during recovery windows.') : t('普通战坚持到倒计时结束即可。击杀更多敌人，带回更多碎片。', 'Survive until time runs out. More kills mean more scrap to rebuild with.')}</p>${r.mode !== 'prototype' && wave.kind !== 'boss' && r.wave > 1 ? `<div class="route-options">${[t('普通路线<br>稳定收益', 'Safe route<br>Standard rewards'), t('货仓捷径<br>+15%预算 / +30碎片', 'Freight route<br>+15% budget / +30 scrap'), t('精英挑战<br>+1精英 / 模块奖励', 'Elite route<br>+1 elite / module')].map((v, i) => `<button class="${r.route === i ? 'active' : ''}" data-action="route" data-index="${i}">${v}</button>`).join('')}</div>` : ''}<div class="protocol-list">${r.protocols.map(p => `<span class="chip" title="${escape(profile.language === 'zh' ? PROTOCOL_BY_ID[p].effect : PROTOCOL_BY_ID[p].effectEn)}">${escape(name(PROTOCOL_BY_ID[p]))}</span>`).join('')}</div><p class="loadout-status ${check.ok ? '' : 'invalid'}">${check.ok ? '✓ ' + t('装配就绪，可以出击', 'Loadout ready for deployment') : escape(profile.language === 'zh' ? check.reason : check.reasonEn)}</p><button class="primary large" data-action="deploy"><span>${r.phase !== 'prep' ? t('领取阶段奖励', 'Collect stage reward') : t('确认装配 · 出击', 'DEPLOY LOADOUT')}</span><span>↗</span></button><p class="help-inline">${t('休整不限时。布局、交易和奖励会自动保存。', 'Take your time. Your loadout, trades and rewards save automatically.')}</p></div></div></div></div>`;
    drawIcons($('prep-screen'));
    drawBoard();
    bindBoard();
    const link = $('link-select');
    if (link)
        link.onchange = () => actResult(economy.setLink(r, selectedUid, link.value), 'connect', true);
    const target = $('event-target');
    if (target)
        target.onchange = () => { r.extra ??= {}; r.extra.eventTargetUid = target.value; persist(); };
    const tag = $('event-tag');
    if (tag)
        tag.onchange = () => { r.extra ??= {}; r.extra.eventTargetTag = tag.value; persist(); };
}
function renderEvent() { if (!run || !run.eventId || run.eventResolved)
    return ''; const e = EVENT_BY_ID[run.eventId]; if (!e)
    return ''; const ids = run.items.filter(i => run.eventId !== 'EV03' || i.tier === 1); const tags = [...new Set(run.items.filter(i => !i.stored && MODULE_BY_ID[i.id].kind === 'weapon').flatMap(i => MODULE_BY_ID[i.id].tags))]; return `<div class="event-box"><div class="eyebrow orange">${t('偶遇', 'ENCOUNTER')} / ${escape(name(e))}</div><p>${escape(profile.language === 'zh' ? e.description : e.descriptionEn)}</p>${['EV03', 'EV05'].includes(e.id) ? `<select id="event-target" style="width:100%;font-size:11px;margin-bottom:8px"><option value="">${t('选择处理的模块', 'Select a module')}</option>${ids.map(i => `<option value="${i.uid}" ${run.extra?.eventTargetUid === i.uid ? 'selected' : ''}>${escape(name(MODULE_BY_ID[i.id]))} ${tier(i.tier)}</option>`).join('')}</select>` : ''}${e.id === 'EV06' ? `<select id="event-tag" style="width:100%;font-size:11px;margin-bottom:8px"><option value="">${t('选择武器标签', 'Select weapon tag')}</option>${tags.map(tag => `<option value="${escape(tag)}" ${run.extra?.eventTargetTag === tag ? 'selected' : ''}>${escape(tagName(tag))}</option>`).join('')}</select>` : ''}<div class="event-actions"><button data-action="event" data-index="0">${eventChoice(e.id, 0)}</button><button data-action="event" data-index="1">${eventChoice(e.id, 1)}</button>${['EV01', 'EV02', 'EV04'].includes(e.id) ? '' : `<button data-action="event" data-index="-1">${t('离开', 'Leave')}</button>`}</div></div>`; }
function eventChoice(id, index) { const zh = { EV01: ['支付24', '离开'], EV02: ['换取35碎片', '放弃'], EV03: ['免费升级', '领取20碎片'], EV04: ['接受救援', '离开'], EV05: ['出售选中模块', '12碎片维修'], EV06: ['预订支持模块', '领取12碎片'], EV07: ['恢复25生命', '下场+15护盾'], EV08: ['接受捷径', '普通路线'] }; const en = { EV01: ['Pay 24', 'Leave'], EV02: ['Take 35 scrap', 'Decline'], EV03: ['Free upgrade', 'Take 20 scrap'], EV04: ['Accept rescue', 'Leave'], EV05: ['Sell selected', 'Heal for 12'], EV06: ['Reserve support', 'Take 12 scrap'], EV07: ['Heal 25 HP', 'Next wave +15 shield'], EV08: ['Take shortcut', 'Safe route'] }; return (profile.language === 'zh' ? zh : en)[id][index]; }
function tagName(tag) { const tags = { '全部': 'All', '实弹': 'Ballistic', '单弹': 'Single shot', '散射': 'Spread', '水': 'Water', '电': 'Electric', '火': 'Fire', '持续': 'Continuous', '油': 'Oil', '爆炸': 'Explosive', '近战': 'Melee', '召唤': 'Drone', '冰': 'Ice' }; return profile.language === 'zh' ? tag : tags[tag] ?? tag; }
function drawBoard() {
    const canvas = $('backpack-canvas');
    if (!canvas || !run)
        return;
    const ctx = canvas.getContext('2d'), size = 750, cell = 150;
    ctx.clearRect(0, 0, size, size);
    ctx.fillStyle = '#142126';
    ctx.fillRect(0, 0, size, size);
    for (let y = 0; y < 5; y++)
        for (let x = 0; x < 5; x++) {
            const corner = x === 0 && y === 0 ? 0 : x === 4 && y === 0 ? 1 : x === 0 && y === 4 ? 2 : x === 4 && y === 4 ? 3 : -1;
            const locked = corner >= 0 && !run.unlockedCorners.includes(corner);
            ctx.fillStyle = locked ? '#10191f' : '#1d2e34';
            ctx.fillRect(x * cell + 5, y * cell + 5, cell - 10, cell - 10);
            ctx.strokeStyle = '#324b51';
            ctx.strokeRect(x * cell + 5.5, y * cell + 5.5, cell - 11, cell - 11);
            if (locked) {
                ctx.fillStyle = '#516167';
                ctx.font = '27px monospace';
                ctx.textAlign = 'center';
                ctx.fillText('×', x * cell + 75, y * cell + 85);
            }
            else {
                ctx.fillStyle = '#3d555d';
                ctx.beginPath();
                ctx.arc(x * cell + 75, y * cell + 75, 2, 0, Math.PI * 2);
                ctx.fill();
            }
        }
    for (const item of run.items.filter(i => !i.stored)) {
        const m = MODULE_BY_ID[item.id], cells = economy.getCells(item), sel = item.uid === selectedUid;
        ctx.fillStyle = sel ? '#4b4938' : m.kind === 'weapon' ? '#4c4435' : m.kind === 'support' ? '#234d4d' : '#35434e';
        ctx.strokeStyle = sel ? '#f3ac62' : m.kind === 'weapon' ? '#9b794e' : m.kind === 'support' ? '#478b82' : '#667e8b';
        ctx.lineWidth = sel ? 4 : 2;
        for (const p of cells) {
            ctx.fillRect(p.x * cell + 9, p.y * cell + 9, cell - 18, cell - 18);
            ctx.strokeRect(p.x * cell + 9, p.y * cell + 9, cell - 18, cell - 18);
            for (const d of [{ x: 1, y: 0 }, { x: 0, y: 1 }])
                if (cells.some(q => q.x === p.x + d.x && q.y === p.y + d.y)) {
                    ctx.fillRect(p.x * cell + (d.x ? cell - 15 : 10), p.y * cell + (d.y ? cell - 15 : 10), d.x ? 30 : cell - 20, d.y ? 30 : cell - 20);
                }
        }
        const center = { x: cells.reduce((n, p) => n + p.x + .5, 0) / cells.length * cell, y: cells.reduce((n, p) => n + p.y + .5, 0) / cells.length * cell };
        const icon = document.createElement('canvas');
        icon.width = 128;
        icon.height = 128;
        if (assetsReady)
            renderer.icon(icon, item.id);
        ctx.drawImage(icon, center.x - 64, center.y - 66, 128, 128);
        ctx.textAlign = 'left';
        ctx.font = 'bold 19px monospace';
        ctx.fillStyle = '#dfe9df';
        const first = cells.reduce((a, b) => a.y < b.y || a.y === b.y && a.x < b.x ? a : b);
        ctx.fillText(`${item.id} · ${tier(item.tier)}`, first.x * cell + 16, first.y * cell + 29);
    }
    for (const support of run.items.filter(i => !i.stored && i.link)) {
        const weapon = run.items.find(i => i.uid === support.link);
        if (!weapon)
            continue;
        const a = economy.getCells(support), b = economy.getCells(weapon);
        let pair;
        for (const p of a)
            for (const q of b)
                if (Math.abs(p.x - q.x) + Math.abs(p.y - q.y) === 1)
                    pair = [p, q];
        if (pair) {
            ctx.strokeStyle = '#6ff3d3';
            ctx.lineWidth = 6;
            ctx.beginPath();
            ctx.moveTo((pair[0].x + .5) * cell, (pair[0].y + .5) * cell + 35);
            ctx.lineTo((pair[1].x + .5) * cell, (pair[1].y + .5) * cell + 35);
            ctx.stroke();
        }
    }
    if (drag?.moved) {
        const item = run.items.find(i => i.uid === drag.uid);
        if (item) {
            const draft = { ...item, x: drag.x, y: drag.y, rotation: heldRotation, stored: false };
            const copy = structuredClone(run);
            const valid = economy.placeItem(copy, item.uid, draft.x, draft.y, draft.rotation).ok;
            ctx.fillStyle = valid ? '#48d1c466' : '#f05b5b66';
            for (const p of economy.getCells(draft))
                ctx.fillRect(p.x * cell + 8, p.y * cell + 8, cell - 16, cell - 16);
        }
    }
}
function boardPoint(e) { const c = $('backpack-canvas').getBoundingClientRect(); return { x: Math.floor((e.clientX - c.left) / c.width * 5), y: Math.floor((e.clientY - c.top) / c.height * 5) }; }
function bindBoard() {
    const canvas = $('backpack-canvas');
    if (!canvas)
        return;
    canvas.onpointerdown = e => { if (!run)
        return; const p = boardPoint(e); const item = run.items.find(i => !i.stored && economy.getCells(i).some(c => c.x === p.x && c.y === p.y)); if (item) {
        pendingBuy = -1;
        selectedUid = item.uid;
        heldRotation = item.rotation;
        drag = { uid: item.uid, startX: e.clientX, startY: e.clientY, offsetX: p.x - item.x, offsetY: p.y - item.y, x: item.x, y: item.y, moved: false };
        canvas.setPointerCapture(e.pointerId);
        drawBoard();
    }
    else {
        placeAt(p.x, p.y);
    } e.preventDefault(); };
    canvas.onpointermove = e => { if (!drag)
        return; if (Math.hypot(e.clientX - drag.startX, e.clientY - drag.startY) > 6)
        drag.moved = true; const p = boardPoint(e); drag.x = p.x - drag.offsetX; drag.y = p.y - drag.offsetY; drawBoard(); };
    canvas.onpointerup = e => { if (!drag || !run)
        return; const d = drag; drag = null; if (d.moved) {
        const before = structuredClone(run);
        const result = economy.placeItem(run, d.uid, d.x, d.y, heldRotation);
        if (result.ok)
            editUndo = before;
        actResult(result, 'connect', true);
    }
    else
        renderPrep(); };
    canvas.onpointercancel = () => { drag = null; drawBoard(); };
}
function placeAt(x, y) { if (!run)
    return; if (pendingBuy >= 0) {
    if (run.shop[pendingBuy]?.id !== pendingOfferId) {
        pendingBuy = -1;
        toast(t('商品已变化，请重新选择', 'The offer changed. Select it again.'));
        renderPrep();
        return;
    }
    const result = economy.buy(run, pendingBuy, { x, y, rotation: heldRotation });
    if (result.ok) {
        pendingBuy = -1;
        selectedUid = run.items.at(-1)?.uid ?? '';
        editUndo = null;
        updateCodex();
    }
    actResult(result, 'buy', true);
    return;
} const item = selectedItem(); if (!item)
    return; const before = structuredClone(run), result = economy.placeItem(run, item.uid, x, y, heldRotation); if (result.ok)
    editUndo = before; actResult(result, 'connect', true); }
function actResult(result, sound = 'click', rerender = true) { if (!result.ok) {
    toast((profile.language === 'zh' ? result.reason : result.reasonEn) ?? t('操作未完成', 'Action could not be completed'));
    audio.play('invalid');
    return false;
} audio.play(sound); persist(); if (rerender)
    render(); return true; }
function updateCodex() { if (!run)
    return; profile.codex = [...new Set([...profile.codex, ...run.items.map(i => i.id)])]; for (const i of run.items.filter(i => i.link)) {
    const target = run.items.find(w => w.uid === i.link);
    if (target)
        profile.connections = [...new Set([...profile.connections, `${i.id}:${target.id}`])];
} }
function render() { if (screen === 'home') {
    renderHome();
    return;
} if (!run) {
    screen = 'home';
    renderHome();
    return;
} if (['won', 'lost'].includes(run.phase)) {
    renderResult();
    return;
} if (run.phase === 'battle' && battle) {
    showScreen('battle');
    applySettings();
    updateHud();
    return;
} renderPrep(); if (['reward', 'protocol', 'expansion'].includes(run.phase) && !deferPending)
    showPending(); }
function openModal(html, kind = 'normal') { activeDialog = kind; $('modal-content').innerHTML = html; const modal = $('modal'); if (!modal.open)
    modal.showModal(); drawIcons($('modal-content')); }
function closeModal() { if (['reward', 'protocol', 'expansion'].includes(activeDialog))
    deferPending = true; activeDialog = ''; $('modal').close(); if (battle && run?.phase === 'battle' && screen === 'run') {
    paused = false;
    audio.resume();
    lastFrame = performance.now();
} }
function setPause() { if (!battle || run?.phase !== 'battle')
    return; paused = true; keys.clear(); joy = null; $('joystick').style.display = 'none'; audio.suspend(); persist(); openModal(`<div class="eyebrow">SYSTEM / PAUSED</div><h2>${t('引擎暂歇', 'Engines on hold')}</h2><p>${t('战斗与冷却已暂停。当前装配只能在休整时调整。', 'Combat and cooldowns are paused. Equipment can be changed between waves.')}</p><div class="protocol-list">${run.items.filter(i => !i.stored).map(i => `<span class="chip">${escape(name(MODULE_BY_ID[i.id]))} ${tier(i.tier)}</span>`).join('')}</div><div class="modal-actions"><button class="primary" data-action="resume">${t('继续战斗', 'Resume')}</button><button data-action="save-home">${t('保存并回到回收站', 'Save & return to depot')}</button><button data-action="settings">${t('设置', 'Settings')}</button></div>`, 'pause'); }
function showPending() { if (!run)
    return; deferPending = false; const r = run; if (r.phase === 'reward') {
    openModal(`<div class="eyebrow">SALVAGE / ${t('战利品', 'REWARD')}</div><h2>${t('发现可用模块', 'Salvage recovered')}</h2><p>${t('选择一件带走，也可以换成12碎片。备件架满时先整理。', 'Take one module, or collect 12 scrap. Make room in your reserve if needed.')}</p><div class="choice-grid">${r.rewardOptions.map((id, index) => `<button class="choice-card" data-action="reward" data-index="${index}">${canvasIcon(id)}<strong>${escape(name(MODULE_BY_ID[id]))}</strong><small>${escape(profile.language === 'zh' ? MODULE_BY_ID[id].effect : MODULE_BY_ID[id].effectEn)}</small></button>`).join('')}</div><div class="modal-actions"><button data-action="reward" data-index="-1">⬡ +12 ${t('碎片', 'scrap')}</button><button data-action="close">${t('先整理背包', 'Arrange backpack first')}</button></div>`, 'reward');
}
else if (r.phase === 'protocol') {
    openModal(`<div class="eyebrow">SYSTEM / UPGRADE</div><h2>${t('选择战术协议', 'Choose a protocol')}</h2><p>${t('协议持续到本次远征结束，不占格子。', 'Protocols last for this expedition and use no backpack space.')}</p><div class="choice-grid">${r.protocolOptions.map(id => { const p = PROTOCOL_BY_ID[id]; return `<button class="choice-card" data-action="protocol" data-id="${id}"><strong>${escape(name(p))}</strong><small>${escape(profile.language === 'zh' ? p.effect : p.effectEn)}</small></button>`; }).join('')}</div>`, 'protocol');
}
else if (r.phase === 'expansion') {
    selectedCorners.clear();
    openModal(`<div class="eyebrow">FRAME / EXPANSION</div><h2>${t('扩展背包框架', 'Expand the frame')}</h2><p>${t('选择两个角格解锁。机体电力与模块升级等级同步开放。', 'Choose two corners to unlock. Power and module upgrades also expand.')}</p><div class="corner-grid">${[t('左上角', 'Top left'), t('右上角', 'Top right'), t('左下角', 'Bottom left'), t('右下角', 'Bottom right')].map((v, i) => `<button data-action="corner" data-index="${i}" ${r.unlockedCorners.includes(i) ? 'disabled' : ''}>${v}${r.unlockedCorners.includes(i) ? ' ✓' : ''}</button>`).join('')}</div><button class="primary" data-action="expand">${t('确认扩容', 'Confirm expansion')}</button>`, 'expansion');
} }
function deploy() { if (!run)
    return; if (run.phase !== 'prep') {
    showPending();
    return;
} updateCodex(); const result = economy.startWave(run); if (!actResult(result, 'click', false))
    return; battle = createBattle(run); terminalElapsed = -1; screen = 'run'; paused = false; accumulator = 0; lastFrame = performance.now(); lastSave = 0; lastHud = 0; pendingBuy = -1; editUndo = null; targetQueued = undefined; targetMarker = undefined; audio.resetEvents(); audio.stop(); audio.music('battle'); if (run.wave >= 2 && run.items.some(i => i.link))
    profile.tutorial = true; render(); persist(); }
function beginNewRun() { const value = $('seed-input')?.value.trim() || homeSeed; homeSeed = value; if (selectedMode === 'prototype' || selectedMode === 'demo' && !['scavenger', 'bulwark'].includes(selectedChassis))
    selectedChassis = 'scavenger'; run = economy.newRun(selectedChassis, selectedMode, selectedDifficulty, profile.tutorial ? value : 'FIRST-LIGHT'); battle = null; selectedUid = ''; pendingBuy = -1; lastUnlocks = []; screen = 'run'; profile.totalRuns++; if (!profile.tutorial) {
    const support = run.items.find(i => i.id === 'S01');
    if (support)
        economy.storeItem(run, support.uid);
} deploy(); if (!profile.tutorial) {
    paused = true;
    openModal(`<div class="eyebrow">FIRST LIGHT / 01</div><h2>${t('欢迎驾驶，维修师。', 'Welcome aboard, pilot.')}</h2><div class="guide-steps"><div class="guide-step"><b>01</b><p>${t('WASD / 方向键，或左侧拖动摇杆移动。武器会自动攻击。', 'Move with WASD / arrow keys, or drag on the left. Weapons fire automatically.')}</p></div><div class="guide-step"><b>02</b><p>${t('空格 / 右侧箭头冲刺。E / 闪电按钮开启短时超载。', 'Space / arrow button to dash. E / lightning button to overdrive.')}</p></div><div class="guide-step"><b>03</b><p>${t('避开红色预警。战后用碎片买模块，把支持装在武器旁。', 'Avoid red warnings. Buy modules after battle and connect supports beside weapons.')}</p></div></div><button class="primary" data-action="resume">${t('准备好了 · 出发', 'Ready · Deploy')}</button>`, 'tutorial');
} persist(); }
function completeBattle() { if (!run || !battle)
    return; deferPending = false; editUndo = null; const completedWave = run.wave, usedDrones = run.items.some(i => !i.stored && i.id === 'W11'); const result = battleResult(battle); const outcome = economy.resolveBattle(run, result); if (!outcome.ok) {
    toast(t('结算异常，请暂停后重试', 'Settlement failed. Pause and retry.'));
    return;
} lastUnlocks.push(...applyProgress(profile, run, completedWave, result.won, usedDrones)); updateCodex(); audio.play(result.won ? 'win' : 'lose'); battle = null; keys.clear(); joy = null; $('joystick').style.display = 'none'; paused = false; render(); persist(); if (result.won && run.wave === 2 && !profile.tutorial && tutorialShown !== run.seed) {
    tutorialShown = run.seed;
    openModal(`<div class="eyebrow">WORKSHOP / FIRST CONNECTION</div><h2>${t('第一次改装', 'Your first upgrade')}</h2><p>${t('备件架中有一件免费增幅线圈。点击它，再点击铆钉枪旁的空格；青色连接线表示生效，铆钉枪基础DPS从20提高到24。', 'A free Amplifier is waiting in reserve. Select it, then tap a free cell beside the Rivet gun. A cyan line confirms the link; base DPS rises from 20 to 24.')}</p><p>${t('你也可以购买第二把武器。每次购入会先放在备件架，记得装进背包再出击。', 'You can also buy a second weapon. Purchases enter the reserve first; equip them before deploying.')}</p><button class="primary" data-action="close">${t('开始拼装', 'Start building')}</button>`, 'guide');
} }
function renderResult() { if (!run)
    return; showScreen('result'); audio.stop(); audio.music('home'); const r = run, win = r.phase === 'won'; const damage = Object.entries(r.stats.damageByModule).sort((a, b) => b[1] - a[1]).slice(0, 3), max = Math.max(1, ...damage.map(d => d[1])); const taken = Object.entries(r.stats.damageTakenBy).sort((a, b) => b[1] - a[1])[0]; $('result-screen').innerHTML = `<div class="result-wrap"><div class="eyebrow">EXPEDITION / ${win ? 'COMPLETE' : 'SIGNAL LOST'}</div><h1>${win ? t('带着新故事，回来了。', 'Back with a new story.') : t('机体停了，思路还在。', 'The rig fell. The idea lives.')}</h1><p class="result-lead">${win ? t('你夺回了这条回收线路。换一台机体，或者提高警戒等级，再试一套新组合。', 'You reclaimed this salvage route. Try a new chassis, raise the threat level, or build something different.') : t('回收站已接到你的信号。看看这次构筑的表现，下一局再做一次调整。', 'The depot has your signal. Review your build, make one change, and try another expedition.')}</p><div class="result-stats"><div><b>${scoreRun(r).toLocaleString()}</b><span>${t('远征成绩', 'SCORE')}</span></div><div><b>${formatTime(r.elapsed)}</b><span>${t('战斗用时', 'COMBAT TIME')}</span></div><div><b>${r.stats.kills}</b><span>${t('回收敌机', 'ENEMIES RECYCLED')}</span></div><div><b>${r.wave}</b><span>${t('到达场次', 'WAVE REACHED')}</span></div></div><div class="panel-heading"><h2>${t('本局火力贡献', 'Your workhorses')}</h2><span class="serial">DAMAGE / OUTPUT</span></div><div class="contribution">${damage.map(([id, value]) => `<div class="contribution-row"><span>${escape(MODULE_BY_ID[id] ? name(MODULE_BY_ID[id]) : id)}</span><i style="width:${value / max * 100}%"></i><span>${Math.round(value).toLocaleString()}</span></div>`).join('') || `<p class="muted">${t('没有有效伤害记录', 'No damage recorded')}</p>`}</div>${taken ? `<p class="result-lead">${t('主要威胁', 'Main threat')}：${escape(taken[0])} · ${Math.round(taken[1])} ${t('伤害。尝试留出一次冲刺，或增加护盾。', 'damage. Save a dash, or invest in shields.')}</p>` : ''}${lastUnlocks.length ? `<p class="chip">${t('新机体解锁', 'Chassis unlocked')}：${lastUnlocks.map(id => escape(name(CHASSIS_BY_ID[id]))).join(' / ')}</p>` : ''}<p class="seed-line">SEED / ${escape(r.seed)} · ${r.mode.toUpperCase()} · THREAT ${r.difficulty}</p><div class="result-actions"><button class="primary" data-action="again">${t('再来一局', 'One more run')} ↗</button><button data-action="home">${t('回到回收站', 'Return to depot')}</button><button data-action="copy-seed">${t('复制种子', 'Copy seed')}</button><button data-action="export">${t('导出记录', 'Export log')}</button></div></div>`; }
function updateHud() { if (!battle || !run)
    return; const b = battle, p = b.player, bosses = b.enemies.filter(e => e.kind === 'boss'), boss = bosses[0]; $('battle-hud').innerHTML = `<div class="player-hud"><div class="hud-label"><span>${escape(name(CHASSIS_BY_ID[run.chassis]))}</span><span>${Math.ceil(p.hp)} / ${p.maxHp}</span></div><div class="health-track"><b style="width:${Math.max(0, p.hp / p.maxHp * 100)}%"></b></div><div class="health-track shield"><b style="width:${p.maxShield ? Math.max(0, p.shield / p.maxShield * 100) : 0}%"></b></div><div class="hud-label"><span>${t('护盾', 'SHIELD')} ${Math.ceil(p.shield)}</span><span>⬡ ${Math.floor(run.gold + b.stats.goldEarned)}</span></div></div><div class="battle-timer"><strong>${formatTime(b.bossId ? b.time : Math.max(0, b.duration - b.time))}</strong><small>${escape(stageName(b.act))} / ${String(b.wave).padStart(2, '0')}</small></div>${boss ? `<div class="boss-hud"><span>${escape(name(BOSS_BY_ID[b.bossId]))}</span><div class="health-track"><b style="width:${Math.max(0, boss.hp / boss.maxHp * 100)}%"></b></div><small>${Math.ceil(boss.hp)} / ${boss.maxHp}${b.time > [80, 100, 120][b.act - 1] ? ' · ' + t('即将过载', 'OVERLOAD IMMINENT') : ''}</small></div>` : ''}`; $('battle-bottom').innerHTML = `<div>${p.overloadTime > 0 ? '<span class="orange">ϟ ' + t('超载中', 'OVERDRIVE') + '</span>' : t('自动攻击已接通', 'AUTO FIRE ONLINE')}</div><div class="weapon-hud">${b.weapons.map(w => `<span>${escape(name(MODULE_BY_ID[w.id]))}</span>`).join('')}</div><div class="touch-hint">WASD / ↑↓←→ · ${t('空格冲刺 · E超载 · P暂停', 'SPACE DASH · E OVERDRIVE · P PAUSE')}</div>`; const d = $('dash-button'), o = $('overload-button'); d.classList.toggle('cooling', p.dashCooldown > 0); o.classList.toggle('cooling', p.overloadCooldown > 0); d.innerHTML = `<b>${p.dashCooldown > 0 ? p.dashCooldown.toFixed(1) : '↗'}</b><span>${t('冲刺', 'DASH')}</span>`; o.innerHTML = `<b>${p.overloadCooldown > 0 ? Math.ceil(p.overloadCooldown) : 'ϟ'}</b><span>${t('超载', 'BOOST')}</span>`; }
function settings() { if (battle && screen === 'run') {
    paused = true;
    audio.suspend();
} const s = profile.settings; const options = [['sound', t('音效', 'Sound effects')], ['music', t('音乐', 'Music')], ['reducedMotion', t('减少震动与闪光', 'Reduce shake & flashes')], ['colorAssist', t('颜色辅助标记', 'Color assistance')], ['leftHanded', t('左手技能布局', 'Left-handed controls')], ['autoOverload', t('自动开启超载', 'Automatic overdrive')]]; openModal(`<div class="eyebrow">SYSTEM / PREFERENCES</div><h2>${t('设置', 'Settings')}</h2>${options.map(([key, text]) => `<label class="setting-row"><span>${text}</span><input type="checkbox" data-setting="${key}" ${s[key] ? 'checked' : ''}></label>`).join('')}<label class="setting-row"><span>${t('音量', 'Volume')}</span><input type="range" min="0" max="1" step="0.05" value="${s.volume}" data-setting="volume"></label><p>${t('进度保存在当前浏览器。静音和减少动态效果不会改变游戏规则。', 'Progress is stored in this browser. Sound and visual settings never change game rules.')}</p><div class="modal-actions"><button class="primary" data-action="close">${t('完成', 'Done')}</button><button data-action="help">${t('操作说明', 'Controls')}</button></div>`, 'settings'); }
function codex() { if (battle && screen === 'run')
    paused = true; openModal(`<div class="eyebrow">SALVAGE / ARCHIVE</div><h2>${t('模块图鉴', 'Module archive')} <small class="muted">${profile.codex.length} / 36</small></h2><p>${t('首次获得点亮记录。所有基础模块从普通模式起可出现，稀有模块从第二章开放。', 'Collect modules to record them. All base modules are available in normal mode; rare modules appear from Act II.')}</p><div class="codex-grid">${MODULES.map(m => `<div class="codex-entry ${profile.codex.includes(m.id) ? '' : 'undiscovered'}">${canvasIcon(m.id)}<strong>${escape(name(m))}</strong><small>${kind(m.kind)} · ${t('电力', 'Power')} ${m.power} · ⬡ ${m.price}</small><small>${escape(profile.language === 'zh' ? m.effect : m.effectEn)}</small></div>`).join('')}</div>`, 'codex'); }
function help() { openModal(`<div class="eyebrow">PILOT / MANUAL</div><h2>${t('操作说明', 'Pilot manual')}</h2><p>${t('电脑：WASD或方向键移动，空格冲刺，E超载，P/Esc暂停。右键敌人设置2秒优先目标。', 'Desktop: WASD / arrows to move, Space to dash, E to overdrive, P / Esc to pause. Right-click an enemy to focus it for two seconds.')}</p><p>${t('手机：拖动左半屏移动，右下角按钮冲刺和超载。长按右半屏目标集火。', 'Touch: drag on the left to move; use the lower-right skill buttons. Hold a target on the right to focus fire.')}</p><p>${t('装配：选择备件后点击空格，或拖动已有模块。R/旋转按钮转向。支持必须贴着兼容武器，最多每枪两个。', 'Workshop: select a reserve item then tap a cell, or drag a placed item. R / Rotate turns it. Supports must touch compatible weapons, at most two per weapon.')}</p><p>${t('所有伤害与危险预警按固定逻辑运行；红色预警期间离开范围，利用Boss后摇攻击。', 'Combat runs at a fixed simulation rate. Leave red telegraphs and strike during boss recovery windows.')}</p><button class="primary" data-action="close">${t('明白了', 'Got it')}</button>`, 'help'); }
async function dispatch(button) {
    const action = button.dataset.action;
    if (!action)
        return;
    audio.unlock();
    const index = Number(button.dataset.index), id = button.dataset.id ?? '';
    if (action === 'chassis') {
        if (selectedMode === 'prototype' && id !== 'scavenger' || selectedMode === 'demo' && !['scavenger', 'bulwark'].includes(id)) {
            toast(t('当前试炼未开放此机体', 'This chassis is not available in this trial'));
            return;
        }
        if (!profile.unlocked.includes(id)) {
            toast(unlockReason(id));
            return;
        }
        selectedChassis = id;
        renderHome();
        return;
    }
    if (action === 'new-run') {
        selectedMode = $('mode-select').value;
        selectedDifficulty = Number($('difficulty-select').value);
        if (run && !['won', 'lost'].includes(run.phase)) {
            openModal(`<h2>${t('开始新的远征？', 'Start a new expedition?')}</h2><p>${t('会替换当前未完成的远征。图鉴、机体与难度解锁保留。', 'This replaces the unfinished expedition. Your codex, chassis and difficulty unlocks remain.')}</p><div class="modal-actions"><button class="primary" data-action="confirm-new">${t('开始新远征', 'Start new run')}</button><button data-action="close">${t('返回', 'Back')}</button></div>`, 'confirm');
        }
        else
            beginNewRun();
        return;
    }
    if (action === 'confirm-new') {
        closeModal();
        beginNewRun();
        return;
    }
    if (action === 'continue') {
        screen = 'run';
        render();
        if (run?.phase === 'battle' && battle)
            setPause();
        return;
    }
    if (action === 'resume' || action === 'close') {
        closeModal();
        return;
    }
    if (action === 'save-home' || action === 'home') {
        if (battle) {
            paused = true;
            persist();
        }
        closeModal();
        paused = !!battle;
        screen = 'home';
        renderHome();
        return;
    }
    if (action === 'settings') {
        settings();
        return;
    }
    if (action === 'help') {
        help();
        return;
    }
    if (action === 'again') {
        if (!run)
            return;
        selectedChassis = run.chassis;
        selectedMode = run.mode;
        selectedDifficulty = run.difficulty;
        homeSeed = seed();
        screen = 'home';
        renderHome();
        beginNewRun();
        return;
    }
    if (action === 'copy-seed') {
        if (run)
            try {
                await navigator.clipboard.writeText(run.seed);
                toast(t('种子已复制', 'Seed copied'));
            }
            catch {
                toast(run.seed);
            }
        return;
    }
    if (action === 'export') {
        if (!run)
            return;
        const blob = new Blob([JSON.stringify({ version: run.version, seed: run.seed, mode: run.mode, chassis: run.chassis, difficulty: run.difficulty, stats: run.stats, history: run.history, items: run.items }, null, 2)], { type: 'application/json' }), a = document.createElement('a');
        a.href = URL.createObjectURL(blob);
        a.download = `mecha-${run.seed}.json`;
        a.click();
        setTimeout(() => URL.revokeObjectURL(a.href), 1000);
        return;
    }
    if (!run)
        return;
    const r = run;
    if (['refresh', 'buy', 'undo-sale', 'undo-edit', 'event', 'reward', 'protocol', 'expand'].includes(action))
        pendingBuy = -1;
    if (action === 'select') {
        selectedUid = button.dataset.uid ?? '';
        heldRotation = selectedItem()?.rotation ?? 0;
        pendingBuy = -1;
        renderPrep();
        return;
    }
    if (action === 'deploy') {
        deploy();
        return;
    }
    if (action === 'buy') {
        const result = economy.buy(r, index);
        if (!result.ok && r.items.filter(i => i.stored).length >= 3) {
            pendingBuy = index;
            pendingOfferId = r.shop[index]?.id ?? '';
            selectedUid = '';
            heldRotation = 0;
            toast(t('备件架已满，点击背包空位完成购买', 'Reserve full. Tap a backpack cell to complete purchase.'));
            renderPrep();
            return;
        }
        if (result.ok) {
            selectedUid = r.items.at(-1)?.uid ?? '';
            heldRotation = 0;
            editUndo = null;
            updateCodex();
        }
        actResult(result, 'buy');
        return;
    }
    if (action === 'cancel-buy') {
        pendingBuy = -1;
        renderPrep();
        return;
    }
    if (action === 'rotate') {
        if (pendingBuy >= 0) {
            heldRotation = (heldRotation + 1) % 4;
            toast(t('待购物品已旋转，点击空格放置', 'Purchase rotated. Tap a cell to place it.'));
            return;
        }
        const item = selectedItem();
        if (!item) {
            toast(t('先选择一个模块', 'Select a module first'));
            return;
        }
        heldRotation = (heldRotation + 1) % 4;
        if (item.stored) {
            item.rotation = heldRotation;
            persist();
            renderPrep();
        }
        else {
            const before = structuredClone(r);
            const result = economy.placeItem(r, item.uid, item.x, item.y, heldRotation);
            if (result.ok)
                editUndo = before;
            else
                heldRotation = item.rotation;
            actResult(result, 'rotate');
        }
        return;
    }
    if (action === 'autopack') {
        const before = structuredClone(r), result = economy.autoPack(r);
        if (result.ok)
            editUndo = before;
        actResult(result, 'connect');
        return;
    }
    if (action === 'undo-edit') {
        if (editUndo) {
            run = editUndo;
            editUndo = null;
            persist();
            render();
        }
        return;
    }
    if (action === 'store') {
        const before = structuredClone(r), result = economy.storeItem(r, selectedUid);
        if (result.ok)
            editUndo = before;
        actResult(result, 'click');
        return;
    }
    if (action === 'sell') {
        const result = economy.sell(r, selectedUid);
        if (result.ok) {
            selectedUid = '';
            editUndo = null;
        }
        actResult(result, 'sell');
        return;
    }
    if (action === 'upgrade') {
        editUndo = null;
        actResult(economy.upgrade(r, selectedUid), 'upgrade');
        return;
    }
    if (action === 'undo-sale') {
        editUndo = null;
        actResult(economy.undoSale(r), 'click');
        return;
    }
    if (action === 'repair') {
        editUndo = null;
        actResult(economy.repair(r), 'buy');
        return;
    }
    if (action === 'refresh') {
        editUndo = null;
        actResult(economy.refreshShop(r), 'click');
        return;
    }
    if (action === 'lock') {
        actResult(economy.toggleLock(r, index));
        return;
    }
    if (action === 'route') {
        actResult(economy.setRoute(r, index));
        return;
    }
    if (action === 'reward') {
        const result = economy.chooseReward(r, index);
        if (result.ok) {
            closeModal();
            deferPending = false;
            editUndo = null;
            updateCodex();
        }
        actResult(result, 'reward');
        return;
    }
    if (action === 'protocol') {
        const result = economy.chooseProtocol(r, id);
        if (result.ok) {
            closeModal();
            deferPending = false;
            editUndo = null;
        }
        actResult(result, 'upgrade');
        return;
    }
    if (action === 'corner') {
        if (selectedCorners.has(index))
            selectedCorners.delete(index);
        else if (selectedCorners.size < 2)
            selectedCorners.add(index);
        button.classList.toggle('active', selectedCorners.has(index));
        return;
    }
    if (action === 'expand') {
        const result = economy.chooseExpansion(r, [...selectedCorners]);
        if (result.ok) {
            closeModal();
            deferPending = false;
            editUndo = null;
        }
        actResult(result, 'upgrade');
        return;
    }
    if (action === 'event') {
        const result = economy.resolveEvent(r, index);
        if (result.ok) {
            editUndo = null;
            updateCodex();
        }
        actResult(result, 'reward');
        return;
    }
}
for (const root of [$('app'), $('modal-content')])
    root.addEventListener('click', e => { const b = e.target.closest('[data-action]'); if (b && !b.disabled)
        void dispatch(b); });
$('app').addEventListener('input', e => { const target = e.target; if (target.id === 'seed-input')
    homeSeed = target.value; });
$('app').addEventListener('change', e => { const target = e.target; if (target.id === 'mode-select') {
    selectedMode = target.value;
    if (selectedMode !== 'full')
        selectedDifficulty = 0;
    if (selectedMode === 'prototype' || selectedMode === 'demo' && !['scavenger', 'bulwark'].includes(selectedChassis))
        selectedChassis = 'scavenger';
    renderHome();
} if (target.id === 'difficulty-select')
    selectedDifficulty = Number(target.value); });
$('modal-content').addEventListener('change', e => { const input = e.target, k = input.dataset.setting; if (!k)
    return; if (k === 'volume')
    profile.settings.volume = Number(input.value);
else
    profile.settings[k] = input.checked; applySettings(); persist(); });
$('language-button').onclick = () => { profile.language = profile.language === 'zh' ? 'en' : 'zh'; applySettings(); persist(); render(); if (activeDialog === 'settings')
    settings(); if (activeDialog === 'codex')
    codex(); };
$('home-button').onclick = () => { if (battle && screen === 'run')
    setPause();
else {
    screen = 'home';
    renderHome();
} };
$('settings-button').onclick = settings;
$('codex-button').onclick = codex;
$('close-modal').onclick = closeModal;
$('modal').addEventListener('cancel', e => { e.preventDefault(); closeModal(); });
$('pause-button').onclick = setPause;
$('dash-button').onpointerdown = e => { e.preventDefault(); audio.unlock(); dashQueued = true; };
$('overload-button').onpointerdown = e => { e.preventDefault(); audio.unlock(); overloadQueued = true; };
window.addEventListener('keydown', e => { if (e.target?.matches('input,select,textarea'))
    return; if (e.code === 'Space' || e.key.startsWith('Arrow'))
    e.preventDefault(); if (e.repeat)
    return; if (e.code === 'Space')
    dashQueued = true; if (e.code === 'KeyE')
    overloadQueued = true; if (e.code === 'KeyR' && run?.phase !== 'battle') {
    const b = document.createElement('button');
    b.dataset.action = 'rotate';
    void dispatch(b);
} if (e.code === 'KeyP' || e.code === 'Escape') {
    if (battle && screen === 'run') {
        if (paused)
            closeModal();
        else
            setPause();
    }
    return;
} keys.add(e.code); });
window.addEventListener('keyup', e => keys.delete(e.code));
window.addEventListener('blur', () => { keys.clear(); if (battle && screen === 'run' && !paused)
    setPause(); });
const battleCanvas = $('battle-canvas');
battleCanvas.addEventListener('contextmenu', e => { e.preventDefault(); if (battle && !paused) {
    targetQueued = renderer.toWorld(e.clientX, e.clientY);
    targetMarker = targetQueued;
    targetUntil = performance.now() + 2000;
} });
battleCanvas.addEventListener('pointerdown', e => { if (!battle || paused)
    return; audio.unlock(); if (e.pointerType === 'mouse') {
    if (e.button === 0) {
        targetQueued = renderer.toWorld(e.clientX, e.clientY);
        targetMarker = targetQueued;
        targetUntil = performance.now() + 2000;
    }
    return;
} const moveSide = profile.settings.leftHanded ? e.clientX > window.innerWidth * .45 : e.clientX < window.innerWidth * .55; if (moveSide && !joy) {
    joy = { id: e.pointerId, x: e.clientX, y: e.clientY, dx: 0, dy: 0 };
    battleCanvas.setPointerCapture(e.pointerId);
    const j = $('joystick');
    j.style.display = 'block';
    j.style.left = e.clientX + 'px';
    j.style.top = e.clientY + 'px';
}
else {
    window.clearTimeout(aimTimer);
    aimTimer = window.setTimeout(() => { targetQueued = renderer.toWorld(e.clientX, e.clientY); targetMarker = targetQueued; targetUntil = performance.now() + 2000; }, 350);
} e.preventDefault(); });
battleCanvas.addEventListener('pointermove', e => { if (joy?.id === e.pointerId) {
    const dx = e.clientX - joy.x, dy = e.clientY - joy.y, len = Math.max(42, Math.hypot(dx, dy));
    joy.dx = dx / len;
    joy.dy = dy / len;
    const knob = $('joystick').firstElementChild;
    knob.style.transform = `translate(${joy.dx * 33}px,${joy.dy * 33}px)`;
}
else
    window.clearTimeout(aimTimer); });
function releasePointer(e) { if (joy?.id === e.pointerId) {
    joy = null;
    $('joystick').style.display = 'none';
} window.clearTimeout(aimTimer); }
battleCanvas.addEventListener('pointerup', releasePointer);
battleCanvas.addEventListener('pointercancel', releasePointer);
document.addEventListener('visibilitychange', () => { if (document.hidden) {
    if (battle && screen === 'run')
        setPause();
    audio.suspend();
    persist();
}
else if (!paused)
    audio.resume(); });
window.addEventListener('pagehide', persist);
function frame(now) {
    const dt = Math.min(.1, Math.max(0, (now - lastFrame) / 1000));
    lastFrame = now;
    homeTime += dt;
    if (battle && run?.phase === 'battle' && screen === 'run') {
        if (!paused) {
            accumulator += dt;
            let steps = 0;
            while (accumulator >= 1 / 60 && steps < 6 && battle.status === 'playing') {
                const input = { x: (keys.has('KeyD') || keys.has('ArrowRight') ? 1 : 0) - (keys.has('KeyA') || keys.has('ArrowLeft') ? 1 : 0) + (joy?.dx ?? 0), y: (keys.has('KeyS') || keys.has('ArrowDown') ? 1 : 0) - (keys.has('KeyW') || keys.has('ArrowUp') ? 1 : 0) + (joy?.dy ?? 0), dash: dashQueued, overload: overloadRequested(overloadQueued, profile.settings.autoOverload, battle.player.overloadCooldown), target: targetQueued };
                dashQueued = false;
                overloadQueued = false;
                targetQueued = undefined;
                stepBattle(battle, input, 1 / 60);
                accumulator -= 1 / 60;
                steps++;
            }
            audio.consume(battle.events);
            if (battle.status !== 'playing') {
                if (terminalElapsed < 0) {
                    terminalElapsed = 0;
                    persist();
                }
                terminalElapsed += dt;
                accumulator = 0;
                const hold = profile.settings.reducedMotion ? .12 : battle.status === 'lost' ? .65 : .35;
                if (terminalElapsed >= hold) {
                    completeBattle();
                    requestAnimationFrame(frame);
                    return;
                }
            }
            if (battle.time - lastSave >= 5) {
                lastSave = battle.time;
                persist();
            }
        }
        renderer.draw(battle, { lang: profile.language, reducedMotion: profile.settings.reducedMotion, colorAssist: profile.settings.colorAssist, target: now < targetUntil ? targetMarker : undefined });
        if (now - lastHud > 100) {
            updateHud();
            lastHud = now;
        }
    }
    requestAnimationFrame(frame);
}
async function boot() { const saved = await loadSave(); profile = saved.profile; run = saved.run; battle = saved.battle; selectedChassis = run?.chassis ?? 'scavenger'; selectedMode = run?.mode ?? 'full'; selectedDifficulty = run?.difficulty ?? 0; audio.configure(profile.settings); applySettings(); renderHome(); try {
    await renderer.load();
    assetsReady = true;
    drawIcons();
    drawBoard();
}
catch (error) {
    console.error(error);
    toast(t('部分素材未能加载，请刷新页面重试。', 'Some artwork could not load. Please refresh.'));
} lastFrame = performance.now(); requestAnimationFrame(frame); }
void boot();
