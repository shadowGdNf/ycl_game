import assert from 'node:assert/strict';
import {readFile,readdir,stat,access,writeFile,mkdir} from 'node:fs/promises';
import path from 'node:path';
import {createHash} from 'node:crypto';
import {fileURLToPath} from 'node:url';
const root=fileURLToPath(new URL('../',import.meta.url));
const dist=path.join(root,'dist');
async function files(dir){return(await Promise.all((await readdir(dir,{withFileTypes:true})).map(async d=>d.isDirectory()?files(path.join(dir,d.name)):[path.join(dir,d.name)]))).flat();}
const all=await files(dist),html=await readFile(path.join(dist,'index.html'),'utf8');
assert(!all.some(f=>f.includes('_qa-')||f.includes('/source/')),'QA fixtures and source masters must not enter the runtime package');
for(const match of html.matchAll(/(?:src|href)="([^"#]+)"/g)){assert(!/^https?:/.test(match[1]),'Runtime should be self-contained');await access(path.resolve(dist,match[1].split('?')[0]));}
const version=html.match(/app\.js\?v=([a-f0-9]+)/)?.[1];assert(version,'Entry module needs a content version');
for(const file of all.filter(f=>f.endsWith('.js'))){const js=await readFile(file,'utf8');for(const m of js.matchAll(/(?:from\s*|import\s*)['"](\.[^'"]+)['"]/g)){await access(path.resolve(path.dirname(file),m[1].split('?')[0]));assert(m[1].endsWith(`?v=${version}`),'All modules must use the same content version');}}
const content=JSON.parse(await readFile(path.join(dist,'assets/content.json'),'utf8'));
for(const [key,count]of Object.entries({modules:36,chassis:4,enemies:12,bosses:6,protocols:9,events:8,waves:12,demoIds:24})){assert.equal(content[key].length,count,key);}
const manifest=JSON.parse(await readFile(path.join(dist,'assets/atlas-manifest.json'),'utf8'));
assert(!all.some(f=>f.endsWith('.png')),'PNG masters must not enter the web package');
let startupImageBytes=0;
for(const [name,atlas] of Object.entries(manifest.atlases)){
  const buffer=await readFile(path.join(dist,'assets',atlas));
  assert.equal(createHash('sha256').update(buffer).digest('hex'),manifest.inspection[name].sha256,`Stale atlas ${name}`);
  assert(atlas.endsWith('.webp')&&atlas.includes(manifest.inspection[name].sha256.slice(0,12)),'Atlas names must include their content hash');
  if(name!=='environment'){startupImageBytes+=buffer.length;assert(html.includes(`href="./assets/${atlas}"`),'Preload required artwork');}
}
assert.equal(Object.keys(manifest.sprites).length,86,'Expected all sprite regions and boss subparts');
for(const item of [...content.modules,...content.enemies,...content.bosses])assert(manifest.sprites[item.id],`Missing sprite ${item.id}`);
for(const c of content.chassis)for(const part of ['body.0','body.1','body.2','body.3','legs','backpack'])assert(manifest.sprites[`${c.id}.${part}`],`Missing chassis part ${c.id}.${part}`);
const bytes=(await Promise.all(all.map(f=>stat(f)))).reduce((sum,s)=>sum+s.size,0);
assert(bytes<3*1024*1024,'Review runtime size above 3 MiB');
assert(startupImageBytes<1.5*1024*1024,'Review startup artwork above 1.5 MiB');
const report={checkedAt:new Date().toISOString(),files:all.length,bytes,mib:Number((bytes/1024/1024).toFixed(2)),startupImageBytes,spriteRegions:Object.keys(manifest.sprites).length,counts:Object.fromEntries(['modules','chassis','enemies','bosses','protocols','events','waves','demoIds'].map(k=>[k,content[k].length])),status:'passed',note:'Static existence/content checks only; not a physical device performance result.'};
await mkdir(path.join(root,'qa'),{recursive:true});await writeFile(path.join(root,'qa/bundle-check.json'),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(report,null,2));
