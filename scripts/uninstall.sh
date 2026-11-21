#!/usr/bin/env bash
# Usage: uninstall.sh <skill> <project-dir|--global>
set -euo pipefail
[ $# -eq 2 ] || { echo "usage: uninstall.sh <skill> <project-dir|--global>" >&2; exit 1; }
if [ "$2" = "--global" ]; then d="$HOME/.claude/skills"; else d="$2/.claude/skills"; fi
[ -d "$d/$1" ] || { echo "not installed: $d/$1" >&2; exit 1; }
rm -rf "${d:?}/$1" && echo "removed $d/$1"
