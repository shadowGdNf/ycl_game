#!/usr/bin/env python3
"""Serve the browser game; Python standard library only."""
import argparse
import functools
import http.server
import pathlib
import socket

parser = argparse.ArgumentParser(description="启动新启程网页版")
parser.add_argument("--port", type=int, default=8765)
parser.add_argument("--lan", action="store_true", help="允许同一局域网内的手机访问")
parser.add_argument("--directory", default=str(pathlib.Path(__file__).parent / "web"))
args = parser.parse_args()

class Handler(http.server.SimpleHTTPRequestHandler):
    extensions_map = {**http.server.SimpleHTTPRequestHandler.extensions_map, ".js": "application/javascript", ".json": "application/json", ".webp": "image/webp", ".wasm": "application/wasm"}
    def end_headers(self):
        self.send_header("X-Content-Type-Options", "nosniff")
        self.send_header("Cache-Control", "no-cache")
        super().end_headers()

server = http.server.ThreadingHTTPServer(("0.0.0.0" if args.lan else "127.0.0.1", args.port), functools.partial(Handler, directory=args.directory))
print(f"电脑打开：http://127.0.0.1:{args.port}", flush=True)
if args.lan:
    try:
        probe = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        probe.connect(("8.8.8.8", 80))
        address = probe.getsockname()[0]
        probe.close()
        print(f"同一 Wi-Fi 的手机打开：http://{address}:{args.port}", flush=True)
    except OSError:
        print("手机访问：使用此电脑的局域网 IP 和相同端口。", flush=True)
print("按 Ctrl+C 关闭。", flush=True)
try:
    server.serve_forever()
except KeyboardInterrupt:
    pass
finally:
    server.server_close()
