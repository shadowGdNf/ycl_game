背包机甲宣传片制作

最终文件：../背包机甲-宣传片.mp4
76 秒，1280×720，30fps，H.264 / AAC，MP4 faststart。

画面直接调用 game/dist 的现有游戏规则、战斗渲染器、背包渲染器和角色图集。
使用合法预装构筑和项目现有自动操作策略；部分 Boss 镜头设置中途血量，以展示后续阶段。
没有改变伤害、射速、敌人生成规则，也没有访问玩家存档。
剪辑、标题和字幕在录制画布合成。配乐为本地原创合成，音效由真实战斗事件同步生成。
参考：用户指定的 Brotato Steam 页面中的游戏实战宣传片，仅参考展示方式，没有使用其画面或音乐。
https://store.steampowered.com/app/1942280/Brotato/?l=schinese

从仓库根目录复现（需要 Node、项目现有 TypeScript、Playwright、Chrome、Python/numpy 和 FFmpeg）：
node backpack-mecha/promo/tools/render.mjs
python3 backpack-mecha/promo/tools/score.py
ffmpeg -hide_banner -y -i /tmp/mecha-trailer-work/picture.mp4 -i /tmp/mecha-trailer-work/score.wav -map 0:v:0 -map 1:a:0 -vf 'scale=in_range=full:out_range=tv,format=yuv420p' -color_range tv -colorspace bt709 -color_primaries bt709 -color_trc bt709 -c:v libx264 -preset fast -crf 19 -af loudnorm=I=-16:TP=-1.5:LRA=9 -c:a aac -b:a 192k -ar 48000 -movflags +faststart -shortest backpack-mecha/promo/背包机甲-宣传片.mp4

MECHA_NODE_MODULES 可指定 Playwright 包所在的 node_modules。
MECHA_VIDEO_WORK 可指定中间文件目录（若改动，后续 FFmpeg 输入路径也应同步修改）。
无需重建、修改或部署游戏；成片本地直接播放。
