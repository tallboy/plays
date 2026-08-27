# Plays

A lightweight, chainable suite of engineering skills for producing **verifiable code output** from a model. Works on any repo. Designed to be extended.

Three layers:

1. **A router** (`tallboy-mode`) that matches the task to a playbook and turns the playbook's steps into the session's todo list — verbatim, with skips visible.
2. **Principles** — 14 decision lenses, loaded only when applied. The router carries a one-line index; each leaf is read on use.
3. **Workhorse skills** — verification, adversarial review, design bakeoffs, and prose discipline, each invokable on its own or chained by the router.

```
plays/
├── tallboy-mode/         The router: triggers, principle index, playbook table
│   └── playbooks/        investigation · bug-fix · feature · refactor ·
│                         prototype · eval · ship · figure-it-out
├── principles/           14 leaves, each a one-idea skill
├── verify-this/          Falsifiable claim → baseline/treatment → graded verdict
├── bootstrap-verify/     Generates a repo-specific verify skill + feature map,
│                         then proves it by running it
├── adversarial-review/   Independent reviewers → consensus-weighted verdict
├── arena/                N candidates → blind cross-judge → pick → graft → verify
├── unslop/               Cut AI tells from prose
└── epistemics/           Confidence tiers for investigation output
```

## Install

Copy what you need into a project's skills directory:

```bash
# The router (playbooks come with it) and the principles
# Principles copy individually — Claude Code discovers skills exactly one
# directory deep, so a nested principles/ folder would never load.
cp -r plays/tallboy-mode plays/principles/principle-* .claude/skills/

# Individual skills as needed
cp -r plays/verify-this plays/adversarial-review .claude/skills/
```

Skills reference each other by name only, never by relative path, so any subset installs cleanly. Then invoke `/tallboy-mode` at the start of a task, or any skill directly.

## The contract that makes it work

Three rules, enforced by the router:

- **Verbatim steps.** The matched playbook's steps become the todo list as written, before any task-specific planning. A step you skip stays in the list as `skip: <reason>` — a reason is a fact about the task, not a mood. Skipping silently is not allowed.
- **Citation integrity.** Naming a principle must trace to a real decision its rule drove. A citation with no decision behind it means the leaf was never read.
- **Honest verdicts.** VERIFIED / NOT VERIFIED / INCONCLUSIVE, with evidence strength named. Inconclusive is not a pass. A gate that silently skips its check is not a gate. Report outcomes, not command names.

## Making it stick in a new repo

Skills are the *soft* layer of enforcement — an agent can forget them. The suite's own advice (`principle-encode-lessons-in-structure`) is to push what recurs into the hard layers: the repo's architecture and its CI. Start a new repo with `bootstrap-verify` so "verified" means something, and every time a correction repeats, turn it into a lint or a check instead of more prose.

## Extending

Add a playbook: one file in `tallboy-mode/playbooks/`, 15–35 lines, plus a one-line entry in the router's table naming what distinguishes it from its nearest neighbor. Add a principle: one leaf dir plus an index line in the router, written in "apply when…" form. Before promoting a change to any skill, run the Eval playbook — blinded, judged, compared against the current version.

## Vendoring

Installs are copies, and copies diverge. The expected divergence is reference-targets only — a copied skill pointing at the host repo's own verify skill or command names instead of a sibling that wasn't copied. Record each retarget in the copy's commit message so it survives an upgrade. To upgrade: re-copy from this repo, reapply the recorded retargets, and if the change touched the router or a principle, rerun the eval (`evals/`) and compare against `evals/BASELINE.md`.

## Checks

`bash scripts/check.sh` (also CI on every push) enforces the structure: frontmatter present and trigger-form, skill names matching their dirs, the install command landing every skill one directory deep, no relative links, no dangling router references, and a per-file word ratchet. Every check encodes a failure that actually happened once.

## Provenance

Distilled from pstack (Lauren "poteto" Tan's Cursor plugin — the source of the router shape, most principle wording, arena, and the verification-skill generator), the thermos and cursor-team-kit plugins (adversarial review shape, verify-this), and the dashi project's command suite (unslop, epistemics, the skip-with-reason and five-heading PR conventions).
