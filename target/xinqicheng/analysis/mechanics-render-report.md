# 静态渲染数据恢复

本次仅读取 APK 的 LuaJIT 字节码、静态反编译结果及图集元数据，没有运行 APK、Lua 游戏代码或连接游戏服务。原始 REA 解包证据为 `ev_7c9409fed63b7b60b8519f5cecbce132705764a8062875b0418b6b27011be627`。

## 产物

- `web/data/render-models.json`：143 个模板的初始渲染层。请求范围内的 111 个模板包括四种基础塔各四级、86 个敌人、Gerald 和士兵/援军；这些模板的 render 表达式全部完成静态解析。额外 32 个 tower_holder 模板保留了动态选择表达式的 unknowns。
- `web/data/scenery.json`：18 关、19 个背景、147 个纯静态装饰、100 个独立纯视觉动画。带 main_script、timed、tween 或 events 组件的场景实体排除，并记录原因。第 18 关的夜间背景例外保留描述，初始 hidden=true。
- `tools/mechanics_render_extract.py`：纯 Python 转换器，只解析受限表赋值、向量/数字运算、已检查的组件默认值和继承关系；不执行 Lua。
- `analysis/mechanics-render-validation.json`：背景计算结果与所有尚未解析的模板表达式。

## 坐标和缩放证据

`analysis/mechanics-decompiled/constants.lua:4` 给出参考坐标 1024×768，Y 轴向上；同文件第 99 行起定义 ipadhd 纹理参考高度 1536。`analysis/mechanics-decompiled/scenery-director.asm` 的 get_texture_scale 静态反汇编给出参考高度除纹理高度，因此当前资源的普通纹理比例为 768/1536=0.5。

`analysis/mechanics-decompiled/scenery-templates.lua:188` 中背景模板使用参考坐标中心 `(512,384)`。`analysis/assets-render-utils.lua:50` 的 frame_draw_params 给出：

```text
screenX = pos.x + offset.x
screenY = 768 - (pos.y + offset.y)
originX = anchor.x * untrimmedWidth - trimLeft
originY = (1 - anchor.y) * untrimmedHeight - trimTop
ordinaryFrameScale = refScale * spriteScale
```

全部背景的原始尺寸为 2800×1536，anchor 为 `(0.5,0.5)`，spriteScale 为 1，refScale 为 0.5。因此背景绘制区域均为 `x=-188, y=0, width=1400, height=768`。第 18 关 Stage18_0001 和 Stage18_0002 的区域相同，后者是运行脚本控制的隐藏夜间层；本次没有复现其过渡 shader。

普通图集帧的 `.scale` 和 `.spriteScale` 是模板缩放乘数，绘制时另乘 `.refScale=0.5`。骨骼动画则使用模板 spriteScale 以及单独恢复的 partScaleCompensation/part pivot 变换，不把整个骨骼再缩小为 0.5 倍。`pos=null` 表示使用实体位置。offset 的单位为参考游戏坐标，正 Y 向上。

## 交叉检查样本

| 数据 | 恢复结果 |
|---|---|
| 第 1 关 mask1 | 完整帧 2800×1536；trim=(602,575,1927,646)；裁片绘制矩形 `(113,287.5,135.5,157.5)` |
| 第 1 关 mask2 | 裁片绘制矩形 `(34,616.5,50.5,62)` |
| 第 1 关 mask3 | 裁片绘制矩形 `(1135.5,47,76.5,97)`，位于 1024 参考宽度之外是原数据的结果 |
| 一级箭塔 | 塔体 offset=(2,6)，射手 offset=(2,43) |
| 四级箭塔 | 四射手 offset=(-17,48),(21,48),(-11,65),(15,65) |
| 四级法师塔 | 星光/塔体 offset=(2,10)，卷轴/发光/法师 offset=(0,10) |
| 四级投石塔 | 三个骨骼层 offset=(0,12) |
| Gerald | anchor=(0.5,0.5)，offset=(0,0)，spriteScale=(1.1,1.1) |
| 乌鸦/石像鬼/滑翔巨魔 | 身体 offset.y=40，影子 offset.y=0 |
| 小恶魔 | 身体 offset.y=30，影子 offset.y=0 |

## 边界

恢复的是模板初始状态及关卡实体覆盖值，动画名、hidden、frame_idx 和 pos 等值可能随后由游戏脚本改变。纯视觉循环单列 ambientAnimations，没有假装是静态帧。第 17 关 decal_stage_17_mask_7 引用 doors_shadows_castles，但当前导出的图集没有同名帧，已显式标为 unknown，没有猜测替代纹理。完整波次/路线/塔位等稳定玩法文件 mechanics.json 未作修改。
