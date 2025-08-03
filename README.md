# 📦 Application Installer Script

This Bash script automates the installation of applications and their dependencies using a JSON-based configuration and a Python installer (`appInstaller.py`).

---

## 🛠 Features

- Automatically ensures **Python 3** is installed.
- Runs a Python script to process `.json` install definitions.
- Supports:
  - Bulk installation of all configs (applications supported: nvim, tmux, zsh)
  - Selective installation of specific apps
  - Dry run mode to preview actions

---

## 🚀 Usage & Examples

Run the script with optional flags and app names:

```bash
./install.sh [--dry] [app1 app2 ...]
```

## ⚙️ Loading Configs

The script `load_config.sh` creates a symlink in the home directory for each file or folder inside the `dotfiles` directory. If a configuration file or folder already exists, it will be backed up before linking.
