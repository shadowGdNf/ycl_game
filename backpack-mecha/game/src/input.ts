import type {Point} from './types.ts';

/** A held accessibility preference must release the edge-triggered skill during cooldown. */
export function overloadRequested(pressed:boolean,automatic:boolean,cooldown:number):boolean {
 return pressed||(automatic&&cooldown<=0);
}

/** Mouse stores its cursor position; touch keeps its anchored analog stick. */
export class MovementStick {
 state:{id:number;pointerType:string;x:number;y:number;dx:number;dy:number}|null=null;
 begin(id:number,pointerType:string,button:number,x:number,y:number,moveSide:boolean):boolean {
  if(this.state||button!==0||pointerType!=='mouse'&&!moveSide)return false;
  this.state={id,pointerType,x,y,dx:0,dy:0};return true;
 }
 move(id:number,x:number,y:number,buttons:number):boolean {
  const stick=this.state;if(!stick||stick.id!==id)return false;
  // Includes release outside the page and left-up while another mouse button stays down.
  if(stick.pointerType==='mouse'&&(buttons&1)===0){this.clear();return true;}
  if(stick.pointerType==='mouse'){
   stick.x=x;stick.y=y;return true;
  }
  const dx=x-stick.x,dy=y-stick.y,length=Math.max(42,Math.hypot(dx,dy));
  stick.dx=dx/length;stick.dy=dy/length;return true;
 }
 aimMouse(player:Point,target:Point):void {
  const stick=this.state;if(stick?.pointerType!=='mouse')return;
  const dx=target.x-player.x,dy=target.y-player.y,distance=Math.hypot(dx,dy);
  // Recompute from the current player/camera each tick, including a press without any drag.
  // Ease near the cursor and stop over the rig instead of oscillating around it.
  const length=Math.max(24,distance);
  stick.dx=distance<=8?0:dx/length;stick.dy=distance<=8?0:dy/length;
 }
 end(id:number):boolean {if(this.state?.id!==id)return false;this.clear();return true;}
 clear():void {this.state=null;}
}

/** A second finger releasing the movement stick must not cancel a focus gesture. */
export class FocusGesture {
 private press:{id:number;x:number;y:number;at:number}|null=null;
 begin(id:number,x:number,y:number,at:number):void {if(!this.press)this.press={id,x,y,at};}
 move(id:number,x:number,y:number):void {if(this.press?.id===id&&Math.hypot(x-this.press.x,y-this.press.y)>12)this.press=null;}
 end(id:number):void {if(this.press?.id===id)this.press=null;}
 clear():void {this.press=null;}
 take(now:number):{x:number;y:number}|undefined {
  if(!this.press||now-this.press.at<350)return;
  const {x,y}=this.press;this.press=null;return {x,y};
 }
}
