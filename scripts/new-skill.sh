#!/usr/bin/env bash
# Scaffold a skill from templates/skill-template and append an INDEX.md row.
# Usage: new-skill.sh <kebab-name> ["use when ..."]
set -euo pipefail
cd "$(dirname "$0")/.."
name=${1:-}; use=${2:-TODO: use when ...}
[[ "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || { echo "usage: new-skill.sh <kebab-name> [\"use when ...\"]" >&2; exit 1; }
[ ! -e "skills/$name" ] || { echo "error: skills/$name exists" >&2; exit 1; }
cp -r templates/skill-template "skills/$name"
sed -i "s/^name: skill-name/name: $name/" "skills/$name/SKILL.md"
echo "| $name | $use | \`skills/$name/SKILL.md\` |" >> INDEX.md
echo "created skills/$name; edit SKILL.md + INDEX row, then run scripts/validate.sh"
