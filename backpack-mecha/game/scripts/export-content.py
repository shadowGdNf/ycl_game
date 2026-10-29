from pathlib import Path
import json
root=Path(__file__).resolve().parents[1]
data=json.loads((root/'assets'/'source'/'design-baseline.json').read_text())
names=['Rivet gun','Scatter cannon','Water lance','Arc coil','Flamethrower','Oil lobber','Rail cannon','Shock hammer','Saw disc','Missile rack','Drone hive','Cryo nozzle','Amplifier','Rapid-fire gear','Split lens','Ricochet plate','Conductive contact','Fuel catalyst','Armor wedge','Energy rectifier','Blast fuse','Command relay','Charge spring','Cryo bearing','Power battery','Shield generator','Repair arm','Magnet','Targeting scope','Composite armor','Thrusters','Emergency capacitor','Recovery protocol','Ammo recycler','Decoy beacon','Insurance fuse']
en=['8 damage every 0.40s. Straight projectile.','5 pellets × 5 damage every 1s; 40° spread.','4 damage every 0.60s; applies Wet for 3s.','10 damage every 0.70s; chains twice for 6 damage. Wet adds a jump.','2 damage every 0.20s in a 90° cone; applies Burn every second hit.','6 area damage every 1.50s; applies Oil for 4s.','55 damage every 2s; pierces three enemies at 100%, 75%, 56.25%.','24 damage every 1s in a 120° arc; knockback and 20 boss stagger.','6 damage every 0.25s; hits up to six enemies around you.','32 area damage every 1.40s; one hit per target.','Two drones each deal 4 damage every 0.50s.','5 damage every 0.50s; applies Chill.','Direct damage +20 / 27 / 36%.','Attack speed +15 / 20 / 27%.','One extra single shot; damage per shot ×65 / 75 / 85%.','Two wall bounces; damage after each bounce ×65 / 75 / 85%.','Wet electric bonus becomes 40 / 45 / 52%; one extra jump.','Oil ignition base damage becomes 30 / 36 / 42, radius 100.','Direct hits ignore 10 / 14 / 18 armor.','Direct critical hits restore 2 / 3 / 4 shield, at most once per second.','Explosive hits on burning targets add 8 / 11 / 14 damage.','One extra drone; drone damage ×90 / 100 / 110%.','Melee range +20 / 27 / 36%; first attack after dash deals +40 / 55 / 70%.','Chill slows 2% more per stack; freeze +0.2 / 0.3 / 0.4s.','Power capacity +2 / 3 / 4.','Shield capacity +25 / 34 / 45; regeneration +1 / 1.5 / 2 per second.','Recover 1 / 1.4 / 1.8 HP every 10s, with a per-wave cap.','Pickup radius +70 / 95 / 126; pickups reduce dash cooldown.','Critical chance +10 / 14 / 18%.','Armor +10 / 14 / 18; movement speed −3%.','Move speed +12 / 16 / 22%; dash cooldown −1 / 1.3 / 1.8s.','On shield break, deal 20 / 27 / 36 electric damage; 8s cooldown.','Elemental kills restore 2 / 3 / 4 shield, 0.5s cooldown.','Every 6 / 5 / 4 attacks adds one free attack. No recursion.','Dashing leaves a decoy for 3 / 4 / 5s; 10s cooldown.','Once per run: survive a lethal hit with 15 / 20 / 25 HP.']
values=[[],[],[],[],[],[],[],[],[],[],[],[],[.2,.27,.36],[.15,.2,.27],[.65,.75,.85],[.65,.75,.85],[.4,.45,.52],[30,36,42],[10,14,18],[2,3,4],[8,11,14],[.9,1,1.1],[.2,.27,.36],[.2,.3,.4],[2,3,4],[25,34,45],[1,1.4,1.8],[70,95,126],[.1,.14,.18],[10,14,18],[.12,.16,.22],[20,27,36],[2,3,4],[6,5,4],[3,4,5],[15,20,25]]
ranges=[400,240,360,320,160,380,620,90,72,500,450,300]
attacks=['bullet','scatter','water','arc','flame','oil','rail','melee','saw','missile','drone','ice']
colors=['#F2C47B','#ECAA72','#70CDE3','#56E3CC','#F99759','#A5B459','#F6DB98','#F9B574','#B8CDD3','#F2A16E','#7AD8C8','#A2DEEF']
mods=[]
for i,m in enumerate(data['modules']):
 m={**m,'en':names[i],'effectEn':en[i],'values':values[i],'color':colors[i] if i<12 else '#63C8BC' if i<24 else '#B6BFCC'}
 if i<12:m.update(range=ranges[i],attack=attacks[i])
 mods.append(m)
chassis=[]
for i,(id,nameen,hp,shield,speed,armor,dash,traiten) in enumerate([('scavenger','Scavenger',100,20,210,0,6,'Pickup radius +30. A versatile salvage rig.'),('bulwark','Bulwark',130,30,180,10,8,'Heavy armor and shields. Slower movement.'),('kestrel','Kestrel',80,15,245,0,5,'Fast movement and short dash cooldown.'),('hive','Hive',90,20,200,0,6,'Drone damage +15%; other direct damage −10%.')]):
 r=data['chassis'][i];chassis.append(dict(id=id,name=r[0],en=nameen,hp=hp,shield=shield,speed=speed,armor=armor,dash=dash,trait=r[6],traitEn=traiten,unlock=r[1]))
