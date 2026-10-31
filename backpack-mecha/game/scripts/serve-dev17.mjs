// Isolated local QA. No fixtures or instrumentation enter dist/.
import http from 'node:http';
import path from 'node:path';
import {readFile} from 'node:fs/promises';
const root=path.resolve('.'),web=path.join(root,'dist'),baseline=process.env.MECHA_BASELINE?path.join(process.env.MECHA_BASELINE,'dist'):'/private/tmp/mecha-dev16-baseline/dist';
const mime={'.html':'text/html; charset=utf-8','.js':'text/javascript; charset=utf-8','.json':'application/json','.webp':'image/webp','.css':'text/css'};
http.createServer(async(req,res)=>{
 try{
  const p=decodeURIComponent(new URL(req.url,'http://localhost').pathname),base=p.startsWith('/baseline/')?baseline:web;
  const relative=p.replace(/^\/(game|baseline)\//,'/');
  const file=p==='/'?path.join(root,'scripts/dev17-preview.html'):path.resolve(base,'.'+(relative==='/'?'/index.html':relative));
  if(p!=='/'&&!file.startsWith(base+path.sep))throw Error('Invalid path');
  let data=await readFile(file);
  if(p==='/game/'){
   let html=data.toString(),v=html.match(/app.js\?v=([^"']+)/)[1];
   html=html.replace('<script type="module"',`<script type="module">import {Renderer} from './js/renderer.js?v=${v}';const stats=window.qa={draws:0,heroes:0,frames:[],errors:[]};for(const key of ['draw','hero']){const fn=Renderer.prototype[key];Renderer.prototype[key]=function(...args){stats[key==='draw'?'draws':'heroes']++;const t=performance.now(),result=fn.apply(this,args);if(key==='draw'){stats.frames.push(performance.now()-t);if(stats.frames.length>3600)stats.frames.shift();}return result;};}window.addEventListener('error',e=>stats.errors.push(e.message));</script><script type="module"`);
   data=Buffer.from(html);
  }
  res.writeHead(200,{'Content-Type':mime[path.extname(file)]||'application/octet-stream','Cache-Control':'no-store'});res.end(data);
 }catch(error){res.writeHead(404);res.end('Not found: '+error.message);}
}).listen(Number(process.env.PORT||4202),'127.0.0.1',()=>console.log('Dev.17 review: http://localhost:4202/'));
