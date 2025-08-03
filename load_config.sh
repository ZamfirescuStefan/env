#!/usr/bin/env bash

set -e

CONFIGS_DIR="./configs"
HOME_DIR="$HOME"
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")

echo "🔧 Preparing to link dotfiles from $CONFIGS_DIR"

backup_if_exists() {
  local target_path="$1"
  if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
    local backup_path="${target_path}.backup.${TIMESTAMP}"
    echo "📦 Backing up $target_path to $backup_path"
    mv "$target_path" "$backup_path"
  fi
}

shopt -s nullglob dotglob

# Symlink entire .config folder
if [ -d "$CONFIGS_DIR/.config" ]; then
  target="$HOME_DIR/.config"
  backup_if_exists "$target"
  echo "🔗 Linking entire .config folder"
  ln -sfn "$(realpath "$CONFIGS_DIR/.config")" "$target"
fi

DOTFILES_DIR="$CONFIGS_DIR/dotfiles"
echo "📦 Linking individual dotfiles from $DOTFILES_DIR..."

# Link individual dotfiles inside configs/dotfiles/
for file in "$DOTFILES_DIR"/*; do
  basefile=$(basename "$file")
  # Skip . and ..
  if [[ "$basefile" == "." || "$basefile" == ".." ]]; then
    continue
  fi
  [ -e "$file" ] || continue

  target="$HOME_DIR/$basefile"
  backup_if_exists "$target"

  echo "🔗 Linking file $basefile"
  ln -sfn "$(realpath "$file")" "$target"
done

echo "✅ Configuration successfully linked."

