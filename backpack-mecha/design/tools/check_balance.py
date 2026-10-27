from pathlib import Path
import sys, json, math
from collections import Counter
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'source'))
from design_data import MODULES, BUILDS, BOSSES, WAVES, DEMO_IDS, CHASSIS, ENEMIES, PROTOCOLS, EVENTS
M={m['id']:m for m in MODULES}

def rotations(shape):
    pts={(x,y) for y,row in enumerate(shape) for x,c in enumerate(row) if c=='#'}
    out=[]
    for _ in range(4):
        dx=min(x for x,y in pts);dy=min(y for x,y in pts)
        pts={(x-dx,y-dy) for x,y in pts}
        p=tuple(sorted(pts))
        if p not in out: out.append(p)
        pts={(-y,x) for x,y in pts}
    return out

def near(a,b):
    return any(abs(x-u)+abs(y-v)==1 for x,y in a for u,v in b)

def pack(build, locked=()):
    items=dict(build['items']); links=build['links']; options={}
    blocked=sum(1<<(y*5+x) for x,y in locked)
    for key,mid in items.items():
        options[key]=[]
        for r,shape in enumerate(rotations(M[mid]['shape'])):
            for y in range(5-max(b for a,b in shape)):
                for x in range(5-max(a for a,b in shape)):
                    pts=tuple((x+a,y+b) for a,b in shape)
                    mask=sum(1<<(b*5+a) for a,b in pts)
                    if not mask&blocked: options[key].append((mask,pts,r))
    nodes=0
    def dfs(placed,used):
        nonlocal nodes
        nodes+=1
        if nodes>1500000: raise RuntimeError('Packing search exhausted')
        if len(placed)==len(items):return placed
        choices=[]
        for key in items:
            if key in placed:continue
            opts=[]
            neighbors=[b for a,b in links.items() if a==key]+[a for a,b in links.items() if b==key]
            for option in options[key]:
                mask,pts,r=option
                if mask&used:continue
                if all(n not in placed or near(pts,placed[n][1]) for n in neighbors):opts.append(option)
            if not opts:return None
            choices.append((len(opts),-len(options[key][0][1]),key,opts))
        _,_,key,opts=min(choices)
        for option in opts:
            answer=dfs({**placed,key:option},used|option[0])
            if answer:return answer
        return None
    answer=dfs({},blocked)
    assert answer,build['name']+' cannot fit'
    return {k:dict(module=items[k],cells=list(v[1]),rotation=v[2]) for k,v in answer.items()},nodes

def tier_cost(mid,tier):
    p=M[mid]['price']
    return p+(math.ceil(.75*p) if tier>=2 else 0)+(math.ceil(1.25*p) if tier>=3 else 0)

assert len(M)==len(MODULES)==36
assert len(DEMO_IDS)==len(set(DEMO_IDS))==24
assert Counter(M[x]['kind'] for x in DEMO_IDS)=={'weapon':8,'support':8,'utility':8}
assert len(WAVES)==12 and sum(w['kind']=='normal' for w in WAVES)==9
assert len(BOSSES)==6 and all(sum(b['act']==a for b in BOSSES)==2 for a in [1,2,3])
result={'status':'passed','scope':'Static design consistency only; no executable gameplay or playtest validation.','builds':[]}
for b in BUILDS:
    ids=[v for k,v in b['items']];mapping=dict(b['items'])
    assert sum(M[mid]['kind']=='weapon' for mid in ids)<=3
    counts=Counter(ids)
    assert all(v<=(2 if M[mid]['kind']=='weapon' else 1) for mid,v in counts.items())
    assert max(Counter(b['links'].values()).values(),default=0)<=2
    for support,weapon in b['links'].items():
        sm,wm=M[mapping[support]],M[mapping[weapon]]
        assert sm['kind']=='support' and wm['kind']=='weapon'
        assert '全部' in sm['tags'] or set(sm['tags'])&set(wm['tags'])
    assert sum(M[mid]['kind']=='support' for mid in ids)==len(b['links'])
    capacity=14+(3 if 'U01' in ids else 0)
    power=sum(M[mid]['power'] for mid in ids)
    assert power<=capacity,(b['name'],power,capacity)
    layout,nodes=pack(b)
    tier={key:(3 if M[mid]['kind']=='weapon' else 2 if M[mid]['kind']=='support' or mid=='U01' else 1) for key,mid in b['items']}
    cost=sum(tier_cost(mid,tier[key]) for key,mid in b['items'])
    assert cost<=702,(b['name'],'too expensive',cost)
    result['builds'].append(dict(name=b['name'],cells=sum(len(x['cells']) for x in layout.values()),power=power,capacity=capacity,cost_before_free_rewards=cost,tiers=tier,layout=layout,search_nodes=nodes))
