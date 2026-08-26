---
name: tallboy-mode
description: "Basketball-style play router. Classify your game, run the right principle, execute the phase play. Magic Johnson court vision for your engineering workflow."
metadata:
  phase: meta (router)
  complexity: intermediate
  duration: "5-10 min to call the play, then per-phase execution"
  principles: 21 (from the pstack playbook)
  version: "1.0.0"
  inspiration: "Magic Johnson's court vision meets MJ's execution focus"
---

# Tallboy Mode: Run the Play

You're on the court. The clock is running. You need to execute with precision. This isn't about being a ball hog (Jordan) or passing-first (Magic). This is about **reading the court, calling the right play, and drilling it.**

## The Game: 5 Phases, 17 Plays, 21 Principles

```
Phase 1: DEFINE  — Get the blueprint (Shawn Kemp pre-dunk, reading the defense)
Phase 2: BUILD   — Execute the fundamentals (Larry Bird's cash, pure form)
Phase 3: VERIFY  — Prove it works (MJ in the Finals, no excuses)
Phase 4: REVIEW  — Quality gate (Magic's leadership, team accountability)
Phase 5: SHIP    — Drop the dunk (Kemp's in-your-face finish)
```

---

## How to Run the Play

### 1. Call the Play: Classify Your Task

Read the court. What are you actually trying to do?

| Task | Phase | Your Principle | The Play |
|------|-------|---|----------|
| Requirements foggy, stakeholders squabbling | **DEFINE** | Read: **foundational-thinking** (get the model right) | `@plays/define/idea-refinement` |
| Big change needs breaking down | **DEFINE** | Read: **laziness-protocol** (start small) | `@plays/define/planning-and-task-breakdown` |
| Architecture before code (the right call) | **DEFINE** | Read: **exhaust-the-design-space** (2-3 options) | `@plays/define/spec-driven-development` |
| One step, one commit (default move) | **BUILD** | Read: **minimize-reader-load** (keep it tight) | `@plays/build/incremental-implementation` |
| Setting up context for AI | **BUILD** | Read: **boundary-discipline** (edge clarity) | `@plays/build/context-engineering` |
| Building UI components | **BUILD** | Read: **model-the-domain** (encode the shape) | `@plays/build/frontend-ui-engineering` |
| Designing APIs or contracts | **BUILD** | Read: **type-system-discipline** (illegal states unrepresentable) | `@plays/build/api-and-interface-design` |
| Tests first, code second (red-green) | **VERIFY** | Read: **prove-it-works** (test real artifacts) | `@plays/verify/test-driven-development` |
| Bug in production, find the root | **VERIFY** | Read: **fix-root-causes** (trace to source) | `@plays/verify/debugging-error-recovery` |
| E2E testing, profiling, DevTools | **VERIFY** | Read: **sequence-verifiable-units** (atomic steps) | `@plays/verify/browser-testing-devtools` |
| Code review before merge | **REVIEW** | Read: **type-system-discipline** (catch illegal states) | `@plays/review/code-review-quality` |
| Security audit | **REVIEW** | Read: **boundary-discipline** (validate edges) | `@plays/review/security-hardening` |
| Perf bottleneck analysis | **REVIEW** | Read: **prove-it-works** (instrument, measure, verify) | `@plays/review/performance-optimization` |
| Branching, tagging, releases | **SHIP** | Read: **migrate-callers-then-delete-legacy** (no compat shims) | `@plays/ship/git-workflow-versioning` |
| CI/CD pipelines, quality gates | **SHIP** | Read: **make-operations-idempotent** (converge to end state) | `@plays/ship/ci-cd-automation` |
| Architecture Decision Records | **SHIP** | Read: **encode-lessons-in-structure** (write it down) | `@plays/ship/documentation-adrs` |
| Production launch, checklist | **SHIP** | Read: **never-block-on-the-human** (proceed, correct after) | `@plays/ship/shipping-launch` |

### 2. Read the Principle: Pre-Game Fundamentals

Before running the play, read the principle that underpins your decision. This is **Magic's court vision**—understanding WHY you're making this move.

Available principles (21 total):
```
Core (always relevant):
  - laziness-protocol
  - foundational-thinking
  - minimize-reader-load
  - prove-it-works

Define Phase:
  - exhaust-the-design-space
  - boundary-discipline

Build Phase:
  - model-the-domain
  - type-system-discipline

Verify Phase:
  - fix-root-causes
  - sequence-verifiable-units

Review Phase:
  - (add principles here)

Ship Phase:
  - migrate-callers-then-delete-legacy
  - make-operations-idempotent
  - encode-lessons-in-structure
  - never-block-on-the-human

Meta:
  - guard-the-context-window
  - boundary-discipline
  - build-the-lever
  - redesign-from-first-principles
  - subtract-before-you-add
  - outcome-oriented-execution
  - experience-first
  - separate-before-serializing-shared-state
```

