# Plays

A lightweight, chainable suite of engineering skills for producing **verifiable code output** from a model. Works on any repo. Designed to be extended.

Three layers:

1. **A router** (`go-tallboy`) that matches the task to a playbook and turns the playbook's steps into the session's todo list — verbatim, with skips visible.
2. **Principles** — 14 decision lenses, loaded only when applied. The router carries a one-line index; each leaf is read on use.
3. **Workhorse skills** — verification, adversarial review, design bakeoffs, review response, skill authoring, issue authoring, and prose discipline, each invokable on its own or chained by the router.

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
├── file-issue/           Bug/feature report → Acceptance Criteria + Out of Scope
├── unslop/               Cut AI tells from prose
├── epistemics/           Confidence tiers for investigation output
├── context-budget/       Token audit across agents/skills/MCP/rules → prioritized savings
├── strategic-compact/    Phase-boundary decision table for when to /compact
└── security-scan/        AgentShield audit of .claude/ config for secrets, injection, over-grants

templates/
└── OBSERVED-FAILURES.md  Seed for the remember step's log; the improve gate counts its entries
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
| `file-issue` | "file a bug", "open an issue", "write this up" | Turns a reported bug or requested feature into an issue with falsifiable Acceptance Criteria and an explicit Out of Scope — the shape Backlog treats as binding. |
| `unslop` | Any prose a person will read (PR body, issue, docs, the reply) | Cuts AI tells at generation time, not as cleanup. |
| `epistemics` | "why is this built this way?", answers assembled from history | Grades each claim by confidence tier so the reader knows fact from inference. |
| `context-budget` | "context budget", before adding another skill/agent/MCP server | Audits token overhead across agents, skills, MCP servers, rules, and CLAUDE.md; reports prioritized savings. |
| `strategic-compact` | "should I compact", a session nearing a context limit | Decides whether now is a good point to `/compact`, based on the task-phase boundary rather than window fullness. |
| `security-scan` | "security scan", before committing settings.json/CLAUDE.md/MCP changes | Audits `.claude/` config for secrets, prompt-injection surface, and permission over-grants via AgentShield. |

**Playbooks** ship inside the router and are not separately installed: Investigation (cited answer, no diff), Bug fix (reproduce → root-cause → fix with runtime evidence), Feature (named data shape → design brief → verifiable units), Refactor (behavior-preserving), Prototype (throwaway sketch to settle a fork), Eval (blinded test of a skill or prompt change), Backlog (the issue loop end to end), Ship (the PR, invoked by every other playbook), and Figure-it-out (the fallback and the escalation for cross-cutting work).

**Principles** install individually as `principle-<name>` skills; the router carries the when-to-apply index and each leaf loads only when applied. Core: laziness-protocol, foundational-thinking, minimize-reader-load. Architecture: model-the-domain, type-system-discipline, make-operations-idempotent, migrate-callers-then-delete-legacy. Verification: prove-it-works, fix-root-causes, sequence-verifiable-units. Delegation: guard-the-context-window, never-block-on-the-human. Meta: build-the-lever, encode-lessons-in-structure.

## Example prompts

One realistic trigger per skill, and the outcome it produces — not the whole workflow, just enough to see what invoking it actually gets you.

