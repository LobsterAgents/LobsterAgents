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

is_interactive_install() {
  [[ "${LOBSTERAGENTS_NO_PROMPT:-0}" != "1" && "${CI:-}" == "" && -t 0 && -t 1 ]]
}

prompt_liaison() {
  is_interactive_install || return 0

  echo
  echo "Connect a liaison agent for LobsterAgents?"
  echo "  1) main (recommended)"
  echo "  2) bob"
  echo "  3) custom agent id"
  echo "  4) skip"
  read -r -p "Choose [1]: " choice || return

  local liaison
  case "${choice:-1}" in
    1) liaison="main" ;;
    2) liaison="bob" ;;
    3) read -r -p "Agent id: " liaison || return ;;
    4|s|S|skip) return ;;
    *) liaison="main" ;;
  esac

  if [[ -n "$liaison" ]]; then
    "$BIN_DIR/lobsteragents" connect "$liaison"
  fi
}

prompt_models() {
  is_interactive_install || return 0

  echo
  read -r -p "Set LobsterAgents models now? [y/N]: " answer || return
  case "$answer" in
    y|Y|yes|YES) ;;
    *) return ;;
  esac

  echo "Example for your test machine:"
  echo "  strategic: openai/gpt-5.5"
  echo "  standard/local: vllm/qwen3.6-fp8"
  read -r -p "Strategic model [openai/gpt-5.5]: " strategic || return
  read -r -p "Standard model [vllm/qwen3.6-fp8]: " standard || return
  read -r -p "Local model [same as standard]: " local_model || return

  strategic="${strategic:-openai/gpt-5.5}"
  standard="${standard:-vllm/qwen3.6-fp8}"
  local_model="${local_model:-$standard}"
  "$BIN_DIR/lobsteragents" models "$strategic" "$standard" "$local_model"
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
prompt_models
prompt_liaison
echo
echo "If $BIN_DIR is not on PATH, add this to your shell profile:"
echo "  export PATH=\"$BIN_DIR:\$PATH\""
