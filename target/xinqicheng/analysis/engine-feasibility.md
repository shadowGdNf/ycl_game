# 原引擎直接迁移验证

验证日期：2026-10-23（Asia/Shanghai）。范围：APK 中 `assets/gc64` 的 866 个 Lua 文件，作为一个架构变体进行分析。

**结论：本次没有实现完整原引擎的网页版运行。** 现有 LuaJIT 反编译工具在核心逻辑中存在恢复缺口，直接把输出交给 Love.js 无法运行游戏。另行实现的网页运行层应标为“复用原素材与关卡数据的网页重构”，不能标为原 APK 的等价移植。本结论不是说完整移植理论上不可能，而是当前产物与验证不能支持该声明。

## 已实际完成的验证

- 对 866 个 LuaJIT 文件进行静态恢复尝试，没有运行 APK、原生动态库或原游戏 Lua。
- 861 个文件产生了文本输出；5 个核心文件无法产生输出。
- 将 861 个输出装入仅用于编译检查的 `.love` 包，由本机浏览器中的真实 Love.js / Lua 5.1 WASM 编译器逐个 `loadstring`。**842 个通过语法编译，19 个失败。** 已编译函数从未被调用；语法通过不表示语义、逻辑或游戏行为正确。
- 15 个输出中合计有 **6093 个** LJD 的 `Decompilation error in this vicinity` 标记，其中包含 `FLOW; TARGET BLOCK`、`JUMP TO BLOCK` 和 `slot1 = if ...` 等非 Lua 源代码。
- Love.js 官方仓库附带的 `nogame.love` 能在同一本机浏览器中显示并运行；自己的编译探针也成功执行。初始探针禁用 audio 模块会触发该运行时的 `RuntimeError: null function`，恢复默认 audio 模块后完成检查。该错误属于探针配置与运行时的兼容问题，不作为原游戏无法移植的证据。

## 未恢复的 5 个文件

| 文件 | 结果 |
| --- | --- |
| `kr6/scripts_game.lua` | 正常反编译由主任务确认失败；本探针使用 `--catch_asserts` 后仍在 `ljd/ast/locals.py` 的变量恢复断言处失败，没有输出。 |
| `kr6/kviews_screen_map_game.lua` | 进程失败，没有输出。 |
| `all/kviews_gg.lua` | 进程失败，没有输出。 |
| `all/scripts.lua` | 进程失败，没有输出。 |
| `all/wave_db.lua` | 进程失败，没有输出。 |

19 个语法失败文件包括 `all/director.lua`、`all/entity_db.lua`、`all/path_db.lua`、`all/script_utils.lua`、`lib/klove/image_db.lua`、`lib/klove/kui.lua`、`sequels/game_gui.lua` 等游戏循环、路径、对象、素材和 UI 基础模块。完整列表及编译错误位置见 `engine-browser-compile-log.json`，最后一次 `PROBE_BEGIN` 至 `PROBE_END` 为最终检查。

## 还需要处理的运行时差异

- 在已恢复文本中找到 102 个直接以 `love.<module>.<name>` 写出的引用；这不是覆盖别名、动态调用和未恢复源码的完整 API 清单。
- 实测 Love.js 中缺少 6 个直接引用：`love.graphics.getCompressedImageFormats`、`love.mouse.hasCursor`、`love.window.getPixelScale`、`love.window.isCreated`，以及 Nintendo Switch 分支下的 `love.nx.allocGetTotalFreeSize` 与 `love.nx.getDesiredLanguage`。Switch 专用分支可以不进入；其余调用需要核对与适配。
- `pcall(require, 'ffi')` 实测为 false。原入口默认 `KR_PLATFORM='android'`、`KR_TARGET='dynamic'`，会经 `all.jni_android` 访问 JNI 和 FFI。这条平台路径需要替换为 Web 配置。
- `main.lua:688` 自定义 `love.run` 含永久 `while true` 循环，须适配浏览器主循环调度。源码还存在 0–255 颜色值、压缩纹理格式探测、文件系统 API 与线程加载路径，均未完成运行时等价验证。
- 原 `features.lua` 启用了统计、支付、HTTP、远程配置等平台服务。探针没有调用这些服务。任何网页实现均需明确选择本地替代或移除；不能直接附带原 SDK、密钥、许可与支付流程。
- 纹理转换、主菜单、完整战斗、全英雄/技能、各关机制、存档与手机性能仍需逐项运行验证。编译探针未对这些行为作任何通过声明。

## 产物与复现

- `../love-probe/game/`：静态反编译输出；**不是可运行的完整游戏**。
- `../love-probe/web/`：离线本机编译探针和 Love.js 运行时；不是用户游戏交付包，不应混入正式网页包。
- `engine-decompile-progress.json`：逐文件反编译结果；`scripts_game.lua` 的单独失败记录位于 `../love-probe/decompile-logs/scripts_game-catch.log`。
- `engine-invalid-blocks.json`：错误标记计数；`engine-api-usage.json`：直接 API 引用路径。
- `engine-browser-compile-log.json` 与 `engine-browser-compile.png`：实际浏览器编译证据。
- `engine-probe-manifest.json`：输入/运行时标识和汇总。

从项目目录运行 `python3 target/xinqicheng/tools/engine/build_probe.py` 重建探针，再运行 `python3 target/xinqicheng/tools/engine/serve_probe.py`；访问 `http://127.0.0.1:8768/`。服务仅监听 127.0.0.1，CSP 的 `connect-src 'self'` 限定请求为本机同源。探针只编译恢复脚本，没有执行这些函数。

## 外部运行时依据

[2dengine/love.js 官方仓库](https://github.com/2dengine/love.js) 提供 LÖVE 11.5 的 WebAssembly 运行时，并说明不使用 LuaJIT。下载的是该仓库 main 分支归档，确切字节的 SHA-256 记录在 manifest；没有把可变分支名作为不可变版本证明。版权与许可文件保存在 `../love-probe/vendor/love.js-main/`。另一可用上游为 [Davidobot/love.js](https://github.com/Davidobot/love.js)。
