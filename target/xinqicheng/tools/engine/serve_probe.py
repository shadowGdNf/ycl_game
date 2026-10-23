"""Local-only HTTP server with remote requests blocked by CSP."""
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
import functools
ROOT = Path(__file__).resolve().parents[2]/'love-probe/web'
class Handler(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Cross-Origin-Opener-Policy','same-origin')
        self.send_header('Cross-Origin-Embedder-Policy','require-corp')
        self.send_header('Content-Security-Policy',"default-src 'self' blob:; script-src 'self' 'wasm-unsafe-eval'; connect-src 'self'; img-src 'self' data: blob:; style-src 'self' 'unsafe-inline'; object-src 'none'")
        super().end_headers()
ThreadingHTTPServer(('127.0.0.1',8768),functools.partial(Handler,directory=str(ROOT))).serve_forever()
