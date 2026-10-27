/** A held accessibility preference must release the edge-triggered skill during cooldown. */
export function overloadRequested(pressed:boolean,automatic:boolean,cooldown:number):boolean {
 return pressed||(automatic&&cooldown<=0);
}
