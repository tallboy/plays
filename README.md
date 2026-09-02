# Plays

A lightweight, chainable suite of engineering skills for producing **verifiable code output** from a model. Works on any repo. Designed to be extended.

Three layers:

1. **A router** (`go-tallboy`) that matches the task to a playbook and turns the playbook's steps into the session's todo list — verbatim, with skips visible.
2. **Principles** — 14 decision lenses, loaded only when applied. The router carries a one-line index; each leaf is read on use.
3. **Workhorse skills** — verification, adversarial review, design bakeoffs, review response, skill authoring, and prose discipline, each invokable on its own or chained by the router.

```
plays/
├── go-tallboy/         The router: triggers, principle index, playbook table
│   └── playbooks/        investigation · bug-fix · feature · refactor ·
│                         prototype · eval · backlog · ship · figure-it-out
├── principles/           14 leaves, each a one-idea skill
├── verify-this/          Falsifiable claim → baseline/treatment → graded verdict
├── bootstrap-verify/     Generates a repo-specific verify skill + feature map,
│                         then proves it by running it
├── adversarial-review/   Independent reviewers → consensus-weighted verdict
├── receive-review/       Respond to review: verify each item, push back, no theater
├── arena/                N candidates → blind cross-judge → pick → graft → verify
├── author-skills/        Write skills against observed failures, promote via eval
├── unslop/               Cut AI tells from prose
└── epistemics/           Confidence tiers for investigation output
```

## What each skill does

| Skill | Invoke | Function |
|---|---|---|
| `go-tallboy` | `/go-tallboy`, or at the start of any multi-step task | Matches the task to a playbook, copies its steps into the todo list verbatim, indexes the principles, and fires the standing triggers below. |
| `verify-this` | "verify this", "prove it works", "did this fix it" | Restates a claim falsifiably, captures baseline and treatment, and returns VERIFIED / NOT VERIFIED / INCONCLUSIVE with the evidence strength named. |
| `bootstrap-verify` | A repo with no scripted way to drive its real surface | Generates a repo-specific `verify-<repo>` skill plus a feature map, then proves the skill by running it. Run once per new repo. |
| `adversarial-review` | "review this", a contested design, any pre-merge review | Spawns independent reviewers and returns a consensus-weighted verdict — the *giving* side of review. |
| `receive-review` | Review feedback arrives on your work | The *receiving* side: verify every item against the codebase before implementing any, push back with reasoning when the feedback is wrong, ban performative agreement. |
| `arena` | A design decision with no codebase precedent | Builds N candidate implementations, cross-judges them blind, picks a winner, grafts the losers' best ideas, verifies the result. |
| `author-skills` | Writing or editing a skill, playbook, or principle | Capture the failure transcript first, match the guidance form to the failure type, keep descriptions trigger-only, promote only through a blinded eval. |
| `unslop` | Any prose a person will read (PR body, issue, docs, the reply) | Cuts AI tells at generation time, not as cleanup. |
| `epistemics` | "why is this built this way?", answers assembled from history | Grades each claim by confidence tier so the reader knows fact from inference. |

**Playbooks** ship inside the router and are not separately installed: Investigation (cited answer, no diff), Bug fix (reproduce → root-cause → fix with runtime evidence), Feature (named data shape → design brief → verifiable units), Refactor (behavior-preserving), Prototype (throwaway sketch to settle a fork), Eval (blinded test of a skill or prompt change), Backlog (the issue loop end to end), Ship (the PR, invoked by every other playbook), and Figure-it-out (the fallback and the escalation for cross-cutting work).

**Principles** install individually as `principle-<name>` skills; the router carries the when-to-apply index and each leaf loads only when applied. Core: laziness-protocol, foundational-thinking, minimize-reader-load. Architecture: model-the-domain, type-system-discipline, make-operations-idempotent, migrate-callers-then-delete-legacy. Verification: prove-it-works, fix-root-causes, sequence-verifiable-units. Delegation: guard-the-context-window, never-block-on-the-human. Meta: build-the-lever, encode-lessons-in-structure.

## Install

Skills load from a `skills/` directory exactly one level deep — which is why the principles copy individually rather than as a nested `principles/` folder.

**Into one project** (`.claude/skills/` at the repo root):

