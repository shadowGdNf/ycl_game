import {cp,mkdir,copyFile,rm,writeFile,readFile,readdir} from 'node:fs/promises';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
const root=fileURLToPath(new URL('../',import.meta.url));
process.chdir(root);
const hash=data=>createHash('sha256').update(data).digest('hex');
const manifest=JSON.parse(await readFile('assets/optimized/atlas-manifest.json','utf8'));
const sourceManifest=await readFile('assets/atlas-manifest.json');
if(hash(sourceManifest)!==manifest.sourceManifestSha256)throw Error('Run npm run art:optimize after updating the source manifest');
const original=JSON.parse(sourceManifest);
for(const [name,file] of Object.entries(original.atlases)){
  if(hash(await readFile(`assets/${file}`))!==original.inspection[name].sha256)throw Error('Run art-check.py --write and npm run art:optimize after updating PNGs');
  if(hash(await readFile(`assets/optimized/${manifest.atlases[name]}`))!==manifest.inspection[name].sha256)throw Error('Optimized atlas is stale: '+name);
}
await rm('dist',{recursive:true,force:true});
const result=spawnSync(process.execPath,['node_modules/typescript/bin/tsc'],{stdio:'inherit'});
if(result.status!==0)process.exit(result.status??1);
await mkdir('dist',{recursive:true});
await copyFile('styles.css','dist/styles.css');
await cp('assets/optimized','dist/assets',{recursive:true});
await copyFile('assets/content.json','dist/assets/content.json');
// Give the entire module graph the same content version, not just the entry point.
const modules=(await readdir('dist/js')).filter(f=>f.endsWith('.js')).sort();
const source=await Promise.all(modules.map(f=>readFile(`dist/js/${f}`,'utf8')));
const html=await readFile('index.html','utf8');
const version=hash(source.join('\n')+html+await readFile('styles.css','utf8')+JSON.stringify(manifest)).slice(0,12);
for(let i=0;i<modules.length;i++)await writeFile(`dist/js/${modules[i]}`,source[i]
  .replace(/(from\s*['"])(\.\/[^'"]+\.js)(['"])/g,`$1$2?v=${version}$3`)
  .replace('../assets/atlas-manifest.json',`../assets/atlas-manifest.json?v=${version}`));
const preloads=['actors','modules','enemies','cargo'].map(name=>`<link rel="preload" as="image" href="./assets/${manifest.atlases[name]}">`).join('');
await writeFile('dist/index.html',html.replace('./styles.css',`./styles.css?v=${version}`).replace('./js/app.js',`./js/app.js?v=${version}`).replace('</head>',preloads+'</head>'));
await writeFile('dist/.nojekyll','');
console.log('Built backpack-mecha/game/dist/');
