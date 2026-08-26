# Plays

Modular software engineering plays for AI coding assistants. Load 2-3 into your `CLAUDE.md`, `.cursorrules`, or chat prompt to give your AI agent explicit process guidance.

Each play follows the [AgentSkills.io](https://agentskills.io/specification) spec: a directory with `SKILL.md` (~800 tokens) and optional `references/` for deep-dive material.

---

## Quick Start

```markdown
# In AGENTS.md, CLAUDE.md, or .cursorrules — load what you need:
@plays/define/planning-and-task-breakdown/SKILL.md
@plays/build/incremental-implementation/SKILL.md
@plays/verify/test-driven-development/SKILL.md
```

Or copy a play into your project:

```bash
cp -r plays/build/incremental-implementation/ .claude/skills/
```

---

## Plays

### Define — Clarity before code

| Play | Use when... |
|------|-------------|
| [idea-refinement](plays/define/idea-refinement/SKILL.md) | Requirements are vague, stakeholders misaligned |
| [planning-and-task-breakdown](plays/define/planning-and-task-breakdown/SKILL.md) | Breaking work into trackable steps |
| [spec-driven-development](plays/define/spec-driven-development/SKILL.md) | New features, breaking changes, architecture shifts |

### Build — Quality implementation

| Play | Use when... |
|------|-------------|
| [incremental-implementation](plays/build/incremental-implementation/SKILL.md) | Default approach — one step, one commit |
| [context-engineering](plays/build/context-engineering/SKILL.md) | Setting up AGENTS.md, project context for AI |
| [frontend-ui-engineering](plays/build/frontend-ui-engineering/SKILL.md) | Building UI components and pages |
| [api-and-interface-design](plays/build/api-and-interface-design/SKILL.md) | Designing APIs, contracts, interfaces |

### Verify — Prove correctness

| Play | Use when... |
|------|-------------|
| [test-driven-development](plays/verify/test-driven-development/SKILL.md) | Writing tests first (red-green-refactor) |
| [debugging-error-recovery](plays/verify/debugging-error-recovery/SKILL.md) | Investigating and fixing bugs |
| [browser-testing-devtools](plays/verify/browser-testing-devtools/SKILL.md) | E2E testing, DevTools debugging |

### Review — Quality gates

| Play | Use when... |
|------|-------------|
| [code-review-quality](plays/review/code-review-quality/SKILL.md) | Reviewing PRs (5-axis framework) |
| [security-hardening](plays/review/security-hardening/SKILL.md) | Security audit, OWASP checks |
| [performance-optimization](plays/review/performance-optimization/SKILL.md) | Profiling, bottleneck analysis |

### Ship — Deploy with confidence

| Play | Use when... |
|------|-------------|
| [git-workflow-versioning](plays/ship/git-workflow-versioning/SKILL.md) | Branching, tagging, releases, changelogs |
| [ci-cd-automation](plays/ship/ci-cd-automation/SKILL.md) | Pipeline setup, quality gates, deployment |
| [documentation-adrs](plays/ship/documentation-adrs/SKILL.md) | Architecture Decision Records |
| [shipping-launch](plays/ship/shipping-launch/SKILL.md) | Production readiness checklist |

---

## What to Load

| Situation | Skills |
|-----------|--------|
| **Bug fix** | debugging-error-recovery, test-driven-development |
| **Small feature** | planning-and-task-breakdown, incremental-implementation |
| **Large feature** | spec-driven-development, planning-and-task-breakdown |
| **Code review** | code-review-quality, security-hardening |
| **Performance issue** | performance-optimization, browser-testing-devtools |
| **Ready to ship** | ci-cd-automation, shipping-launch |

---

## Reference Material

Some plays include a `references/` directory with deep-dive content — load on demand when stuck or learning:

```markdown
@plays/build/incremental-implementation/references/pitfalls.md    # When stuck
@plays/verify/test-driven-development/references/examples.md      # When learning
```

Reference types: `anti-rationalization.md` (why it matters), `pitfalls.md` (common mistakes), `examples.md` (walkthroughs), `advanced.md` (edge cases).

---

## Directory Structure

```
plays/
├── README.md
└── plays/<phase>/<play-name>/
    ├── SKILL.md              # Loadable play (~800 tokens)
    └── references/           # Optional deep-dive material
        ├── anti-rationalization.md
        ├── pitfalls.md
        ├── examples.md
        └── advanced.md
```

Phases: `define/`, `build/`, `verify/`, `review/`, `ship/`
