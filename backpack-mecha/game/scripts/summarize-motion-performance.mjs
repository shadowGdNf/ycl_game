import assert from 'node:assert/strict';
import {readFileSync,writeFileSync} from 'node:fs';
const records=readFileSync('qa/dev4-performance.jsonl','utf8').trim().split('\n').map(l=>JSON.parse(l));
const latest=records.at(-1).startedAt,rows=records.filter(r=>r.startedAt===latest);
assert.equal(rows.length,6,'Need three complete baseline/current pairs');
assert.ok(rows.every(r=>r.foreground&&!r.layoutChanged),'Every segment must remain foreground at fixed canvas dimensions');
for(const r of rows){assert.deepEqual(r.viewport,[1280,900]);assert.deepEqual(r.canvas,rows[0].canvas);assert.ok(r.raw.renders.length>=1000);assert.ok(r.raw.intervals.reduce((a,b)=>a+b,0)>=59950);}
const summary=values=>{const a=[...values].sort((a,b)=>a-b);return{n:a.length,p50:a[Math.floor(a.length*.5)],p95:a[Math.floor(a.length*.95)],max:a.at(-1),over50Pct:100*a.filter(x=>x>50).length/a.length};};
const aggregate=Object.fromEntries(['dev.3','dev.4'].map(version=>{
 const group=rows.filter(r=>r.version===version);assert.deepEqual(group.map(r=>r.sample),[1,2,3]);
 return [version,{render:summary(group.flatMap(r=>r.raw.renders)),interval:summary(group.flatMap(r=>r.raw.intervals))}];
}));
const growthPct=100*(aggregate['dev.4'].render.p95/aggregate['dev.3'].render.p95-1);
const report={checkedAt:new Date().toISOString(),status:growthPct>15.0001?'regression-review-required':'passed',browser:'Codex in-app browser',os:'macOS 26.6.2',architecture:'arm64',userAgent:rows[0].userAgent,viewport:rows[0].viewport,canvas:rows[0].canvas,startedAt:latest,
 methodology:'Three alternating 60-second foreground samples per version, each after 3 seconds of warm-up; identical dense/Boss/overlap snapshots. Raw arrays retained. Pooled p95 is the comparison metric; all individual segments are also reported.',
 aggregate,renderP95GrowthPct:growthPct,reviewThresholdPct:15,segments:rows.map(({raw,...row})=>row),
 discarded:[{file:'dev4-performance-discarded-layout-initial.jsonl',reason:'Results panel changed the canvas height after the first sample; not a valid fixed-layout comparison.'},{file:'dev4-performance-discarded-layout-optimized.jsonl',reason:'Incomplete optimization rerun using the same flawed layout; discarded before final fixed-layout sampling.'},{file:'dev4-performance-before-charge-fix.jsonl',reason:'Superseded by the charge-path and contact-footprint correction; retained, not used for final-code performance claims.'},{file:'dev4-performance-discarded-viewport.jsonl',reason:'The first baseline segment detected a canvas size change. Entire comparison retained but excluded; precise transition was not recorded by that earlier harness.'}],
 priorReview:{evidence:'dev4-performance-before-label-cache-summary.json',status:'regression-review-required',baselineP95:1,currentP95:1.2,renderP95GrowthPct:20,change:'Added a bounded whole-label raster cache, followed by a fresh baseline/current comparison. Different sessions do not establish the cache effect in isolation.'},
 limitations:['Fixed-snapshot renderer timings, not end-to-end moving combat or touch latency.','In-app browser only; UA Chrome text is not independent Chrome coverage.','No phone thermal, memory-growth, or 20-minute run claim.'],
 sourceEvidence:'dev4-performance-source.json'};
writeFileSync('qa/dev4-performance-summary.json',JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify({status:report.status,aggregate,growthPct,canvas:report.canvas},null,2));
