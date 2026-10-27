# 背包机甲 · Backpack Mecha

可玩的原创单人 H5 Roguelike：战斗自动开火，手动走位、冲刺、超载；战后在 5×5 背包中旋转、连接、购买和升级模块。默认中文，可切换英文。

[线上试玩（免登录）](https://shadowgdnf.github.io/ycl_game/backpack-mecha/game/dist/)

本目录由 `ycl_game` 主仓库统一管理，不再使用嵌套的独立 Git 仓库。请在仓库根目录查看和提交变更。

当前工作版本为 **v0.2.0-dev.2**：在购买前装配预览、逐场战报等 v0.2 功能基础上，接入用户选定的 **A 方案风格化金属素材**，统一四机体、全部模块、敌人、Boss 和地面，并补齐独立母舰侧舱。见 [A 方案改造与验收](docs/ART-STYLE-A.md)和 [v0.2 开发记录](docs/V0.2-DEVELOPMENT.md)。正式上线仍需真机与真人试玩；[v0.1 验收记录](docs/QA.md)保留为历史基线。线上试玩以最近一次 Pages 部署为准，本地构建不会自动更新线上。

## 本地启动

需要 Node.js 22.18+（本次使用 24.21.0）。运行时无框架、CDN 或服务器接口依赖；构建只依赖 TypeScript 5.9。

```sh
cd backpack-mecha/game
npm ci
npm run check
npm test
npm run build
npm run dev
```

打开终端显示的 `http://localhost:4174`。开发服务器只服务 `dist/`；修改源码后重新执行 `npm run build` 并刷新。不要直接双击 HTML，ES 模块和 IndexedDB 需要 HTTP 来源。

在局域网手机上测试时，执行 `HOST=0.0.0.0 npm run dev`，使用电脑的局域网地址访问。系统防火墙可能需要允许连接。`PORT=4175 npm run dev` 可改端口。停止服务按 Ctrl+C。

静态包解压后的目录可交给任何静态 HTTP 服务器。网页资源全部使用相对路径，可以部署在子目录；无上传、账号、广告和支付逻辑。

## GitHub Pages 更新

试玩与《新启程》共用 `shadowGdNf/ycl_game` 仓库的 GitHub Pages。`dist/` 纳入版本管理；修改源码后执行 `npm run build`，将源码和生成的 `dist/` 一起提交并推送到仓库 `main` 分支。等待 `pages build and deployment` 成功后，线上版本才会更新。图集通过 `import.meta.url` 定位，支持 `/ycl_game/backpack-mecha/game/dist/` 子目录，详见[仓库发布说明](../../README.md#更新-github-pages-试玩)。

## 操作

| 操作 | 键鼠 | 手机触屏 |
|---|---|---|
| 移动 | WASD / 方向键 | 左侧拖动浮动摇杆 |
| 冲刺 | 空格 | 右侧箭头按钮 |
| 超载 | E | 右侧闪电按钮 |
| 指定目标 | 点击 / 右键目标附近 | 右侧长按 |
| 暂停 | P / Esc | 右上暂停 |
| 背包装配 | 拖动，或选中后点击空格 | 选中后点空格，也支持拖动 |
| 旋转 | R / 旋转按钮 | 旋转按钮 |

武器最多三件。支持件必须与兼容武器边缘相邻；每把武器最多连接两件支持。青色连线代表生效；挪动支持件后检查连接和电力。备件架最多三件。自动整理整理已装备模块，备件需主动装入。战斗中不能换装。

商店点击「查看装配」可预览形状、价格、装入后的电力与占格，以及可连接的武器。选择直接装入时，点击背包中的标记完成购买；也可先买到备件架。背包标记表示模块左上角：青色「＋」可生效，橙色「○」表示支持件仍需连接。旋转会更新标记。失败时不扣款。

设置提供音效、合成背景音乐、音量、减少动态效果、色彩辅助、左手操作和自动超载。切后台自动暂停。

## 三个内容档位

| 档位 | 内容 |
|---|---|
| 首章训练 | 拾荒者、10模块、第一章4场、压路王 |
| 两章试炼 | 拾荒者/堡垒、指定24模块、E01–E06、8场、压路王/熔炉蟹、一次协议、基础选路、难度0 |
| 三章远征 | 四机体、36模块、12敌人、三章12场、每章随机二选一Boss、9协议池、8事件池、难度0–4 |

四机体分别为拾荒者、堡垒、游隼、蜂巢；首局只开放拾荒者。完成第一章解锁堡垒；使用无人机完成第二章解锁蜂巢；三章通关解锁游隼及下一档难度。新解锁不影响当前局数值。

六条构筑路线：潮湿电链、燃油连爆、穿甲齐射、堡垒震荡、无人机编队、冰霜回弹。商店和事件提供随机组合，图鉴记录见过的模块及成功连接。可输入或复制种子复现路线与随机序列；操作差异仍会改变战斗结果。

## 存档

IndexedDB 数据库 `backpack-mecha-v1`，单一续局槽。交易与阶段变化后保存，战斗每5个游戏秒保存完整快照，暂停/切后台时也保存。快照包括随机流、弹丸、区域、状态层、冷却、掉落、统计和已结算标记。

不同浏览器、端口和部署域名拥有独立存档。保存失败时页面显示提示，当前内存游戏仍可继续；隐私模式和浏览器清理可能导致数据丢失。损坏的战斗快照退回当前战前装配，版本不兼容的整局会放弃并保留可识别的永久进度。结算页可导出本局战斗/购买记录 JSON，此记录不是可导入存档。

v0.2 沿用原存档格式与数据库，兼容 v0.1 续局。新增战报独立校验，旧存档和损坏的战报不会导致有效游戏进度被删除。休整和结算都可以导出本局战报，包含最多 400 条操作/供货记录、逐场装配与战损、可见休整时间和浏览器帧间隔统计；全部留在本地，不自动上传。撤销交易会回滚经济状态，同时保留战报中的操作历史。战报不是输入回放或可导入存档。

## 工程与资源

- `src/types.ts`：公共内容、装配、只读场景和事件接口。
- `src/combat.ts` / `src/encounters.ts`：60 Hz规则、伤害状态、敌人、Boss、导航与刷怪。
- `src/economy.ts`：装配合法性、交易原子性、路线、事件和结算。
- `src/renderer.ts` / `src/art.ts`：图集、分层角色、关键帧与特效；只消费规则数据。
- `src/app.ts` / `styles.css`：流程、键鼠/触屏、中文/英文、界面。
- `src/storage.ts` / `src/input.ts` / `src/audio.ts`：存档、技能输入、Web Audio 合成音效/音乐。
- `src/journal.ts` / `src/version.ts`：有容量上限的本地战报、运行版本与规则版本。
- `assets/content.json`：可阅读数值目录；`assets/source/design-baseline.json`：原设计基线。
- `scripts/export-content.py`：从工程内设计基线生成结构化目录和中英文参数说明。
- `assets/atlases/` / `assets/atlas-manifest.json`：五张 PNG 图集、86 个采样区域及图集哈希；挂点位于渲染器。
- `assets/source/art-layout.json`：经透明通道检查的图集分区；旧图保存在 `assets/source/pre-style-a/`，不进入网页包。
- [美术规范](docs/ART.md)、[A 方案素材提示](docs/ASSET-PROMPTS-A.json)、[原版素材提示](docs/ASSET-PROMPTS.txt)、[接口与实现说明](docs/IMPLEMENTATION.md)、[测试与限制](docs/QA.md)。

`python3 scripts/package-release.py` 输出静态网页ZIP、完整源码ZIP与SHA-256清单到相邻的`releases/`。

`python3 scripts/export-content.py` 可重新生成目录。调整涉及机制的参数时须同时检查战斗实现和中文/英文描述；运行时不会解析中文文字来执行效果。

```sh
npm test           # 规则、经济、存档、流程回归
npm run probe      # 按章节的真实规则Boss构筑探针，覆盖写入qa/balance-probe.json
npm run probe:natural # 六条路线各10种子的自然成长完整局，保留失败与未集齐核心的结果
python3 scripts/art-check.py  # 需要Pillow；检查图集和采样区域
node scripts/check-bundle.mjs # 生产资源引用、内容数量与包体检查
```

[探针报告](docs/BALANCE-PROBE.md)明示测试条件：使用预装合法构筑与机器避险输入，不能当作真人胜率或随机商店可达性证明。

[自然成长探针](docs/V0.2-DEVELOPMENT.md)补充真实商店购买、升级、战损、奖励和完整十二场规则战斗。摘要为 `qa/natural-probe.json`，完整操作记录为 `qa/natural-probe-runs.json.gz`。小样本 `npm run probe:natural -- --seeds=1` 写入独立的 smoke 报告，不覆盖正式十种子结果。机器策略结果不能当作真人胜率。

## 已知验收缺口

- 未执行 Android Chrome / iPhone Safari 真机性能测量、完整桌面 Chrome/Safari 矩阵和十二名新玩家观察。
- 完整预装构筑的部分Boss击杀时间短于设计目标，下一轮需依据真实商店成长的完整局数据调优。
- 角色采用 3D 质感透明图片与四姿态插值；敌人每种一张基础姿态。未新增真实 3D 模型、逐敌人动画帧或实时材质光照。PNG 保留生成原像素，通过元数据裁切采样。
- 每日轮换、皮肤、联网排行、广告、支付均属于后续扩展。

素材由内置图像生成工具按本项目统一参考生成，来源与提示保存在工程中。背景音乐和音效由工程内 Web Audio 代码合成，没有外部歌曲或商业素材包依赖。