enames=['Scrap mite','Needle runner','Heavy hauler','Pin sentry','Volatile cell','Repair orb','Shield guard','Burrow drill','Cable spider','Split crate','Pulse caster','Street sweeper']
behaviors=['chase','runner','tank','ranged','suicide','healer','shield','burrow','tether','split','pulse','charger']
enemies=[dict(id=r[0],name=r[1],en=enames[i],act=r[2],hp=r[3],armor=r[4],speed=r[5],damage=r[6],cost=r[7],behavior=behaviors[i],radius=[13,11,22,16,14,16,20,17,17,20,19,28][i]) for i,r in enumerate(data['enemies'])]
enemies+=json.loads((root/'assets'/'source'/'enemies-dev10.json').read_text())
bnames=['The Compactor','Magnet Crane','Furnace Crab','Storm Twins','Recycler Zero','Orbital Carrier']
bosses=[{k:v for k,v in dict(**b,en=bnames[i]).items() if k in ['id','name','en','act','hp','armor','radius','speed','attacks','phases','counter']} for i,b in enumerate(data['bosses'])]
# Keep the original design baseline intact; the live boss guide follows dev.9 choreography.
boss_guide=json.loads((root/'assets'/'source'/'boss-guide-dev9.json').read_text())
bosses=[{**b,**boss_guide.get(b['id'],{})} for b in bosses]
pnames=['Conductive loop','Ember recovery','Precision calibration','Impact bracing','Coordinated command','Kinetic recovery','Emergency power','Safe recovery','Insulated cutter']
pdescs=['Wet lasts 2s longer. Electric first hit on a wet target deals +10%.','Oil explosions restore 1 HP on kills (max 10 per wave), +15% damage to bosses.','Direct damage +15% beyond 250 range, −10% within 120.','Shield capacity +20; dash cooldown +0.5s.','Drones deal +20% damage to the selected target.','After dashing, ballistic attack speed +20% for 3s.','Below 35% HP: attack speed +20%; first crossing per wave restores 15 shield.','Recover 8 HP after a normal wave, or 10 extra after a boss.','Direct damage +15% against chilled or frozen targets.']
ptags=[['电'],['火','油'],['实弹'],[],['召唤'],['实弹'],[],[],['冰']]
protocols=[dict(id=p[0],name=p[1],en=pnames[i],effect=p[2],effectEn=pdescs[i],tags=ptags[i]) for i,p in enumerate(data['protocols'])]
evnames=['Scrap exchange','Dangerous battery','Old workbench','Rescue signal','Dismantler','Sealed shipment','Repair station','Freight shortcut']
eventen=['Pay 24 scrap for a choice of uncommon modules, or leave.','Lose 15 HP for 35 scrap, or leave.','Upgrade one module to tier II for free, or take 20 scrap.','Face an extra elite next wave for an uncommon module reward.','Sell a module for 75% value, or pay 12 scrap to heal 20 HP.','Guarantee compatible support in the next shop, or take 12 scrap.','Repair 25 HP, or gain 15 temporary shield next wave.','Next wave gets 15% more enemies; gain 30 extra scrap.']
events=[dict(id=f'EV{i+1:02}',name=e[0],en=evnames[i],description=e[1],descriptionEn=eventen[i]) for i,e in enumerate(data['events'])]
waves=[{k:v for k,v in w.items() if k in ['n','act','kind','duration','budget','base','bonus']} for w in data['waves']]
events[0].update(description='支付24碎片，从三件进阶型号中选择一件，稀有度随关卡提升；或离开。',descriptionEn='Pay 24 scrap to choose from three advanced designs with progress-scaled rarity, or leave.')
events[3].update(description='下一战额外出现1只精英；胜利后从三件进阶型号中选择一件，稀有度随关卡提升。',descriptionEn='Face an extra elite next wave for advanced salvage with progress-scaled rarity.')
content=dict(modules=mods,chassis=chassis,enemies=enemies,bosses=bosses,protocols=protocols,events=events,waves=waves,demoIds=data['demo_module_ids'])
(root/'assets'/'content.json').write_text(json.dumps(content,ensure_ascii=False,indent=2))
lines=["// Generated from the design baseline by scripts/export-content.py. No description parsing at runtime.","import type {ModuleDef,ChassisDef,EnemyDef,BossDef,ProtocolDef,EventDef,WaveDef,Lang} from './types.ts';"]
for var,key,type_ in [('MODULES','modules','ModuleDef'),('CHASSIS','chassis','ChassisDef'),('ENEMIES','enemies','EnemyDef'),('BOSSES','bosses','BossDef'),('PROTOCOLS','protocols','ProtocolDef'),('EVENTS','events','EventDef'),('WAVES','waves','WaveDef')]:
 lines.append(f'export const {var}:{type_}[]='+json.dumps(content[key],ensure_ascii=False)+';')
 singular={'MODULES':'MODULE','CHASSIS':'CHASSIS','ENEMIES':'ENEMY','BOSSES':'BOSS','PROTOCOLS':'PROTOCOL','EVENTS':'EVENT'}
 if var in singular:lines.append(f'export const {singular[var]}_BY_ID:Record<string,{type_}>=Object.fromEntries({var}.map(v=>[v.id,v]));')
lines.append('export const DEMO_IDS:string[]='+json.dumps(data['demo_module_ids'])+';')
lines.append("export const PROTOTYPE_IDS=['W01','W02','W03','W04','S01','S02','S03','S05','U01','U02'];")
lines.append("export function label(d:{name:string;en:string},lang:Lang):string{return lang==='zh'?d.name:d.en;}")
lines.append("export const VERSION='0.1.0';")
(root/'src'/'content.ts').write_text('\n'.join(lines)+'\n')
print('Exported structured catalog: 36 modules, 4 chassis, 16 enemies, 6 bosses')
