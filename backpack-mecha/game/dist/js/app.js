import { chassisSkill, skillName, skillDescription } from "./skills.js?v=c32c7858f958";
import { rarity, rarityName, TIERS, offerTier, equipmentPrice, moduleStat, shopTierChances } from "./rarity.js?v=c32c7858f958";
import { rarityBadge, equipmentDescription } from "./equipment-ui.js?v=c32c7858f958";
import { workshopMarkup } from "./ui-workshop.js?v=c32c7858f958";
import { TRAINING_PRESETS, trainingRun, chassisUnlocked, difficultyLimit } from "./training.js?v=c32c7858f958";
import { ENEMY_TACTICS, ELITE_AFFIXES, localized } from "./bestiary.js?v=c32c7858f958";
import { MODULES, MODULE_BY_ID, CHASSIS, CHASSIS_BY_ID, ENEMIES, ENEMY_BY_ID, BOSSES, BOSS_BY_ID, PROTOCOL_BY_ID, EVENT_BY_ID, label } from "./content.js?v=c32c7858f958";
import * as economy from "./economy.js?v=c32c7858f958";
import { createBattle, stepBattle, battleResult } from "./combat.js?v=c32c7858f958";
import { Renderer } from "./renderer.js?v=c32c7858f958";
import { loadSave, saveGame, freshProfile, applyProgress, scoreRun } from "./storage.js?v=c32c7858f958";
import { GameAudio } from "./audio.js?v=c32c7858f958";
import { overloadRequested, FocusGesture } from "./input.js?v=c32c7858f958";
import { exportRunReport, preserveJournal, recordAction, recordPrepTime, recordFrame } from "./journal.js?v=c32c7858f958";
import { BUILD_VERSION } from "./version.js?v=c32c7858f958";
import { ForegroundFrameClock } from "./performance.js?v=c32c7858f958";
import { supportFeedback, supportBenefit, connectionLesson, workshopHints, deploymentWarnings } from "./workshop.js?v=c32c7858f958";
const $ = (id) => document.getElementById(id);
const escape = (value) => String(value).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
let profile = freshProfile(), run = null, battle = null, screen = 'home', paused = false;
let deferPending = false, terminalElapsed = -1, displayedScreen = '';
let selectedChassis = 'scavenger', selectedMode = 'full', selectedDifficulty = 0, selectedUid = '', pendingBuy = -1, pendingOfferId = '', heldRotation = 0, editUndo = null;
let toastTimer = 0, lastFrame = 0, accumulator = 0, lastSave = 0, lastHud = 0, homeTime = 0, assetsReady = false, assetsLoading = false, assetsFailed = false, renderFailed = false, assetsLoaded = 0, tutorialShown = '', activeDialog = '', lastUnlocks = [];
const renderer = new Renderer($('battle-canvas'));
const audio = new GameAudio(profile.settings);
const keys = new Set();
let dashQueued = false, overloadQueued = false, skillQueued = false, targetQueued, targetMarker, targetUntil = 0;
let joy = null;
const focusGesture = new FocusGesture();
const frameClock = new ForegroundFrameClock();
let boardOptions = [];
let drag = null;
const selectedCorners = new Set();
const t = (zh, en) => profile.language === 'zh' ? zh : en;
const name = (obj) => label(obj, profile.language);
const tier = (n) => rarity(n).roman;
const kind = (k) => k === 'weapon' ? t('武器', 'WEAPON') : k === 'support' ? t('支持', 'SUPPORT') : t('功能', 'UTILITY');
const stageName = (act) => [t('废料堆场', 'Scrap Yard'), t('熔炼工厂', 'Foundry'), t('轨道货港', 'Orbital Port')][act - 1];
const formatTime = (n) => `${Math.floor(n / 60).toString().padStart(2, '0')}:${Math.floor(n % 60).toString().padStart(2, '0')}`;
function resetControls() { frameClock.reset(); keys.clear(); joy = null; dashQueued = false; overloadQueued = false; skillQueued = false; targetQueued = undefined; targetMarker = undefined; targetUntil = 0; focusGesture.clear(); drag = null; $('joystick').style.display = 'none'; }
function seed() { return 'RIG-' + Math.random().toString(36).slice(2, 8).toUpperCase(); }
let homeSeed = seed();
let workshopTab = 'shop';
let catalogTab = 'modules', catalogQuery = '';
let practiceSetup = { chassis: 'scavenger', boss: 'B1A', difficulty: 0, tier: 2, power: 18, modules: [...TRAINING_PRESETS[0].modules] };
let careerState = null;
function toast(message) { $('toast').textContent = message; $('toast').classList.add('show'); window.clearTimeout(toastTimer); toastTimer = window.setTimeout(() => $('toast').classList.remove('show'), 3500); }
function persist() { void saveGame({ version: 1, profile, run: careerState ? careerState.run : run, battle: careerState ? careerState.battle : battle, savedAt: Date.now() }).then(ok => { const warn = $('save-warning'); warn.hidden = ok; if (!ok)
    warn.textContent = t('浏览器保存不可用；本次游戏仍可继续。', 'Browser storage unavailable. You can keep playing this session.'); }); }
function applySettings() { const edition = document.querySelector('.edition'); if (edition)
    edition.textContent = 'v' + BUILD_VERSION; document.documentElement.lang = profile.language === 'zh' ? 'zh-CN' : 'en'; document.body.classList.toggle('reduced-motion', profile.settings.reducedMotion); document.body.classList.toggle('left-handed', profile.settings.leftHanded); $('codex-button').textContent = t('图鉴', 'Codex'); $('settings-button').textContent = t('设置', 'Settings'); $('language-button').textContent = t('EN', '中文'); $('station-label').textContent = t('回收站 07', 'DEPOT 07'); audio.configure(profile.settings); }
function showScreen(id) { if (displayedScreen !== id) {
    displayedScreen = id;
    window.scrollTo(0, 0);
} for (const key of ['home', 'prep', 'battle', 'result'])
    $(key + '-screen').hidden = key !== id; document.body.classList.toggle('battle-active', id === 'battle'); document.body.classList.toggle('workshop-active', id === 'prep'); }
