// Local-only QA surface. No app, IndexedDB access, or fixtures in the runtime package.
import http from 'node:http';
import {readFile,appendFile} from 'node:fs/promises';
import path from 'node:path';
const root=path.resolve('.'),temp=process.env.MECHA_MOTION_DIR||'/private/tmp/backpack-mecha-dev4-qa',base=process.env.MECHA_BASELINE_WEB||'/private/tmp/backpack-mecha-dev4-baseline/web';
const types={'.html':'text/html; charset=utf-8','.js':'text/javascript; charset=utf-8','.json':'application/json','.png':'image/png','.css':'text/css'};
http.createServer(async(req,res)=>{try{
 const url=new URL(req.url,'http://localhost'),p=decodeURIComponent(url.pathname);
 if(req.method==='POST'&&['/observations','/performance'].includes(p)){
  const chunks=[];let size=0;for await(const chunk of req){size+=chunk.length;if(size>2e6)throw Error('Report too large');chunks.push(chunk);}
  const value=JSON.parse(Buffer.concat(chunks).toString());await appendFile(path.join(root,'qa',`dev4-${p.slice(1)}.jsonl`),JSON.stringify(value)+'\n');res.writeHead(200);res.end('saved');return;
 }
 let folder= p.startsWith('/current/')?path.join(root,'dist'):p.startsWith('/baseline/')?base:temp;
 let relative=p.replace(/^\/(current|baseline)\//,'/');
 let file=p==='/'?path.join(root,'scripts/motion-preview.html'):path.resolve(folder,'.'+relative);
 if(p!=='/'&&!file.startsWith(folder+path.sep))throw Error('Invalid path');
 const data=await readFile(file);res.writeHead(200,{'Content-Type':types[path.extname(file)]||'application/octet-stream','Cache-Control':'no-store'});res.end(data);
 }catch{res.writeHead(404);res.end('Not found');}
}).listen(4196,'127.0.0.1',()=>console.log('Motion fixtures: http://localhost:4196/'));
