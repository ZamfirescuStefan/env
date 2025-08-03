#!/bin/bash

# Ensure Python is installed
ensure_python_installed() {
  if ! which python3 >/dev/null 2>&1; then
    echo "Python3 not found. Installing now..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      echo "Installing Python3 on Linux using apt..."
      sudo apt update && sudo apt install -y python3
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      echo "Installing Python3 on macOS using brew..."
      brew install python3
    else
      echo "Unsupported OS: $OSTYPE"
      exit 1
    fi

    if which python3 >/dev/null 2>&1; then
      echo "Python3 installed successfully."
    else
      echo "Failed to install Python3."
      exit 1
    fi
  fi
}

# Run the Python installer for a given JSON file
run_installer() {
  local script="$1"
  local json_file="$2"
  local dry_flag="${3:-}"

  if [ ! -f "$json_file" ]; then
    echo "JSON file not found: $json_file"
    return
  fi

  local abs_path
  abs_path=$(realpath "$json_file")
  echo "Installing from $abs_path"
  python3 "$script" "$abs_path" $dry_flag
}

# Main logic
main() {
  ensure_python_installed

  local PYTHON_SCRIPT="./appInstaller.py"
  local JSON_FOLDER="./install_configs"
  local DRY_RUN_FLAG=""

  # Parse --dry flag
  if [[ "$1" == "--dry" ]]; then
    DRY_RUN_FLAG="--dry"
    shift
  fi

  if [ $# -eq 0 ]; then
    for json in "$JSON_FOLDER"/*.json; do
      run_installer "$PYTHON_SCRIPT" "$json" "$DRY_RUN_FLAG"
    done
  else
    for app in "$@"; do
      local json_path="$JSON_FOLDER/$app.json"
      run_installer "$PYTHON_SCRIPT" "$json_path" "$DRY_RUN_FLAG"
    done
  fi
}

main "$@"
