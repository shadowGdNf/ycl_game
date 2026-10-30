// Local review only. Fixtures are isolated on port 4201 and never shipped.
import http from 'node:http';
import path from 'node:path';
import {readFile} from 'node:fs/promises';
const root=path.resolve('.'),web=path.join(root,'dist'),baseline=process.env.MECHA_BASELINE;
const mime={'.html':'text/html; charset=utf-8','.js':'text/javascript; charset=utf-8','.json':'application/json','.webp':'image/webp','.css':'text/css'};
http.createServer(async(req,res)=>{
 try{
  const p=decodeURIComponent(new URL(req.url,'http://localhost').pathname),base=p.startsWith('/baseline/')&&baseline?path.join(baseline,'dist'):web;
  const relative=p.replace(/^\/(game|baseline)\//,'/');
  const file=p==='/'?path.join(root,'scripts/dev11-preview.html'):path.resolve(base,'.'+(relative==='/'?'/index.html':relative));
  if(p!=='/'&&!file.startsWith(base+path.sep))throw Error('Invalid path');
  const data=await readFile(file);res.writeHead(200,{'Content-Type':mime[path.extname(file)]||'application/octet-stream','Cache-Control':'no-store'});res.end(data);
 }catch{res.writeHead(404);res.end('Not found');}
}).listen(Number(process.env.PORT||4201),'127.0.0.1',()=>console.log('Dev.11 review: http://localhost:4201/ · game: /game/'));
