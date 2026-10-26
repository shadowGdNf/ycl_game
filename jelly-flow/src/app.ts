import { createState, releaseQueue, getHint, cloneState } from './core.ts';
import type { GameState } from './core.ts';
import { LEVELS } from './levels.ts';
import { GameRenderer, COLORS } from './renderer.ts';
import { CandyAudio } from './audio.ts';
import { readSave, writeSave } from './storage.ts';

const $=<T extends HTMLElement=HTMLElement>(id:string):T=>{const e=document.getElementById(id);if(!e)throw new Error(`Missing game element: ${id}`);return e as T;};
const save=readSave(), audio=new CandyAudio();audio.enabled=save.sound;
let level=LEVELS[save.level-1]||LEVELS[0];
let state=createState(level),history:number[]=[],undoStack:GameState[]=[],assists=save.assists;
let busy=false,generation=0,toastTimer=0;
const events:{event:string;level:number;moves:number;time:number;[key:string]:unknown}[]=[];
function track(event:string,extra:Record<string,unknown>={}) {events.push({event,level:level.id,moves:state.moves,time:Date.now(),...extra});if(events.length>300)events.shift();}
for(const q of save.history){const result=releaseQueue(state,q);if(result.state.moves===state.moves||result.state.status!=='playing'){history=[];undoStack=[];state=createState(level);assists=0;break;}undoStack.push(cloneState(state));state=result.state;history.push(q);}
const renderer=new GameRenderer($<HTMLCanvasElement>('game-canvas'),move);
renderer.setState(state);
const dialogs=['level-dialog','help-dialog','result-dialog'].map(id=>$<HTMLDialogElement>(id));
const anyDialog=()=>dialogs.some(x=>x.open);
function closeAll(){dialogs.forEach(d=>d.close());}
function persist(){save.level=level.id;save.history=state.status==='playing'?[...history]:[];save.assists=state.status==='playing'?assists:0;const ok=writeSave(save);const label=document.getElementById('save-status');if(label)label.textContent=ok?'Your progress is saved on this device.':'Session only — browser storage is unavailable.';}
function toast(message:string,duration=4000){$('toast').textContent=message;$('toast').classList.add('show');window.clearTimeout(toastTimer);toastTimer=window.setTimeout(()=>{$('toast').classList.remove('show');},duration);}
function recordWin(){const stars=assists===0?3:assists<=2?2:1;const old=save.best[level.id];if(!old||stars>old.stars)save.best[level.id]={stars,moves:state.moves};save.unlocked=Math.max(save.unlocked,Math.min(20,level.id+1));return stars;}
function defaultTip(){if(state.status==='lost')return 'Waiting room full. Undo a move or give it another go.';if(state.status==='won')return 'A little order. A lot of happiness.';if(level.id===1&&state.moves===0)return 'Tap a numbered chute to fill a matching cup.';if(state.buffer.length)return 'Make room: finish a cup to bring in the next color.';return 'Same color, happy cup. Choose your next chute.';}
function sync(){
  $('level-number').textContent=String(level.id).padStart(2,'0');
  $('level-name').textContent=level.name;
  $('level-subtitle').textContent=level.subtitle;
  $('moves-value').textContent=String(state.moves);
  $('collected-value').textContent=`${state.collected} / ${state.total}`;
  $('progress-fill').style.width=`${state.collected/state.total*100}%`;
  $('progress-fill').parentElement?.setAttribute('aria-valuenow',String(Math.round(state.collected/state.total*100)));
  $('buffer-label').textContent=`${state.buffer.length} / ${state.bufferSize}`;
  $('buffer-label').classList.toggle('is-danger',state.buffer.length>=state.bufferSize);
  $<HTMLButtonElement>('undo-btn').disabled=!undoStack.length||busy;
  $<HTMLButtonElement>('hint-btn').disabled=state.status!=='playing'||busy;
  $<HTMLButtonElement>('levels-btn').disabled=busy;
  $<HTMLButtonElement>('help-btn').disabled=busy;
  $('sound-btn').setAttribute('aria-pressed',String(save.sound));
  $('sound-btn').setAttribute('aria-label',save.sound?'Mute sound':'Enable sound');
  $('sound-btn').setAttribute('data-muted',String(!save.sound));
  const soundLabel=$('sound-btn').querySelector('[data-sound-label]');if(soundLabel)soundLabel.textContent=save.sound?'Sound on':'Sound off';
  const chapter=document.getElementById('chapter-label');if(chapter)chapter.textContent=['A sweet beginning','Find your flow','A little twist','Master the mix'][Math.floor((level.id-1)/5)];
  const best=document.getElementById('best-value');if(best)best.textContent=save.best[level.id]?'★'.repeat(save.best[level.id].stars):'—';
  const assist=document.getElementById('assist-value');if(assist)assist.textContent=String(assists);
  const controls=$('queue-controls');controls.replaceChildren();
  state.queues.forEach((queue,i)=>{
    const b=document.createElement('button');b.type='button';b.textContent=String(i+1);b.disabled=!queue.length||busy||state.status!=='playing';
    let group=0;while(queue[group]&&queue[group]===queue[0])group++;
    b.setAttribute('aria-label',queue.length?`Chute ${i+1}: release ${group} ${COLORS[queue[0]].name} jellies`:`Chute ${i+1}: empty`);
    b.style.setProperty('--chute-color',queue.length?COLORS[queue[0]].fill:'#E6DDDA');b.addEventListener('click',()=>move(i));controls.append(b);
  });
  $('game-canvas').setAttribute('aria-label',`Level ${level.id}, ${level.name}. ${state.collected} of ${state.total} jellies collected. ${state.buffer.length} of ${state.bufferSize} waiting spaces occupied. Use the numbered chute buttons to play.`);
}
function startLevel(id:number){
  if(id<1||id>20||id>save.unlocked)return;
  generation++;busy=false;renderer.cancel();closeAll();level=LEVELS[id-1];state=createState(level);history=[];undoStack=[];assists=0;
  renderer.setState(state);sync();persist();toast(defaultTip(),6000);track('level_start');
  if(id===1)renderer.showHint(level.solution[0],8000);
}
function move(index:number){
  if(busy||state.status!=='playing'||anyDialog())return;
  const before=state,result=releaseQueue(state,index);if(result.state.moves===state.moves)return;
  audio.unlock();audio.tap();undoStack.push(cloneState(state));history.push(index);state=result.state;
  busy=true;const token=++generation;if(state.status==='won')recordWin();renderer.animate(before,state,result.events);sync();persist();track('release',{chute:index});
  const released=result.events.find(e=>e.type==='release')?.amount||1;
  const completed=result.events.filter(e=>e.type==='complete').length;audio.flow(released,completed);
  if(completed>1)toast(`${completed} cups in one move. Sweet combo!`);
  else if(completed)toast('Perfect match. Make room for something sweet.');
  else if(state.buffer.length)toast('A few jellies are waiting for their matching cup.');
  window.setTimeout(()=>{
    if(token!==generation)return;busy=false;renderer.setState(state);sync();
    if(state.status==='won')win();else if(state.status==='lost')lose();
  },window.matchMedia('(prefers-reduced-motion: reduce)').matches?100:720);
}
function win(){
  audio.win();const stars=recordWin();persist();sync();track('level_win',{stars,assists});
  $('result-eyebrow').textContent=level.id===20?'THE WHOLE SWEET JOURNEY':'FRESHLY SORTED';
  $('result-title').textContent=level.id===20?'You’re a flow master!':'That was sweet!';
  $('result-description').textContent=level.id===20?'All 20 levels, neatly wrapped. Revisit any level and collect every star.':`${state.total} jellies found a home in ${state.moves} moves. ${assists===0?'A perfect, unassisted solve.':`${assists} assist${assists===1?'':'s'} used. Try again for three stars.`}`;
  $('result-stars').textContent='★'.repeat(stars)+'☆'.repeat(3-stars);$('result-stars').setAttribute('aria-label',`${stars} of 3 stars`);
  $<HTMLButtonElement>('next-btn').hidden=false;$('next-btn').textContent=level.id===20?'Play from the beginning':'Next sweet level';
  $('retry-btn').textContent='Play this level again';closeAll();$<HTMLDialogElement>('result-dialog').showModal();
}
function lose(){audio.lose();track('level_fail',{buffer:state.buffer.length});$('result-eyebrow').textContent='A LITTLE SUGAR JAM';$('result-title').textContent='Oops, a full house!';$('result-description').textContent='The waiting room overflowed. Try opening a chute that fills a cup first.';$('result-stars').textContent='';$<HTMLButtonElement>('next-btn').hidden=true;$('retry-btn').textContent='Try again';closeAll();$<HTMLDialogElement>('result-dialog').showModal();}
function undo(){if(busy||!undoStack.length)return;closeAll();generation++;state=undoStack.pop()!;history.pop();assists++;renderer.setState(state);sync();persist();toast('One step back. A fresh chance to find your flow.');track('undo');}
function hint(){
  if(busy||state.status!=='playing')return;
  const index=getHint(state);
  if(index===null){toast('No safe route found. Try undoing your last move.',6000);return;}
  assists++;renderer.showHint(index);sync();$('queue-controls').children[index]?.setAttribute('data-hint','true');persist();toast(`Try chute ${index+1}. It keeps a path to a clean finish.`,5000);track('hint',{chute:index});
}
function showLevels(){
  const grid=$('level-grid');grid.replaceChildren();
  LEVELS.forEach(l=>{const b=document.createElement('button');b.type='button';const unlocked=l.id<=save.unlocked,best=save.best[l.id];b.disabled=!unlocked;b.className=[unlocked?'':'locked',best?'completed':'',l.id===level.id?'current':''].filter(Boolean).join(' ');if(l.id===level.id)b.setAttribute('aria-current','true');b.setAttribute('aria-label',`Level ${l.id}, ${l.name}${!unlocked?', locked':best?`, ${best.stars} stars`:''}`);const n=document.createElement('span');n.textContent=String(l.id).padStart(2,'0');const stars=document.createElement('small');stars.textContent=best?'★'.repeat(best.stars)+'☆'.repeat(3-best.stars):unlocked?'PLAY':'LOCKED';b.append(n,stars);b.addEventListener('click',()=>startLevel(l.id));grid.append(b);});closeAll();$<HTMLDialogElement>('level-dialog').showModal();
}
$('undo-btn').addEventListener('click',undo);
$('restart-btn').addEventListener('click',()=>startLevel(level.id));
$('hint-btn').addEventListener('click',hint);
$('sound-btn').addEventListener('click',()=>{save.sound=!save.sound;audio.enabled=save.sound;audio.unlock();audio.tap();sync();persist();});
$('levels-btn').addEventListener('click',showLevels);
$('help-btn').addEventListener('click',()=>{closeAll();$<HTMLDialogElement>('help-dialog').showModal();});
$('close-levels').addEventListener('click',()=>{$<HTMLDialogElement>('level-dialog').close();});
$('close-help').addEventListener('click',()=>{$<HTMLDialogElement>('help-dialog').close();});
$('start-playing').addEventListener('click',()=>{$<HTMLDialogElement>('help-dialog').close();save.tutorialSeen=true;persist();audio.unlock();});
$('next-btn').addEventListener('click',()=>startLevel(level.id===20?1:level.id+1));
$('retry-btn').addEventListener('click',()=>startLevel(level.id));
$('result-levels').addEventListener('click',showLevels);
for(const d of dialogs)d.addEventListener('click',e=>{if(e.target===d){const r=d.getBoundingClientRect();const p=e as MouseEvent;if(p.clientX<r.left||p.clientX>r.right||p.clientY<r.top||p.clientY>r.bottom)d.close();}});
document.addEventListener('keydown',e=>{
  if(e.ctrlKey||e.metaKey||e.altKey||e.repeat||anyDialog())return;
  if((e.target as HTMLElement).matches('input,textarea,select'))return;
  if(/^[1-6]$/.test(e.key)){e.preventDefault();move(Number(e.key)-1);}
  if(e.key.toLowerCase()==='z'){e.preventDefault();undo();}
});
document.addEventListener('visibilitychange',()=>{if(document.hidden){persist();track('session_pause');}});
window.addEventListener('pagehide',persist);
sync();toast(defaultTip(),8000);track('session_start');
if(level.id===1&&state.moves===0)renderer.showHint(level.solution[0],10000);
const exportButton=document.getElementById('export-session');
if(exportButton)exportButton.addEventListener('click',()=>{const blob=new Blob([JSON.stringify({game:'Jelly Flow',version:1,events},null,2)],{type:'application/json'});const url=URL.createObjectURL(blob);const a=document.createElement('a');a.href=url;a.download='jelly-flow-session.json';a.click();window.setTimeout(()=>URL.revokeObjectURL(url),1000);});
