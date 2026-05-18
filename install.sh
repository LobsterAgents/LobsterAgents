#!/usr/bin/env bash
set -euo pipefail
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${LOBSTERCLAW_HOME:-$HOME/.lobsterclaw}"
BIN_DIR="${LOBSTERCLAW_BIN_DIR:-$HOME/.local/bin}"
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

print_wsl_node_help() {
  cat >&2 <<'EOF'
ERROR: WSL is seeing a Windows Node/npm/OpenClaw command instead of a Linux one.

Install Node.js inside WSL, then rerun ./install.sh:
  curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
  sudo apt-get install -y nodejs
  hash -r

Then verify these paths are Linux paths, not /mnt/c/... paths:
  which node
  which npm
  which openclaw
EOF
}

install_openclaw_cli() {
  if is_usable_command openclaw; then
    return
  fi

  if ! is_usable_command npm; then
    if is_wsl; then
      print_wsl_node_help
      exit 1
    fi
    echo "ERROR: openclaw was not found, and npm is not installed." >&2
    echo "Install Node.js/npm first, then rerun ./install.sh." >&2
    exit 1
  fi

  echo "OpenClaw CLI not found. Installing OpenClaw with npm..."
  npm install -g openclaw
  hash -r

  if ! is_usable_command openclaw; then
    if is_wsl; then
      print_wsl_node_help
    else
      echo "ERROR: OpenClaw installed, but the openclaw command is not usable." >&2
      echo "Check your npm global bin directory is on PATH, then rerun ./install.sh." >&2
    fi
    exit 1
  fi
}

bootstrap_openclaw_state() {
  if [[ -f "$OPENCLAW_CONFIG" ]]; then
    return
  fi

  echo "OpenClaw config not found at $OPENCLAW_CONFIG."
  echo "Creating baseline OpenClaw state..."
  openclaw onboard \
    --non-interactive \
    --accept-risk \
    --auth-choice skip \
    --skip-daemon \
    --skip-channels \
    --skip-skills \
    --skip-search \
    --skip-ui \
    --skip-health \
    --workspace "$OPENCLAW_HOME/workspace"

  if [[ ! -f "$OPENCLAW_CONFIG" ]]; then
    echo "ERROR: OpenClaw onboarding completed, but config was not created at $OPENCLAW_CONFIG." >&2
    echo "Run OpenClaw onboarding manually, then rerun ./install.sh:" >&2
    echo "  openclaw onboard --accept-risk" >&2
    exit 1
  fi
}

install_openclaw_cli
bootstrap_openclaw_state

mkdir -p "$INSTALL_DIR" "$BIN_DIR"
rsync -a --delete --exclude='.git' --exclude='.DS_Store' "$SOURCE_DIR/" "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/bin/lobsterclaw"
ln -sf "$INSTALL_DIR/bin/lobsterclaw" "$BIN_DIR/lobsterclaw"
echo "Installed lobsterclaw CLI: $BIN_DIR/lobsterclaw"
echo
"$BIN_DIR/lobsterclaw" install
echo
echo "If $BIN_DIR is not on PATH, add this to your shell profile:"
echo "  export PATH=\"$BIN_DIR:\$PATH\""
