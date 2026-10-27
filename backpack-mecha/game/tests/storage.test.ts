import test from 'node:test';
import assert from 'node:assert/strict';
import {freshProfile,loadSave,sanitizeSave,saveGame} from '../src/storage.ts';
import type {SaveEnvelope} from '../src/storage.ts';
import {newRun,storeItem,startWave} from '../src/economy.ts';
import {createBattle} from '../src/combat.ts';

function envelope():SaveEnvelope {return {version:1,profile:freshProfile(),run:newRun('scavenger','full',0,'storage'),battle:null,savedAt:123456};}

test('fresh profiles do not share mutable arrays or settings',()=>{
 const a=freshProfile(),b=freshProfile();a.unlocked.push('bulwark');a.settings.sound=false;a.codex.push('W02');
 assert.deepEqual(b.unlocked,['scavenger']);assert.equal(b.settings.sound,true);assert.deepEqual(b.codex,['W01','S01']);
});

test('valid prep save preserves progress, timestamp and deterministic state without aliasing',()=>{
 const input=envelope();input.profile.language='en';input.profile.unlocked.push('bulwark');input.profile.best['full:scavenger:0']={score:15000,seconds:600};
 const output=sanitizeSave(input);assert.equal(output.savedAt,input.savedAt);assert.deepEqual(output.run,input.run);assert.deepEqual(output.profile,input.profile);
 output.run!.items[0].x=3;output.profile.settings.sound=false;assert.equal(input.run!.items[0].x,1);assert.equal(input.profile.settings.sound,true);
});

test('unknown version keeps valid permanent progress but discards the incompatible active run',()=>{
 const input=envelope();input.profile.unlocked.push('hive');input.profile.maxDifficulty=3;
 const output=sanitizeSave({...input,version:999});assert.equal(output.run,null);assert.equal(output.battle,null);assert.deepEqual(output.profile.unlocked,['scavenger','hive']);assert.equal(output.profile.maxDifficulty,3);
});

test('profile sanitization filters unknown unlocks and clamps settings and scores',()=>{
 const input=envelope();input.profile.unlocked=['hive','hive','not-a-chassis'];input.profile.codex=['W01','unknown'];input.profile.maxDifficulty=20;input.profile.settings.volume=100;input.profile.best={negative:{score:-3,seconds:-4},invalid:{score:Infinity,seconds:2}};
 const p=sanitizeSave(input).profile;assert.deepEqual(p.unlocked,['scavenger','hive']);assert.deepEqual(p.codex,['W01']);assert.equal(p.maxDifficulty,4);assert.equal(p.settings.volume,1);assert.deepEqual(p.best,{negative:{score:0,seconds:0}});
});

test('incomplete or invalid run records cannot enter a dead-end UI phase or throw on the next command',()=>{
 const mutations=[
  (r:Record<string,unknown>)=>{delete r.history;},
  (r:Record<string,unknown>)=>{delete r.rewardOptions;},
  (r:Record<string,unknown>)=>{delete r.protocolOptions;},
  (r:Record<string,unknown>)=>{delete r.eventsSeen;},
  (r:Record<string,unknown>)=>{r.phase='unknown';},
  (r:Record<string,unknown>)=>{r.mode='demo';r.wave=12;},
  (r:Record<string,unknown>)=>{r.rng={shop:1,map:2,event:3};},
  (r:Record<string,unknown>)=>{r.items=[{uid:'i1',id:'missing',tier:1,x:0,y:0,rotation:0,stored:true}];},
  (r:Record<string,unknown>)=>{r.protocols=['missing-protocol'];},
  (r:Record<string,unknown>)=>{r.protocolOptions=['missing-protocol'];},
  (r:Record<string,unknown>)=>{r.rewardOptions=['missing-module'];},
  (r:Record<string,unknown>)=>{r.bosses=['missing-boss'];},
  (r:Record<string,unknown>)=>{r.eventId='missing-event';r.eventResolved=false;},
 ];
 for(const mutate of mutations){const input=envelope();mutate(input.run as unknown as Record<string,unknown>);assert.equal(sanitizeSave(input).run,null,mutate.toString());}
});

test('structurally valid unfinished loadout remains recoverable between battles',()=>{
 const input=envelope();assert.equal(storeItem(input.run!,input.run!.items[0].uid).ok,true);
 const restored=sanitizeSave(input);assert.notEqual(restored.run,null);assert.equal(restored.run!.phase,'prep');assert.equal(restored.run!.items[0].stored,true);assert.equal(restored.run!.items[1].link,undefined);
});

test('complete battle state survives JSON storage with runtime simulation fields intact',()=>{
 const input=envelope();assert.equal(startWave(input.run!).ok,true);input.battle=createBattle(input.run!);
 const restored=sanitizeSave(JSON.parse(JSON.stringify(input)));assert.equal(restored.run!.phase,'battle');assert.deepEqual(restored.battle,input.battle);assert.equal(restored.savedAt,123456);
 const battle=restored.battle as ReturnType<typeof createBattle>;assert.equal(battle.rng,input.run!.rng.combat);assert.equal(battle.encounter.wave.n,1);assert.equal(battle.nextEvent,2);
});

test('invalid battle snapshots recover at prep rather than casting an incomplete view into runtime state',()=>{
 for(const missing of ['encounter','rng','utilities','protocols','slainGroups','nextId','nextShot']){
  const input=envelope();assert.equal(startWave(input.run!).ok,true);const battle=createBattle(input.run!);delete (battle as unknown as Record<string,unknown>)[missing];input.battle=battle;
  const restored=sanitizeSave(input);assert.equal(restored.battle,null,missing);assert.equal(restored.run!.phase,'prep',missing);
 }
});

test('battle mismatch is rejected without losing permanent progress',()=>{
 const input=envelope();input.profile.unlocked.push('bulwark');startWave(input.run!);input.battle=createBattle(input.run!);input.battle.wave=2;
 const restored=sanitizeSave(input);assert.equal(restored.battle,null);assert.equal(restored.run!.phase,'prep');assert.deepEqual(restored.profile.unlocked,['scavenger','bulwark']);
});

test('missing IndexedDB reports failed saves and keeps the queue usable',async()=>{
 const input=envelope();assert.equal(typeof indexedDB,'undefined');assert.equal(await saveGame(input),false);assert.equal(await saveGame(input),false);assert.equal((await loadSave()).run,null);
});
