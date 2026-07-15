#!/usr/bin/env python3

import json
import time
import threading
from http.server import HTTPServer, BaseHTTPRequestHandler
from mcstatus import JavaServer

SERVERS = [
    {"name": "cool-server1", "host": "localhost", "port": 25565},
]

CACHE = {"data": [], "timestamp": 0}
CACHE_TTL = 10


def query_servers():
    results = []
    for srv in SERVERS:
        entry = {
            "name": srv["name"],
            "players": {"online": 0, "max": 0},
            "version": "unknown",
            "latency": 0,
            "motd": "",
        }

        try:
            status = JavaServer(srv["host"], srv["port"]).status(tries=1)
            entry.update({
                "status": "up",
                "players": {
                    "online": status.players.online,
                    "max": status.players.max,
                },
                "version": status.version.name,
                "latency": round(status.latency),
                "motd": str(status.motd.to_plain()),
            })
        except Exception as e:
            entry.update({
                "status": "down",
                "motd": str(e),
            })

        results.append(entry)
    return results


def refresh_loop():
    while True:
        try:
            CACHE["data"] = query_servers()
            CACHE["timestamp"] = time.time()
        except Exception:
            pass
        time.sleep(CACHE_TTL)


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/status":
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Access-Control-Allow-Origin", "*")
            self.end_headers()
            self.wfile.write(json.dumps(CACHE.get("data", [])).encode())
        else:
            self.send_response(404)
            self.end_headers()

    def log_message(self, format, *args):
        pass


def main():
    t = threading.Thread(target=refresh_loop, daemon=True)
    t.start()

    server = HTTPServer(("127.0.0.1", 9090), Handler)
    server.serve_forever()


if __name__ == "__main__":
    main()