| Skill | You say | It does |
|---|---|---|
| `go-tallboy` | "Add pagination to the search results endpoint" | Matches Feature, copies its steps into the todo list verbatim, cites principles as each decision lands. |
| `verify-this` | "Did that actually fix the race condition?" | Restates the claim falsifiably, captures baseline vs. treatment, returns VERIFIED / NOT VERIFIED / INCONCLUSIVE. |
| `bootstrap-verify` | First task in a repo with no scripted way to drive it | Generates a `verify-<repo>` skill and a feature map, then proves the skill by running it. |
| `adversarial-review` | "Review this before I open the PR" | Spawns independent reviewers, returns a consensus-weighted verdict. |
| `receive-review` | "Reviewer says this should use a queue instead" | Verifies the claim against the codebase before touching anything; pushes back if the reviewer is wrong. |
| `arena` | "We need a caching strategy and there's no precedent here" | Fans out 3–4 candidates, cross-judges blind, picks a base, grafts the losers' best ideas in. |
| `author-skills` | "This skill isn't catching the mistake it's supposed to" | Captures the failure transcript, edits the skill against it, blind-evals before promoting. |
| `file-issue` | "File a bug: exports silently drop rows over 10k" | Writes it with falsifiable Acceptance Criteria and an explicit Out of Scope. |
| `unslop` | Drafting the PR description or an issue body | Cuts AI tells at generation time — no separate cleanup pass. |
| `epistemics` | "Why does this retry three times instead of circuit-breaking?" | Answers with each claim tagged by confidence tier — fact vs. inference. |
| `context-budget` | "Can we add the new Slack MCP server?" | Audits current token overhead first, reports prioritized savings before anything new loads. |
| `strategic-compact` | "Should I compact now?" mid-implementation | Checks the phase-boundary table; says no and why, or compacts with a focus message. |
| `security-scan` | About to commit a new hook or `settings.json` change | Runs AgentShield (or the manual checklist fallback), reports the grade and findings by severity. |

## The loop

Every unit of work that goes through the skill chain closes plan → test → implement → review → verify → remember → improve. Each word has a standing owner — not a skill you have to remember to invoke, something the router enforces:

| Word | Owner | How it's enforced |
|---|---|---|
| Plan | Playbook steps 1–4 of feature/bug-fix/refactor; `file-issue` | Required step, before any implementation |
| Test | Playbook steps of feature/bug-fix/refactor | Required red-leg-proof step — a test that fails before the fix, passes after |
| Implement | Playbook steps of feature/bug-fix/refactor | Required step, smallest change the evidence justifies |
| Review | **Review gate**, mandatory before Ship | A design/module boundary crossed, an auth/money/schema path touched, or self-assessed contested → `adversarial-review`; a split or unresolved verdict on high-blast-radius work → pause for the human. Otherwise skip with a real, visible reason — never silently |
| Verify | `verify-this` / `bootstrap-verify` | Required step; global router trigger; VERIFIED/NOT VERIFIED/INCONCLUSIVE is the only currency |
| Remember | `.claude/skills/OBSERVED-FAILURES.md` | A correction with nothing to encode into repo structure gets appended verbatim before the reply ends — it does not survive only in the reply's text |
| Improve | **Improve gate**, mandatory before Ship | `OBSERVED-FAILURES.md` at 3+ entries → run `author-skills`' Eval playbook over them, or skip with a real, visible reason naming when it'll happen instead |

Review and improve are gates, not skills you invoke by name — they're standing checks the router runs before every Ship, each with a real predicate and a required, visible skip. The point of a gate over a trigger phrase like "if contested" is that it doesn't rely on the agent doing the work to notice it's the one being graded.

## Install

Skills load from a `skills/` directory exactly one level deep — which is why the principles copy individually rather than as a nested `principles/` folder.

**Into one project** (`.claude/skills/` at the repo root):

```bash
mkdir -p .claude/skills
cp -r plays/go-tallboy plays/principles/principle-* .claude/skills/
cp -r plays/verify-this plays/bootstrap-verify plays/adversarial-review plays/arena \
      plays/unslop plays/epistemics plays/receive-review plays/author-skills plays/file-issue \
      plays/context-budget plays/strategic-compact plays/security-scan .claude/skills/
cp -n templates/OBSERVED-FAILURES.md .claude/skills/
```

The log copies with `-n` on purpose: re-running this to upgrade must not wipe the
corrections a repo has accumulated.

**Globally** (every repo on the machine) — same command against `~/.claude/skills/`:

```bash
mkdir -p ~/.claude/skills
cp -r plays/go-tallboy plays/principles/principle-* ~/.claude/skills/
cp -r plays/verify-this plays/bootstrap-verify plays/adversarial-review plays/arena \
      plays/unslop plays/epistemics plays/receive-review plays/author-skills plays/file-issue \
      plays/context-budget plays/strategic-compact plays/security-scan ~/.claude/skills/
```

Skills reference each other by name only, never by relative path, so any subset installs cleanly — the router alone is useful, and each workhorse skill stands on its own. Two things stay per-repo regardless of a global install: the `verify-<repo>` skill that bootstrap-verify generates, and the `project-conventions` skill described under Project layer. Then invoke `/go-tallboy` at the start of a task, or any skill directly.

