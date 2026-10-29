/** Scrap per unit of enemy cost. Later waves never dilute an individual kill. */
export const scrapPerCost=(wave:number):number=>.4+.12*(Math.max(1,Math.min(12,Math.floor(wave)||1))-1);
export const waveScrapLimit=(wave:number,budget:number):number=>budget*scrapPerCost(wave);
