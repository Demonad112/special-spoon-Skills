# special-spoon-Skills

Personal skill library. Skills live here, **not** in any project's `.claude/skills` or `~/.claude/skills`, so they cost **zero tokens** in a session until you explicitly pull one in.

## How it works

| Layer | Context cost | Purpose |
|---|---|---|
| This repo | none (never auto-loaded) | Storage |
| `INDEX.md` | ~1 line/skill, read only when asked | Lookup table: name → trigger → path |
| `skills/<name>/SKILL.md` | only when invoked | The skill itself |

## Using a skill (pick one)

1. **Ad hoc (most common):** with this repo attached to the session, say
   *"Use the `code-review` skill from special-spoon-Skills on PR 12."*
   Claude reads `INDEX.md` → reads `skills/code-review/SKILL.md` → follows it.
2. **Install into a project** (makes it a real `/slash` skill there, ~100 tokens for its description):
   `scripts/install.sh code-review /path/to/project` (project) or `scripts/install.sh code-review --global` (`~/.claude/skills`).
3. **Remote one-liner** (from any repo/session with network access to GitHub):
   `scripts/install.sh --remote demonad112/special-spoon-skills code-review .`

Remove with `scripts/uninstall.sh <name> [dir|--global]`.

## Layout

```
skills/<name>/SKILL.md        # required: frontmatter name + description, then instructions
skills/<name>/references/     # optional: long docs loaded only when SKILL.md says so
skills/<name>/scripts/        # optional: deterministic helpers
templates/SKILL.template.md   # copy to start a new skill
INDEX.md                      # keep in sync (scripts/validate.sh checks)
docs/                         # conventions, roadmap
```

## Adding a skill

1. `cp -r templates/skill-template skills/<name>` and edit `SKILL.md`.
2. Add a row to `INDEX.md`.
3. `scripts/validate.sh` must pass.
4. PR → merge.

See `docs/CONVENTIONS.md` and `docs/ROADMAP.md`.
