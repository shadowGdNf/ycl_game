/** The game only needs positive rectangles with one radius. Works before roundRect. */
export function roundRect(ctx:CanvasRenderingContext2D|OffscreenCanvasRenderingContext2D,x:number,y:number,w:number,h:number,r:number):void{
  if(typeof ctx.roundRect==='function'){ctx.roundRect(x,y,w,h,r);return;}
  const radius=Math.max(0,Math.min(r,w/2,h/2));
  ctx.moveTo(x+radius,y);ctx.lineTo(x+w-radius,y);
  ctx.quadraticCurveTo(x+w,y,x+w,y+radius);ctx.lineTo(x+w,y+h-radius);
  ctx.quadraticCurveTo(x+w,y+h,x+w-radius,y+h);ctx.lineTo(x+radius,y+h);
  ctx.quadraticCurveTo(x,y+h,x,y+h-radius);ctx.lineTo(x,y+radius);
  ctx.quadraticCurveTo(x,y,x+radius,y);ctx.closePath();
}
