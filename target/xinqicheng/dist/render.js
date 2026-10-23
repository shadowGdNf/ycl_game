const root = new URL('./assets/', import.meta.url);
const pointY = y => 768 - y;
export async function json(url) { const response = await fetch(url); if (!response.ok) throw new Error(`无法加载 ${url} (${response.status})`); return response.json(); }
export class Assets {
  constructor() { this.frames = new Map(); this.images = new Map(); this.groups = new Map(); this.exos = new Map(); this.resolved = new Map(); }
  async init() {
    [this.manifest, this.animations, this.frameIndex] = await Promise.all([json(new URL('manifest.json', root)), json(new URL('animations/index.json', root)), json(new URL('frames-index.json', root))]);
  }
  async group(name) {
    if (this.groups.has(name)) return this.groups.get(name);
    const info = this.manifest.atlases[name];
    if (!info) throw new Error(`缺少图集 ${name}`);
    const promise = (async () => {
      const data = await json(new URL(info.url || `atlases/${name}.json`, root));
      for (const [key, value] of Object.entries(data.frames)) this.frames.set(key, value);
      await Promise.all([...new Set(Object.values(data.frames).map(f => f.image))].map(path => this.image(path)));
      return data;
    })();
    this.groups.set(name, promise);
    try { return await promise; } catch (e) { this.groups.delete(name); throw e; }
  }
  async image(path) {
    if (this.images.has(path)) return this.images.get(path);
    const img = new Image(); img.decoding = 'async'; img.src = new URL(path, root);
    await img.decode(); this.images.set(path, img); return img;
  }
  find(prefix, action = 'idle') {
    const key = `${prefix}:${action}`;
    if (this.resolved.has(key)) return this.resolved.get(key);
    let value;
    if (this.animations.exo[prefix]) value = { kind: 'exo', name: prefix, info: this.animations.exo[prefix] };
    else {
      const suffixes = action === 'walk' ? ['walkingRightLeft', 'walk', 'walking', 'run', 'idle'] : action === 'attack' ? ['attack', 'shoot', 'attackRightLeft', 'idle'] : ['idle', 'idleRightLeft', 'standing', 'walkingRightLeft'];
      let name = suffixes.map(s => `${prefix}_${s}`).find(n => this.animations.sprites[n]);
      if (!name) name = Object.keys(this.animations.sprites).find(k => k.startsWith(`${prefix}_`));
      if (name) value = { kind: 'sprite', name, info: this.animations.sprites[name] };
    }
    this.resolved.set(key, value || null); return value;
  }
  async entity(prefix) {
    if (!prefix) return;
    const infos = ['idle', 'walk', 'attack'].map(a => this.find(prefix, a)).filter(Boolean);
    for (const info of infos) {
      if (info.kind === 'exo' && !this.exos.has(prefix)) this.exos.set(prefix, await json(new URL(info.info.url, root)));
      await Promise.all((info.info.atlasGroups || []).filter(g => this.manifest.atlases[g]).map(g => this.group(g)));
    }
  }
  async stage(level, mechanics, progress) {
    if(this.activeStage!==level.id){this.groups.clear();this.images.clear();this.frames.clear();this.exos.clear();this.activeStage=level.id;}
    const groups = [`go_stage${String(level.id).padStart(2,'0')}_bg`,`go_stage${String(level.id).padStart(2,'0')}`, 'go_towers', 'go_towers_archers', 'go_towers_knights', 'go_towers_wizard', 'go_towers_catapult'];
    const prefixes = new Set(['hero_geraldDef','knights_order_soldier_lvl1','knights_order_soldier_lvl2','knights_order_soldier_lvl3','knights_order_soldier_lvl4','reinforcements_lvl1_1']);
    for (const type of ['archers','knights','wizard','catapult']) for (const l of mechanics.towers[type]?.levels || []) for (const p of Object.values(l.spritePrefixes || {})) prefixes.add(p);
    for (const wave of [...level.waves, ...(level.manualWaves || [])]) for (const s of wave.spawns || []) {
      for (const p of Object.values(mechanics.enemies[s.enemy]?.spritePrefixes || {})) prefixes.add(p);
    }
    for(const d of this.scenery?.levels?.[level.id]?.decorations||[])if(d.atlas)groups.push(d.atlas);
    const tasks = [...new Set(groups.filter(g => this.manifest.atlases[g]))].map(g => () => this.group(g)).concat([...prefixes].map(p => () => this.entity(p)));
    let n = 0;
    for (let i = 0; i < tasks.length; i += 4) await Promise.all(tasks.slice(i,i+4).map(async task => { await task(); progress?.(++n / tasks.length); }));
  }
  frame(ctx, name, x, y, scale = .5, ax = .5, ay = .5, shiftX = 0, shiftY = 0) {
    const f = this.frames.get(name), img = f && this.images.get(f.image);
    if (!f || !img) return false;
    const [sx,sy,w,h] = f.rect;
    ctx.drawImage(img,sx,sy,w,h,x-f.size[0]*scale*ax+f.trim[0]*scale+shiftX,y-f.size[1]*scale*ay+f.trim[1]*scale+shiftY,w*scale,h*scale);
    return true;
  }
  entityDraw(ctx, prefix, action, x, y, time, facing = 1, extraScale = 1, anchor = {x:.5,y:.5}) {
    const found = this.find(prefix, action); if (!found) return false;
    ctx.save(); ctx.translate(x,y);ctx.scale(facing,1);ctx.scale(extraScale,extraScale);
    let ok = false;
    if (found.kind === 'sprite') {
      const seq = found.info.frames, frame = seq[Math.floor(time * (found.info.fps || 30)) % seq.length];
      ok = this.frame(ctx,frame,0,0,.5,anchor.x,1-anchor.y);
    } else {
      const exo = this.exos.get(prefix);
      if (exo) {
        const choices = action === 'walk' ? ['walk','walking','run','walkingRightLeft','idle'] : action === 'attack' ? ['attack','shoot','idle'] : ['idle','idle1','loop'];
        const anim = choices.map(n => exo.animations.find(a => a.name === n)).find(Boolean) || exo.animations[0];
        if (anim?.frames.length) {
          const parts = anim.frames[Math.floor(time * (exo.fps || 30)) % anim.frames.length];
          for (const part of parts) {
            const [type,idx,alpha,px,py,sx,sy,r,kx,ky] = part;
            if (type === 8 || alpha <= 0) continue;
            const p = exo.parts[idx-1]; if (!p) continue;
            ctx.save(); ctx.globalAlpha *= alpha;ctx.translate(px,py);ctx.rotate(r || 0);ctx.transform(sx ?? 1,(ky || 0)*(sy ?? 1),(kx || 0)*(sx ?? 1),sy ?? 1,0,0);
            ok = this.frame(ctx,p[0],0,0,exo.atlasScale || .5,.5,.5,p[1] || 0,p[2] || 0) || ok;ctx.restore();
          }
        }
      }
    }
    ctx.restore(); return ok;
  }
  background(ctx, id, width = 1400, height = 768) {
    const names = [...this.frames.keys()].filter(k => new RegExp(`^Stage${String(id).padStart(2,'0')}(?:_|$)`, 'i').test(k));
    const name = names.find(n => /0001$/.test(n)) || names[0];
    if (!name) return false;
    const f = this.frames.get(name), image = this.images.get(f.image); if(!image) return false;
    ctx.drawImage(image,...f.rect,0,0,width,height);return true;
  }
}

