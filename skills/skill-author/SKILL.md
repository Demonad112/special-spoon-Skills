---
name: skill-author
description: Write a new skill for this library to spec. Use when asked to "create a skill", "add a skill", "turn this workflow into a skill", or to refactor an existing skill in special-spoon-Skills.
allowed-tools: Bash(scripts/new-skill.sh:*), Bash(scripts/validate.sh:*), Read, Write, Edit
---

# Skill Author

**Goal:** produce a valid, minimal skill that passes `scripts/validate.sh` and follows `docs/CONVENTIONS.md`.

**Inputs:** the workflow to encode (rough notes are fine), trigger phrases, desired output format.

## Steps
1. Read `docs/CONVENTIONS.md`. Do not store case data, PII, secrets or evidence in the skill.
2. Run `scripts/new-skill.sh <kebab-name> "<use when ...>"` (scaffolds from the template and appends the INDEX row).
3. Edit `skills/<name>/SKILL.md`:
   - `description`: what + when, specific trigger phrases, under ~300 chars.
   - `allowed-tools`: least privilege only.
   - Body: Goal, Inputs, numbered Steps, exact Output format, Guardrails/failure points.
   - Keep under ~300 lines; push bulk to `references/` and say when to read it. Put deterministic work in `scripts/`.
4. Add one worked example in `references/example.md` (synthetic data only).
5. If imported from elsewhere, record upstream source + version at the top.
6. Tighten the INDEX row (name, use-when, path).
7. Run `scripts/validate.sh`; fix until OK.
8. One skill per PR; title `skill: <name>`.

## Output format
Files created/changed, the validate result, and a one-line summary of the trigger phrases.

## Guardrails / failure points
- Directory name must equal frontmatter `name` (kebab-case); skills live directly under `skills/`.
- Vague descriptions cause mis-triggering; include concrete phrases.
- Don't duplicate content that belongs in `references/`.
