import { createState, releaseQueue } from '../src/core.ts';
import { writeFileSync } from 'node:fs';

// Offline generation only. Each shipped level includes a replayable solution.
const colors = ['pink', 'yellow', 'mint', 'purple'];
let seed = 10426;
const random = () => { seed = (Math.imul(1664525, seed) + 1013904223) >>> 0; return seed / 4294967296; };
const pick = n => Math.floor(random() * n);
const shuffle = a => { a = [...a]; for (let i = a.length - 1; i > 0; i--) { const j = pick(i + 1); [a[i],a[j]]=[a[j],a[i]]; } return a; };
const runCount = qs => qs.reduce((sum,q)=>sum+q.filter((c,i)=>i===0||c!==q[i-1]).length,0);
function solve(initial, cap=50000) {
  let n=0; const dead = new Set();
  function visit(s) {
    if(s.status==='won') return [];
    if(s.status==='lost'||++n>cap)return null;
    const key=JSON.stringify([s.queues,s.activeCups,s.pendingCups,s.buffer]);
    if(dead.has(key))return null;
    const choices=s.queues.flatMap((q,i)=>q.length?[{i,s:releaseQueue(s,i).state}]:[])
      .filter(x=>x.s.status!=='lost').sort((a,b)=>b.s.collected-a.s.collected+a.s.buffer.length-b.s.buffer.length);
    for(const x of choices){ const tail=visit(x.s); if(tail)return [x.i,...tail]; }
    dead.add(key); return null;
  }
  return {path:visit(initial),nodes:n};
}
function randomWinRate(level, samples=80) {
  let wins=0;
  for(let t=0;t<samples;t++) {
    let s=createState({...level,solution:[]});
    for(let k=0;k<100&&s.status==='playing';k++) {
      const options=s.queues.map((q,i)=>q.length?i:-1).filter(i=>i!==-1);
      if(!options.length)break;
      s=releaseQueue(s,options[pick(options.length)]).state;
    }
    if(s.status==='won')wins++;
  }
  return wins/samples;
}
const names = [
 ['First Pour','Tap a chute. Fill a matching cup.'],
 ['Sweet Company','Full cups leave. New cups move in.'],
 ["Three’s a Charm",'Follow the colors, one sweet batch at a time.'],
 ['Make Some Room','Waiting candy catches the next matching cup.'],
 ['Little Detour','Look at the next cups before opening a chute.'],
 ['Purple Haze','Four colors. Three cup spots. Choose your order.'],
 ['Pocket Full','A little room in the tray goes a long way.'],
 ['Sugar Shuffle','Clear a cup to set a waiting color free.'],
 ['Color Cascade','One full cup can start a sweet chain reaction.'],
 ['Halfway Sweet','Read the chutes from the bottom up.'],
 ['Candy Crossroads','Two good-looking moves. Think one cup ahead.'],
 ['Double Scoop','Some batches need more than one cup.'],
 ['The Long Pour','Save room before you release a big batch.'],
 ['Sweet Switch','A new cup can rescue the waiting tray.'],
 ['Tight Squeeze','Every space in the waiting tray matters.'],
 ['Ripple Effect','Make one cup lead neatly into the next.'],
 ['Sugar Rush','Keep the colors moving, not the tray filling.'],
 ['The Last Gap','Leave yourself one useful opening.'],
 ['Almost a Master','Plan the chain before you open the chute.'],
 ['Master Mixer','Your final recipe: patience, color, and flow.'],
];
const starts = [
 {queues:[['pink','pink'],['yellow','yellow'],['pink'],['yellow']],cups:[{color:'pink',capacity:3},{color:'yellow',capacity:3}],bufferSize:6},
 {queues:[['pink','pink','yellow'],['yellow','yellow','pink'],['mint','mint','pink'],['mint','pink','pink']],cups:[{color:'pink',capacity:3},{color:'yellow',capacity:3},{color:'mint',capacity:3},{color:'pink',capacity:3}],bufferSize:6},
 {queues:[['pink','pink','mint'],['yellow','yellow','pink'],['mint','mint','yellow'],['pink','yellow','mint']],cups:[{color:'pink',capacity:2},{color:'yellow',capacity:2},{color:'mint',capacity:2},{color:'pink',capacity:2},{color:'yellow',capacity:2},{color:'mint',capacity:2}],bufferSize:6},
];
function candidate(id) {
  const colorCount=id<6?3:4;
  const cupCount=6+Math.floor(id/3);
  const queueCount=id<8?4:id<14?5:6;
  const cups=shuffle(Array.from({length:cupCount},(_,i)=>({color:colors[i%colorCount],capacity:id<10?3:4})));
  const remaining=Object.fromEntries(colors.map(c=>[c,cups.filter(x=>x.color===c).reduce((s,x)=>s+x.capacity,0)]));
  const queues=Array.from({length:queueCount},()=>[]);
  while(Object.values(remaining).some(x=>x>0)) {
    const available=colors.filter(c=>remaining[c]>0);
    const color=available[pick(available.length)];
    const batch=Math.min(remaining[color],1+pick(id<7?2:3));
    const low=Math.min(...queues.map(q=>q.length));
    const targets=queues.map((q,i)=>q.length<=low+3?i:-1).filter(i=>i!==-1);
    const target=targets[pick(targets.length)];
    queues[target].push(...Array(batch).fill(color)); remaining[color]-=batch;
  }
  return {id,name:names[id-1][0],subtitle:names[id-1][1],queues,cups,bufferSize:6,solution:[],par:runCount(queues)};
}
const levels=[]; const metrics=[];
for(let id=1;id<=20;id++) {
  if(id<=3) {
    const level={id,name:names[id-1][0],subtitle:names[id-1][1],...starts[id-1],solution:[],par:runCount(starts[id-1].queues)};
    level.solution=solve(createState(level)).path;
    levels.push(level); metrics.push({id,rate:randomWinRate(level),moves:level.par});continue;
  }
  const target=Math.max(.08,.96-(id-3)*.05);
  let best=null, bestDistance=Infinity;
  for(let attempt=0;attempt<160;attempt++) {
    const level=candidate(id);
    const proof=solve(createState(level),20000);
    if(!proof.path)continue;
    level.solution=proof.path;
    const rate=randomWinRate(level,1000);
    const prev=metrics.at(-1).rate;
    const penalty=rate>prev?2*(rate-prev):0;
    const distance=Math.abs(rate-target)+penalty;
    if(distance<bestDistance) { best={level,rate,nodes:proof.nodes};bestDistance=distance; }
    if(bestDistance<.015)break;
  }
  if(!best)throw new Error(`No level ${id}`);
  levels.push(best.level);metrics.push({id,rate:best.rate,moves:best.level.par,nodes:best.nodes});
  console.log(metrics.at(-1));
}
// Calibrate with a larger independent simulation, then order within the stages
// that introduce new colors/chutes. This is a design proxy, not player data.
const calibrated=levels.map(level=>({level,rate:randomWinRate(level,5000)}));
for(const [from,to] of [[3,5],[5,7],[7,13],[13,20]]) {
  const ordered=calibrated.slice(from,to).sort((a,b)=>b.rate-a.rate);
  ordered.forEach((entry,index)=> {
    const id=from+index+1;
    entry.level.id=id;entry.level.name=names[id-1][0];entry.level.subtitle=names[id-1][1];
    levels[from+index]=entry.level;
  });
}
for(const level of levels) {
  let state=createState(level);
  for(const move of level.solution)state=releaseQueue(state,move).state;
  if(state.status!=='won')throw new Error(`Bad certificate ${level.id}`);
}
const initials={pink:'p',yellow:'y',mint:'m',purple:'v'};
const rows=levels.map(l=>`  make(${l.id}, ${JSON.stringify(l.name)}, ${JSON.stringify(l.subtitle)},\n    ${JSON.stringify(l.queues.map(q=>q.map(c=>initials[c]).join('')))},\n    ${JSON.stringify(l.cups.map(c=>initials[c.color]+c.capacity))}, ${l.bufferSize}, ${JSON.stringify(l.solution)}),`).join('\n');
const output=`import type { CandyColor, Level } from './core.ts';\n\nconst COLORS: Record<string, CandyColor> = { p: 'pink', y: 'yellow', m: 'mint', v: 'purple' };\nfunction make(id: number, name: string, subtitle: string, queues: string[], cups: string[], bufferSize: number, solution: number[]): Level {\n  return { id, name, subtitle, queues: queues.map(q => [...q].map(c => COLORS[c])),\n    cups: cups.map(c => ({color: COLORS[c[0]], capacity: Number(c.slice(1))})),\n    bufferSize, solution, par: solution.length };\n}\n\n/** Twenty seeded, curated puzzles with replay-proven solutions.\n * Chute strings are front-first: p pink, y yellow, m mint, v purple.\n * Early levels teach the rules; later stages add colors, chutes, and ordering pressure.\n * Offline random-policy simulation orders puzzles within each stage; this is not user data. */\nexport const LEVELS: Level[] = [\n${rows}\n];\n`;
writeFileSync(new URL('../src/levels.ts',import.meta.url),output);
console.log(JSON.stringify(metrics,null,2));
