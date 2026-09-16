#!/usr/bin/env python3
"""Parsing and lookup helpers for updateflake.sh.

Subcommands:
  lockstate <flake.lock>   Print TSV: name, rev, lastModified, repo, owner, branch
  latest <url>             Print "rev\tlastModified" of the newest commit at url
"""

import datetime
import json
import subprocess
import sys
import urllib.request


def lockstate(lockfile):
    with open(lockfile) as f:
        data = json.load(f)
    for name, node in data["nodes"].items():
        if name == "root" or name.startswith("systems"):
            continue
        locked = node.get("locked", {})
        rev = locked.get("rev", "n/a")[:12]
        ts = str(locked.get("lastModified", 0))
        repo = locked.get("repo", "n/a")
        owner = locked.get("owner", "n/a")
        branch = locked.get("original", {}).get("ref", "HEAD")
        print(f"{name}\t{rev}\t{ts}\t{repo}\t{owner}\t{branch}")


def _parse_github_url(url):
    spec = url[len("github:"):]
    parts = spec.split("/")
    if len(parts) < 2:
        return None
    return parts[0], parts[1], parts[2] if len(parts) > 2 else "HEAD"


def _github_latest(owner, repo, branch):
    api = f"https://api.github.com/repos/{owner}/{repo}/commits/{branch}"
    try:
        with urllib.request.urlopen(api, timeout=15) as resp:
            data = json.load(resp)
        sha = data.get("sha", "n/a")[:12]
        date = data.get("commit", {}).get("committer", {}).get("date", "")
        ts = 0
        if date:
            ts = int(datetime.datetime.fromisoformat(date.replace("Z", "+00:00")).timestamp())
        print(f"{sha}\t{ts}")
    except Exception:
        print("n/a\t0")


def _nix_latest(url):
    try:
        out = subprocess.run(
            ["nix", "flake", "metadata", url, "--json"],
            capture_output=True,
            text=True,
            timeout=60,
        )
        data = json.loads(out.stdout)
        rev = data.get("revision", "n/a")[:12]
        ts = str(data.get("lastModified", 0))
        print(f"{rev}\t{ts}")
    except Exception:
        print("n/a\t0")


def latest(url):
    if url.startswith("github:"):
        parsed = _parse_github_url(url)
        if parsed is None:
            print("n/a\t0")
            return
        _github_latest(*parsed)
    else:
        _nix_latest(url)


def main(argv):
    if len(argv) < 3:
        print(__doc__, file=sys.stderr)
        return 1
    cmd, args = argv[1], argv[2:]
    if cmd == "lockstate":
        lockstate(args[0])
    elif cmd == "latest":
        latest(args[0])
    else:
        print(__doc__, file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))