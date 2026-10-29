/** Raster atlas access. Atlas rectangles come from alpha inspection, not grid guesses. */
export interface SpriteRect {atlas:string;x:number;y:number;w:number;h:number}
interface Manifest {version:number;atlases:Record<string,string>;sprites:Record<string,SpriteRect>}
export interface ArtProgress {loaded:number;total:number}
const REQUIRED=['actors','modules','enemies','cargo'];
export class Art {
  private images=new Map<string,HTMLImageElement>();
  private manifest:Manifest|null=null;
  private pending:Promise<void>|null=null;
  private environmentPending=false;
  private flashes=new Map<string,OffscreenCanvas|HTMLCanvasElement>();
  private timeoutMs:number;
  constructor(timeoutMs=15000){this.timeoutMs=timeoutMs;}
  get ready():boolean{return this.manifest!==null&&REQUIRED.every(key=>this.images.has(key));}
  load(onProgress?:(progress:ArtProgress)=>void):Promise<void>{
    if(this.pending)return this.pending;
    this.pending=this.fetchAssets(onProgress).finally(()=>{this.pending=null;});
    return this.pending;
  }
  private async retry<T>(operation:()=>Promise<T>):Promise<T>{
    try{return await operation();}catch{return operation();}
  }
  private async fetchAssets(onProgress?:(progress:ArtProgress)=>void):Promise<void>{
    if(!this.manifest)this.manifest=await this.retry(async()=>{
      const controller=new AbortController(),timer=setTimeout(()=>controller.abort(),this.timeoutMs);
      try{
        const response=await fetch(new URL('../assets/atlas-manifest.json',import.meta.url),{signal:controller.signal});
        if(!response.ok)throw new Error(`Atlas manifest failed: ${response.status}`);
        const data=await response.json() as Manifest;
        if(!data.sprites||REQUIRED.some(key=>!data.atlases?.[key]))throw new Error('Incomplete atlas manifest');
        return data;
      }finally{clearTimeout(timer);}
    });
    const report=()=>onProgress?.({loaded:REQUIRED.filter(key=>this.images.has(key)).length,total:REQUIRED.length});
    report();
    // Retain successful images across retries; settle every request before enabling retry.
    const results=await Promise.allSettled(REQUIRED.map(async name=>{
      if(this.images.has(name))return;
      this.images.set(name,await this.retry(()=>this.loadImage(this.manifest!.atlases[name])));report();
    }));
    const failed=results.find(result=>result.status==='rejected');
    if(failed?.status==='rejected')throw failed.reason;
  }
  private loadImage(path:string):Promise<HTMLImageElement>{
    return new Promise((resolve,reject)=>{
      const img=new Image();img.decoding='async';
      const finish=(error?:Error)=>{
        clearTimeout(timer);img.onload=null;img.onerror=null;
        if(error){img.src='';reject(error);}else resolve(img);
      };
      const timer=setTimeout(()=>finish(new Error(`Artwork timed out: ${path}`)),this.timeoutMs);
      img.onload=()=>finish();img.onerror=()=>finish(new Error(`Cannot load artwork: ${path}`));
      img.src=new URL(`../assets/${path}`,import.meta.url).href;
    });
  }
  /** Decorative ground loading never blocks the first playable frame. */
  prepareEnvironment():void{
    if(this.environmentPending||!this.manifest)return;this.environmentPending=true;
    void this.retry(()=>this.loadImage(this.manifest!.atlases.environment))
      .then(img=>{this.images.set('environment',img);}).catch(()=>{/* Solid floor remains playable. */});
  }
  has(key:string):boolean{return Boolean(this.manifest?.sprites[key]);}
  draw(ctx:CanvasRenderingContext2D,key:string,x:number,y:number,w:number,h:number,angle=0,opacity=1,flip=false):boolean{
    const sprite=this.manifest?.sprites[key];if(!sprite)return false;
    const im=this.images.get(sprite.atlas);if(!im)return false;
    const fit=Math.min(w/sprite.w,h/sprite.h);const dw=sprite.w*fit,dh=sprite.h*fit;
    ctx.save();ctx.translate(x,y);ctx.rotate(angle);if(flip)ctx.scale(1,-1);ctx.globalAlpha*=opacity;
    ctx.drawImage(im,sprite.x,sprite.y,sprite.w,sprite.h,-dw/2,-dh/2,dw,dh);ctx.restore();return true;
  }
  /** Bounded cached silhouette; no per-frame pixel reads or mask allocations. */
  flash(ctx:CanvasRenderingContext2D,key:string,x:number,y:number,w:number,h:number,opacity:number,color='#fff1cf'):void{
    const s=this.manifest?.sprites[key],im=s&&this.images.get(s.atlas);if(!s||!im||opacity<=0)return;
    const cacheKey=`${key}/${color}`;let mask=this.flashes.get(cacheKey);
    if(!mask){
      const fit=Math.min(1,256/Math.max(s.w,s.h)),mw=Math.ceil(s.w*fit),mh=Math.ceil(s.h*fit);
      mask=typeof OffscreenCanvas==='function'?new OffscreenCanvas(mw,mh):document.createElement('canvas');mask.width=mw;mask.height=mh;
      const c=mask.getContext('2d') as CanvasRenderingContext2D|OffscreenCanvasRenderingContext2D|null;if(!c)return;
      c.drawImage(im,s.x,s.y,s.w,s.h,0,0,mw,mh);c.globalCompositeOperation='source-in';c.fillStyle=color;c.fillRect(0,0,mw,mh);
      if(this.flashes.size>=40)this.flashes.delete(this.flashes.keys().next().value!);this.flashes.set(cacheKey,mask);
    }
    const fit=Math.min(w/s.w,h/s.h);ctx.save();ctx.globalAlpha*=opacity;ctx.drawImage(mask,x-s.w*fit/2,y-s.h*fit/2,s.w*fit,s.h*fit);ctx.restore();
  }
  tile(ctx:CanvasRenderingContext2D,key:string,x:number,y:number,w:number,h:number):void{
    const s=this.manifest?.sprites[key];if(!s)return;const im=this.images.get(s.atlas);if(!im)return;
    ctx.drawImage(im,s.x,s.y,s.w,s.h,x,y,w,h);
  }
  /** A normalized portion of an existing sprite, aligned to its full fitted rectangle. */
  part(ctx:CanvasRenderingContext2D,key:string,x:number,y:number,w:number,h:number,u:number,v:number,uw:number,vh:number):void{
    const s=this.manifest?.sprites[key];if(!s)return;const im=this.images.get(s.atlas);if(!im)return;
    const fit=Math.min(w/s.w,h/s.h),dw=s.w*fit,dh=s.h*fit;
    ctx.drawImage(im,s.x+s.w*u,s.y+s.h*v,s.w*uw,s.h*vh,x-dw/2+dw*u,y-dh/2+dh*v,dw*uw,dh*vh);
  }
}
