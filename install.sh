#!/usr/bin/env bash
set -euo pipefail
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${LOBSTERCLAW_HOME:-$HOME/.lobsterclaw}"
BIN_DIR="${LOBSTERCLAW_BIN_DIR:-$HOME/.local/bin}"
OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"
OPENCLAW_CONFIG="${OPENCLAW_CONFIG:-$OPENCLAW_HOME/openclaw.json}"
OPENCLAW_INSTALL_URL="${OPENCLAW_INSTALL_URL:-https://openclaw.ai/install.sh}"

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

download_openclaw_installer() {
  local dest="$1"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL --proto '=https' --tlsv1.2 --retry 3 --retry-delay 1 -o "$dest" "$OPENCLAW_INSTALL_URL"
    return
  fi

  if command -v wget >/dev/null 2>&1; then
    wget -q --https-only --secure-protocol=TLSv1_2 -O "$dest" "$OPENCLAW_INSTALL_URL"
    return
  fi

  echo "ERROR: OpenClaw is not installed, and neither curl nor wget is available to fetch the official installer." >&2
  exit 1
}

ensure_openclaw_cli() {
  if is_usable_command openclaw; then
    return
  fi

  local installer
  installer="$(mktemp)"
  trap "rm -f '$installer'" EXIT

  echo "OpenClaw CLI not found or not usable. Running the official OpenClaw installer..."
  download_openclaw_installer "$installer"
  bash "$installer"
  export PATH="$HOME/.local/bin:$OPENCLAW_HOME/bin:$HOME/.npm-global/bin:$PATH"
  hash -r

  if ! is_usable_command openclaw; then
    echo "ERROR: The official OpenClaw installer completed, but the openclaw command is still not usable." >&2
    echo "Run the OpenClaw installer directly, then rerun ./install.sh:" >&2
    echo "  curl -fsSL --proto '=https' --tlsv1.2 $OPENCLAW_INSTALL_URL | bash" >&2
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

ensure_openclaw_cli
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
