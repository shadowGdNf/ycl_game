"""Create a compiler-only Love.js probe. It does not execute recovered game Lua."""
from pathlib import Path
import shutil, zipfile, hashlib, json
BASE = Path(__file__).resolve().parents[4]
ROOT = BASE/'target/xinqicheng/love-probe'
WEB = ROOT/'web'
VENDOR = ROOT/'vendor/love.js-main'
WEB.mkdir(exist_ok=True)
for rel in ['11.5', 'lua']:
    shutil.copytree(VENDOR/rel, WEB/rel, dirs_exist_ok=True)
shutil.copy2(VENDOR/'player.js', WEB/'player.js')
shutil.copy2(VENDOR/'license.txt', WEB/'license.txt')
MAIN = '''local files = require('files')
local passed, failed = 0, 0
local done = false
local i = 1
function love.load()
 print('PROBE_BEGIN Lua=' .. _VERSION .. ' Love=' .. love.getVersion())
 local apis = require('apis')
 local missing = 0
 for _,name in ipairs(apis) do
   local v = _G
   for part in name:gmatch('[^.]+') do v = type(v)=='table' and v[part] or nil end
   if v==nil then missing=missing+1; print('PROBE_API_MISSING '..name) end
 end
 print('PROBE_API_END direct='..#apis..' missing='..missing)
 local ffi = pcall(require,'ffi')
 print('PROBE_FFI_AVAILABLE '..tostring(ffi))
end
function love.update()
 if done then return end
 for j=1,25 do
   local name = files[i]
   if not name then
     print('PROBE_END passed='..passed..' failed='..failed..' total='..#files)
     done=true
     return
   end
   local bytes = love.filesystem.read('recovered/'..name)
   local fn, err = loadstring(bytes, '@'..name)
   if fn then passed=passed+1 else
     failed=failed+1
     print('PROBE_PARSE_ERROR '..tostring(err))
   end
   i=i+1
 end
end
function love.draw()
 love.graphics.print('Original engine compatibility probe: compile only',20,20)
 love.graphics.print('Parsed: '..passed..' | Failed: '..failed..' | Total: '..#files,20,50)
 love.graphics.print(done and 'Compiler probe complete. Recovered game code was not executed.' or 'Checking recovered Lua...',20,80)
end
'''
files = sorted(p for p in (ROOT/'game').rglob('*.lua') if p.stat().st_size)
with zipfile.ZipFile(WEB/'compiler-probe.love','w',zipfile.ZIP_DEFLATED) as z:
    z.writestr('main.lua',MAIN)
    z.writestr('conf.lua','function love.conf(t) t.identity="xinqicheng-engine-probe"; t.window.width=960; t.window.height=180; t.modules.physics=false end')
    z.writestr('files.lua','return {\n'+''.join(json.dumps(str(p.relative_to(ROOT/'game')),ensure_ascii=False)+',\n' for p in files)+'}\n')
    apis = json.loads((ROOT.parent/'analysis/engine-api-usage.json').read_text())
    z.writestr('apis.lua','return {\n'+''.join(json.dumps(name)+',\n' for name in apis)+'}\n')
    for p in files:
        z.write(p,'recovered/'+str(p.relative_to(ROOT/'game')))
(WEB/'index.html').write_text('''<!doctype html><html lang="en"><meta charset="utf-8"><title>APK engine compatibility probe</title>
<style>body{background:#17202b;color:#d2deea;font:14px monospace;margin:20px}canvas{max-width:100%;border:1px solid #536272}pre{white-space:pre-wrap}.error{color:#ff9875}</style>
<h1>APK → Love.js compiler probe</h1><p>This diagnostic compiles recovered Lua inside WASM; it does not execute recovered game code.</p><canvas id="canvas"></canvas><div id="spinner">Loading</div><pre id="log"></pre>
<script src="probe-logging.js"></script><script src="player.js?g=compiler-probe.love&n=1"></script></html>''')
(WEB/'probe-logging.js').write_text('''window.probeLog=[];const log=document.getElementById('log');const originalLog=console.log.bind(console);function append(...args){const text=args.join(' ');if(!text.startsWith('PROBE_')&&!text.startsWith('JS_'))return;window.probeLog.push(text);log.textContent+=text+'\\n';if(text.startsWith('PROBE_END'))document.getElementById('spinner').textContent='Diagnostic complete';}function report(...args){append(...args);originalLog(...args)}console.log=report;window.Module={print:report,printErr:report};window.addEventListener('error',e=>report('JS_ERROR',e.message));window.addEventListener('unhandledrejection',e=>report('JS_REJECTION',String(e.reason)));''')
print('Packaged compiler-only probe:',len(files),'Lua files', (WEB/'compiler-probe.love').stat().st_size,'bytes')