Invoke directly when stuck: `@plays/principles/principle-<name>/SKILL.md`

### 3. Execute the Play

Load your play:
```markdown
# Option A: In your CLAUDE.md or chat
@plays/<phase>/<play-name>/SKILL.md

# Option B: Copy locally
cp -r plays/<phase>/<play-name>/ .claude/skills/
```

Then follow the steps. Each play is ~800 tokens, designed for one focused session.

### 4. Drop the Dunk: Verify You Shipped

Before you're done:
- ✓ One testable step completed
- ✓ One atomic commit made (or one PR reviewed)
- ✓ One principle applied and named
- ✓ One person could read your work and understand the WHY

---

## The 21 Principles: Your Playbook

Think of these as the 21 fundamental coaching rules:

**Core Plays (never miss these):**
- **Laziness Protocol** — Delete first. Shortest path wins.
- **Foundational Thinking** — Architecture before code. Get the model right.
- **Minimize Reader Load** — Keep cognitive load low. Tight code, tight prose.
- **Prove It Works** — Test on real artifacts. No simulators.

**By Phase:**
- **Define:** Exhaust the design space (2-3 prototypes, not one)
- **Build:** Model the domain (encode business logic in type)
- **Verify:** Fix root causes (don't patch symptoms)
- **Ship:** Migrate callers then delete legacy (no compatibility cruft)

---

## Non-Negotiables

No matter which play you run:

1. **Name the principle.** Before you code, say which principle matters. Aloud or in a comment.
2. **One testable unit per session.** Kemp doesn't try to dunk from halfcourt. Neither do you.
3. **Verify on real artifacts.** MJ didn't practice free throws against imaginary defenders.
4. **Know your constraints.** Time, team, stakeholders. Name them first.
5. **If you're stuck, read the principle.** Don't brute-force it.

---

## Example Playbooks: From Bench to Court

### Play 1: Bug in Production (MJ Mode)
```
Situation: Crash in production at 2am.
Your move:  
  1. Read: /principle-fix-root-causes (trace the symptom)
  2. Run: /plays/verify/debugging-error-recovery
  3. Test: /plays/verify/test-driven-development (prove the fix)
  4. Done: One atomic commit, root cause fixed, no patches.
```

### Play 2: New Feature (Magic + Bird Mode)
```
Situation: "Add authentication to the API."
Your move:
  1. Read: /principle-foundational-thinking (get user/token model right)
  2. Run: /plays/define/spec-driven-development (design first)
  3. Read: /principle-boundary-discipline (validate at edges)
  4. Run: /plays/define/planning-and-task-breakdown (break into steps)
  5. Read: /principle-type-system-discipline (make illegal states impossible)
  6. Run: /plays/build/api-and-interface-design (shape the contract)
  7. Run: /plays/build/incremental-implementation (build step-by-step)
  8. Done: One phase complete, ready for next.
```

### Play 3: Code Review Before Merge (Ref Mode)
```
Situation: PR ready, you're the reviewer.
Your move:
  1. Read: /principle-type-system-discipline (catch illegal states)
  2. Run: /plays/review/code-review-quality (5-axis review)
  3. If security concern: /plays/review/security-hardening
  4. Done: Ship with confidence or send back for edits.
```

---

## This Runs Everywhere

- **Cursor** (add to .cursorrules)
- **Claude Code** (add to CLAUDE.md)
- **Claude.ai** (paste into chat)
- **ChatGPT** (paste the SKILL.md)
- **Manual** (print the table, go to town)
- **No LLM** (you're the AI, follow the plays by hand)

Zero dependencies. Zero model-specific code. Pure basketball engineering.

---

## Tallboy Mode: The Philosophy

You're not trying to be:
- A one-man team (that's Jordan, doesn't scale)
- The passer without finishing (that's pure Magic, you ship nothing)
- The lone wolf (Bird had a team)

You're trying to be: **The right player at the right moment.**

Sometimes you're the scorer (BUILD phase). Sometimes you're the point guard reading the court (defining the architecture). Sometimes you're the defender (REVIEW phase, keeping bad code out). Sometimes you're the rebounder (cleaning up after chaos).

**The play tells you which one.**

Now get on the court. 🏀

---

## Get Started

```bash
# Clone plays repo
git clone https://github.com/tallboy/plays.git

# Pick your situation
@plays/meta/tallboy-mode/SKILL.md              # This file
@plays/define/planning-and-task-breakdown      # Big change ahead
@plays/build/incremental-implementation        # Ready to ship
@plays/verify/test-driven-development          # Write tests first
@plays/review/code-review-quality              # Review before merge
@plays/ship/shipping-launch                    # Ready for production

# Read a principle when stuck
@plays/principles/principle-prove-it-works
@plays/principles/principle-foundational-thinking
```

Good luck. You've got this. 🏀✨
