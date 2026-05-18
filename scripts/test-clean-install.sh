#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP="$(mktemp -d /tmp/lobsterclaw-clean-install.XXXXXX)"

mkdir -p "$TMP/home" "$TMP/bin" "$TMP/data"

(
  cd "$ROOT"
  HOME="$TMP/home" \
    LOBSTERCLAW_BIN_DIR="$TMP/bin" \
    LOBSTERCLAW_DATA_HOME="$TMP/data/lobsteragents" \
    ./install.sh
)

HOME="$TMP/home" \
  LOBSTERCLAW_DATA_HOME="$TMP/data/lobsteragents" \
  "$TMP/bin/lobsterclaw" doctor

python3 - "$TMP/home/.openclaw/openclaw.json" <<'PY'
import json, sys
from pathlib import Path

cfg = json.loads(Path(sys.argv[1]).read_text())
agents = cfg.get("agents", {}).get("list", [])
ids = {a.get("id") for a in agents if isinstance(a, dict)}
main = next((a for a in agents if isinstance(a, dict) and a.get("id") == "main"), {})
allow = main.get("subagents", {}).get("allowAgents", [])

assert "bob-hawthorne" in ids, "bob-hawthorne missing from OpenClaw config"
assert len(allow) == 28, f"expected 28 allowed Lobster agents, got {len(allow)}"

print(f"Clean install test OK: {len(ids)} configured agents, {len(allow)} allowed subagents")
PY
