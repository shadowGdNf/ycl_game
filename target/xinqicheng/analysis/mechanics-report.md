# 新启程 APK：关卡与战斗数据静态恢复记录

本记录属于用户要求的 APK 网页迁移工作。分析只读取用户指定 APK 的 REA 解包内容，并使用 LJD 静态反编译 LuaJIT 字节码；没有运行 APK、没有执行解包游戏脚本、没有连接游戏服务。

REA 原始提取证据：`ev_7c9409fed63b7b60b8519f5cecbce132705764a8062875b0418b6b27011be627`。

## 已恢复的内容

- 18 个战役关卡的中文名称、故事、起始生命和金币。
- 全部 18 关原始路径、三条子线路、贝塞尔控制点、路径连接和原始地图实体。
- 战役模式 213 个普通塔位，包含阻塞塔位和预置塔。特殊关卡建筑单独保存在 `specialTowers`。
- 245 个普通波次、6,879 次普通敌人生成；每次包含时间、敌人模板、路径和子线路。
- 14 组手动触发波次，包括教程、Boss 增援和剧情组；保留 `event`、`signal`、`wait`、`wait_signal`、重复控制等原始命令。
- 15 类防御塔的价格、伤害、射程、攻速、技能与终极技能数值，以及英雄、敌人、力量、升级、道具和 KR1 模式的原始平衡表。
- 86 个敌人模板的继承信息、战斗平衡数据引用、贴图前缀和飞行标记。战役普通波次使用的 47 种敌人全部可解析。
- 全量简体中文文案，以及包内其余 TSV 模式 `iron`、`blitz`、`no_hero`、`extra_heroes`、`kr1`。

这证明原包含有足够的数据支持按原地图和数值重建战役。恢复数据本身不等于原版全部行为已经移植完成。

## 证据与关键语义

| 结论 | 静态来源 | 置信度 |
| --- | --- | --- |
| 地图参考尺寸为 1024 × 768，FPS 为 30 | `mechanics-decompiled/constants.lua` 第 2、4、5 行 | 高，字节码常量 |
| 地图坐标包含超出参考画面的出入场节点 | `level01_paths.lua` 第一个节点 x=1261 | 高，表字面量 |
| 地图渲染需把向上的 Y 轴转换为 Canvas 向下的 Y 轴 | 原图场景实体、路径、背景定位与图像匹配；`yCanvas = 768 - y` | 高，跨资源一致性 |
| TSV 是原加载器优先选择的数据来源 | `mechanics-decompiled/wave_db.asm` 第 2062 行起，源行 710–721：先调用 `load_tsv`，失败才尝试 `load_lua` | 高，指令路径 |
| TSV `inc` 为每行等待秒数；子线路 `*` 由引擎选择 | `wave_db.asm` 的 `parse_spawn`（源行 160–190）、`create_wave_group_from_tsv`（源行 344–411） | 高，指令字段及 FPS 转换 |
| 难度数组顺序为简单、普通、困难、不可能 | `constants.lua` 第 472–475 行 | 高，字节码常量 |
| 塔位必须按模式选择 | `level*_data.lua` 中 `editor.game_mode`，0 为通用、1 为战役 | 高，模式常量及实体记录 |
| 第一关初始金币 175、5 波、7 个普通塔位 | 第一关当前 TSV 与 `level01_data.lua` | 高，直接数据 |
| 塔多数使用多个 exoskeleton 部件拼合 | `templates_game.lua` 第 8823 行起，弓兵塔分别引用塔体、射手、边沿和弓部件 | 高，静态模板 |

完整原始成员与反编译产物的 SHA-256 位于 `web/data/mechanics-source-manifest.json`。反编译不是原始源代码；记录中的 Lua 文件是 LJD 恢复结果。

## 前端入口与数据约定

主要入口是 `web/data/mechanics.json`：

