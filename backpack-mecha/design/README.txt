背包机甲 设计交付 v0.1

主文档：backpack-mecha-gdd-v0.1.docx
配置数据：balance-v0.1.json
美术方向：assets/art-direction.png
装配示例：assets/loadout.png

这是设计提案，尚未制作可玩游戏，也没有真实玩家平衡数据。
规则检查与装配验证在 qa/balance-check.json 中。

设计来源在 source/design_data.py 与 source/chapters.py。
使用包含 python-docx 与 Pillow 的 Python 环境执行：
  python tools/check_balance.py
  python tools/build_design.py

build_design.py 会重新生成并覆盖主文档。若直接编辑过 Word，请先另存副本。
qa/render-final 中的 PDF 和页面图仅用于内部排版检查，不是额外交付格式。
source/art-prompt.txt 保存内置图像生成工具使用的完整提示。
