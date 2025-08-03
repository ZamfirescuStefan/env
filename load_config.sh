#!/usr/bin/env bash

set -e

CONFIG_SOURCE=".config"
CONFIG_TARGET="$HOME/.config"
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")

# Detect OS and install stow if missing
install_stow() {
  echo "Installing GNU Stow..."
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update && sudo apt install -y stow
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install stow
  else
    echo "Unsupported OS: $OSTYPE"
    exit 1
  fi
}

# Check and install stow if missing
if ! command -v stow >/dev/null 2>&1; then
  echo "GNU Stow not found."
  install_stow
fi

# Backup existing ~/.config if it exists and isn't a symlink
if [ -d "$CONFIG_TARGET" ] && [ ! -L "$CONFIG_TARGET" ]; then
  BACKUP_DIR="${CONFIG_TARGET}.backup.${TIMESTAMP}"
  echo "Backing up existing config to: $BACKUP_DIR"
  mv "$CONFIG_TARGET" "$BACKUP_DIR"
fi

# Ensure ~/.config exists
mkdir -p "$CONFIG_TARGET"

# Run stow to symlink the contents of .config into ~/.config
echo "Linking configuration using stow..."
stow --target="$CONFIG_TARGET" "$CONFIG_SOURCE"

echo "✅ Configuration successfully linked."
