// Test-only fixture UI on its own origin; never ships in dist/.
import http from 'node:http';
import {readFile,stat} from 'node:fs/promises';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
const root=fileURLToPath(new URL('../dist/',import.meta.url)),port=Number(process.env.PORT||4204);
const types={'.html':'text/html; charset=utf-8','.css':'text/css','.js':'text/javascript','.webp':'image/webp','.json':'application/json'};
http.createServer(async(req,res)=>{
 try{
  const pathname=decodeURIComponent(new URL(req.url,'http://localhost').pathname);
  if(pathname==='/qa'){
   const entry=await readFile(path.join(root,'index.html'),'utf8'),version=entry.match(/app\.js\?v=([a-f0-9]+)/)[1];
   res.writeHead(200,{'Content-Type':'text/html; charset=utf-8','Cache-Control':'no-store'});
   res.end((await readFile(new URL('./dev21-fixtures.html',import.meta.url),'utf8')).replaceAll('__VERSION__',version));return;
  }
  const file=path.resolve(root,'.'+(pathname.endsWith('/')?pathname+'index.html':pathname));
  if(!file.startsWith(root)||!(await stat(file)).isFile())throw Error('Not found');
  res.writeHead(200,{'Content-Type':types[path.extname(file)]||'application/octet-stream','Cache-Control':'no-store'});res.end(await readFile(file));
 }catch{res.writeHead(404);res.end('Not found');}
}).listen(port,'127.0.0.1',()=>console.log(`Isolated dev.21 fixtures: http://127.0.0.1:${port}/qa`));
