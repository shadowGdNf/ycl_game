"""Original procedural score plus event-synchronised synthesised game sounds. No external media."""
import json, math, wave, os
from pathlib import Path
import numpy as np

work=Path(os.environ.get('MECHA_VIDEO_WORK','/tmp/mecha-trailer-work'))
report=json.loads((work/'capture-report.json').read_text())
rate=48000; duration=report['duration']; size=rate*duration
mix=np.zeros((size,2),np.float32); rng=np.random.default_rng(1942280)

def add(at,sound,gain=1,pan=0):
    start=int(at*rate)
    if start<0 or start>=size:return
    n=min(len(sound),size-start)
    mix[start:start+n,0]+=sound[:n]*gain*math.sqrt((1-pan)/2)
    mix[start:start+n,1]+=sound[:n]*gain*math.sqrt((1+pan)/2)

def tone(freq,length,kind='sine',slide=1):
    t=np.arange(int(length*rate))/rate
    phase=2*np.pi*freq*(t+(slide-1)*t*t/(2*length))
    if kind=='saw': sig=sum(np.sin(phase*k)/k for k in range(1,6))*.55
    elif kind=='square':sig=sum(np.sin(phase*k)/k for k in (1,3,5,7))*.8
    elif kind=='triangle':sig=np.arcsin(np.sin(phase))*2/np.pi
    else:sig=np.sin(phase)
    env=np.minimum(1,t/.008)*np.exp(-t/max(.015,length/4))*np.minimum(1,(length-t)/.025)
    return (sig*env).astype(np.float32)

def noise(length,decay=12):
    t=np.arange(int(rate*length))/rate
    n=rng.normal(0,1,len(t));n=np.r_[n[0],np.diff(n)]*.35
    return (n*np.exp(-t*decay)*np.minimum(1,t/.002)).astype(np.float32)

def section_gain(t):
    if 5<=t<8:return .68
    if 8<=t<18:return .62
    if 52<=t<70:return 1.18
    if t>=70:return .75
    return .92

# 120 BPM, A minor electronic pulse. Four-bar harmonic movement.
roots=[55,49,43.654,41.203]
for beat in range(duration*2):
    at=beat*.5;g=section_gain(at);root=roots[(beat//8)%4]
    if at<74:
        add(at,tone(133,.36,'sine',.23),.34*g)
        add(at,noise(.035,70),.025*g)
        if beat%2==1:
            add(at,noise(.17,23),.17*g);add(at,tone(185,.12,'triangle',.6),.1*g)
        for off in [0,.25]:add(at+off,noise(.045,65),.043*g,(-.3 if off==0 else .3))
        for off,ratio in [(0,1),(.25,1 if beat%4!=3 else 1.5)]:
            add(at+off,tone(root*ratio,.23,'saw'),.13*g)
    if 18<=at<70:
        arp=[1,1.5,2,2.375,2,1.5,1.1875,1.5]
        for step in range(2):
            f=root*4*arp[(beat*2+step)%8]
            sig=tone(f,.29,'triangle');pos=(-.45 if step==0 else .45)
            add(at+step*.25,sig,.048*g,pos);add(at+step*.25+.375,sig,.018*g,-pos)
    if beat%8==0:
        t=np.arange(int(rate*3.8))/rate;env=np.minimum(1,t/.4)*np.minimum(1,(3.8-t)/1.4)
        chord=sum(np.sin(2*np.pi*root*2*r*t) for r in [1,1.1892,1.4983])/3
        add(at,(chord*env).astype(np.float32),.09*g,-.12)

for at in [0,5,8,18,24,30,36,40,44,48,52,58,64,70]:
    add(at,tone(65,.6,'sine',.3),.3)
    add(at,noise(.5,10),.06,.3)
for at in [17,51,63,69]:
    t=np.arange(rate)/rate
    riser=np.sin(2*np.pi*(130*t+600*t*t))*t*t*.04+noise(1,0)*t*t*.07
    add(at,riser.astype(np.float32),1)

weapon={'W01':(135,.06,'square',.08),'W02':(75,.12,'saw',.10),'W03':(650,.09,'sine',.075),'W04':(420,.12,'triangle',.09),'W05':(94,.06,'saw',.06),'W06':(190,.14,'triangle',.09),'W08':(55,.16,'triangle',.14),'W11':(320,.05,'sine',.055),'W13':(180,.04,'square',.045),'W14':(920,.18,'saw',.07),'W15':(240,.2,'sine',.08),'W17':(65,.23,'saw',.11),'W18':(510,.06,'triangle',.055)}
presets={'hit':(180,.07,'triangle',.045,.35),'kill':(180,.08,'triangle',.05,.7),'explosion':(65,.25,'saw',.13,.35),'overload':(240,.35,'triangle',.17,3),'dash':(180,.12,'saw',.1,2.1),'warning':(520,.18,'triangle',.1,.7),'phase':(240,.4,'square',.1,1.6),'enemy-shot':(140,.1,'saw',.04,.5),'slam':(65,.24,'triangle',.13,.3),'beam':(95,.3,'saw',.12,2.3),'pulse':(280,.28,'triangle',.1,.3),'charge':(80,.3,'saw',.12,3),'pickup':(980,.11,'sine',.025,1.5),'connect':(630,.16,'sine',.15,1.5),'click':(440,.05,'sine',.13,1.2),'hurt':(73,.15,'saw',.07,.7),'shield':(740,.2,'sine',.05,.4),'heal':(680,.16,'sine',.08,1.4)}
last={};used=0
for event in report['soundEvents']:
    typ=event['type'];at=event['time'];key=typ+event['source'] if typ=='fire' else typ
    if at-last.get(key,-100)<(.12 if typ=='fire' else .09):continue
    last[key]=at
    if typ=='fire':f,l,k,v=weapon.get(event['source'][:3],weapon['W01']);slide=.55
    elif typ in presets:f,l,k,v,slide=presets[typ]
    else:continue
    add(at,tone(f,l,k,slide),v);used+=1

# Gentle fade-in/out; peak protection before standards-based loudness normalisation at mux.
mix[:int(.08*rate)]*=np.linspace(0,1,int(.08*rate))[:,None]
mix[int((duration-1.6)*rate):]*=np.linspace(1,0,int(1.6*rate))[:,None]
peak=float(np.max(np.abs(mix)));mix*=.85/max(peak,.85)
with wave.open(str(work/'score.wav'),'wb') as f:
    f.setnchannels(2);f.setsampwidth(2);f.setframerate(rate);f.writeframes((np.clip(mix,-1,1)*32767).astype('<i2').tobytes())
print(json.dumps({'seconds':duration,'sampleRate':rate,'synchronisedSoundEvents':used,'rawPeak':peak,'originalMusic':True}))
