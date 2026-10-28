import assert from 'node:assert/strict';
import {readFileSync,writeFileSync} from 'node:fs';
import {gunzipSync} from 'node:zlib';
import {createHash} from 'node:crypto';
const files=['qa/natural-probe-dev3-legacy-runs.json.gz','qa/natural-probe-dev4-legacy-runs.json.gz'];
const [before,after]=files.map(f=>JSON.parse(gunzipSync(readFileSync(f))));
const key=r=>`${r.family}/${r.seed}`;
const projection=r=>{
 const copy=structuredClone(r);delete copy.buildVersion;delete copy.decisions;delete copy.diagnosticSummary;delete copy.journal.buildVersion;return copy;
};
assert.equal(after.results.length,60);assert.equal(before.results.length,60);
for(const r of after.results){const old=before.results.find(o=>key(o)===key(r));assert.ok(old,key(r));assert.deepEqual(projection(r),projection(old),key(r));}
const report={checkedAt:new Date().toISOString(),status:'passed',identicalRuns:60,wins:after.results.filter(r=>r.status==='won').length,resumeChecks:after.results.reduce((n,r)=>n+r.resumedWaves,0),
 compared:'Entire natural run reports, including every shop action, wave economy, loadout, RNG journal, damage, outcome and recovery checks.',
 excluded:['buildVersion','journal.buildVersion','decisions and diagnosticSummary (optional dev.3 growth-search diagnostics)'],
 sourceHashes:Object.fromEntries(files.map(f=>[f,createHash('sha256').update(readFileSync(f)).digest('hex')])),families:after.summaries,
 limitation:'Machine simulation through production rules; not browser interaction, a human win rate or a device performance measurement.'};
writeFileSync('qa/dev4-natural-comparison.json',JSON.stringify(report,null,2)+'\n');console.log(JSON.stringify({identicalRuns:report.identicalRuns,wins:report.wins,resumeChecks:report.resumeChecks}));