## The contract that makes it work

Three rules, enforced by the router:

- **Verbatim steps.** The matched playbook's steps become the todo list as written, before any task-specific planning. A step you skip stays in the list as `skip: <reason>` — a reason is a fact about the task, not a mood. Skipping silently is not allowed.
- **Citation integrity.** Naming a principle must trace to a real decision its rule drove. A citation with no decision behind it means the leaf was never read.
- **Honest verdicts.** VERIFIED / NOT VERIFIED / INCONCLUSIVE, with evidence strength named. Inconclusive is not a pass. A gate that silently skips its check is not a gate. Report outcomes, not command names.
- **No silent gates.** The review and improve gates run before every Ship; each names its predicate and either routes to the matching skill or records `skip: <reason>` in the reply. A reason must be a fact about the diff or the backlog state, not a mood.

## Making it stick in a new repo

Skills are the *soft* layer of enforcement — an agent can forget them. The suite's own advice (`principle-encode-lessons-in-structure`) is to push what recurs into the hard layers: the repo's architecture and its CI. Start a new repo with `bootstrap-verify` so "verified" means something, and every time a correction repeats, turn it into a lint or a check instead of more prose.

## Extending

Add a playbook: one file in `go-tallboy/playbooks/`, 15–35 lines, plus a one-line entry in the router's table naming what distinguishes it from its nearest neighbor. Add a principle: one leaf dir plus an index line in the router, written in "apply when…" form. Author either per the `author-skills` skill: capture the failure without the guidance first, write against the transcript, and before promoting any change, run the Eval playbook — blinded, judged, compared against the current version.

## Project layer

A repo makes the suite its own with one extra skill: `.claude/skills/project-conventions/` (fixed name, under 60 lines). It declares project playbook rows (matched before the generic table), backlog conventions (claim command, branch prefix, label rules, protected paths), and the name of the repo's verify skill; project playbooks live at `project-conventions/playbooks/*.md`. The vendored router stays byte-identical everywhere — upgrades are a plain re-copy. New-repo onboarding: copy the router + principles, run bootstrap-verify to generate `verify-<repo>`, write a short project-conventions. Done.

## Vendoring

Installs are copies, and copies diverge. The expected divergence is reference-targets only — a copied skill pointing at the host repo's own verify skill or command names instead of a sibling that wasn't copied. Record each retarget in the copy's commit message so it survives an upgrade. To upgrade, start with `bash scripts/sync.sh <repo-or-skills-dir>`: it reports every skill as same / differs / missing, prints the differing lines so a deliberate retarget is distinguishable from upstream drift, names the project-local skills it does not manage, and fails loud on a router reference with no skill behind it. It is read-only and prints the `cp` commands rather than running them, because a blind re-copy clobbers retargets. Exit codes: 0 in sync, 1 drift, 2 dangling references, 64 usage.

Then re-copy, reapply the recorded retargets, and if the change touched the router or a principle, rerun the eval (`evals/`) and compare against `evals/BASELINE.md`.

## Checks

`bash scripts/check.sh` (also CI on every push) enforces the structure: frontmatter present and trigger-form, skill names matching their dirs, the install command landing every skill one directory deep, no relative links, no dangling router references, and a per-file word ratchet. Every check encodes a failure that actually happened once.

## Provenance

Distilled from pstack (Lauren "poteto" Tan's Cursor plugin — the source of the router shape, most principle wording, arena, and the verification-skill generator), the thermos and cursor-team-kit plugins (adversarial review shape, verify-this), the dashi project's command suite (unslop, epistemics, the skip-with-reason and five-heading PR conventions), obra's Superpowers plugin (receive-review's response pattern and anti-sycophancy rules; author-skills' baseline-first method, form-matching table, and trigger-only descriptions; the bug-fix fix counter and red-leg proof; the single-message dispatch rule), and Affaan Mustafa's Everything Claude Code (context-budget and strategic-compact's phase-boundary guide, trimmed of its hook dependency; security-scan as a thin wrapper over the separately maintained AgentShield CLI).
