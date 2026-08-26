# 🏀 Plays: Run the Game

**Basketball-style engineering plays.** Repeatable, tactical, proven. Get on the court and execute.

```
Situation: "I don't know where to start"
Your move: Run /tallboy-mode
```

---

## You Are the Playground

| Who You Are | Your Setup |
|---|---|
| 🐐 **The Closer** (MJ era) | Execution-focused. You ship. You iterate. Deliver before perfect. |
| 🧠 **The Orchestrator** (Magic era) | Court vision. You architect first, then execute. Team player. |
| 🔨 **The Fundamentalist** (Bird era) | Precision over flash. Textbook execution. Zero wasted motion. |
| ⚡ **The Power Move** (Kemp era) | Raw energy, straight line to the goal. Full-speed execution. |

**This playbook works for all four.** Pick your phase, run the play, stay sharp.

---

## The 5-Phase Game

```
DEFINE   → Get the blueprint (architecture, design, scope)
BUILD    → Execute with precision (code, implement, integrate)
VERIFY   → Prove it works (test, measure, validate)
REVIEW   → Quality gate (code review, security audit, perf check)
SHIP     → Drop the dunk (release, deploy, land it)
```

Each phase has **plays** (repeatable workflows) + **principles** (decision lenses).

---

## Quick Start: Pick Your Play

**I'm starting fresh:**
```
/plays/define/idea-refinement            — Vague requirements? Start here.
/plays/define/planning-and-task-breakdown — Big change? Break it down.
/plays/define/spec-driven-development    — Architecture first.
```

**I'm building:**
```
/plays/build/incremental-implementation  — One step, one commit (default move).
/plays/build/context-engineering         — Setting up for AI.
/plays/build/api-and-interface-design    — Shape before code.
/plays/build/frontend-ui-engineering     — Components and pages.
```

**I'm verifying:**
```
/plays/verify/test-driven-development    — Tests first (red-green).
/plays/verify/debugging-error-recovery   — Bug in production? Root cause.
/plays/verify/browser-testing-devtools   — E2E, profiling, DevTools.
```

**I'm reviewing:**
```
/plays/review/code-review-quality        — PR review (5-axis).
/plays/review/security-hardening         — Security audit.
/plays/review/performance-optimization   — Perf bottleneck.
```

**I'm shipping:**
```
/plays/ship/git-workflow-versioning      — Branching, tags, releases.
/plays/ship/ci-cd-automation             — Pipelines, quality gates.
/plays/ship/documentation-adrs           — Architecture decisions.
/plays/ship/shipping-launch              — Production readiness.
```

---

## The 21 Principles: When You're Stuck

Every play rests on principles. Read one when you need clarity:

**Core (always relevant):**
- 🦾 **Laziness Protocol** — Delete first, smallest change wins (Shawn Kemp)
- 🏗️ **Foundational Thinking** — Architecture before code (Larry Bird)
- 🎯 **Minimize Reader Load** — Keep heads out of clouds (Magic)
- ✅ **Prove It Works** — Test on real artifacts (MJ)

**When stuck:**
```
@plays/principles/principle-<name>/SKILL.md
```

Full principles guide: `@plays/principles/README.md`

---

## The Tallboy Mode Router

Unsure which play to run?

```
/plays/meta/tallboy-mode/SKILL.md
```

Reads your situation, calls the play, cites the principle. Magic Johnson's court vision meets MJ's execution focus.

---

## How to Load a Play

### Option 1: Inline (Cursor, Claude Code, ChatGPT)
```markdown
# In your .cursorrules, CLAUDE.md, or chat:
@plays/build/incremental-implementation/SKILL.md
```

### Option 2: Copy Locally
```bash
cp -r plays/build/incremental-implementation/ .claude/skills/
```

Then invoke:
```
/incremental-implementation
```

### Option 3: Manual (Print and Go)
Read the SKILL.md, follow the steps.

---

## The Plays Map

```
plays/
├── meta/                     # The router
│   └── tallboy-mode/         # Classify → Principle → Play
├── principles/               # 21 decision lenses
│   ├── principle-laziness-protocol/
│   ├── principle-foundational-thinking/
│   ├── principle-prove-it-works/
│   └── ... (18 more)
├── define/                   # Get clear on what you're doing
│   ├── idea-refinement/
│   ├── planning-and-task-breakdown/
│   └── spec-driven-development/
├── build/                    # Execute with precision
│   ├── incremental-implementation/
│   ├── context-engineering/
│   ├── api-and-interface-design/
│   └── frontend-ui-engineering/
├── verify/                   # Prove it works
│   ├── test-driven-development/
│   ├── debugging-error-recovery/
│   └── browser-testing-devtools/
├── review/                   # Quality gate
│   ├── code-review-quality/
│   ├── security-hardening/
│   └── performance-optimization/
└── ship/                     # Deploy with confidence
    ├── git-workflow-versioning/
    ├── ci-cd-automation/
    ├── documentation-adrs/
    └── shipping-launch/
```

---

## Philosophy

**You're not looking for a magic playbook.** You're looking for **clarity on the next move.**

Each play is ~800 tokens. Designed for one focused session. One phase complete.

Stack plays across sessions. Design → Build → Verify → Review → Ship.

---

## Basketball References

- 🐐 **Michael Jordan** — Clutch execution, never giving up, proving it in the Finals
- 🧠 **Magic Johnson** — Court vision, orchestration, seeing the whole game
- 🏹 **Larry Bird** — Textbook fundamentals, precision, killer instinct
- ⚡ **Shawn Kemp** — Raw power, straight line to the goal, full-speed execution

This playbook borrows from all four. Pick your style, run the play, stay sharp.

---

## Get Started

1. Pick your situation (define, build, verify, review, ship)
2. Load the relevant play
3. Read the principle if stuck
4. Execute the workflow
5. One testable unit per session
6. Commit, done, next

Now go run the game. 🏀

---

**Built by Tallboy.** Basketball terminology for engineering workflows. Repeatable, tactical, proven.

**Repos:** [github.com/tallboy/plays](https://github.com/tallboy/plays) | [code.devsnc.com/tommy-ryan/plays](https://code.devsnc.com/tommy-ryan/plays)
