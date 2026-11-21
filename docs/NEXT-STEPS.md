# Next Steps: Skill Library Build Plan

Paste this file (or point Claude at it) in the next chat. Work top to bottom; each phase ends in one PR.

## Current state
- `skills/code-review` (imported from Anthropic plugin v1.0.1), INDEX.md, install/uninstall/validate scripts, template, conventions.
- Zero auto-loaded context: nothing here is picked up by a session unless the repo is attached and a skill is requested or installed.

## Phase 0: Verify access (10 min)
1. New chat: attach this repo (`add_repo demonad112/special-spoon-skills`).
2. Prompt: `Read INDEX.md in special-spoon-Skills, then run the code-review skill on PR <n>.` Confirm it loads only that SKILL.md.
3. Test install path: `scripts/install.sh code-review .` in a scratch repo, confirm `/code-review` appears, then uninstall.
4. Check the cloud-session note in code-review works with `mcp__github__*` (no `gh` there). Fix the skill if not.

## Phase 1: Harden the foundation
- [ ] GitHub Action: run `scripts/validate.sh` on every PR.
- [ ] `scripts/new-skill.sh <name>`: scaffold from template + append INDEX row.
- [ ] Add `skills/_meta/skill-author`: wraps your conventions so Claude writes new skills to spec.
- [ ] Decide: repo public vs private. Private needs the repo attached to each session; public allows `install.sh --remote`.
- [ ] Optional: add `.claude-plugin/marketplace.json` so `/plugin marketplace add` + per-skill install works from any machine.

## Phase 2: Port your existing workflows into skills (highest ROI first)
Convert anything you currently re-explain in prompts. Use skill-creator to draft, then trim.

| Priority | Skill | What it encodes | Why |
|---|---|---|---|
| 1 | `dns-log-analysis` | Triage of DNS/DoH logs: baselining, beaconing, DGA/entropy, NXDOMAIN spikes, rare-domain ranking, output as facts / interpretation / action | Core to your work; repeatable method |
| 2 | `ios-macos-diagnostics` | sysdiagnose / unified log / sharkdp-style triage: what to pull, predicates, timelines, artefact locations | Same re-explaining every case |
| 3 | `incident-timeline` | Raw evidence → normalized UTC timeline → gaps → hypotheses with confidence | Evidence rigor, consistent output |
| 4 | `investigation-report` | Fraud/LP case write-up SOP: facts vs inference, exhibits list, defensible wording (no PII stored in the skill) | Template-driven, saves hours |
| 5 | `firewall-log-triage` | Rule-hit analysis, geo/ASN outliers, port-scan and exfil heuristics | Parallels DNS skill |
| 6 | `prompt-refiner` | Takes rough natural language → structured prompt (role, context, constraints, output format) per your preferences | You do this constantly |
| 7 | `notion-sop-builder` | Rough notes → SOP/checklist/template in your Notion structure | Automation staple |
| 8 | `workflow-automation-design` | Break a manual process into trigger/steps/failure points/tooling (Notion, Zapier/n8n, Gemini, Perplexity) | Matches your goal of less manual work |
| 9 | `research-synthesis` | Multi-source research → organized, actionable brief with source quality notes | Perplexity/Gemini handoff |
| 10 | `commit-and-pr` | Your commit/PR style + template | Pairs with code-review |
| 11 | `security-review` | Pending-diff security pass (OWASP-style, secrets, injection) | Complements code-review |
| 12 | `fitness-program-builder` / `game-optimization` | Lower priority, add when needed | Personal-use |

Per-skill definition of done: description with trigger phrases, <300 lines, an explicit output format, one worked example in `references/`, INDEX row, validate passes.

## Phase 3: Make it dependable
- [ ] Eval each skill: 3 realistic prompts, record pass/fail in `skills/<name>/EVALS.md`.
- [ ] Tag releases (`v1`); changelog per skill.
- [ ] Add `scripts/audit-context.sh`: counts description tokens of installed skills so you can see the cost.
- [ ] Review quarterly: delete unused skills.

## Guardrails
- Never store case data, evidence, client names, or credentials in this repo. Procedure only.
- Keep installed skills per project minimal; prefer ad hoc invocation from this repo.
- One skill per PR; PR title `skill: <name>`.

## Copy/paste kickoff prompt for next chat
```
Repo: demonad112/special-spoon-skills (attach it). Read README.md, INDEX.md, docs/CONVENTIONS.md and docs/NEXT-STEPS.md.
Execute Phase 0, report results, then Phase 1. Open one PR per phase, run scripts/validate.sh before each, merge when green.
Stop and ask only if blocked.
```
