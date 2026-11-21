# Conventions

- One directory per skill; directory name == frontmatter `name` (kebab-case).
- `description` = what + when. Specific trigger phrases. Under ~300 chars.
- SKILL.md under ~300 lines. Push bulk into `references/` and tell the skill when to read it.
- Deterministic work (parsing, hashing, formatting) goes in `scripts/`, not prose.
- Least-privilege `allowed-tools`.
- Never commit secrets, case data, PII, or client/evidence material. Skills hold procedure, not data.
- Every skill gets an INDEX.md row. `scripts/validate.sh` enforces it.
- Record upstream source + version at the top of any imported skill.
- Version via git tags (`v1`, `v2`); breaking changes to a skill's interface bump the tag.