```bash
mkdir -p .claude/skills
cp -r plays/go-tallboy plays/principles/principle-* .claude/skills/
cp -r plays/verify-this plays/bootstrap-verify plays/adversarial-review plays/arena \
      plays/unslop plays/epistemics plays/receive-review plays/author-skills .claude/skills/
```

**Globally** (every repo on the machine) — same command against `~/.claude/skills/`:

```bash
mkdir -p ~/.claude/skills
cp -r plays/go-tallboy plays/principles/principle-* ~/.claude/skills/
cp -r plays/verify-this plays/bootstrap-verify plays/adversarial-review plays/arena \
      plays/unslop plays/epistemics plays/receive-review plays/author-skills ~/.claude/skills/
```

Skills reference each other by name only, never by relative path, so any subset installs cleanly — the router alone is useful, and each workhorse skill stands on its own. Two things stay per-repo regardless of a global install: the `verify-<repo>` skill that bootstrap-verify generates, and the `project-conventions` skill described under Project layer. Then invoke `/go-tallboy` at the start of a task, or any skill directly.

## The contract that makes it work

Three rules, enforced by the router:

- **Verbatim steps.** The matched playbook's steps become the todo list as written, before any task-specific planning. A step you skip stays in the list as `skip: <reason>` — a reason is a fact about the task, not a mood. Skipping silently is not allowed.
- **Citation integrity.** Naming a principle must trace to a real decision its rule drove. A citation with no decision behind it means the leaf was never read.
- **Honest verdicts.** VERIFIED / NOT VERIFIED / INCONCLUSIVE, with evidence strength named. Inconclusive is not a pass. A gate that silently skips its check is not a gate. Report outcomes, not command names.

## Making it stick in a new repo

Skills are the *soft* layer of enforcement — an agent can forget them. The suite's own advice (`principle-encode-lessons-in-structure`) is to push what recurs into the hard layers: the repo's architecture and its CI. Start a new repo with `bootstrap-verify` so "verified" means something, and every time a correction repeats, turn it into a lint or a check instead of more prose.

## Extending

Add a playbook: one file in `go-tallboy/playbooks/`, 15–35 lines, plus a one-line entry in the router's table naming what distinguishes it from its nearest neighbor. Add a principle: one leaf dir plus an index line in the router, written in "apply when…" form. Author either per the `author-skills` skill: capture the failure without the guidance first, write against the transcript, and before promoting any change, run the Eval playbook — blinded, judged, compared against the current version.

## Project layer

A repo makes the suite its own with one extra skill: `.claude/skills/project-conventions/` (fixed name, under 60 lines). It declares project playbook rows (matched before the generic table), backlog conventions (claim command, branch prefix, label rules, protected paths), and the name of the repo's verify skill; project playbooks live at `project-conventions/playbooks/*.md`. The vendored router stays byte-identical everywhere — upgrades are a plain re-copy. New-repo onboarding: copy the router + principles, run bootstrap-verify to generate `verify-<repo>`, write a short project-conventions. Done.

## Vendoring

Installs are copies, and copies diverge. The expected divergence is reference-targets only — a copied skill pointing at the host repo's own verify skill or command names instead of a sibling that wasn't copied. Record each retarget in the copy's commit message so it survives an upgrade. To upgrade: re-copy from this repo, reapply the recorded retargets, and if the change touched the router or a principle, rerun the eval (`evals/`) and compare against `evals/BASELINE.md`.

## Checks

`bash scripts/check.sh` (also CI on every push) enforces the structure: frontmatter present and trigger-form, skill names matching their dirs, the install command landing every skill one directory deep, no relative links, no dangling router references, and a per-file word ratchet. Every check encodes a failure that actually happened once.

## Provenance

Distilled from pstack (Lauren "poteto" Tan's Cursor plugin — the source of the router shape, most principle wording, arena, and the verification-skill generator), the thermos and cursor-team-kit plugins (adversarial review shape, verify-this), the dashi project's command suite (unslop, epistemics, the skip-with-reason and five-heading PR conventions), and obra's Superpowers plugin (receive-review's response pattern and anti-sycophancy rules; author-skills' baseline-first method, form-matching table, and trigger-only descriptions; the bug-fix fix counter and red-leg proof; the single-message dispatch rule).
