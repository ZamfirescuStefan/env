#!/usr/bin/env bash

set -e

DOTFILES_DIR="./dotfiles"
HOME_DIR="$HOME"
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")

echo "🔧 Preparing to link dotfiles from $DOTFILES_DIR"

backup_if_exists() {
  local target_path="$1"
  if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
    local backup_path="${target_path}.backup.${TIMESTAMP}"
    echo "📦 Backing up $target_path to $backup_path"
    mv "$target_path" "$backup_path"
  fi
}

shopt -s nullglob dotglob

echo "📦 Linking individual dotfiles from $DOTFILES_DIR..."

# Link individual dotfiles inside ./dotfiles/
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

