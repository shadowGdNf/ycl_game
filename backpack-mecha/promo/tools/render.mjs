// Offline video authoring: renders the existing game engine into frames, with no player save access.
import http from 'node:http';
import path from 'node:path';
import {readFile,writeFile,mkdir} from 'node:fs/promises';
import {fileURLToPath} from 'node:url';
import {spawn} from 'node:child_process';
import {once} from 'node:events';
const here=path.dirname(fileURLToPath(import.meta.url)),game=path.resolve(here,'../../game');
const deps=process.env.MECHA_NODE_MODULES||'/Users/atlasv/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules';
const {chromium}=await import(path.join(deps,'playwright/index.mjs'));
const ts=(await import(path.join(game,'node_modules/typescript/lib/typescript.js'))).default;
const work=process.env.MECHA_VIDEO_WORK||'/tmp/mecha-trailer-work';await mkdir(work,{recursive:true});
const pilot=ts.transpileModule((await readFile(path.join(game,'scripts/probe-pilot.ts'),'utf8')).replaceAll('../src/combat.ts','/game/js/combat.js').replaceAll('../src/encounters.ts','/game/js/encounters.js'),{compilerOptions:{target:ts.ScriptTarget.ES2022,module:ts.ModuleKind.ES2022}}).outputText;
const server=http.createServer(async(req,res)=>{try{const url=new URL(req.url,'http://localhost');if(url.pathname==='/pilot.js'){res.setHeader('Content-Type','text/javascript');res.end(pilot);return;}const base=url.pathname.startsWith('/game/')?path.join(game,'dist'):here;const rel=url.pathname.startsWith('/game/')?url.pathname.slice(6):url.pathname==='/'?'capture.html':url.pathname.slice(1);const file=path.resolve(base,rel);if(!file.startsWith(base+'/'))throw Error('outside root');res.setHeader('Content-Type',({'.html':'text/html','.js':'text/javascript','.json':'application/json','.webp':'image/webp','.png':'image/png'})[path.extname(file)]||'application/octet-stream');res.end(await readFile(file));}catch(e){res.statusCode=404;res.end(String(e));}});
await new Promise(r=>server.listen(0,'127.0.0.1',r));
const browser=await chromium.launch({headless:true,executablePath:'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',args:['--autoplay-policy=no-user-gesture-required']});
const page=await browser.newPage({viewport:{width:1280,height:720},deviceScaleFactor:1});
const errors=[];page.on('pageerror',e=>{errors.push(String(e));console.error(e);});
try{
 await page.goto(`http://127.0.0.1:${server.address().port}/`);await page.waitForFunction(()=>window.ready,{},{timeout:30000});
 const duration=await page.evaluate(()=>window.duration),preview=process.argv.includes('--preview');
 const ff=preview?null:spawn('ffmpeg',['-hide_banner','-loglevel','warning','-y','-f','image2pipe','-vcodec','mjpeg','-framerate','30','-i','pipe:0','-an','-c:v','libx264','-preset','fast','-crf','19','-pix_fmt','yuv420p','-movflags','+faststart',path.join(work,'picture.mp4')],{stdio:['pipe','inherit','inherit']});
 const done=ff?once(ff,'exit'):null;
 const scenes=await page.evaluate(()=>window.scenes);let sceneIndex=-1;
 for(let frame=0;frame<duration*30;frame++){
  const index=scenes.findIndex(s=>frame/30>=s.start&&frame/30<s.start+s.duration);
  if(sceneIndex!==index){sceneIndex=index;console.log(`Scene ${index+1}/${scenes.length}: ${scenes[index].id}`);}
  const data=Buffer.from(await page.evaluate(f=>window.renderFrame(f),frame),'base64');
  if(ff&&!ff.stdin.write(data))await once(ff.stdin,'drain');
  if(frame===Math.round((scenes[index].start+2)*30))await writeFile(path.join(work,`${String(index).padStart(2,'0')}-${scenes[index].id}.jpg`),data);
 }
 if(ff){ff.stdin.end();const [code]=await done;if(code!==0)throw Error(`Encoder failed: ${code}`);}
 const report=await page.evaluate(()=>window.captureReport());report.errors=errors;await writeFile(path.join(work,'capture-report.json'),JSON.stringify(report,null,2));
 console.log(JSON.stringify({duration,errors,evidence:report.evidence.map(x=>({id:x.id,start:x.startStatus,end:x.endStatus,kills:x.kills,skills:x.skills}))},null,2));
 if(errors.length)process.exitCode=1;
}finally{await browser.close();server.close();}
