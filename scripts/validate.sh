#!/usr/bin/env bash
# Checks: frontmatter name matches dir, description present, INDEX.md row exists, SKILL.md size.
set -euo pipefail
cd "$(dirname "$0")/.."
fail=0
for f in skills/*/SKILL.md; do
  d=$(basename "$(dirname "$f")")
  name=$(awk '/^---$/{c++;next} c==1 && /^name:/{sub(/^name: */,"");print;exit}' "$f")
  desc=$(awk '/^---$/{c++;next} c==1 && /^description:/{print;exit}' "$f")
  [ "$name" = "$d" ] || { echo "FAIL $d: frontmatter name '$name' != dir"; fail=1; }
  [ -n "$desc" ] || { echo "FAIL $d: missing description"; fail=1; }
  grep -q "skills/$d/SKILL.md" INDEX.md || { echo "FAIL $d: not in INDEX.md"; fail=1; }
  n=$(wc -l <"$f"); [ "$n" -le 300 ] || echo "WARN $d: $n lines (>300, move bulk to references/)"
done
for p in $(grep -o 'skills/[a-z0-9-]*/SKILL.md' INDEX.md); do [ -f "$p" ] || { echo "FAIL INDEX points to missing $p"; fail=1; }; done
[ $fail -eq 0 ] && echo "OK: $(ls skills | wc -l) skill(s) valid"
exit $fail