function drawIcons(root = document) { root.querySelectorAll('canvas[data-icon]').forEach(c => renderer.icon(c, c.dataset.icon)); root.querySelectorAll('canvas[data-portrait]').forEach(c => renderer.portrait(c, c.dataset.portrait)); root.querySelectorAll('canvas[data-sprite]').forEach(c => renderer.thumbnail(c, c.dataset.sprite)); }
function canvasIcon(id, cls = '') { return `<canvas class="${cls}" width="128" height="128" data-icon="${escape(id)}" aria-label="${escape(name(MODULE_BY_ID[id]))}"></canvas>`; }
function unlockReason(id) { return id === 'bulwark' ? t('完成第一章解锁', 'Clear Act I to unlock') : id === 'kestrel' ? t('三章通关解锁', 'Complete a full run to unlock') : t('使用无人机击败第二章 Boss', 'Defeat an Act II boss with drones'); }
function updateAssetStatus() {
    const status = $('asset-status'), message = $('asset-message'), retry = $('asset-retry');
    status.hidden = assetsReady && !renderFailed;
    retry.hidden = !assetsFailed && !renderFailed;
    message.textContent = renderFailed ? t('画面暂时无法显示，进度已尝试保存。请刷新页面；若仍失败，请更新浏览器。', 'Unable to draw the game. A save was attempted. Reload the page, or update your browser if this continues.') : assetsFailed ? t('图片加载中断，请检查网络后重试。已加载的图片会保留。', 'Artwork loading stopped. Check your connection and retry; loaded images are kept.') :
        t(`正在加载机甲与武器… ${assetsLoaded}/4，首次打开请稍候。`, `Loading mechs and weapons… ${assetsLoaded}/4. Please wait on your first visit.`);
    retry.textContent = renderFailed ? t('刷新页面', 'Reload page') : t('重试加载', 'Retry loading');
    document.querySelectorAll('[data-action="new-run"],[data-action="continue"],[data-action="confirm-new"],[data-action="again"],[data-action="deploy"]').forEach(button => { button.disabled = !assetsReady || renderFailed; });
}
async function loadArtwork() {
    if (assetsLoading || assetsReady)
        return;
    assetsLoading = true;
    assetsFailed = false;
    updateAssetStatus();
    try {
        await renderer.load(progress => { assetsLoaded = progress.loaded; updateAssetStatus(); drawIcons(); });
        assetsReady = true;
        drawIcons();
        drawBoard();
    }
    catch (error) {
        console.error(error);
        assetsFailed = true;
    }
    finally {
        assetsLoading = false;
        updateAssetStatus();
    }
}
function renderHome() {
    showScreen('home');
    audio.stop();
    audio.music('home');
    applySettings();
    const c = CHASSIS_BY_ID[selectedChassis];
    $('home-screen').innerHTML = `<div class="home-layout"><div class="home-intro"><div class="eyebrow">FIELD NOTES / 001 <span class="orange">&nbsp; · &nbsp; ${t('废铁也有第二次机会', 'A SECOND LIFE FOR SCRAP')}</span></div><h1>${t('把废铁，<br>装成<em>王牌。</em>', 'Small pack.<br><em>Big firepower.</em>')}</h1><p class="lead">${t('空间有限，组合无限。拼好你的机甲，穿过失控的回收工厂，把每一次失败变成新的打法。', 'Build a better machine from what you find. Fit your weapons, discover a synergy, and take back the runaway factories.')}</p><div class="hero-rig"><canvas id="hero-portrait" width="640" height="480" data-portrait="${c.id}"></canvas><div class="rig-caption"><strong>${escape(name(c))}</strong>${t('模块化回收机体', 'MODULAR SALVAGE RIG')}<br>UNIT / ${String(CHASSIS.indexOf(c) + 1).padStart(2, '0')}</div></div></div><div class="launch-panel"><div class="panel-heading"><h2>${t('选择你的机体', 'Choose your chassis')}</h2><span class="serial">ASSEMBLY / 01</span></div><div class="chassis-list">${CHASSIS.map(ch => `<button class="chassis ${ch.id === c.id ? 'selected' : ''}" data-action="chassis" data-id="${ch.id}" aria-pressed="${ch.id === c.id}" title="${escape(chassisUnlocked(profile, ch.id) ? name(ch) : unlockReason(ch.id))}"><canvas width="192" height="192" data-portrait="${ch.id}"></canvas><span>${escape(name(ch))}</span>${chassisUnlocked(profile, ch.id) ? '' : '<b class="lock-mark">◇</b>'}</button>`).join('')}</div><div class="chassis-description"><strong>${escape(name(c))}</strong><p>${escape(profile.language === 'zh' ? c.trait : c.traitEn)}</p><p class="chassis-skill"><b>Q · ${escape(skillName(c.id, profile.language))}</b><br>${escape(skillDescription(c.id, profile.language))}</p><div class="mini-stats"><span>HP ${c.hp}</span><span>${t('护盾', 'SHIELD')} ${c.shield}</span><span>${t('移速', 'SPEED')} ${c.speed}</span></div></div><div class="launch-fields"><label class="field">${t('远征长度', 'EXPEDITION')}<select id="mode-select"><option value="full" ${selectedMode === 'full' ? 'selected' : ''}>${t('三章远征 · 约15分钟', 'Full expedition · ~15 min')}</option><option value="demo" ${selectedMode === 'demo' ? 'selected' : ''}>${t('两章试炼 · 约10分钟', 'Two-act trial · ~10 min')}</option><option value="prototype" ${selectedMode === 'prototype' ? 'selected' : ''}>${t('首章训练 · 约4分钟', 'Act I training · ~4 min')}</option></select></label><label class="field">${t('警戒等级', 'THREAT LEVEL')}<select id="difficulty-select">${Array.from({ length: 5 }, (_, i) => `<option value="${i}" ${i === selectedDifficulty ? 'selected' : ''} ${i > difficultyLimit(profile) || selectedMode !== 'full' && i > 0 ? 'disabled' : ''}>${i === 0 ? t('0 · 标准', '0 · Standard') : i + ' · ' + t('警戒', 'Alert')}${i > difficultyLimit(profile) ? ' ◇' : ''}</option>`).join('')}</select></label><label class="field wide">${t('远征种子 · 可分享相同路线', 'SEED · SHARE THE SAME EXPEDITION')}<input id="seed-input" maxlength="48" value="${escape(homeSeed)}" spellcheck="false"></label></div><button class="primary large" data-action="new-run"><span>${t('启动远征', 'BEGIN EXPEDITION')}</span><span>↗</span></button>${run && !['won', 'lost'].includes(run.phase) ? `<button class="continue" data-action="continue">${t('继续上次远征', 'Continue expedition')} · ${t('第', 'Wave ')}${run.wave}${t('场', '')}</button>` : ''}<p class="milestone">${t('自动攻击 · 手动走位 · 局间拼装 · 随时暂停', 'Auto fire · Manual movement · Build between waves · Pause anytime')}</p></div></div><div class="home-foot"><div><strong>36 ${t('件模块', 'MODULES')}</strong>${t('为每一格找到用途', 'EVERY CELL COUNTS')}</div><div><strong>06 ${t('条构筑路线', 'BUILD FAMILIES')}</strong>${t('在随机中找到组合', 'FIND YOUR SYNERGY')}</div><div><strong>03 ${t('座失控工厂', 'ROGUE FACTORIES')}</strong>${t('六种首领，三场决战', 'SIX BOSSES. THREE SHOWDOWNS.')}</div><div><strong>${String(profile.wins).padStart(2, '0')} ${t('次归来', 'RETURNS')}</strong>${t('带回经验，再次出发', 'REBUILD. RETURN. REPEAT.')}</div></div>`;
    $('home-screen').querySelector('.launch-fields').insertAdjacentHTML('beforebegin', `<label class="unlock-switch"><span><strong>${t('自由解锁', 'Unlock all')}</strong><small>${t('开放全部机体与 0–4 难度，可随时关闭', 'All chassis and threat levels; switch off anytime')}</small></span><input id="unlock-all" type="checkbox" role="switch" aria-label="${t('解锁全部角色和难度', 'Unlock all chassis and difficulties')}" ${profile.settings.unlockAll ? 'checked' : ''}></label>`);
    $('home-screen').querySelector('.launch-panel').insertAdjacentHTML('beforeend', `<div class="home-entries"><button data-action="catalog"><b>▦</b><span>${t('完整图鉴', 'Full archive')}<small>${t('模块 · 小怪 · 精英 · 首领', 'Modules · Enemies · Elites · Bosses')}</small></span><i>↗</i></button><button data-action="practice"><b>◎</b><span>${t('首领试炼场', 'Boss lab')}<small>${t('自由选配 · 直接挑战', 'Build a loadout · Challenge any boss')}</small></span><i>↗</i></button></div>`);
    drawIcons($('home-screen'));
    updateAssetStatus();
}
function selectedItem() { return run?.items.find(i => i.uid === selectedUid); }
function renderPlacementHelp() {
    if (!run)
        return '';
    const item = selectedItem(), support = run.items.find(i => i.id === 'S01');
    const feedback = item && pendingBuy < 0 ? supportFeedback(run, item.uid, profile.language) : undefined;
    if (feedback)
        return `<div class="placement-help support-feedback ${feedback.status === 'active' ? 'connected' : ''}" id="placement-feedback" role="status"><strong>${escape(feedback.title)}</strong><p>${escape(feedback.detail)}</p>${feedback.status !== 'active' ? `<p class="potential-benefit">${t('连接后', 'Once connected')}：${escape(feedback.benefit)}</p>` : ''}</div>`;
    let message = t('标记是模块左上角：青色＋可生效，橙色○支持件还需连接。旋转可查看其他方向。', 'Markers show the top-left cell: cyan + is active; amber ○ needs a support connection. Rotate for more options.');
    if (pendingBuy >= 0)
        message = t('点击圆点位置直接购买并装入；旋转可查看其他方向。', 'Tap a marked origin to buy directly into the backpack. Rotate to check other orientations.');
    else if (item?.stored)
        message = t('备件尚未生效。点击＋装入并生效；○位置的支持件还需连接。旋转可找其他位置。', 'Reserve items are inactive. Tap + to equip and activate; ○ supports still need a connection. Rotate for more positions.');
    else if (item?.link) {
        const weapon = run.items.find(w => w.uid === item.link);
        if (weapon)
            message = t(`已生效：${name(MODULE_BY_ID[item.id])} → ${name(MODULE_BY_ID[weapon.id])}。${MODULE_BY_ID[item.id].effect}`, `Connected: ${name(MODULE_BY_ID[item.id])} → ${name(MODULE_BY_ID[weapon.id])}. ${MODULE_BY_ID[item.id].effectEn}`);
    }
    else if (item && MODULE_BY_ID[item.id].kind === 'support')
        message = t('支持件尚未连接。将它移到兼容武器边缘，留出一个连接位。', 'Support inactive. Move it along a compatible weapon edge with a free support slot.');
    else if (!profile.tutorial && run.wave === 2 && support?.stored)
        message = t('第一次改装：选中备件架里的免费增幅线圈，再点击铆钉枪旁的青色圆点。', 'First upgrade: select the free Amplifier in reserve, then tap a cyan origin beside the Rivet gun.');
    return `<div class="placement-help" id="placement-feedback" role="status">${escape(message)}</div>`;
}
function renderConnectionLesson() {
    if (!run)
        return '';
    const step = connectionLesson(run, profile.tutorial, selectedUid);
    if (step === 'hidden')
        return '';
    const coil = run.items.find(i => i.id === 'S01'), feedback = supportFeedback(run, coil.uid, profile.language);
    const labels = [t('选择免费线圈', 'Select free coil'), t('放在兼容武器旁', 'Place beside a weapon'), t('检查连接并出击', 'Check link and deploy')], index = step === 'select' ? 0 : step === 'place' ? 1 : 2;
    return `<section class="connection-lesson" aria-label="${t('首次连接引导', 'First connection guide')}"><div class="lesson-heading"><strong>${step === 'ready' ? t('第一次连接完成', 'First connection complete') : t('第一次改装 · 三步接通火力', 'First upgrade · connect your firepower')}</strong><button data-action="skip-tutorial">${t('略过引导', 'Skip guide')}</button></div><ol class="lesson-steps">${labels.map((label, i) => `<li class="${i === index ? 'current' : i < index ? 'done' : ''}" ${i === index ? 'aria-current="step"' : ''}><span>${i < index ? '✓' : i + 1}</span>${label}</li>`).join('')}</ol><p>${escape(step === 'ready' ? feedback.detail : step === 'select' && coil.stored ? t('免费增幅线圈在备件架。先选中它，再看背包里的可连接位置。', 'Your free Amplifier is in reserve. Select it to see connection positions on the board.') : feedback.detail)}</p><div class="lesson-actions">${step === 'ready' ? `<button class="cyan-button" data-action="deploy">${t('连接已生效 · 出击', 'Connection active · Deploy')}</button>` : `<button class="cyan-button" data-action="guide-select">${t('选择免费线圈', 'Select free Amplifier')}</button>`}</div></section>`;
}
function previewPurchase(index) {
    if (!run)
        return;
    const offer = run.shop[index], m = offer?.id ? MODULE_BY_ID[offer.id] : undefined;
    if (!m)
        return;
    recordAction(run, `inspect:${m.id}`);
    const preview = economy.previewPurchase(run, index), connected = preview.placements.filter(p => p.ready), weapons = [...new Set(preview.placements.flatMap(p => p.linkedWeapon ? [name(MODULE_BY_ID[p.linkedWeapon.id])] : []))];
    const cells = m.shape.reduce((n, row) => n + [...row].filter(c => c === '#').length, 0), after = preview.placements[0], quality = offerTier(offer), mergeTargets = economy.purchaseMergeTargets(run, index);
    const fit = connected.length ? t('当前布局可装入并出战', 'Fits the current loadout and is ready for battle') : preview.placements.length ? t('能放入，但仍需处理未连接的支持件', 'Fits, but a support still needs a connection') : t('当前布局放不下，需旋转、移动或腾出其他模块', 'No fit in the current layout. Rearrange or remove equipment first.');
    openModal(`<div class="eyebrow">WORKSHOP / FIT CHECK</div><h2>${escape(name(m))} ${rarityBadge(quality, profile.language)}</h2><div class="purchase-preview rarity-${quality}">${canvasIcon(m.id)}<div><div class="module-shape" style="--shape-width:${m.shape[0].length}">${m.shape.flatMap(row => [...row].map(c => `<i class="${c === '#' ? 'filled' : ''}"></i>`)).join('')}</div><p>${cells} ${t('格', cells === 1 ? 'cell' : 'cells')} · ${t('耗电', 'Power')} ${m.power} · ⬡ ${economy.offerPrice(offer)}</p></div></div><p>${escape(equipmentDescription({ id: m.id, tier: quality }, profile.language))}</p>${m.kind === 'support' ? `<p class="purchase-benefit"><strong>${t('连接收益', 'Connection benefit')}</strong><br>${escape(supportBenefit({ uid: 'preview', id: m.id, tier: quality, x: -1, y: -1, rotation: 0, stored: true }, profile.language))}</p>` : ''}<div class="placement-help"><strong>${fit}</strong>${weapons.length ? `<p>${t('可连接', 'Can link to')}：${escape(weapons.join(' / '))}</p>` : ''}<p>${t('当前电力', 'Current power')} ${run.items.filter(i => !i.stored).reduce((n, i) => n + MODULE_BY_ID[i.id].power, 0)} / ${economy.getCapacity(run)}${after ? ` → ${after.power} / ${after.capacity}` : ''} · ${t('备件架', 'Reserve')} ${run.items.filter(i => i.stored).length} / 3</p>${after ? `<p>${t('装入后占格', 'Cells after equipping')} ${after.cells} / ${21 + run.unlockedCorners.length}</p>` : ''}</div>${!preview.result.ok ? `<p class="invalid">${escape(profile.language === 'zh' ? preview.result.reason : preview.result.reasonEn)}</p>` : ''}<div class="modal-actions">${mergeTargets.map(item => `<button class="merge-button" data-action="preview-buy-merge" data-index="${index}" data-uid="${item.uid}" ${run.gold >= economy.offerPrice(offer) ? '' : 'disabled'}>${t('购买并合成', 'Buy & combine')} · ${item.stored ? t('备件', 'Reserve') : t('已装备', 'Equipped')} → ${rarityName(item.tier + 1, profile.language)} · ⬡ ${economy.offerPrice(offer)}</button>`).join('')}<button class="primary" data-action="place-purchase" data-index="${index}" ${preview.result.ok && preview.placements.length ? '' : 'disabled'}>${t('选择位置并装入', 'Choose a placement')}</button><button data-action="buy" data-index="${index}" ${preview.result.ok && preview.canReserve ? '' : 'disabled'}>${t('购买到备件架', 'Buy to reserve')}</button><button data-action="close">${t('返回', 'Back')}</button></div>`, 'purchase');
}
function showRarityHelp() {
    const odds = shopTierChances(run?.wave ?? 2);
    openModal(`<div class="eyebrow">SALVAGE / RARITY</div><h2>${t('装备稀有度', 'Equipment rarity')}</h2><p>${t('两件同名、同稀有度装备可免费合成到下一阶，传说为最高阶。合成不改变形状与耗电。', 'Combine two identical modules of the same rarity for free, up to Legendary. Shape and power draw stay unchanged.')}</p><div class="rarity-comparison">${TIERS.map(level => `<div class="rarity-${level}">${rarityBadge(level, profile.language)}<b>${t('武器伤害', 'Weapon damage')} ×${rarity(level).damage} · ${t('武器价格', 'Weapon price')} ×${rarity(level).weaponPrice}<br>${t('支持 / 功能价格', 'Support / utility price')} ×${rarity(level).price}</b><p>${t('当前商店 / 新战利品概率', 'Current shop / new salvage chance')} ${(odds[level - 1] * 100).toFixed(1)}%</p></div>`).join('')}</div><p>${t('商店与新战利品共用当前概率。高阶装备随远征进度逐步出现：第 2 场可见精良，第 5 场可见史诗，第 9 场可见传说。支持件与功能件按各自效果成长，详情和图鉴显示实际数值。', 'Shop and new salvage share these odds. Higher rarities enter at waves 2 / 5 / 9. Supports and utilities scale their own effects; details and the archive show exact values.')}</p>`, 'rarity-help');
}
function showMerge(uid, shopIndex) {
    if (!run)
        return;
    const source = run.items.find(i => i.uid === uid);
    if (!source)
        return;
    const buying = shopIndex !== undefined, offer = buying ? run.shop[shopIndex] : undefined;
    if (buying && (!offer || !economy.purchaseMergeTargets(run, shopIndex).some(i => i.uid === uid)))
        return;
    const preview = buying ? null : economy.previewMerge(run, uid);
    if (!buying && !preview?.ok) {
        toast((profile.language === 'zh' ? preview?.reason : preview?.reasonEn));
        return;
    }
    const result = preview?.item ?? { ...source, tier: (source.tier + 1) }, price = offer ? economy.offerPrice(offer) : 0;
    openModal(`<div class="eyebrow">WORKSHOP / COMBINE</div><h2>${t('合成升阶', 'Combine equipment')}</h2><p>${escape(name(MODULE_BY_ID[source.id]))}</p><div class="merge-flow"><div class="rarity-${source.tier}">${canvasIcon(source.id)}${rarityBadge(source.tier, profile.language)}<b>× 2</b></div><span>→</span><div class="rarity-${result.tier}">${canvasIcon(result.id)}${rarityBadge(result.tier, profile.language)}<b>× 1</b></div></div><div class="merge-stats"><p>${moduleStat(source.id, source.tier, profile.language)} → <strong>${moduleStat(result.id, result.tier, profile.language)}</strong></p><p>${escape(equipmentDescription(result, profile.language))}</p></div><p>${buying ? t(`支付 ${price} 碎片购买材料，随即合成；不占备件空间。`, `Buy the material for ${price} scrap and combine immediately; no reserve space needed.`) : t('消耗两件同名同阶装备，合成为一件。无需碎片，优先保留已装备的位置。', 'Consumes two matching modules to create one. No scrap cost; preserves the equipped position when possible.')}</p>${preview?.disconnected?.length ? `<p class="invalid">${t('合成会使部分支持件失去连接；可重新摆放或整理，也可确认后带着失效配件出击。', 'Some supports will disconnect. Reposition, arrange, or confirm deployment with those supports inactive.')}</p>` : ''}<div class="modal-actions"><button class="primary" data-action="${buying ? 'confirm-buy-merge' : 'confirm-merge'}" data-uid="${uid}" ${buying ? `data-index="${shopIndex}"` : ''}>${buying ? t('购买并合成', 'Buy & combine') : t('免费合成', 'Combine for free')} ↑</button><button data-action="close">${t('取消', 'Cancel')}</button></div>`, 'merge');
    drawIcons();
}
function renderWaveReport() {
    if (!run?.journal)
        return '';
    const rows = run.journal.waves.filter(w => w.end);
    const prep = Object.values(run.journal.prepSeconds).reduce((a, b) => a + b, 0);
    return `<details class="wave-report"><summary>${t('逐场战报', 'Wave report')} · ${rows.length} ${t('场', 'waves')} · ${t('装配与选奖', 'Preparation')} ${formatTime(prep)}</summary>${run.journal.partial ? `<p class="muted">${t('此局由旧存档继续，早期记录不完整。', 'This run continued from an older save; earlier records are incomplete.')}</p>` : ''}<div class="report-scroll"><table><thead><tr><th>${t('场次', 'Wave')}</th><th>${t('结果', 'Result')}</th><th>${t('战斗', 'Combat')}</th><th>${t('战前休整', 'Prep')}</th><th>${t('生命', 'HP')}</th><th>${t('收入', 'Income')}</th></tr></thead><tbody>${rows.map(w => `<tr><td>${w.wave}${w.boss ? ' · ' + escape(name(BOSS_BY_ID[w.boss])) : ''}</td><td>${w.end.won ? '✓' : '×'}</td><td>${formatTime(w.end.seconds)}</td><td>${formatTime(w.prepSeconds)}</td><td>${Math.ceil(w.start.hp)} → ${Math.ceil(w.end.hp)}</td><td>+${Math.floor(w.end.income)}</td></tr>`).join('')}</tbody></table></div><p class="muted">${t('导出战报可查看每场装配、商店供货、交易与伤害明细。', 'Export the report for loadouts, shop offers, transactions and damage breakdowns.')}</p></details>`;
}
function describe(item) { return escape(equipmentDescription(item, profile.language)); }
function renderPrep() {
    if (!run)
        return;
    showScreen('prep');
    applySettings();
    audio.stop();
    audio.music('home');
    const r = run, selected = selectedItem();
    $('prep-screen').innerHTML = workshopMarkup(r, { lang: profile.language, selected, pendingBuy, undo: !!editUndo, tab: workshopTab, icon: canvasIcon, placement: renderPlacementHelp(), event: renderEvent(), tutorial: profile.tutorial });
    boardOptions = pendingBuy >= 0 ? economy.previewPurchase(r, pendingBuy).placements.filter(p => p.item?.rotation === heldRotation) : selected ? economy.placementOptions(r, selected.uid, heldRotation) : [];
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
    return ''; const ids = run.items.filter(i => run.eventId !== 'EV03' || i.tier === 1); const tags = [...new Set(run.items.filter(i => !i.stored && MODULE_BY_ID[i.id].kind === 'weapon').flatMap(i => MODULE_BY_ID[i.id].tags))]; return `<div class="event-box"><div class="eyebrow orange">${t('偶遇', 'ENCOUNTER')} / ${escape(name(e))}</div><p>${escape(e.id === 'EV01' ? t('支付24碎片，从三件进阶型号中选择一件，稀有度随关卡提升；或离开。', 'Pay 24 scrap to choose from three advanced designs. Rarity improves with progress, or you can leave.') : e.id === 'EV04' ? t('下一战额外出现1只精英；胜利后从三件进阶型号中选择一件，稀有度随关卡提升。', 'Face an extra elite next wave; on victory choose from three advanced designs with progress-scaled rarity.') : profile.language === 'zh' ? e.description : e.descriptionEn)}</p>${['EV03', 'EV05'].includes(e.id) ? `<select id="event-target" style="width:100%;font-size:11px;margin-bottom:8px"><option value="">${t('选择处理的模块', 'Select a module')}</option>${ids.map(i => `<option value="${i.uid}" ${run.extra?.eventTargetUid === i.uid ? 'selected' : ''}>${escape(name(MODULE_BY_ID[i.id]))} ${tier(i.tier)}</option>`).join('')}</select>` : ''}${e.id === 'EV06' ? `<select id="event-tag" style="width:100%;font-size:11px;margin-bottom:8px"><option value="">${t('选择武器标签', 'Select weapon tag')}</option>${tags.map(tag => `<option value="${escape(tag)}" ${run.extra?.eventTargetTag === tag ? 'selected' : ''}>${escape(tagName(tag))}</option>`).join('')}</select>` : ''}<div class="event-actions"><button data-action="event" data-index="0">${eventChoice(e.id, 0)}</button><button data-action="event" data-index="1">${eventChoice(e.id, 1)}</button>${['EV01', 'EV02', 'EV04'].includes(e.id) ? '' : `<button data-action="event" data-index="-1">${t('离开', 'Leave')}</button>`}</div></div>`; }
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
        ctx.fillStyle = rarity(item.tier).color + (sel ? '55' : '25');
        ctx.strokeStyle = sel ? '#fff5d4' : rarity(item.tier).color;
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
        ctx.fillStyle = rarity(item.tier).color;
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
    for (const option of boardOptions) {
        const item = option.item;
        if (!item)
            continue;
        ctx.beginPath();
        ctx.arc((item.x + .5) * cell, (item.y + .5) * cell, 12, 0, Math.PI * 2);
        const unlinked = MODULE_BY_ID[item.id].kind === 'support' && !option.linkedWeapon;
        ctx.fillStyle = unlinked ? '#f3ac62' : '#6ff3d3';
        ctx.fill();
        ctx.strokeStyle = '#10191f';
        ctx.lineWidth = 4;
        ctx.stroke();
        ctx.fillStyle = '#10191f';
        ctx.font = 'bold 22px sans-serif';
        ctx.textAlign = 'center';
        ctx.fillText(unlinked ? '○' : '+', (item.x + .5) * cell, (item.y + .5) * cell + 8);
    }
    if (drag?.moved) {
        const item = run.items.find(i => i.uid === drag.uid);
        if (item) {
            const draft = { ...item, x: drag.x, y: drag.y, rotation: heldRotation, stored: false };
            const valid = economy.previewPlacement(run, item.uid, draft.x, draft.y, draft.rotation).ok;
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
    canvas.onpointerdown = e => { if (!run || drag)
        return; const p = boardPoint(e); const item = run.items.find(i => !i.stored && economy.getCells(i).some(c => c.x === p.x && c.y === p.y)); if (item) {
        pendingBuy = -1;
        workshopTab = 'module';
        selectedUid = item.uid;
        heldRotation = item.rotation;
        boardOptions = economy.placementOptions(run, item.uid, heldRotation);
        drag = { pointerId: e.pointerId, uid: item.uid, startX: e.clientX, startY: e.clientY, offsetX: p.x - item.x, offsetY: p.y - item.y, x: item.x, y: item.y, moved: false };
        canvas.setPointerCapture(e.pointerId);
        drawBoard();
    }
    else {
        placeAt(p.x, p.y);
    } e.preventDefault(); };
    const move = (e) => { if (!drag || drag.pointerId !== e.pointerId)
        return; if (Math.hypot(e.clientX - drag.startX, e.clientY - drag.startY) > 6)
        drag.moved = true; const p = boardPoint(e); drag.x = p.x - drag.offsetX; drag.y = p.y - drag.offsetY; drawBoard(); };
    const release = (e) => { if (!drag || drag.pointerId !== e.pointerId || !run)
        return; const d = drag; drag = null; if (d.moved) {
        const before = structuredClone(run);
        const result = economy.placeItem(run, d.uid, d.x, d.y, heldRotation);
        if (result.ok)
            editUndo = before;
        if (!actResult(result, 'connect', true))
            drawBoard();
    }
    else
        renderPrep(); };
    const cancel = (e) => { if (drag?.pointerId === e.pointerId) {
        drag = null;
        drawBoard();
    } };
    canvas.onpointermove = move;
    canvas.onpointerup = release;
    canvas.onpointercancel = cancel;
    canvas.onlostpointercapture = cancel;
    for (const slot of Array.from(document.querySelectorAll('.rack-slot[data-uid]'))) {
        let suppressClick = false;
        slot.onpointerdown = e => {
            if (!run || drag || e.button !== 0)
                return;
            const item = run.items.find(i => i.uid === slot.dataset.uid && i.stored);
            if (!item)
                return;
            suppressClick = false;
            pendingBuy = -1;
            workshopTab = 'module';
            selectedUid = item.uid;
            heldRotation = item.rotation;
            boardOptions = economy.placementOptions(run, item.uid, heldRotation);
            drag = { pointerId: e.pointerId, uid: item.uid, startX: e.clientX, startY: e.clientY, offsetX: 0, offsetY: 0, x: -1, y: -1, moved: false };
            slot.setPointerCapture(e.pointerId);
            e.preventDefault();
            drawBoard();
        };
        slot.onpointermove = move;
        slot.onpointerup = e => { if (drag?.pointerId === e.pointerId)
            suppressClick = drag.moved; release(e); };
        slot.onpointercancel = cancel;
        slot.onlostpointercapture = cancel;
        slot.onclick = e => { if (suppressClick) {
            suppressClick = false;
            e.preventDefault();
            e.stopPropagation();
        } };
    }
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
    if (run)
        recordAction(run, `rejected:${result.reasonEn ?? result.reason ?? 'unknown'}`);
    const feedback = $('placement-feedback');
    if (feedback) {
        feedback.textContent = (profile.language === 'zh' ? result.reason : result.reasonEn) ?? '';
        feedback.classList.add('invalid');
    }
    toast((profile.language === 'zh' ? result.reason : result.reasonEn) ?? t('操作未完成', 'Action could not be completed'));
    audio.play('invalid');
    return false;
} audio.play(sound); persist(); if (rerender)
    render(); return true; }
