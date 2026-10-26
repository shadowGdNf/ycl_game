export class CandyAudio {
  enabled = true;
  private context: AudioContext | null = null;
  unlock() {
    if (!this.enabled) return;
    try {
      this.context ??= new AudioContext();
      if (this.context.state === 'suspended') void this.context.resume().catch(() => {});
    } catch { /* Sound is optional; all gameplay remains visible. */ }
  }
  private tone(freq:number, time:number, length:number, volume:number, type:OscillatorType='sine') {
    const ctx=this.context;
    if (!ctx || !this.enabled || ctx.state!=='running') return;
    const osc=ctx.createOscillator(), gain=ctx.createGain();
    osc.type=type; osc.frequency.setValueAtTime(freq,ctx.currentTime+time);
    osc.frequency.exponentialRampToValueAtTime(freq*0.8,ctx.currentTime+time+length);
    gain.gain.setValueAtTime(0.001,ctx.currentTime+time);
    gain.gain.exponentialRampToValueAtTime(volume,ctx.currentTime+time+0.008);
    gain.gain.exponentialRampToValueAtTime(0.001,ctx.currentTime+time+length);
    osc.connect(gain); gain.connect(ctx.destination);
    osc.start(ctx.currentTime+time); osc.stop(ctx.currentTime+time+length+0.02);
  }
  tap() { this.tone(560,0,.09,.055); }
  flow(count:number,completions:number) {
    for(let i=0;i<Math.min(count,7);i++) this.tone(380+55*i,i*.045,.12,.035);
    for(let i=0;i<completions;i++) this.tone(660*Math.pow(1.26,i),.18+i*.09,.25,.06,'triangle');
  }
  win() { [523.25,659.25,783.99,1046.5].forEach((n,i)=>this.tone(n,i*.11,.35,.07,'triangle')); }
  lose() { this.tone(260,0,.24,.06); this.tone(190,.18,.32,.05); }
}
