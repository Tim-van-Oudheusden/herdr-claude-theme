#!/usr/bin/env bash
# Install (or remove) the Claude Code look into the Herdr app's home.
#
#   ./install.sh              copy themes and the layout
#   ./install.sh --switch     copy, then switch the open window to the layout
#   ./install.sh --uninstall  remove the copied files
#
# HERDR_APP_HOME picks another home, as it does for herdr-app.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
home="${HERDR_APP_HOME:-$HOME/.config/herdr-app}"

files=(
  themes/claude-code-dark.json
  themes/claude-code-light.json
  layouts/claude-code.json
  layouts/claude-code.svg
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
    ;;
  *)
    echo "usage: $0 [--switch | --uninstall]" >&2
    exit 2
    ;;
esac