export class Renderer {
  constructor(canvas, assets) { this.canvas = canvas;this.ctx = canvas.getContext('2d',{alpha:false});this.assets=assets;this.zoom=1;this.pan={x:0,y:0};this.selected=null;this.target=null;this.pointer=null;this.models=null; }
  position(clientX,clientY) { const r=this.canvas.getBoundingClientRect(); return {x:((clientX-r.left)/r.width*1400-700-this.pan.x)/this.zoom+512,y:768-(((clientY-r.top)/r.height*768-384-this.pan.y)/this.zoom+384)}; }
  setZoom(n) { this.zoom=Math.max(1,Math.min(2.5,n));if(this.zoom===1)this.pan={x:0,y:0};this.clampPan(); }
  clampPan() { const maxX=700*(this.zoom-1),maxY=384*(this.zoom-1);this.pan.x=Math.max(-maxX,Math.min(maxX,this.pan.x));this.pan.y=Math.max(-maxY,Math.min(maxY,this.pan.y)); }
  render(game) {
    const c=this.ctx,a=this.assets; c.fillStyle='#172b24';c.fillRect(0,0,1400,768);c.save();c.translate(700+this.pan.x,384+this.pan.y);c.scale(this.zoom,this.zoom);c.translate(-700,-384);
    a.background(c,game.level.id);c.translate(188,0);
    const decorations=a.scenery?.levels?.[game.level.id]?.decorations||[];
    for(const d of decorations)if(d.z<3000&&!d.hidden)this.decoration(c,d);
    const selected=game.towers.find(t=>t.id===this.selected);
    if(selected?.type){c.fillStyle=selected.type==='barracks'?'#74b9cc19':'#ecdda21b';c.strokeStyle='#f3de8588';c.lineWidth=2;c.beginPath();c.ellipse(selected.x,pointY(selected.y),game.towerStats(selected).range,game.towerStats(selected).range*.75,0,0,Math.PI*2);c.fill();c.stroke();}
    for(const t of game.towers) if(!t.type) this.holder(c,t,game.time,t.id===this.selected);
    const drawables=[...game.towers.filter(t=>t.type).map(t=>({kind:'tower',y:t.y,data:t})),...game.enemies.map(e=>({kind:'enemy',y:e.y,data:e})),...game.units.filter(u=>u.hp>0).map(u=>({kind:'unit',y:u.y,data:u}))].sort((x,y)=>y.y-x.y);
    for(const d of drawables){if(d.kind==='tower')this.tower(c,d.data,game.time);else if(d.kind==='enemy')this.enemy(c,d.data,game.time);else this.unit(c,d.data,game.time);}
    for(const d of decorations)if(d.z>=3000&&!d.hidden)this.decoration(c,d);
    if(game.hero.target){c.strokeStyle='#94e6f2';c.lineWidth=2;c.beginPath();c.ellipse(game.hero.target.x,pointY(game.hero.target.y),15,7,0,0,Math.PI*2);c.stroke();}
    for(const p of game.projectiles){const t=Math.min(1,p.elapsed/p.duration),x=p.x+(p.targetX-p.x)*t,y=pointY(p.y+(p.targetY-p.y)*t)-(p.type==='artillery'?Math.sin(t*Math.PI)*65:0);c.save();c.translate(x,y);if(p.type==='archer'){c.rotate(Math.atan2(p.y-p.targetY,p.targetX-p.x));c.strokeStyle='#efd9a2';c.lineWidth=2;c.beginPath();c.moveTo(-8,0);c.lineTo(4,0);c.stroke();}else{c.shadowBlur=p.type==='meteor'?20:8;c.shadowColor=p.type==='mage'?'#97c5ff':'#ff9e43';c.fillStyle=p.type==='mage'?'#b9c8ff':p.type==='meteor'?'#ffd28a':'#4a3932';c.beginPath();c.arc(0,0,p.type==='meteor'?11:p.type==='mage'?4:6,0,Math.PI*2);c.fill();}c.restore();}
    for(const e of game.effects){const t=1-e.life/e.total;c.save();c.globalAlpha=Math.min(1,e.life/e.total*2);const x=e.x,y=pointY(e.y);if(e.type==='coin'){c.font='bold 14px sans-serif';c.fillStyle='#ffe281';c.strokeStyle='#42391e';c.lineWidth=3;c.strokeText(`+${e.value}`,x,y-24-t*25);c.fillText(`+${e.value}`,x,y-24-t*25);}else if(e.type==='blast'){c.fillStyle=e.color;c.beginPath();c.arc(x,y,(e.radius||45)*(.2+t*.8),0,Math.PI*2);c.fill();c.fillStyle='#ffe5ae';c.beginPath();c.arc(x,y,(e.radius||45)*(.15+t*.35),0,Math.PI*2);c.fill();}else if(e.type==='slash'){c.strokeStyle='#fff3c0';c.lineWidth=3;c.beginPath();c.moveTo(x-12,y+3);c.lineTo(x+9,y-20);c.stroke();}else{c.strokeStyle=e.color||'#c6dfaa';c.lineWidth=3;c.beginPath();c.ellipse(x,y,10+t*30,5+t*15,0,0,Math.PI*2);c.stroke();}c.restore();}
    if(this.target&&this.pointer){c.strokeStyle=this.target==='meteor'?'#ffb75c':'#a7d9ee';c.fillStyle=this.target==='meteor'?'#ff963522':'#93c6df22';c.setLineDash([7,5]);c.lineWidth=2;c.beginPath();c.ellipse(this.pointer.x,pointY(this.pointer.y),this.target==='meteor'?85:30,this.target==='meteor'?65:18,0,0,Math.PI*2);c.fill();c.stroke();c.setLineDash([]);}
    c.restore();
  }
  holder(c,t,time,selected){const x=t.x,y=pointY(t.y);c.save();c.translate(x,y);c.fillStyle='#3f3517bb';c.strokeStyle=selected?'#fff1ad':'#dac27a';c.lineWidth=selected?3:2;c.beginPath();c.ellipse(0,3,30,16,0,0,Math.PI*2);c.fill();c.stroke();c.fillStyle=selected?'#ffecab':'#e6cc81';c.font='bold 27px sans-serif';c.textAlign='center';c.textBaseline='middle';c.fillText(t.blocked?'⌁':'+',0,0);if(selected){c.strokeStyle='#f0d99466';c.beginPath();c.ellipse(0,3,36+Math.sin(time*4)*2,20,0,0,Math.PI*2);c.stroke();}c.restore();}
  tower(c,t,time){const a=this.assets,x=t.x,y=pointY(t.y),l=t.level;let rendered=false;
    if(this.models){const key={archer:'archers',barracks:'knights',mage:'wizard',artillery:'catapult'}[t.type];const model=this.models[`tower_${key}_lvl${l}`];if(model?.layers){rendered=this.model(c,model,x,y,time);}}
    if(!rendered&&t.type==='archer')rendered=a.entityDraw(c,`archer${l}_torreDef`,'idle',x,y,time);
    if(!rendered&&t.type==='barracks')rendered=a.frame(c,`knights_order_tower_lvl${l}`,x,y);
    if(!rendered){const fallback={archer:`archer_tower_lvl${Math.min(l,3)}_tower`,barracks:`KR1_barracks_tower_lvl${Math.min(l,3)}`,mage:`arcane_wizard_tower_KR1_lvl${Math.min(l,3)}_tower_0001`,artillery:`engineer_tower_lvl${Math.min(l,3)}_tower_0001`}[t.type];a.frame(c,fallback,x,y);}
    c.fillStyle='#10261dcc';c.beginPath();c.roundRect(x-17,y+11,34,11,4);c.fill();c.fillStyle='#e4cb83';for(let i=0;i<l;i++){c.beginPath();c.arc(x+(i-(l-1)/2)*7,y+16,2,0,Math.PI*2);c.fill();}
  }
  decoration(c,d){const image=this.assets.images.get(d.image);if(!image||!d.rect||!d.drawRect)return;const r=d.drawRect;c.drawImage(image,...d.rect,r.x,r.y,r.width,r.height);}
  model(c,m,x,y,time,action=null,facing=1){let ok=false;c.save();c.translate(x,y);c.scale(facing,1);for(const s of m.layers||[]){if(s.hidden)continue;const ox=s.offset?.x||0,oy=-(s.offset?.y||0);c.save();c.translate(ox,oy);c.rotate(-(s.r||0));c.scale(s.spriteScale?.x??1,s.spriteScale?.y??1);c.globalAlpha*=Math.min(1,(s.alpha??255)/255);if(s.prefix)ok=this.assets.entityDraw(c,s.prefix,action||s.name||'idle',0,0,time,1,1,s.anchor||{x:.5,y:.5})||ok;else if(s.name&&!s.name.includes('%'))ok=this.assets.frame(c,s.name,0,0,.5,s.anchor?.x??.5,1-(s.anchor?.y??.5))||ok;c.restore();}c.restore();return ok;}
  enemy(c,e,time){const a=this.assets,x=e.x,y=pointY(e.y),prefix=e.meta.spritePrefix;let ok=this.models?.[e.template]?this.model(c,this.models[e.template],x,y,e.age,e.blocked?'attack':'walk',e.facing):a.entityDraw(c,prefix,e.blocked?'attack':'walk',x,y,e.age,e.facing);if(!ok){const key=e.meta.spritePrefixes?.['1'];if(key)ok=a.entityDraw(c,key,e.blocked?'attack':'walk',x,y,e.age,e.facing);}if(!ok){c.fillStyle=e.boss?'#b65a4c':'#637b54';c.strokeStyle='#222d25';c.lineWidth=2;c.beginPath();c.ellipse(x,y-12,e.boss?23:12,e.boss?30:15,0,0,Math.PI*2);c.fill();c.stroke();c.fillStyle='#e5d1a0';c.font='10px sans-serif';c.textAlign='center';c.fillText(e.name.slice(0,2),x,y-8);}if(e.hp<e.maxHp||e.boss)this.bar(c,x,y-(e.boss?65:38),e.hp/e.maxHp,e.boss?64:26,'#b5d56d');}
  unit(c,u,time){const a=this.assets,x=u.x,y=pointY(u.y);c.fillStyle=u.kind==='hero'?'#4ea8c050':'#20372155';c.beginPath();c.ellipse(x,y,17,7,0,0,Math.PI*2);c.fill();let ok=false;const action=u.moving?'walk':u.attacking?'attack':'idle';if(u.kind==='hero')ok=this.models?.hero_gerald?this.model(c,this.models.hero_gerald,x,y,time,action,u.facing||1):a.entityDraw(c,'hero_gerald',action,x,y,time,u.facing||1);else{const prefix=u.kind==='reinforcement'?'reinforcements_lvl1_1':`knights_order_soldier_lvl${u.level||1}`;ok=a.entityDraw(c,prefix,action,x,y,time,u.facing||1);}if(!ok){c.fillStyle='#4b708c';c.strokeStyle='#263b43';c.lineWidth=2;c.beginPath();c.roundRect(x-7,y-22,14,20,4);c.fill();c.stroke();c.fillStyle='#d4c9a3';c.beginPath();c.arc(x,y-25,6,0,Math.PI*2);c.fill();c.strokeStyle='#b8c4c5';c.beginPath();c.moveTo(x+10,y-8);c.lineTo(x+14,y-27);c.stroke();}if(u.kind==='hero'||u.hp<u.maxHp)this.bar(c,x,y-44,u.hp/u.maxHp,u.kind==='hero'?34:22,u.kind==='hero'?'#81c8df':'#8fc887');}
  bar(c,x,y,ratio,width,color){c.fillStyle='#18251de0';c.fillRect(x-width/2-1,y-1,width+2,5);c.fillStyle=color;c.fillRect(x-width/2,y,Math.max(0,ratio)*width,3);}
}
