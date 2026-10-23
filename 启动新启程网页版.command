#!/bin/zsh
set -eu
cd -- "$(dirname -- "$0")"
exec python3 target/xinqicheng/serve.py --port 8765 --lan --directory releases/xinqicheng-web-001/site
