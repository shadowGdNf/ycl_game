// Development-only dev.10 review with its own origin and save. Never bundled.
import http from 'node:http';
import path from 'node:path';
import {readFile} from 'node:fs/promises';
const root=path.resolve('.'),web=path.join(root,'dist');
const mime={'.html':'text/html; charset=utf-8','.js':'text/javascript; charset=utf-8','.json':'application/json','.webp':'image/webp','.css':'text/css'};
http.createServer(async(req,res)=>{
 try{
  const p=decodeURIComponent(new URL(req.url,'http://localhost').pathname);
  const relative=p.replace(/^\/game\//,'/');
  const file=p==='/'?path.join(root,'scripts/dev10-preview.html'):path.resolve(web,'.'+(relative==='/'?'/index.html':relative));
  if(p!=='/'&&!file.startsWith(web+path.sep))throw Error('Invalid path');
  const data=await readFile(file);res.writeHead(200,{'Content-Type':mime[path.extname(file)]||'application/octet-stream','Cache-Control':'no-store'});res.end(data);
 }catch{res.writeHead(404);res.end('Not found');}
}).listen(Number(process.env.PORT||4200),'127.0.0.1',()=>console.log(`Dev.10 review: http://localhost:${process.env.PORT||4200}/ · production UI: /game/`));
