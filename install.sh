#!/usr/bin/env bash
# Install (or remove) the Claude desktop look into the Herdr app's home.
#
#   ./install.sh              copy themes, layouts and the sidebar mod
#   ./install.sh --switch     copy, then switch the open window to the claude-code layout
#   ./install.sh --uninstall  remove the copied files and the mod folder
#
# HERDR_APP_HOME picks another home, as it does for herdr-app.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
home="${HERDR_APP_HOME:-$HOME/.config/herdr-app}"
cd "$src"

# The mod goes first so the layouts that use it never load without it.
mods=(mods/claude-chrome)
files=(
  mods/claude-chrome/*
  themes/claude-desktop-dark.json
  themes/claude-desktop-light.json
  # Old theme names, kept one more release for settings.json files that name them.
  themes/claude-code-dark.json
  themes/claude-code-light.json
  layouts/claude-code.json
  layouts/claude-code.svg
  layouts/claude-desktop.json
  layouts/claude-desktop.svg
)

case "${1:-}" in
  "" | --switch)
    for f in "${files[@]}"; do
      install -D -m 0644 "$src/$f" "$home/$f"
      echo "installed $home/$f"
    done
    if [[ "${1:-}" == --switch ]]; then
      herdr-app do layout.switch --name claude-code
    fi
    ;;
  --uninstall)
    for f in "${files[@]}"; do
      rm -f "$home/$f"
      echo "removed $home/$f"
    done
    # Herdr writes its own files (jsconfig.json, gpui-kit.d.ts) into mod folders.
    for d in "${mods[@]}"; do
      rm -rf "${home:?}/$d"
      echo "removed $home/$d"
    done
    ;;
  *)
    echo "usage: $0 [--switch | --uninstall]" >&2
    exit 2
    ;;
esac
