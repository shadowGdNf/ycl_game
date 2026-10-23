# APK 素材恢复记录

## 来源与边界

- 原包：`/Users/atlasv/Downloads/新启程.apk`。
- REA 安全解包证据：`ev_7c9409fed63b7b60b8519f5cecbce132705764a8062875b0418b6b27011be627`。
- 原图源目录：`assets/kr6-phone/images/ipadhd/`。未修改原 APK 或解包文件，未执行 APK、目标 Lua 或目标原生库。
- 对明文图集和 `.exo3` 仅做严格字面量解析；传统动画表由现有 LJD 静态反编译，再严格解析字面量。源数据里出现的指令均未执行。

## 已验证结果

- 全部 136 份原始 Lua 图集都能通过字面量解析与尺寸/裁切校验，包含 64,772 条帧及别名记录。
- 本次选择转换 102 张纹理、69 个图集，共 37,644 条帧及别名记录。
- 覆盖 18 关背景、关卡装饰、世界地图、主菜单、关卡预览、4 个 KR6 基础塔（archers / knights / wizard / catapult）、全部常规敌人图集、Gerald、援军以及通用 UI。
- 已导出 90 个骨骼定义、2,339 条传统动画序列。47 种战役出怪模板的主动画与所需帧检查全部通过，详情见 `assets-validation.json`。
- 每张输出纹理都做了重新打开、尺寸和 SHA-256 校验。已目视核对第 1 关背景、主菜单和原 logo，颜色、透明度和方向正确。
- 原容器为 LZ4 frame 压缩的 KTX1；已选纹理的编码为 ETC2 RGBA8 (`glInternalFormat=0x9278`)。解码库返回 BGRA，转换时按该通道顺序读取。
- 网页纹理为 WebP quality 90，保留透明通道；这是浏览器体积优化，并非逐像素无损。脚本支持 `--quality 100` 无损 WebP 或 `--format png`。

## 网页接口

`web/assets/manifest.json`：

```json
{
  "textures": {"原文件名.pkm.lz4": {"image":"textures/xxx.webp","width":100,"height":100,"sourceSha256":"...","outputSha256":"..."}},
  "atlases": {"图集名": {"url":"atlases/图集名.json","frames":1,"textures":["原文件名.pkm.lz4"]}}
}
```

每个 `atlases/*.json` 的 `frames[帧名]`：

```json
{"image":"textures/xxx.webp","rect":[0,0,80,90],"size":[100,100],"trim":[10,5,10,5],"atlasSize":[1024,1024],"aliasOf":"可选原帧名"}
```

`rect` 是图集裁切区域，`size` 是未裁切尺寸，`trim` 顺序为左、上、右、下。动态绘制不能忽略 trim，否则动画锚点会晃动。`frames-index.json` 是全局 `{帧名:图集名}` 映射，重复帧优先选择确定排序中的较早图集。

`animations/index.json`：

- `exo[名称]`：`url`、`fps`、`atlasGroups`、`clips`（动画名→帧数）、`missingFrames`。
- `sprites[动画名]`：原 `prefix/from/to`、`fps`、`frames`（已展开的图集帧名数组）、`atlasGroups`、`missingFrames`。
- 例如 `bandit_walkingRightLeft` 对应 `bandit_enemy_0002` 至 `bandit_enemy_0021`；`knights_order_soldier_lvl1_walk` 与 `reinforcements_lvl1_1_walk` 也已恢复。

`animations/exo/*.json`：

```json
{"name":"hero_geraldDef","fps":30,"atlasScale":0.5,"parts":[["图集帧名",0,0]],"animations":[{"name":"idle","frames":[[[1,1,1,0,0,1,1,0,0,0]]]}]}
```

每个骨骼部件为 `[type, partIndex, alpha, x, y, sx, sy, rotation, kx, ky]`；partIndex 沿用 Lua 的 1 起始索引。`type=8` 是挂点而非图像。个别源 frame 还有命名挂点字段，已保留为同动画的 `frameMetadata`，绘制数组依然统一。

静态反编译的 `all/render_utils.lua` 第 259–296 行给出的绘制规则为：

```text
part = parts[partIndex-1] = [frameName, pox, poy]
ox = size.width / 2 - trim.left - pox / refScale
oy = size.height / 2 - trim.top - poy / refScale
draw(crop, x, y, rotation, sx * refScale, sy * refScale, ox, oy, kx, ky)
```

浏览器画布 Y 向下，骨骼局部 `y` 直接使用；游戏模板 layer offset 的 Y 向上，转换为画布时取负。`partScaleCompensation` 保留为原数据字段；上述原 Lua renderer 没有另乘该字段。`atlasScale=0.5` 对应当前 ipadhd 图像与逻辑场景比例。

阶段 18 背景是两张背景拼在一张图集中，必须通过 `go_stage18_bg` 的帧 rect 取图；不能将整张图集直接当场景。

## 音频和品牌

- `branding/logo.png` 是 `ScreenSlotsLogo_asst_mainmenu_logo` 的无损裁切，未重新绘制；图形写有 KINGDOM RUSH 6 GENESIS。
- `branding/icon-android.png`、`icon-round.png` 是 APK launcher 图标的原文件副本。另保留包内 `icon-256.png`。
- `audio/manifest.json` 包含 `battle`、`map`、`build`、`wave`、`explosion` 五项。使用原包 OGG 解码后转成 MP3，适配桌面和移动浏览器，总计约 2.25 MB；映射包含原路径、输出路径及哈希。

## 可复现工具

- `tools/assets_convert.py`：LZ4/KTX/ETC 解码与图集导出，支持按图集正则选择和增量转换。
- `tools/assets_extract_frames.py`：无损裁切已有图集帧，写 provenance JSON。
- `tools/assets_lua_literals.py`：非执行型 Lua 字面量解析器。
- `tools/assets_export_animations.py`：骨骼、传统动画及全局帧索引导出。
- `tools/assets_audio.py`：所选五个原音频转码和 manifest。
- 解码依赖固定为项目内 `texture-deps/` 的 `lz4==4.4.5` 和 `texture2ddecoder==1.0.6`；没有更改系统 Python。图像 I/O 使用已有 Pillow，音频使用已有 FFmpeg。

## 已知边界

- 动画索引包含全包已反编译的序列；未选择恢复的商店、百科或额外英雄纹理仍会在对应非战役动画上标记 `missingFrames`。已检查的 47 种战役出怪不受影响。
- `archerarrow3Def` 引用的 2 个帧名、`archerarrow3_trailDef` 引用的 10 个帧名在原包全部 136 份图集中未找到。它们保留为显式 `missingFrames`，没有用猜测图像填补。基础塔主体和普通攻击者图像完整。
- 原游戏的脚本事件、材质特效、骨骼挂点逻辑和战斗 AI 是否完整运行，不由素材恢复证明。此处验证的是可显示资源与静态动画数据。
- 最大图集为 4096×4096，单张 RGBA 解码约 64 MB。网页按关卡所需图集加载并释放上一关资源，避免一次性解码全部素材。
