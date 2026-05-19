#!/usr/bin/env bash
set -euo pipefail
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${LOBSTERAGENTS_HOME:-$HOME/.lobsteragents}"
BIN_DIR="${LOBSTERAGENTS_BIN_DIR:-$HOME/.local/bin}"
OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"
OPENCLAW_CONFIG="${OPENCLAW_CONFIG:-$OPENCLAW_HOME/openclaw.json}"

is_wsl() {
  grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null
}

command_path() {
  command -v "$1" 2>/dev/null || true
}

is_windows_path() {
  local path="$1"
  [[ "$path" == /mnt/[a-zA-Z]/* || "$path" == *.exe || "$path" == *.cmd || "$path" == *.bat ]]
}

is_usable_command() {
  local name="$1"
  local path
  path="$(command_path "$name")"
  [[ -n "$path" ]] || return 1
  if is_wsl && is_windows_path "$path"; then
    return 1
  fi
  "$name" --version >/dev/null 2>&1
}

require_openclaw_ready() {
  if is_usable_command openclaw; then
    if [[ -f "$OPENCLAW_CONFIG" ]]; then
      return
    fi

    echo "ERROR: OpenClaw is installed, but setup is not complete." >&2
    echo "Missing config: $OPENCLAW_CONFIG" >&2
    echo >&2
    echo "Finish OpenClaw setup first, then rerun ./install.sh:" >&2
    echo "  openclaw onboard --accept-risk" >&2
    exit 1
  fi

  echo "ERROR: OpenClaw is not installed or is not usable in this shell." >&2
  if is_wsl; then
    echo "In WSL, make sure you run the OpenClaw Linux installer inside Ubuntu, not the Windows installer." >&2
  fi
  echo >&2
  echo "Install and set up OpenClaw first:" >&2
  echo "  curl -fsSL --proto '=https' --tlsv1.2 https://openclaw.ai/install.sh | bash" >&2
  echo >&2
  echo "Then rerun this installer:" >&2
  echo "  ./install.sh" >&2
  exit 1
}

require_openclaw_ready

mkdir -p "$INSTALL_DIR" "$BIN_DIR"
rsync -a --delete --exclude='.git' --exclude='.DS_Store' "$SOURCE_DIR/" "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/bin/lobsteragents"
ln -sf "$INSTALL_DIR/bin/lobsteragents" "$BIN_DIR/lobsteragents"
echo "Installed LobsterAgents CLI: $BIN_DIR/lobsteragents"
echo
"$BIN_DIR/lobsteragents" install
echo
echo "If $BIN_DIR is not on PATH, add this to your shell profile:"
echo "  export PATH=\"$BIN_DIR:\$PATH\""