starter=dict(name='初始装配',items=[('a','W01'),('b','S01')],links={'b':'a'})
result['starter_layout']=pack(starter,locked=[(0,0),(4,0),(0,4),(4,4)])[0]
result['economy']={
 'initial':40,'normal_base':sum(w['base'] for w in WAVES if w['kind']=='normal'),
 'kill_bonus_max':sum(w['bonus'] for w in WAVES),'boss_rewards':sum(w['base'] for w in WAVES if w['kind']=='boss'),
 'total_max':40+sum(w['base']+w['bonus'] for w in WAVES),
 'expected_70pct_bonus':40+sum(w['base']+.7*w['bonus'] for w in WAVES),
 'spendable_before_final_boss':40+sum(w['base']+.7*w['bonus'] for w in WAVES[:-1])}
normal_sec=sum(w['duration'] for w in WAVES if w['kind']=='normal')
boss_sec=sum(w['duration'] for w in WAVES if w['kind']=='boss')
result['run_minutes']={'normal_combat':normal_sec/60,'boss_target':boss_sec/60,'planning_11x20s':220/60,'start_end_45s':.75,'nominal_total':(normal_sec+boss_sec+220+45)/60}
result['demo_run_minutes']=(sum(w['duration'] for w in WAVES[:8])+7*20+45)/60
result['boss_ttk']=[]
for a,dps,u in [(1,35,.8),(2,65,.75),(3,110,.7)]:
    boss=next(b for b in BOSSES if b['act']==a)
    ttl=boss['hp']*(1+boss['armor']/100)/(dps*u)
    result['boss_ttk'].append(dict(act=a,hp=boss['hp'],armor=boss['armor'],target_dummy_dps=dps,uptime=u,estimated_seconds=round(ttl,2),excludes='mechanic-specific damage bonuses, guard, stagger, summons'))
assert 13<=result['run_minutes']['nominal_total']<=18
assert result['economy']['spendable_before_final_boss']==702
(ROOT/'qa'/'balance-check.json').write_text(json.dumps(result,ensure_ascii=False,indent=2))
export=dict(version='0.1',status='design_proposal_not_playtested',modules=MODULES,waves=WAVES,bosses=BOSSES,builds=BUILDS,chassis_columns=['name','unlock','hp_shield','speed','armor','dash','trait'],chassis=CHASSIS,enemy_columns=['id','name','first_act','hp','armor','speed','damage','spawn_cost','behavior'],enemies=ENEMIES,protocol_columns=['id','name','effect'],protocols=PROTOCOLS,event_columns=['name','choices','constraint'],events=EVENTS,demo_module_ids=DEMO_IDS,checks=result)
(ROOT/'balance-v0.1.json').write_text(json.dumps(export,ensure_ascii=False,indent=2))
print(json.dumps({'status':'passed','builds':[{k:b[k] for k in ('name','cells','power','capacity','cost_before_free_rewards')} for b in result['builds']],'economy':result['economy'],'run_minutes':result['run_minutes'],'boss_ttk':result['boss_ttk']},ensure_ascii=False,indent=2))