function updateCodex() { if (!run || careerState)
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
function openModal(html, kind = 'normal') { if (battle && screen === 'run') {
    paused = true;
    resetControls();
    audio.suspend();
} activeDialog = kind; $('modal-content').innerHTML = html; const modal = $('modal'); if (!modal.open)
    modal.showModal(); drawIcons($('modal-content')); }
function closeModal() { if (['reward', 'protocol', 'expansion'].includes(activeDialog))
    deferPending = true; activeDialog = ''; $('modal').close(); if (battle && run?.phase === 'battle' && screen === 'run') {
    paused = false;
    resetControls();
    audio.resume();
    lastFrame = performance.now();
} }
function setPause() { if (!battle || run?.phase !== 'battle')
    return; paused = true; resetControls(); audio.suspend(); persist(); openModal(`<div class="eyebrow">SYSTEM / PAUSED</div><h2>${t('引擎暂歇', 'Engines on hold')}</h2><p>${t('战斗与冷却已暂停。当前装配只能在休整时调整。', 'Combat and cooldowns are paused. Equipment can be changed between waves.')}</p><div class="protocol-list">${run.items.filter(i => !i.stored).map(i => `<span class="chip rarity-${i.tier}">${escape(name(MODULE_BY_ID[i.id]))} ${rarityBadge(i.tier, profile.language)}</span>`).join('')}</div><div class="modal-actions"><button class="primary" data-action="resume">${t('继续战斗', 'Resume')}</button><button data-action="save-home">${careerState ? t('退出练习，回到首页', 'Exit practice') : t('保存并回到回收站', 'Save & return to depot')}</button><button data-action="settings">${t('设置', 'Settings')}</button></div>`, 'pause'); }
function showPending() { if (!run)
    return; deferPending = false; const r = run; if (r.phase === 'reward') {
    openModal(`<div class="eyebrow">SALVAGE / ${t('战利品', 'REWARD')}</div><h2>${t('发现可用模块', 'Salvage recovered')}</h2><p>${t('选择一件带走，也可以换成12碎片。备件架满时先整理。', 'Take one module, or collect 12 scrap. Make room in your reserve if needed.')}</p><div class="choice-grid">${r.rewardOptions.map((id, index) => `<button class="choice-card" data-action="reward" data-index="${index}">${canvasIcon(id)}<strong>${escape(name(MODULE_BY_ID[id]))} ${rarityBadge(economy.rewardTier(r, index), profile.language)}</strong><small>${escape(equipmentDescription({ id, tier: economy.rewardTier(r, index) }, profile.language))}</small></button>`).join('')}</div><div class="modal-actions"><button data-action="reward" data-index="-1">⬡ +12 ${t('碎片', 'scrap')}</button><button data-action="close">${t('先整理背包', 'Arrange backpack first')}</button></div>`, 'reward');
}
else if (r.phase === 'protocol') {
    openModal(`<div class="eyebrow">SYSTEM / UPGRADE</div><h2>${t('选择战术协议', 'Choose a protocol')}</h2><p>${t('协议持续到本次远征结束，不占格子。', 'Protocols last for this expedition and use no backpack space.')}</p><div class="choice-grid">${r.protocolOptions.map(id => { const p = PROTOCOL_BY_ID[id]; return `<button class="choice-card" data-action="protocol" data-id="${id}"><strong>${escape(name(p))}</strong><small>${escape(profile.language === 'zh' ? p.effect : p.effectEn)}</small></button>`; }).join('')}</div>`, 'protocol');
}
else if (r.phase === 'expansion') {
    selectedCorners.clear();
    openModal(`<div class="eyebrow">FRAME / EXPANSION</div><h2>${t('扩展背包框架', 'Expand the frame')}</h2><p>${t('选择两个角格解锁，机体基础电力也会提升。', 'Choose two corners to unlock. Base power also increases.')}</p><div class="corner-grid">${[t('左上角', 'Top left'), t('右上角', 'Top right'), t('左下角', 'Bottom left'), t('右下角', 'Bottom right')].map((v, i) => `<button data-action="corner" data-index="${i}" ${r.unlockedCorners.includes(i) ? 'disabled' : ''}>${v}${r.unlockedCorners.includes(i) ? ' ✓' : ''}</button>`).join('')}</div><button class="primary" data-action="expand">${t('确认扩容', 'Confirm expansion')}</button>`, 'expansion');
} }
function warningMarkup(r) { return `<ul class="deployment-warnings">${deploymentWarnings(r, profile.language).map(w => `<li><strong>${escape(w.name)} · ${escape(w.reason)}</strong><p>${escape(w.detail)}</p></li>`).join('')}</ul>`; }
function confirmInactive(r, action) {
    if (!deploymentWarnings(r, profile.language).length)
        return false;
    openModal(`<div class="eyebrow">LOADOUT / NOTICE</div><h2>${t('部分配件不会生效', 'Some supports will be inactive')}</h2><p>${t('以下配件保留在背包里并占用格子与电力，但本场不会提供增益。其他武器和模块正常工作。', 'These supports keep their space and power cost but grant no bonuses this battle. Other equipment works normally.')}</p>${warningMarkup(r)}<div class="modal-actions"><button class="primary" data-action="${action}">${t('仍然出击', 'Deploy anyway')} ↗</button><button data-action="${action === 'practice-confirm' ? 'practice' : 'close'}">${t('返回调整', 'Adjust loadout')}</button></div>`, 'inactive-supports');
    return true;
}
function deploy(confirmed = false) {
    if (!run || !assetsReady || renderFailed)
        return;
    resetControls();
    if (run.phase !== 'prep') {
        showPending();
        return;
    }
    const check = economy.validateLoadout(run);
    if (!check.ok) {
        actResult(check, 'click', false);
        return;
    }
    if (run.eventId && !run.eventResolved) {
        actResult(economy.startWave(run), 'click', false);
        return;
    }
    if (!confirmed && confirmInactive(run, 'deploy-confirm'))
        return;
    closeModal();
    updateCodex();
    const result = economy.startWave(run);
    if (!actResult(result, 'click', false))
        return;
    battle = createBattle(run);
    terminalElapsed = -1;
    screen = 'run';
    paused = false;
    accumulator = 0;
    lastFrame = performance.now();
    lastSave = 0;
    lastHud = 0;
    pendingBuy = -1;
    editUndo = null;
    targetQueued = undefined;
    targetMarker = undefined;
    audio.resetEvents();
    audio.stop();
    audio.music('battle');
    if (run.wave >= 2 && run.items.some(i => i.link))
        profile.tutorial = true;
    render();
    persist();
}
function beginNewRun() { if (!assetsReady || renderFailed)
    return; const value = $('seed-input')?.value.trim() || homeSeed; homeSeed = value; if (selectedMode === 'prototype' || selectedMode === 'demo' && !['scavenger', 'bulwark'].includes(selectedChassis))
    selectedChassis = 'scavenger'; run = economy.newRun(selectedChassis, selectedMode, selectedDifficulty, profile.tutorial ? value : 'FIRST-LIGHT'); battle = null; selectedUid = ''; pendingBuy = -1; lastUnlocks = []; screen = 'run'; profile.totalRuns++; if (!profile.tutorial) {
    const support = run.items.find(i => i.id === 'S01');
    if (support)
        economy.storeItem(run, support.uid);
} deploy(); if (!profile.tutorial) {
    paused = true;
    openModal(`<div class="eyebrow">FIRST LIGHT / 01</div><h2>${t('欢迎驾驶，维修师。', 'Welcome aboard, pilot.')}</h2><div class="guide-steps"><div class="guide-step"><b>01</b><p>${t('WASD / 方向键，或左侧拖动摇杆移动。武器会自动攻击。', 'Move with WASD / arrow keys, or drag on the left. Weapons fire automatically.')}</p></div><div class="guide-step"><b>02</b><p>${t('空格 / 右侧箭头冲刺。E / 闪电按钮开启短时超载。', 'Space / arrow button to dash. E / lightning button to overdrive.')}</p></div><div class="guide-step"><b>03</b><p>${t('避开红色预警。战后用碎片买模块，把支持装在武器旁。', 'Avoid red warnings. Buy modules after battle and connect supports beside weapons.')}</p></div></div><div class="modal-actions"><button class="primary" data-action="resume">${t('准备好了 · 出发', 'Ready · Deploy')}</button><button data-action="skip-tutorial">${t('熟悉操作 · 略过引导', 'Skip guide')}</button></div>`, 'tutorial');
} persist(); }
function completeBattle() { if (!run || !battle)
    return; if (careerState) {
    completePractice();
    return;
} deferPending = false; editUndo = null; const completedWave = run.wave, usedDrones = run.items.some(i => !i.stored && i.id === 'W11'); const result = battleResult(battle); const outcome = economy.resolveBattle(run, result); if (!outcome.ok) {
    toast(t('结算异常，请暂停后重试', 'Settlement failed. Pause and retry.'));
    return;
} lastUnlocks.push(...applyProgress(profile, run, completedWave, result.won, usedDrones)); updateCodex(); audio.play(result.won ? 'win' : 'lose'); battle = null; keys.clear(); joy = null; $('joystick').style.display = 'none'; paused = false; render(); persist(); if (result.won && run.wave === 2 && !profile.tutorial && tutorialShown !== run.seed) {
    tutorialShown = run.seed;
    openModal(`<div class="eyebrow">WORKSHOP / FIRST CONNECTION</div><h2>${t('第一次改装', 'Your first upgrade')}</h2><p>${t('备件架中有一件免费增幅线圈。点击它，再点击铆钉枪旁的空格；青色连接线表示生效；装好后会显示这次连接的当前增益。', 'A free Amplifier is waiting in reserve. Select it, then tap a free cell beside the Rivet gun. A cyan line confirms the link; the current benefit appears after placement.')}</p><p>${t('你也可以购买第二把武器。先查看装配，再选择直接装入或放进备件架；备件装入背包才会生效。', 'Inspect a second weapon before buying. Equip it directly or keep it in reserve; reserve items are inactive until equipped.')}</p><div class="modal-actions"><button class="primary" data-action="guide-select">${t('选择免费线圈', 'Select free Amplifier')}</button><button data-action="skip-tutorial">${t('略过引导', 'Skip guide')}</button></div>`, 'guide');
} }
function renderResult() { if (!run)
    return; if (careerState) {
    renderPracticeResult();
    return;
} showScreen('result'); audio.stop(); audio.music('home'); const r = run, win = r.phase === 'won'; const damage = Object.entries(r.stats.damageByModule).sort((a, b) => b[1] - a[1]).slice(0, 3), max = Math.max(1, ...damage.map(d => d[1])); const taken = Object.entries(r.stats.damageTakenBy).sort((a, b) => b[1] - a[1])[0]; $('result-screen').innerHTML = `<div class="result-wrap"><div class="eyebrow">EXPEDITION / ${win ? 'COMPLETE' : 'SIGNAL LOST'}</div><h1>${win ? t('带着新故事，回来了。', 'Back with a new story.') : t('机体停了，思路还在。', 'The rig fell. The idea lives.')}</h1><p class="result-lead">${win ? t('你夺回了这条回收线路。换一台机体，或者提高警戒等级，再试一套新组合。', 'You reclaimed this salvage route. Try a new chassis, raise the threat level, or build something different.') : t('回收站已接到你的信号。看看这次构筑的表现，下一局再做一次调整。', 'The depot has your signal. Review your build, make one change, and try another expedition.')}</p><div class="result-stats"><div><b>${scoreRun(r).toLocaleString()}</b><span>${t('远征成绩', 'SCORE')}</span></div><div><b>${formatTime(r.elapsed)}</b><span>${t('战斗用时', 'COMBAT TIME')}</span></div><div><b>${r.stats.kills}</b><span>${t('回收敌机', 'ENEMIES RECYCLED')}</span></div><div><b>${r.wave}</b><span>${t('到达场次', 'WAVE REACHED')}</span></div></div><div class="panel-heading"><h2>${t('本局火力贡献', 'Your workhorses')}</h2><span class="serial">DAMAGE / OUTPUT</span></div><div class="contribution">${damage.map(([id, value]) => `<div class="contribution-row"><span>${escape(MODULE_BY_ID[id] ? name(MODULE_BY_ID[id]) : id.startsWith('skill-') ? skillName(id.slice(6), profile.language) : id)}</span><i style="width:${value / max * 100}%"></i><span>${Math.round(value).toLocaleString()}</span></div>`).join('') || `<p class="muted">${t('没有有效伤害记录', 'No damage recorded')}</p>`}</div>${taken ? `<p class="result-lead">${t('主要威胁', 'Main threat')}：${escape(taken[0])} · ${Math.round(taken[1])} ${t('伤害。尝试留出一次冲刺，或增加护盾。', 'damage. Save a dash, or invest in shields.')}</p>` : ''}${renderWaveReport()}${lastUnlocks.length ? `<p class="chip">${t('新机体解锁', 'Chassis unlocked')}：${lastUnlocks.map(id => escape(name(CHASSIS_BY_ID[id]))).join(' / ')}</p>` : ''}<p class="seed-line">SEED / ${escape(r.seed)} · ${r.mode.toUpperCase()} · THREAT ${r.difficulty}</p><div class="result-actions"><button class="primary" data-action="again">${t('再来一局', 'One more run')} ↗</button><button data-action="home">${t('回到回收站', 'Return to depot')}</button><button data-action="copy-seed">${t('复制种子', 'Copy seed')}</button><button data-action="export">${t('导出记录', 'Export log')}</button></div></div>`; }
function updateHud() { if (!battle || !run)
    return; const b = battle, p = b.player, bosses = b.enemies.filter(e => e.kind === 'boss'), boss = bosses[0]; $('battle-hud').innerHTML = `<div class="player-hud"><div class="hud-label"><span>${escape(name(CHASSIS_BY_ID[run.chassis]))}</span><span>${Math.ceil(p.hp)} / ${p.maxHp}</span></div><div class="health-track"><b style="width:${Math.max(0, p.hp / p.maxHp * 100)}%"></b></div><div class="health-track shield"><b style="width:${p.maxShield ? Math.max(0, p.shield / p.maxShield * 100) : 0}%"></b></div><div class="hud-label"><span>${t('护盾', 'SHIELD')} ${Math.ceil(p.shield)}</span><span class="hud-scrap ${b.events.some(e => e.type === 'pickup' && b.time - e.at < .65) ? 'collecting' : ''}">⬡ ${Number((run.gold + b.stats.goldEarned).toFixed(1))}</span></div></div><div class="battle-timer"><strong>${formatTime(b.bossId ? b.time : Math.max(0, b.duration - b.time))}</strong><small>${escape(stageName(b.act))} / ${String(b.wave).padStart(2, '0')}</small></div>${boss ? `<div class="boss-hud"><span>${escape(name(BOSS_BY_ID[b.bossId]))}</span><div class="health-track"><b style="width:${Math.max(0, boss.hp / boss.maxHp * 100)}%"></b></div><small>${Math.ceil(boss.hp)} / ${boss.maxHp}${b.bossEnraged ? ' · ' + t('狂暴过载中', 'ENRAGED') : b.bossOverloadWarned ? ' · ' + t('即将过载', 'OVERLOAD IMMINENT') : ''}</small></div>` : ''}`; $('battle-bottom').innerHTML = `<div>${p.overloadTime > 0 ? '<span class="orange">ϟ ' + t('超载中', 'OVERDRIVE') + '</span>' : t('自动攻击已接通', 'AUTO FIRE ONLINE')}</div><div class="weapon-hud">${b.weapons.map(w => `<span class="rarity-${w.tier}">${escape(name(MODULE_BY_ID[w.id]))} ${tier(w.tier)}</span>`).join('')}</div><div class="touch-hint">WASD / ↑↓←→ · ${t('空格冲刺 · E超载 · Q技能 · P暂停', 'SPACE DASH · E OVERDRIVE · Q SKILL · P PAUSE')}</div>`; updateSkillHud(b); const d = $('dash-button'), o = $('overload-button'); d.classList.toggle('cooling', p.dashCooldown > 0); o.classList.toggle('cooling', p.overloadCooldown > 0); d.innerHTML = `<b>${p.dashCooldown > 0 ? p.dashCooldown.toFixed(1) : '↗'}</b><span>${t('冲刺', 'DASH')}</span>`; o.innerHTML = `<b>${p.overloadCooldown > 0 ? Math.ceil(p.overloadCooldown) : 'ϟ'}</b><span>${t('超载', 'BOOST')}</span>`; }
function updateSkillHud(b) {
    const p = b.player, s = chassisSkill(b.chassis), button = $('skill-button'), cooldown = p.skillCooldown ?? 0, active = (p.skillTime ?? 0) > 0;
    button.classList.toggle('cooling', cooldown > 0 && !active);
    button.classList.toggle('active-skill', active);
    button.innerHTML = `<b>${active ? (p.skillTime ?? 0).toFixed(1) : cooldown > 0 ? Math.ceil(cooldown) : s.icon}</b><span>${escape(skillName(b.chassis, profile.language))}</span>`;
    button.title = `Q · ${skillName(b.chassis, profile.language)} — ${skillDescription(b.chassis, profile.language)}`;
    button.setAttribute('aria-label', `${button.title} ${active ? t('生效中', 'Active') : cooldown > 0 ? t('冷却中', 'Cooling down') : t('就绪', 'Ready')}`);
    button.style.setProperty('--skill-color', s.color);
}
function settings() { if (battle && screen === 'run') {
    paused = true;
    audio.suspend();
} const s = profile.settings; const options = [['sound', t('音效', 'Sound effects')], ['music', t('音乐', 'Music')], ['reducedMotion', t('减少震动与闪光', 'Reduce shake & flashes')], ['colorAssist', t('颜色辅助标记', 'Color assistance')], ['leftHanded', t('左手技能布局', 'Left-handed controls')], ['autoOverload', t('自动开启超载', 'Automatic overdrive')]]; openModal(`<div class="eyebrow">SYSTEM / PREFERENCES</div><h2>${t('设置', 'Settings')}</h2>${options.map(([key, text]) => `<label class="setting-row"><span>${text}</span><input type="checkbox" data-setting="${key}" ${s[key] ? 'checked' : ''}></label>`).join('')}<label class="setting-row"><span>${t('音量', 'Volume')}</span><input type="range" min="0" max="1" step="0.05" value="${s.volume}" data-setting="volume"></label><p>${t('进度保存在当前浏览器。静音和减少动态效果不会改变游戏规则。', 'Progress is stored in this browser. Sound and visual settings never change game rules.')}</p><div class="modal-actions"><button class="primary" data-action="close">${t('完成', 'Done')}</button><button data-action="help">${t('操作说明', 'Controls')}</button></div>`, 'settings'); }
function catalog() { catalogTab = 'modules'; catalogQuery = ''; renderCatalog(); }
function codex() { catalog(); }
function spriteCanvas(id, cls = '') { return `<canvas class="${cls}" width="220" height="180" data-sprite="${escape(id)}" aria-label="${escape(name(ENEMY_BY_ID[id] ?? BOSS_BY_ID[id]))}"></canvas>`; }
function catalogCards() {
    const query = catalogQuery.trim().toLowerCase(), match = (v) => `${v.id} ${v.name} ${v.en}`.toLowerCase().includes(query);
    if (catalogTab === 'modules')
        return MODULES.filter(match).map(m => `<button class="archive-card" data-action="catalog-detail" data-id="${m.id}">${canvasIcon(m.id)}<span>${escape(name(m))}</span><small>${kind(m.kind)} · ${t('电力', 'Power')} ${m.power}</small></button>`).join('');
    if (catalogTab === 'bosses')
        return BOSSES.filter(match).map(b => `<button class="archive-card boss" data-action="catalog-detail" data-id="${b.id}">${spriteCanvas(b.id)}<span>${escape(name(b))}</span><small>${t('第', 'ACT ')}${b.act}${t('章', '')} · HP ${b.hp}</small></button>`).join('');
    return ENEMIES.filter(match).flatMap(e => (catalogTab === 'elites' ? [0, 1, 2] : [-1]).map(affix => `<button class="archive-card ${affix >= 0 ? 'elite' : ''}" data-action="catalog-detail" data-id="${e.id}" data-index="${affix}">${spriteCanvas(e.id)}<span>${affix >= 0 ? localized(ELITE_AFFIXES[affix].name, profile.language) + ' · ' : ''}${escape(name(e))}</span><small>${localized(ENEMY_TACTICS[e.id].role, profile.language)}</small></button>`)).join('');
}
function renderCatalog() {
    openModal(`<div class="eyebrow">FIELD ARCHIVE / COMPLETE</div><h2>${t('完整图鉴', 'Complete archive')}</h2><nav class="archive-tabs">${[['modules', t('装配 36', 'Modules 36')], ['enemies', t('小怪 12', 'Enemies 12')], ['elites', t('精英 36', 'Elites 36')], ['bosses', t('首领 6', 'Bosses 6')]].map(([id, title]) => `<button data-action="catalog-tab" data-id="${id}" aria-pressed="${catalogTab === id}">${title}</button>`).join('')}</nav><input id="catalog-search" type="search" value="${escape(catalogQuery)}" placeholder="${t('搜索名字或编号', 'Search name or ID')}" aria-label="${t('搜索图鉴', 'Search archive')}"><div id="archive-results" class="archive-grid">${catalogCards() || `<p>${t('没有匹配条目', 'No matching entries')}</p>`}</div>`, 'catalog');
    drawIcons();
}
function catalogDetail(id, affix = -1) {
    const module = MODULE_BY_ID[id], enemy = ENEMY_BY_ID[id], boss = BOSS_BY_ID[id];
    if (!module && !enemy && !boss)
        return;
    let body = '';
    if (module)
        body = `${canvasIcon(id, 'archive-hero')}<h2>${escape(name(module))}</h2><p>${kind(module.kind)} · ${t('电力', 'Power')} ${module.power} · ⬡ ${module.price}</p><div class="module-shape" style="--shape-width:${module.shape[0].length}">${module.shape.flatMap(row => [...row].map(c => `<i class="${c === '#' ? 'filled' : ''}"></i>`)).join('')}</div><div class="rarity-comparison">${TIERS.map(level => `<div class="rarity-${level}">${rarityBadge(level, profile.language)}<b>${moduleStat(id, level, profile.language)} · ⬡ ${equipmentPrice(id, level)}</b><p>${escape(equipmentDescription({ id, tier: level }, profile.language))}</p></div>`).join('')}</div><p>${module.tags.map(tagName).join(' / ')}</p>`;
    else if (enemy) {
        const tactics = ENEMY_TACTICS[id], elite = affix >= 0 && affix < 3;
        body = `${spriteCanvas(id, 'archive-hero')}<h2>${elite ? localized(ELITE_AFFIXES[affix].name, profile.language) + ' · ' : ''}${escape(name(enemy))}</h2><p>${localized(tactics.role, profile.language)} · ${t('第', 'ACT ')}${enemy.act}${t('章', '')}</p><div class="archive-stats"><span>HP ${Math.round(enemy.hp * [1, 1.65, 2.55][enemy.act - 1] * (elite ? 1.8 : 1))}</span><span>${t('护甲', 'Armor')} ${enemy.armor + (elite && affix === 1 ? 10 : 0)}</span><span>${t('移速', 'Speed')} ${Math.round(enemy.speed * [1, 1.06, 1.1][enemy.act - 1] * (elite && affix === 0 ? 1.15 : 1))}</span></div><p>${localized(tactics.skill, profile.language)}</p>${elite ? `<p class="elite-note">${t('精英：生命 ×1.8，伤害 ×1.2。', 'Elite: HP ×1.8, damage ×1.2.')} ${localized(ELITE_AFFIXES[affix].detail, profile.language)}</p>` : ''}<p class="archive-counter">${t('应对', 'Counter')}：${localized(tactics.counter, profile.language)}</p><small>${t('面板按所属章节、难度 0 显示；高难度继续应用对应倍率。', 'Stats shown for its act at threat 0; higher threat applies its modifiers.')}</small>`;
    }
    else if (boss)
        body = `${spriteCanvas(id, 'archive-hero')}<h2>${escape(name(boss))}</h2><div class="archive-stats"><span>HP ${boss.hp}</span><span>${t('护甲', 'Armor')} ${boss.armor}</span><span>${t('第', 'ACT ')}${boss.act}${t('章', '')}</span></div>${boss.attacks.map(attack => `<details class="boss-attack"><summary>${escape(attack[0])}</summary><p>${attack.slice(1).map(escape).join('<br>')}</p></details>`).join('')}<p>${escape(boss.phases)}</p><p class="archive-counter">${escape(boss.counter)}</p><button class="primary" data-action="practice-boss" data-id="${id}">${t('选配装备挑战', 'Build a loadout and challenge')}</button>`;
    openModal(`<div class="eyebrow">ARCHIVE / ${escape(id)}</div>${body}<div class="modal-actions"><button data-action="catalog-back">← ${t('返回图鉴', 'Back to archive')}</button></div>`, 'catalog-detail');
    drawIcons();
}
function renderPractice() {
    const scroll = activeDialog === 'practice' ? (document.querySelector('.practice-modules')?.scrollTop ?? 0) : 0;
    const preview = trainingRun(practiceSetup), chosen = new Set(practiceSetup.modules), presetIndex = TRAINING_PRESETS.findIndex(p => p.modules.length === chosen.size && p.modules.every(id => chosen.has(id)));
    openModal(`<div class="eyebrow">BOSS LAB / FREE LOADOUT</div><h2>${t('首领试炼场', 'Boss lab')}</h2><p class="practice-note">${t('自由选装，直接挑战。练习不替换远征存档，不计入通关与解锁。', 'Choose your kit and fight. Practice preserves your expedition and awards no progression.')}</p><div class="practice-fields">
 <label>${t('机体', 'Chassis')}<select data-practice="chassis">${CHASSIS.map(c => `<option value="${c.id}" ${practiceSetup.chassis === c.id ? 'selected' : ''}>${escape(name(c))}</option>`).join('')}</select></label>
 <label>${t('首领', 'Boss')}<select data-practice="boss">${BOSSES.map(b => `<option value="${b.id}" ${practiceSetup.boss === b.id ? 'selected' : ''}>${escape(name(b))}</option>`).join('')}</select></label>
 <label>${t('难度', 'Threat')}<select data-practice="difficulty">${[0, 1, 2, 3, 4].map(n => `<option ${practiceSetup.difficulty === n ? 'selected' : ''}>${n}</option>`).join('')}</select></label>
 <label>${t('装备稀有度', 'Rarity')}<select data-practice="tier">${TIERS.map(n => `<option value="${n}" ${practiceSetup.tier === n ? 'selected' : ''}>${tier(n)} · ${rarityName(n, profile.language)}</option>`).join('')}</select></label>
 <label>${t('基础电力', 'Base power')}<select data-practice="power">${[10, 14, 18, 24].map(n => `<option ${practiceSetup.power === n ? 'selected' : ''}>${n}</option>`).join('')}</select></label>
 <label>${t('预设构筑', 'Preset')}<select id="practice-preset"><option value="" ${presetIndex < 0 ? 'selected' : ''}>${t('自定义', 'Custom')}</option>${TRAINING_PRESETS.map((preset, i) => `<option value="${i}" ${presetIndex === i ? 'selected' : ''}>${profile.language === 'zh' ? preset.name : preset.en}</option>`).join('')}</select></label></div>
 <p class="chassis-skill"><b>Q · ${escape(skillName(practiceSetup.chassis, profile.language))}</b><br>${escape(skillDescription(practiceSetup.chassis, profile.language))}</p><div class="practice-preview"><canvas id="training-preview" width="250" height="250" aria-label="${t('自动装配预览', 'Auto-arranged loadout preview')}"></canvas><div><strong>${t('已选', 'Selected')} ${chosen.size}/12 · ${t('最多三件武器', 'Up to three weapons')}</strong><p class="${preview.ok ? '' : 'invalid'}" role="status">${preview.ok ? t('装配已排入；如有未生效配件，开战前会列出原因。', 'Loadout fits. Any inactive supports will be listed before battle.') : escape(profile.language === 'zh' ? preview.reason : preview.reasonEn)}</p><button data-action="practice-clear">${t('清空模块', 'Clear modules')}</button></div></div>
 <div class="practice-modules">${MODULES.map(m => `<button class="rarity-${practiceSetup.tier} ${chosen.has(m.id) ? 'selected' : ''}" data-action="practice-module" data-id="${m.id}" aria-pressed="${chosen.has(m.id)}">${canvasIcon(m.id)}<span>${escape(name(m))}</span><small>${moduleStat(m.id, practiceSetup.tier, profile.language)} · ${m.shape.join('').replaceAll('.', '').length}${t('格', ' cells')}</small></button>`).join('')}</div><div class="practice-launch"><button data-action="close">${t('返回', 'Back')}</button><button class="primary" data-action="practice-start" ${preview.ok && assetsReady && !renderFailed ? '' : 'disabled'}>${t('进入首领战', 'Fight boss')} ↗</button></div>`, 'practice');
    drawIcons();
    drawTrainingPreview(preview.run);
    document.querySelector('.practice-modules').scrollTop = scroll;
}
function drawTrainingPreview(preview) {
    const canvas = $('training-preview'), ctx = canvas.getContext('2d');
    ctx.fillStyle = '#12252b';
    ctx.fillRect(0, 0, 250, 250);
    for (let y = 0; y < 5; y++)
        for (let x = 0; x < 5; x++) {
            ctx.strokeStyle = '#46636a';
            ctx.strokeRect(x * 50 + 2, y * 50 + 2, 46, 46);
        }
    if (!preview)
        return;
    for (const item of preview.items) {
        ctx.fillStyle = rarity(item.tier).color + '88';
        for (const cell of economy.getCells(item))
            ctx.fillRect(cell.x * 50 + 4, cell.y * 50 + 4, 42, 42);
        ctx.font = 'bold 12px sans-serif';
        ctx.fillStyle = '#fff5de';
        ctx.fillText(item.id, item.x * 50 + 6, item.y * 50 + 22);
    }
}
function startPractice(confirmed = false) {
    if (!assetsReady || renderFailed)
        return;
    const prepared = trainingRun(practiceSetup);
    if (!prepared.ok || !prepared.run) {
        toast((profile.language === 'zh' ? prepared.reason : prepared.reasonEn));
        return;
    }
    if (!confirmed && confirmInactive(prepared.run, 'practice-confirm'))
        return;
    if (!careerState)
        careerState = { run, battle };
    run = prepared.run;
    const result = economy.startWave(run);
    if (!result.ok) {
        leavePractice();
        return;
    }
    $('modal').close();
    activeDialog = '';
    battle = createBattle(run);
    screen = 'run';
    paused = false;
    resetControls();
    terminalElapsed = -1;
    accumulator = 0;
    lastFrame = performance.now();
    lastSave = 0;
    lastHud = 0;
    audio.resetEvents();
    audio.stop();
    audio.music('battle');
    render();
}
function leavePractice() {
    if (!careerState)
        return;
    const career = careerState;
    careerState = null;
    run = career.run;
    battle = career.battle;
    paused = !!battle;
    resetControls();
    $('modal').close();
    activeDialog = '';
    screen = 'home';
    renderHome();
    persist();
}
function completePractice() {
    if (!battle || !run)
        return;
    const result = battleResult(battle);
    run.phase = result.won ? 'won' : 'lost';
    run.hp = result.hp;
    run.shield = result.shield;
    run.stats = result.stats;
    run.elapsed = result.elapsed;
    battle = null;
    paused = false;
    resetControls();
    audio.play(result.won ? 'win' : 'lose');
    renderPracticeResult();
}
function renderPracticeResult() {
    if (!run)
        return;
    showScreen('result');
    audio.stop();
    const won = run.phase === 'won';
    $('result-screen').innerHTML = `<div class="result-wrap"><div class="eyebrow">BOSS LAB / ${won ? 'CLEAR' : 'RETRY'}</div><h1>${won ? t('首领已击破', 'Boss defeated') : t('调整一下，再试一次', 'Rebuild and retry')}</h1><p>${escape(name(BOSS_BY_ID[practiceSetup.boss]))} · ${t('难度', 'Threat')} ${practiceSetup.difficulty} · ${formatTime(run.elapsed)}</p><p>${t('练习结束，远征存档保持原样。', 'Practice complete. Your expedition is preserved.')}</p><div class="result-actions"><button class="primary" data-action="practice-start">${t('同配置再战', 'Rematch')}</button><button data-action="practice-edit">${t('调整装备', 'Edit loadout')}</button><button data-action="practice-exit">${t('回到首页', 'Return home')}</button></div></div>`;
}
function help() { openModal(`<div class="eyebrow">PILOT / MANUAL</div><h2>${t('操作说明', 'Pilot manual')}</h2><p>${t('电脑：WASD或方向键移动，空格冲刺，E超载，Q机体技能，P/Esc暂停。右键敌人设置2秒优先目标。', 'Desktop: WASD / arrows to move, Space to dash, E to overdrive, Q for the chassis skill, P / Esc to pause. Right-click an enemy to focus it for two seconds.')}</p><p>${t('手机：拖动左半屏移动，右下角按钮冲刺、超载和释放机体技能。长按右半屏目标集火。', 'Touch: drag on the left to move; use the lower-right skill buttons. Hold a target on the right to focus fire.')}</p><p>${t('装配：选择备件后点击空格，也可以拖动备件或已有模块。R/旋转按钮转向。支持必须贴着兼容武器，最多每枪两个。', 'Workshop: select a reserve item then tap a cell, or drag a reserve or placed item. R / Rotate turns it. Supports must touch compatible weapons, at most two per weapon.')}</p><p>${t('所有伤害与危险预警按固定逻辑运行；红色预警期间离开范围，利用Boss后摇攻击。', 'Combat runs at a fixed simulation rate. Leave red telegraphs and strike during boss recovery windows.')}</p><button class="primary" data-action="close">${t('明白了', 'Got it')}</button>`, 'help'); }
async function dispatch(button) {
    const action = button.dataset.action;
    if (!action)
        return;
    if (['new-run', 'confirm-new', 'continue', 'again', 'deploy'].includes(action) && (!assetsReady || renderFailed)) {
        updateAssetStatus();
        return;
    }
    audio.unlock();
    const index = Number(button.dataset.index), id = button.dataset.id ?? '';
    if (action === 'rarity-help') {
        showRarityHelp();
        return;
    }
    if (action === 'workshop-tab') {
        workshopTab = id;
        renderPrep();
        return;
    }
    if (action === 'workshop-more') {
        openModal(`<h2>${t('装配帮助', 'Workshop help')}</h2>${renderConnectionLesson()}${renderWaveReport()}<p>${t('选中模块，再点击空格放置；支持件需贴着兼容武器。详情在模块面板，选路和事件在路线面板。', 'Select a module then tap a cell. Supports must touch compatible weapons. Use Module for details and Route for events.')}</p><div class="modal-actions"><button data-action="export">${t('导出战报', 'Export report')}</button><button data-action="help">${t('操作说明', 'Controls')}</button></div>`, 'workshop-help');
        return;
    }
    if (action === 'module-details') {
        const item = selectedItem();
        if (item)
            openModal(`<h2>${escape(name(MODULE_BY_ID[item.id]))} ${tier(item.tier)}</h2>${canvasIcon(item.id)}<p>${describe(item)}</p>${renderPlacementHelp()}`, 'module-details');
        drawIcons();
        return;
    }
    if (action === 'loadout-details') {
        if (run) {
            const check = economy.validateLoadout(run);
            openModal(`<h2>${t('出击检查', 'Deployment check')}</h2><p>${check.ok ? t('装配合法，可以出击。', 'Loadout is ready.') : escape(profile.language === 'zh' ? check.reason : check.reasonEn)}</p>${warningMarkup(run)}${workshopHints(run, profile.language).map(h => `<p>${escape(h)}</p>`).join('')}`, 'loadout-check');
        }
        return;
    }
    if (action === 'catalog') {
        catalog();
        return;
    }
    if (action === 'catalog-tab') {
        catalogTab = id;
        renderCatalog();
        return;
    }
    if (action === 'catalog-detail') {
        catalogDetail(id, Number.isFinite(index) ? index : -1);
        return;
    }
    if (action === 'catalog-back') {
        renderCatalog();
        return;
    }
    if (action === 'practice' || action === 'practice-boss') {
        if (id)
            practiceSetup.boss = id;
        renderPractice();
        return;
    }
    if (action === 'practice-module') {
        const selected = practiceSetup.modules.indexOf(id);
        if (selected >= 0)
            practiceSetup.modules.splice(selected, 1);
        else if (practiceSetup.modules.length < 12)
            practiceSetup.modules.push(id);
        else
            toast(t('最多选择 12 件模块', 'Choose up to 12 modules'));
        renderPractice();
        return;
    }
    if (action === 'practice-clear') {
        practiceSetup.modules = [];
        renderPractice();
        return;
    }
    if (action === 'practice-start' || action === 'practice-confirm') {
        startPractice(action === 'practice-confirm');
        return;
    }
    if (action === 'practice-exit') {
        leavePractice();
        return;
    }
    if (action === 'practice-edit') {
        leavePractice();
        renderPractice();
        return;
    }
    if (action === 'chassis') {
        if (selectedMode === 'prototype' && id !== 'scavenger' || selectedMode === 'demo' && !['scavenger', 'bulwark'].includes(id)) {
            toast(t('当前试炼未开放此机体', 'This chassis is not available in this trial'));
            return;
        }
        if (!chassisUnlocked(profile, id)) {
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
    if (action === 'skip-tutorial') {
        profile.tutorial = true;
        if (run)
            recordAction(run, 'tutorial:skipped');
        closeModal();
        persist();
        render();
        return;
    }
    if (action === 'guide-select') {
        const coil = run?.items.find(i => i.id === 'S01');
        if (!coil)
            return;
        workshopTab = 'module';
        selectedUid = coil.uid;
        heldRotation = coil.rotation;
        pendingBuy = -1;
        closeModal();
        renderPrep();
        return;
    }
    if ((action === 'save-home' || action === 'home') && careerState) {
        leavePractice();
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
        const blob = new Blob([JSON.stringify(exportRunReport(run), null, 2)], { type: 'application/json' }), a = document.createElement('a');
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
        workshopTab = 'module';
        selectedUid = button.dataset.uid ?? '';
        heldRotation = selectedItem()?.rotation ?? 0;
        pendingBuy = -1;
        renderPrep();
        return;
    }
    if (action === 'deploy' || action === 'deploy-confirm') {
        deploy(action === 'deploy-confirm');
        return;
    }
    if (action === 'preview-buy') {
        previewPurchase(index);
        return;
    }
    if (action === 'place-purchase') {
        workshopTab = 'module';
        pendingBuy = index;
        pendingOfferId = r.shop[index]?.id ?? '';
        selectedUid = '';
        heldRotation = 0;
        closeModal();
        renderPrep();
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
            closeModal();
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
            renderPrep();
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
        if (result.ok)
            toast(t('背包已整理，优先保留有效连接；未连接配件可在出击前确认。', 'Backpack arranged; active links preserved where possible. Review inactive supports before deployment.'));
        return;
    }
    if (action === 'undo-edit') {
        if (editUndo) {
            preserveJournal(r, editUndo, 'undo-edit');
            run = editUndo;
            editUndo = null;
            heldRotation = selectedItem()?.rotation ?? 0;
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
    if (action === 'preview-merge') {
        showMerge(selectedUid);
        return;
    }
    if (action === 'preview-buy-merge') {
        showMerge(button.dataset.uid ?? '', index);
        return;
    }
    if (action === 'confirm-merge') {
        const uid = button.dataset.uid ?? '', before = structuredClone(r), preview = economy.previewMerge(r, uid);
        const result = economy.merge(r, uid);
        if (result.ok) {
            selectedUid = preview.item.uid;
            closeModal();
            editUndo = before;
            workshopTab = 'module';
        }
        actResult(result, 'upgrade');
        return;
    }
    if (action === 'confirm-buy-merge') {
        const uid = button.dataset.uid ?? '', result = economy.buyAndMerge(r, index, uid);
        if (result.ok) {
            selectedUid = uid;
            closeModal();
            editUndo = null;
            pendingBuy = -1;
            workshopTab = 'module';
            updateCodex();
        }
        actResult(result, 'upgrade');
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
$('app').addEventListener('change', e => { const target = e.target; if (target.id === 'unlock-all') {
    profile.settings.unlockAll = e.target.checked;
    if (!chassisUnlocked(profile, selectedChassis))
        selectedChassis = 'scavenger';
    selectedDifficulty = Math.min(selectedDifficulty, difficultyLimit(profile));
    persist();
    renderHome();
    return;
} if (target.id === 'mode-select') {
    selectedMode = target.value;
    if (selectedMode !== 'full')
        selectedDifficulty = 0;
    if (selectedMode === 'prototype' || selectedMode === 'demo' && !['scavenger', 'bulwark'].includes(selectedChassis))
        selectedChassis = 'scavenger';
    renderHome();
} if (target.id === 'difficulty-select')
    selectedDifficulty = Number(target.value); });
$('modal-content').addEventListener('input', e => { const input = e.target; if (input.id === 'catalog-search') {
    catalogQuery = input.value;
    $('archive-results').innerHTML = catalogCards() || `<p>${t('没有匹配条目', 'No matching entries')}</p>`;
    drawIcons();
} });
$('modal-content').addEventListener('change', e => {
    const field = e.target;
    if (field.dataset.practice) {
        const key = field.dataset.practice;
        if (key === 'chassis' || key === 'boss')
            practiceSetup[key] = field.value;
        else if (key === 'tier')
            practiceSetup.tier = Number(field.value);
        else if (key === 'difficulty' || key === 'power')
            practiceSetup[key] = Number(field.value);
        renderPractice();
        return;
    }
    if (field.id === 'practice-preset' && field.value !== '') {
        practiceSetup.modules = [...TRAINING_PRESETS[Number(field.value)].modules];
        renderPractice();
        return;
    }
    const input = e.target, k = input.dataset.setting;
    if (!k)
        return;
    if (k === 'volume')
        profile.settings.volume = Number(input.value);
    else
        profile.settings[k] = input.checked;
    applySettings();
    persist();
});
$('asset-retry').onclick = () => { if (renderFailed)
    location.reload();
else
    void loadArtwork(); };
$('language-button').onclick = () => { profile.language = profile.language === 'zh' ? 'en' : 'zh'; applySettings(); persist(); render(); if (activeDialog === 'settings')
    settings(); if (activeDialog === 'catalog')
    renderCatalog(); if (activeDialog === 'practice')
    renderPractice(); };
$('home-button').onclick = () => { if (careerState && !battle) {
    leavePractice();
    return;
} if (battle && screen === 'run')
    setPause();
else {
    screen = 'home';
    renderHome();
} };
$('settings-button').onclick = settings;
$('codex-button').onclick = codex;
$('close-modal').onclick = closeModal;
$('modal').addEventListener('cancel', e => { e.preventDefault(); closeModal(); });
$('skill-button').onpointerdown = e => { e.preventDefault(); if (battle && screen === 'run' && !paused) {
    audio.unlock();
    skillQueued = true;
} };
$('skill-button').onclick = e => { if (e.detail === 0 && battle && screen === 'run' && !paused)
    skillQueued = true; };
$('pause-button').onclick = setPause;
$('dash-button').onpointerdown = e => { e.preventDefault(); audio.unlock(); dashQueued = true; };
$('overload-button').onpointerdown = e => { e.preventDefault(); audio.unlock(); overloadQueued = true; };
window.addEventListener('keydown', e => { if (e.target?.matches('input,select,textarea'))
    return; if (activeDialog && e.code !== 'Escape' && e.code !== 'KeyP')
    return; if (e.code === 'Space' || e.key.startsWith('Arrow'))
    e.preventDefault(); if (e.repeat)
    return; if (e.code === 'Space')
    dashQueued = true; if (e.code === 'KeyE')
    overloadQueued = true; if (e.code === 'KeyQ')
    skillQueued = true; if (e.code === 'KeyR' && run?.phase !== 'battle') {
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
window.addEventListener('blur', () => { resetControls(); if (battle && screen === 'run' && !paused)
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
    j.firstElementChild.style.transform = 'translate(0px,0px)';
    j.style.display = 'block';
    j.style.left = e.clientX + 'px';
    j.style.top = e.clientY + 'px';
}
else if (!moveSide) {
    focusGesture.begin(e.pointerId, e.clientX, e.clientY, performance.now());
    battleCanvas.setPointerCapture(e.pointerId);
} e.preventDefault(); });
battleCanvas.addEventListener('pointermove', e => { if (joy?.id === e.pointerId) {
    const dx = e.clientX - joy.x, dy = e.clientY - joy.y, len = Math.max(42, Math.hypot(dx, dy));
    joy.dx = dx / len;
    joy.dy = dy / len;
    const knob = $('joystick').firstElementChild;
    knob.style.transform = `translate(${joy.dx * 33}px,${joy.dy * 33}px)`;
}
else
    focusGesture.move(e.pointerId, e.clientX, e.clientY); });
function releasePointer(e) { if (joy?.id === e.pointerId) {
    joy = null;
    $('joystick').style.display = 'none';
} focusGesture.end(e.pointerId); }
battleCanvas.addEventListener('pointerup', releasePointer);
battleCanvas.addEventListener('pointercancel', releasePointer);
battleCanvas.addEventListener('lostpointercapture', releasePointer);
window.addEventListener('orientationchange', () => { resetControls(); if (battle && screen === 'run')
    setPause(); });
document.addEventListener('visibilitychange', () => { if (document.hidden) {
    if (battle && screen === 'run')
        setPause();
    audio.suspend();
    persist();
}
else if (!paused)
    audio.resume(); });
window.addEventListener('pagehide', () => { resetControls(); if (battle && screen === 'run')
    setPause();
else
    persist(); });
window.addEventListener('pageshow', e => { if (e.persisted) {
    resetControls();
    accumulator = 0;
    lastFrame = performance.now();
    if (battle && screen === 'run')
        setPause();
} });
function frame(now) {
    try {
        advanceFrame(now);
    }
    catch (error) {
        console.error(error);
        renderFailed = true;
        paused = true;
        resetControls();
        audio.suspend();
        try {
            persist();
        }
        catch (saveError) {
            console.error(saveError);
        }
        $('modal').close();
        activeDialog = '';
        updateAssetStatus();
    }
}
function advanceFrame(now) {
    const rawMs = Math.max(0, now - lastFrame);
    const dt = Math.min(.1, rawMs / 1000);
    lastFrame = now;
    homeTime += dt;
    const frameMs = frameClock.sample(now, battle && run?.phase === 'battle' && screen === 'run' && !paused && !document.hidden && battle.status === 'playing' ? battle : undefined);
    if (run && screen === 'run' && !document.hidden) {
        if (!['settings', 'codex', 'help', 'confirm'].includes(activeDialog))
            recordPrepTime(run, rawMs / 1000);
    }
    if (battle && run?.phase === 'battle' && screen === 'run') {
        if (!paused && !document.hidden) {
            const focus = focusGesture.take(now);
            if (focus) {
                targetQueued = renderer.toWorld(focus.x, focus.y);
                targetMarker = targetQueued;
                targetUntil = now + 2000;
            }
            accumulator += dt;
            let steps = 0;
            while (accumulator >= 1 / 60 && steps < 6 && battle.status === 'playing') {
                const input = { x: (keys.has('KeyD') || keys.has('ArrowRight') ? 1 : 0) - (keys.has('KeyA') || keys.has('ArrowLeft') ? 1 : 0) + (joy?.dx ?? 0), y: (keys.has('KeyS') || keys.has('ArrowDown') ? 1 : 0) - (keys.has('KeyW') || keys.has('ArrowUp') ? 1 : 0) + (joy?.dy ?? 0), dash: dashQueued, skill: skillQueued, overload: overloadRequested(overloadQueued, profile.settings.autoOverload, battle.player.overloadCooldown), target: targetQueued };
                dashQueued = false;
                overloadQueued = false;
                skillQueued = false;
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
        const renderStart = performance.now();
        renderer.draw(battle, { lang: profile.language, reducedMotion: profile.settings.reducedMotion, colorAssist: profile.settings.colorAssist, target: now < targetUntil ? targetMarker : undefined });
        const renderMs = performance.now() - renderStart;
        if (frameMs !== undefined)
            recordFrame(run, frameMs, renderMs, JSON.stringify({ build: BUILD_VERSION, browser: navigator.userAgent, viewport: [innerWidth, innerHeight], canvas: [battleCanvas.width, battleCanvas.height], dpr: devicePixelRatio, reducedMotion: profile.settings.reducedMotion, colorAssist: profile.settings.colorAssist }));
        if (now - lastHud > 100) {
            updateHud();
            lastHud = now;
        }
    }
    requestAnimationFrame(frame);
}
async function boot() { const saved = await loadSave(); profile = saved.profile; run = saved.run; battle = saved.battle; selectedChassis = run?.chassis ?? 'scavenger'; selectedMode = run?.mode ?? 'full'; selectedDifficulty = run?.difficulty ?? 0; audio.configure(profile.settings); applySettings(); renderHome(); lastFrame = performance.now(); requestAnimationFrame(frame); void loadArtwork(); }
void boot();
