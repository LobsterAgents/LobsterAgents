#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP="$(mktemp -d /tmp/lobsteragents-clean-install.XXXXXX)"

mkdir -p "$TMP/home/.openclaw" "$TMP/bin" "$TMP/data"
cat > "$TMP/home/.openclaw/openclaw.json" <<'JSON'
{
  "models": {
    "providers": {
      "openai": {
        "models": [
          { "id": "gpt-5.5" }
        ]
      },
      "vllm": {
        "models": [
          { "id": "qwen3.6-fp8" }
        ]
      }
    }
  },
  "agents": {
    "list": [
      {
        "id": "main",
        "model": {
          "primary": "openai/gpt-5.5"
        }
      }
    ]
  }
}
JSON
cat > "$TMP/bin/openclaw" <<'SH'
#!/usr/bin/env bash
case "${1:-}" in
  --version) echo "openclaw-mock 1.0.0" ;;
  *) echo "openclaw mock: $*" ;;
esac
SH
chmod +x "$TMP/bin/openclaw"

(
  cd "$ROOT"
  HOME="$TMP/home" \
    PATH="$TMP/bin:$PATH" \
    LOBSTERAGENTS_NO_PROMPT=1 \
    LOBSTERAGENTS_BIN_DIR="$TMP/bin" \
    LOBSTERAGENTS_DATA_HOME="$TMP/data/lobsteragents" \
    ./install.sh
)

HOME="$TMP/home" \
  LOBSTERAGENTS_DATA_HOME="$TMP/data/lobsteragents" \
  "$TMP/bin/lobsteragents" models list | tee "$TMP/models-list.txt"

grep -q "openai/gpt-5.5" "$TMP/models-list.txt"
grep -q "vllm/qwen3.6-fp8" "$TMP/models-list.txt"

HOME="$TMP/home" \
  LOBSTERAGENTS_DATA_HOME="$TMP/data/lobsteragents" \
  "$TMP/bin/lobsteragents" models 1 2 2

HOME="$TMP/home" \
  LOBSTERAGENTS_DATA_HOME="$TMP/data/lobsteragents" \
  "$TMP/bin/lobsteragents" connect main

HOME="$TMP/home" \
  LOBSTERAGENTS_DATA_HOME="$TMP/data/lobsteragents" \
  "$TMP/bin/lobsteragents" doctor

python3 - "$TMP/home/.openclaw/openclaw.json" <<'PY'
import json, sys
from pathlib import Path

cfg = json.loads(Path(sys.argv[1]).read_text())
agents = cfg.get("agents", {}).get("list", [])
ids = {a.get("id") for a in agents if isinstance(a, dict)}
main = next((a for a in agents if isinstance(a, dict) and a.get("id") == "main"), {})
allow = main.get("subagents", {}).get("allowAgents", [])
bob = next((a for a in agents if isinstance(a, dict) and a.get("id") == "bob-hawthorne"), {})

assert "bob-hawthorne" in ids, "bob-hawthorne missing from OpenClaw config"
assert len(allow) == 28, f"expected 28 allowed Lobster agents after connect, got {len(allow)}"
assert bob.get("model", {}).get("primary") == "vllm/qwen3.6-fp8", "standard model was not applied"

print(f"Clean install test OK: {len(ids)} configured agents, {len(allow)} allowed subagents")
PY

HOME="$TMP/home" \
  LOBSTERAGENTS_DATA_HOME="$TMP/data/lobsteragents" \
  "$TMP/bin/lobsteragents" disconnect main

python3 - "$TMP/home/.openclaw/openclaw.json" <<'PY'
import json, sys
from pathlib import Path
cfg = json.loads(Path(sys.argv[1]).read_text())
main = next((a for a in cfg.get("agents", {}).get("list", []) if isinstance(a, dict) and a.get("id") == "main"), {})
allow = main.get("subagents", {}).get("allowAgents", [])
assert not allow, f"expected disconnect to clear LobsterAgents liaison allow list, got {len(allow)}"
print("Disconnect test OK")
PY
