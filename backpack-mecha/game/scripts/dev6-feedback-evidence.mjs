// Validate saved evidence and fingerprint this feedback increment. Does not rerun QA.
import assert from 'node:assert/strict';
import {readFileSync,readdirSync,writeFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import {gunzipSync} from 'node:zlib';
const root=new URL('../',import.meta.url),read=p=>readFileSync(new URL(p,root)),json=p=>JSON.parse(read(p));
const hash=p=>createHash('sha256').update(read(p)).digest('hex');
const build=json('package.json').version;
assert.equal(build,'0.2.0-dev.6');assert.match(read('src/version.ts').toString(),/RULESET_VERSION = '0\.1\.1'/);
const tests=read('qa/dev6-feedback-tests.txt').toString();assert.match(tests,/pass 104/);assert.match(tests,/fail 0/);
const natural=json('qa/dev6-feedback-natural.json'),raw=JSON.parse(gunzipSync(read(`qa/${natural.rawRuns}`)));
assert.equal(natural.results.length,60);assert.equal(raw.results.length,60);
for(const [p,h] of Object.entries(natural.sourceHashes))assert.equal(hash(p),h,`Natural probe source changed: ${p}`);
for(const r of natural.results){assert.equal(r.buildVersion,build);assert.equal(r.rulesVersion,'0.1.1');assert.ok(r.verifiedResume);assert.equal(r.anomalies.length,0);}
const baseline=json('qa/natural-probe-dev4-legacy.json'),fields=['status','wave','battleSeconds','items','attainedAtWaves','stats'];
const comparison=natural.results.map(r=>{const old=baseline.results.find(o=>o.family===r.family&&o.seed===r.seed);assert.ok(old);return {
 family:r.family,seed:r.seed,matchingFields:fields.filter(f=>isDeepStrictEqual(r[f],old[f])),
 damageTakenBefore:old.stats.damageTaken,damageTakenAfter:r.stats.damageTaken,damageTakenDelta:r.stats.damageTaken-old.stats.damageTaken,
 };});
const matchesByField=Object.fromEntries(fields.map(f=>[f,comparison.filter(r=>r.matchingFields.includes(f)).length]));
const chrome=json('qa/dev6-feedback-chrome-first-light.json');assert.equal(chrome.buildVersion,build);assert.equal(chrome.seed,'FIRST-LIGHT');assert.equal(chrome.wave,2);assert.equal(chrome.status,'prep');
assert.equal(chrome.journal.waves[0].end.won,true);assert.equal(chrome.battleSeconds,40);
const performance=json('qa/dev6-feedback-dense-performance.json');assert.equal(performance.build,build);assert.equal(performance.foreground,true);assert.equal(performance.battleStatus,'playing');assert.ok(performance.battleSeconds>=10.9);assert.ok(performance.remainingEnemies>30);
for(const [key,rawKey] of [['interval','intervalMs'],['render','renderMs']]){
 const sorted=performance.raw[rawKey].toSorted((a,b)=>a-b);assert.equal(sorted.length,performance[key].samples);assert.ok(sorted.length>=500);
 assert.equal(sorted[Math.ceil(sorted.length*.95)-1],performance[key].p95);assert.equal(sorted.at(-1),performance[key].max);
}
const sourcePaths=['.gitignore','package.json','package-lock.json',...readdirSync(new URL('src/',root)).filter(p=>p.endsWith('.ts')).map(p=>`src/${p}`),
 'tests/combat-feedback.test.ts','scripts/feedback-preview.html','scripts/serve-feedback.mjs','scripts/dev6-feedback-evidence.mjs','docs/DEV6-COMBAT-FEEDBACK.md'];
const evidencePaths=['dev6-feedback-tests.txt','dev6-feedback-natural.json',natural.rawRuns,'dev6-feedback-chrome-first-light.json',
 'dev6-feedback-dense-performance.json','dev6-feedback-dense-performance-wide.json','dev6-feedback-dense-performance-attempt1.json',
 'dev6-crane-before.png','dev6-crane-hit.png','dev6-weapon-feedback.png'];
const output={checkedAt:new Date().toISOString(),buildVersion:build,rulesVersion:'0.1.1',scope:'Combat feedback increment; full dev.6 acceptance is still pending',
 checks:{typecheck:'passed',tests:{passed:104,failed:0,newRegressionCases:10},build:'passed',bundle:json('qa/bundle-check.json'),
 natural:{runs:60,wins:natural.results.filter(r=>r.status==='won').length,resumeChecks:natural.summaries.reduce((n,s)=>n+s.resumeChecks,0),sourceHashesVerified:true,
  comparisonBaseline:'natural-probe-dev4-legacy.json',matchesByField,damageChangedRuns:comparison.filter(r=>r.damageTakenDelta!==0).length,comparison},
 browser:{independentChrome:{reportedVersion:'155.0.0.0 (user agent)',system:'macOS 26.6.2',origin:'http://localhost:4198/game/',
  seed:'FIRST-LIGHT',note:'First-run tutorial overrides the home seed with FIRST-LIGHT.',
  actions:['Normal launch and tutorial','Keyboard W/D, dash, pause','Save and return home','Reload and resume','Complete wave 1 normally','Enter wave 2 preparation','Export battle report'],
  end:chrome.journal.waves[0].end,fullTwelveWaves:false,audio:'Browser showed playback; routing tested in unit tests; human listening quality not evaluated'},
 inApp:{scenes:['crane','sweep','ballistic','element','flame','melee','dense'],reducedMotionAndColorAssist:'sweep checked',consoleErrors:0,
  sweepComparison:{time:1.5,initial:{hp:100,shield:5},before:{hp:100,shield:5,damageTaken:0},after:{hp:87,shield:0,damageTaken:18}}}},
 densePerformance:{...performance,raw:undefined},excludedPerformance:{file:'dev6-feedback-dense-performance-attempt1.json',reason:'Player died at 3.53s; stationary terminal rendering contaminates the 10s window.'}},
 limitations:['Machine policies are not human win rates.','40-enemy performance fixture explicitly grants 10000 HP and equipment; not a natural run.','Local browser windows are not phone or sustained 20-minute performance.','No full twelve-wave browser, Safari, physical-phone or human playtest claim.','Area damage now checks every tick; old saves continue under corrected rules, not frozen buggy rules.'],
 sourceHashes:Object.fromEntries(sourcePaths.map(p=>[p,hash(p)])),evidenceHashes:Object.fromEntries(evidencePaths.map(p=>[p,hash(`qa/${p}`)])),
 deployment:{committed:false,pushed:false,onlineUpdated:false},releaseManifest:'../releases/release-manifest-v0.2.0-dev.6.json'};
writeFileSync(new URL('qa/dev6-feedback-check.json',root),JSON.stringify(output,null,2)+'\n');
console.log(JSON.stringify({build,tests:104,naturalRuns:60,resumeChecks:output.checks.natural.resumeChecks,matchesByField,
 denseP95Ms:performance.interval.p95,renderP95Ms:performance.render.p95,sourceFiles:sourcePaths.length,evidenceFiles:evidencePaths.length},null,2));
