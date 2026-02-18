# Skills

Modular software engineering skills for AI coding assistants. Load 2-3 into your `CLAUDE.md`, `.cursorrules`, or chat prompt to give your AI agent explicit process guidance.

Each skill follows the [AgentSkills.io](https://agentskills.io/specification) spec: a directory with `SKILL.md` (~800 tokens) and optional `references/` for deep-dive material.

---

## Quick Start

```markdown
# In AGENTS.md, CLAUDE.md, or .cursorrules — load what you need:
@skills/define/planning-and-task-breakdown/SKILL.md
@skills/build/incremental-implementation/SKILL.md
@skills/verify/test-driven-development/SKILL.md
```

Or copy a skill into your project:

```bash
cp -r skills/build/incremental-implementation/ .claude/skills/
```

---

## Skills

### Define — Clarity before code

| Skill | Use when... |
|-------|-------------|
| [idea-refinement](skills/define/idea-refinement/SKILL.md) | Requirements are vague, stakeholders misaligned |
| [planning-and-task-breakdown](skills/define/planning-and-task-breakdown/SKILL.md) | Breaking work into trackable steps |
| [spec-driven-development](skills/define/spec-driven-development/SKILL.md) | New features, breaking changes, architecture shifts |

### Build — Quality implementation

| Skill | Use when... |
|-------|-------------|
| [incremental-implementation](skills/build/incremental-implementation/SKILL.md) | Default approach — one step, one commit |
| [context-engineering](skills/build/context-engineering/SKILL.md) | Setting up AGENTS.md, project context for AI |
| [frontend-ui-engineering](skills/build/frontend-ui-engineering/SKILL.md) | Building UI components and pages |
| [api-and-interface-design](skills/build/api-and-interface-design/SKILL.md) | Designing APIs, contracts, interfaces |

### Verify — Prove correctness

| Skill | Use when... |
|-------|-------------|
| [test-driven-development](skills/verify/test-driven-development/SKILL.md) | Writing tests first (red-green-refactor) |
| [debugging-error-recovery](skills/verify/debugging-error-recovery/SKILL.md) | Investigating and fixing bugs |
| [browser-testing-devtools](skills/verify/browser-testing-devtools/SKILL.md) | E2E testing, DevTools debugging |

### Review — Quality gates

| Skill | Use when... |
|-------|-------------|
| [code-review-quality](skills/review/code-review-quality/SKILL.md) | Reviewing PRs (5-axis framework) |
| [security-hardening](skills/review/security-hardening/SKILL.md) | Security audit, OWASP checks |
| [performance-optimization](skills/review/performance-optimization/SKILL.md) | Profiling, bottleneck analysis |

### Ship — Deploy with confidence

| Skill | Use when... |
|-------|-------------|
| [git-workflow-versioning](skills/ship/git-workflow-versioning/SKILL.md) | Branching, tagging, releases, changelogs |
| [ci-cd-automation](skills/ship/ci-cd-automation/SKILL.md) | Pipeline setup, quality gates, deployment |
| [documentation-adrs](skills/ship/documentation-adrs/SKILL.md) | Architecture Decision Records |
| [shipping-launch](skills/ship/shipping-launch/SKILL.md) | Production readiness checklist |

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

Some skills include a `references/` directory with deep-dive content — load on demand when stuck or learning:

```markdown
@skills/build/incremental-implementation/references/pitfalls.md    # When stuck
@skills/verify/test-driven-development/references/examples.md      # When learning
```

Reference types: `anti-rationalization.md` (why it matters), `pitfalls.md` (common mistakes), `examples.md` (walkthroughs), `advanced.md` (edge cases).

---

## Directory Structure

```
skills/
├── README.md
└── skills/<phase>/<skill-name>/
    ├── SKILL.md              # Loadable skill (~800 tokens)
    └── references/           # Optional deep-dive material
        ├── anti-rationalization.md
        ├── pitfalls.md
        ├── examples.md
        └── advanced.md
```

Phases: `define/`, `build/`, `verify/`, `review/`, `ship/`
