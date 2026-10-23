import {Assets,Renderer,json} from './render.js';
import {Game} from './engine.js';
const results=[];
document.querySelector('#run').onclick=async()=>{
 document.querySelector('#run').disabled=true;
 const assets=new Assets(),render=new Renderer(document.querySelector('canvas'),assets);
 try{
  const [data,models,scenery]=await Promise.all([json('data/mechanics.json'),json('data/render-models.json'),json('data/scenery.json'),assets.init()]);
  render.models=models.models;assets.scenery=scenery;
  for(const level of data.levels){
   document.querySelector('#status').textContent=`正在校验 ${level.id} / 18：${level.name}`;
   const start=performance.now();
   try{
    const game=new Game(level,data.enemies,{...data,seed:703+level.id});
    await assets.stage({...level,waves:game.campaignWaves},data);
    for(const slot of game.towers)if(!slot.blocked&&!slot.type)game.build(slot.id,'archer');
    game.callWave();for(let i=0;i<900;i++)game.update(1/30);
    render.render(game);
    results.push({level:level.id,status:'pass',images:assets.images.size,frames:assets.frames.size,enemiesVisible:game.enemies.length,waves:game.totalWaves,phase:game.phase,errors:game.errors,ms:Math.round(performance.now()-start)});
   }catch(e){results.push({level:level.id,status:'fail',error:String(e.stack||e)});}
   document.querySelector('#report').textContent=JSON.stringify(results,null,2);
   await new Promise(requestAnimationFrame);
  }
  document.querySelector('#status').textContent=`完成：${results.filter(r=>r.status==='pass').length} / 18 通过`;
 }catch(e){document.querySelector('#status').textContent=`校验失败：${e.message}`;}
};
