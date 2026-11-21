#!/usr/bin/env bash
# Install a skill from this library into a project or global skills dir (copy, not symlink: works in cloud sessions).
# Usage:
#   install.sh <skill> <project-dir>            -> <project-dir>/.claude/skills/<skill>
#   install.sh <skill> --global                 -> ~/.claude/skills/<skill>
#   install.sh --remote <owner/repo> <skill> <project-dir|--global> [ref]
set -euo pipefail
die(){ echo "error: $*" >&2; exit 1; }
dest_for(){ if [ "$1" = "--global" ]; then echo "$HOME/.claude/skills"; else echo "$1/.claude/skills"; fi; }

if [ "${1:-}" = "--remote" ]; then
  [ $# -ge 4 ] || die "usage: install.sh --remote <owner/repo> <skill> <dir|--global> [ref]"
  repo=$2 skill=$3 target=$4 ref=${5:-main}
  tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
  git clone --depth 1 --branch "$ref" "https://github.com/$repo.git" "$tmp/src" >/dev/null 2>&1 || die "clone failed for $repo@$ref"
  src="$tmp/src/skills/$skill"
else
  [ $# -eq 2 ] || die "usage: install.sh <skill> <project-dir|--global>"
  skill=$1 target=$2
  src="$(cd "$(dirname "$0")/.." && pwd)/skills/$skill"
fi
[ -f "$src/SKILL.md" ] || die "skill '$skill' not found"
dest="$(dest_for "$target")"; mkdir -p "$dest"
rm -rf "${dest:?}/$skill"; cp -r "$src" "$dest/$skill"
echo "installed $skill -> $dest/$skill"
