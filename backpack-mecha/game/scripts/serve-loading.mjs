// Development-only failure/slow/legacy browser fixtures; never copied into dist.
// /broken/ fails the first two actors requests. Retry in the UI then succeeds.
// /slow/ delays image responses by 8 seconds. /legacy/ removes roundRect support.
import http from 'node:http';
import {readFile,stat} from 'node:fs/promises';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
const root=fileURLToPath(new URL('../dist',import.meta.url));
const types={'.html':'text/html; charset=utf-8','.css':'text/css','.js':'text/javascript','.json':'application/json','.webp':'image/webp'};
let actorFailures=0;
http.createServer(async(req,res)=>{
  try{
    const url=new URL(req.url,'http://localhost'),parts=url.pathname.split('/'),scenario=parts[1];
    if(!['broken','slow','legacy'].includes(scenario))throw Error();
    let relative=parts.slice(2).join('/');if(!relative||relative.endsWith('/'))relative+='index.html';
    const file=path.resolve(root,relative);if(!file.startsWith(root+path.sep)||!(await stat(file)).isFile())throw Error();
    if(scenario==='broken'&&relative.includes('/actors.')&&actorFailures++<2){res.writeHead(503,{'Cache-Control':'no-store'});res.end('Simulated artwork failure');return;}
    let data=await readFile(file);
    if(relative==='index.html'){
      let html=data.toString().replace(/<link rel="preload"[^>]+>/g,'');
      if(scenario==='legacy')html=html.replace('<body>','<body><script>delete CanvasRenderingContext2D.prototype.roundRect;if(typeof OffscreenCanvasRenderingContext2D!=="undefined")delete OffscreenCanvasRenderingContext2D.prototype.roundRect;</script>');
      data=Buffer.from(html);
    }
    if(scenario==='slow'&&file.endsWith('.webp'))await new Promise(resolve=>setTimeout(resolve,8000));
    res.writeHead(200,{'Content-Type':types[path.extname(file)]||'application/octet-stream','Cache-Control':'no-store'});res.end(data);
  }catch{res.writeHead(404);res.end('Not found');}
}).listen(4184,'127.0.0.1',()=>console.log('Loading QA: http://localhost:4184/{broken,slow,legacy}/'));
