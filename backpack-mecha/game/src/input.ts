/** A held accessibility preference must release the edge-triggered skill during cooldown. */
export function overloadRequested(pressed:boolean,automatic:boolean,cooldown:number):boolean {
 return pressed||(automatic&&cooldown<=0);
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