```js
{
  schemaVersion: 1,
  coordinateSystem: {width: 1024, height: 768, yAxis: 'up'},
  difficultyOrder: ['easy', 'normal', 'hard', 'impossible'],
  levels: [{
    id: 1, name: '1. 利尼维亚城堡', lives: 20, gold: 175,
    paths: [{id: 1, points: [{x: 1261, y: 239}], lanes: [/* 3 子线路 */]}],
    towerSlots: [{id: '4', x: 602, y: 263, rally: {x: 650, y: 354}, blocked: false}],
    waves: [{id: 1, interval: -1, spawns: [{time: 2, enemy: 'enemy_bandit', path: 1, lane: 2}]}],
    manualWaves: [/* 需脚本触发 */],
    specialTowers: [/* 关卡特有建筑 */]
  }],
  enemies: {enemy_bandit: {spritePrefix: 'bandit', stats: {hp: [40,40,50,100], gold: 5, speed: 40}}},
  towers: {archers: {stats: {/* 四级数值 */}, levels: [/* 贴图前缀与名称 */]}}
}
```

数组使用 JavaScript 的 0 基索引，但 `path`、`lane`、`id` 保留原游戏的 1 基标识。`lane=0` 表示原 TSV 的 `*`。`points` 是原第 1 子线路（中线），完整子线路保留在 `lanes`。`interval=-1` 是手动等待语义，不能当作负时间自动计时。

`towerSlots.existingTower` 指定预建塔，`blocked` 指示需要解除阻塞的塔位。`specialTowers` 包含起重机、谷仓、营地、日光塔等特殊建筑，不应直接当作普通可建塔位。所有模式和实体原记录仍在原始数据文件中。

为了便于集成，另外输出：

- `levels.json`：主入口中的关卡数组。
- `balance.json`：原始平衡表，包含全部数值层次。
- `strings-zh-Hans.json`：原简体中文文案。
- `mechanics-raw-levels.json`：未按战役筛选的地图实体、路径和控制点。
- `mechanics-raw-waves.json`：战役 TSV 的元数据、普通波次、手动波次及原命令。
- `mechanics-extra-modes.json`：其余包内 TSV 模式。
- `mechanics-template-metadata.json`：模板继承、贴图前缀、动画名与平衡表路径。
- `mechanics-summary.json`：统计与关卡清单。

## 校验

静态校验通过：18 关全部有地图与波次；所有路径均有 3 条子线路；中线坐标为有限数值；所有普通和手动波次引用的路径存在；所有敌人模板存在；战役普通塔位 ID 无重复。

转换器只接受 Lua 表字面量、字段引用、算术，以及经过查看的四个纯数据辅助函数：`fts`、`v`、`sub_one`、`slow_calc`。遇到任何不在允许列表内的调用立即失败，既不使用 Lua 解释器，也不执行目标代码。

## 仍需运行层实现的范围

- 手动波次、`wait_signal`、剧情事件的实际触发条件，关卡特有 Boss 阶段、楼梯、传送门、路径切换、屏障与机关。
- 技能施法状态机、伤害类型组合、护甲/抗性与特殊免疫、治疗、重生、分裂、单位召唤等完整战斗逻辑。
- 多部件 `.exo3` 动画和模板偏移、英雄移动及技能动画、特殊塔位开锁与关卡装饰交互。
- 存档、解锁、经济、成就、教程等产品流程。

`waves.spawns[].time` 是从原 TSV 等待量累计的便捷时间表。包含动态等待或事件的关卡，运行层应处理 `events` 或读取原始命令，而不能把该时间表误称为所有运行行为的精确复现。没有对原 APK 做动态验证，所有行为结论均为静态观察或明确推断。

## 复现

```sh
python3 target/xinqicheng/tools/mechanics_decompile.py --assets <REA解包目录>/assets
python3 target/xinqicheng/tools/mechanics_extract.py --assets <REA解包目录>/assets
```

以上命令仅调用已取得的本地 LJD 与 Python 标准库。`mechanics_decompile.py` 的目标清单固定为 18 关地图数据、平衡表、模板、常量和全局配置；不会启动游戏。
