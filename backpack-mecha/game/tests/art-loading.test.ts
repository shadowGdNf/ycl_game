import test from 'node:test';
import type {TestContext} from 'node:test';
import assert from 'node:assert/strict';
import {Art} from '../src/art.ts';
import {roundRect} from '../src/canvas.ts';

const manifest={version:2,atlases:Object.fromEntries(['actors','modules','enemies','cargo','environment'].map(name=>[name,`atlases/${name}.webp`])),sprites:{body:{atlas:'actors',x:0,y:0,w:10,h:10}}};
function fakeNetwork(t:TestContext){
  const requests:string[]=[],fail=new Set<string>(),hang=new Set<string>();
  class FakeImage {
    onload:(()=>void)|null=null;onerror:(()=>void)|null=null;decoding='';
    set src(value:string){
      if(!value)return;const key=value.split('/').at(-1)!;requests.push(key);
      if(hang.has(key))return;
      queueMicrotask(()=>{if(fail.has(key))this.onerror?.();else this.onload?.();});
    }
  }
  t.mock.method(globalThis,'fetch',async()=>new Response(JSON.stringify(manifest)));
  const previous=Object.getOwnPropertyDescriptor(globalThis,'Image');
  Object.defineProperty(globalThis,'Image',{value:FakeImage,configurable:true});
  t.after(()=>{if(previous)Object.defineProperty(globalThis,'Image',previous);else Reflect.deleteProperty(globalThis,'Image');});
  return {requests,fail,hang};
}

test('required sprites load with progress; decorative floor is deferred',async t=>{
  const network=fakeNetwork(t),art=new Art(50),progress:number[]=[];
  await art.load(value=>progress.push(value.loaded));
  assert.equal(art.ready,true);assert.deepEqual(progress,[0,1,2,3,4]);
  assert.equal(network.requests.length,4);assert(!network.requests.includes('environment.webp'));
  art.prepareEnvironment();await new Promise(resolve=>setTimeout(resolve,0));
  assert.equal(network.requests.filter(name=>name==='environment.webp').length,1);
});

test('failed image retries automatically, then manual retry reuses successful images',async t=>{
  const network=fakeNetwork(t),art=new Art(50);network.fail.add('actors.webp');
  await assert.rejects(art.load(),/Cannot load artwork/);assert.equal(art.ready,false);
  assert.equal(network.requests.filter(name=>name==='actors.webp').length,2);
  network.fail.clear();await art.load();assert.equal(art.ready,true);
  assert.equal(network.requests.filter(name=>name==='actors.webp').length,3);
  for(const name of ['modules','enemies','cargo'])assert.equal(network.requests.filter(value=>value===`${name}.webp`).length,1);
});

test('hung image has bounded failure and can recover without refreshing',async t=>{
  const network=fakeNetwork(t),art=new Art(10);network.hang.add('cargo.webp');
  const pending=art.load();assert.equal(art.load(),pending);
  await assert.rejects(pending,/Artwork timed out/);assert.equal(art.ready,false);
  network.hang.clear();await art.load();assert.equal(art.ready,true);
});

test('manifest request is aborted on timeout, retried, and recoverable',async t=>{
  fakeNetwork(t);let attempts=0;
  const fetchMock=t.mock.method(globalThis,'fetch',(_url:unknown,options?:RequestInit)=>{
    attempts++;
    return new Promise<Response>((_resolve,reject)=>options?.signal?.addEventListener('abort',()=>reject(new Error('aborted'))));
  });
  const art=new Art(10);await assert.rejects(art.load(),/aborted/);assert.equal(attempts,2);
  fetchMock.mock.mockImplementation(async()=>new Response(JSON.stringify(manifest)));
  await art.load();assert.equal(art.ready,true);
});

test('missing floor never rejects gameplay or launches requests every frame',async t=>{
  const network=fakeNetwork(t),art=new Art(50);await art.load();network.fail.add('environment.webp');
  for(let i=0;i<60;i++)art.prepareEnvironment();
  await new Promise(resolve=>setTimeout(resolve,0));
  for(let i=0;i<60;i++)art.prepareEnvironment();
  assert.equal(art.ready,true);assert.equal(network.requests.filter(name=>name==='environment.webp').length,2);
});

test('rounded paths draw on contexts without the modern roundRect method',()=>{
  const calls:unknown[][]=[];
  const ctx=Object.fromEntries(['moveTo','lineTo','quadraticCurveTo','closePath'].map(name=>[name,(...args:number[])=>calls.push([name,...args])])) as unknown as CanvasRenderingContext2D;
  roundRect(ctx,10,20,30,10,20);
  assert.deepEqual(calls[0],['moveTo',15,20]);
  assert.deepEqual(calls.at(-1),['closePath']);
  assert.equal(calls.filter(call=>call[0]==='quadraticCurveTo').length,4);
});
