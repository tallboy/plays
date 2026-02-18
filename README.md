# Skills

Modular software engineering skills for AI coding assistants. Load 2-3 into your `CLAUDE.md`, `.cursorrules`, or chat prompt to give your AI agent explicit process guidance.

Each skill is ~800 tokens with YAML frontmatter, organized by development phase.

---

## Quick Start

```markdown
# In AGENTS.md, CLAUDE.md, or .cursorrules — load what you need:
@skills/define/planning-and-task-breakdown.md
@skills/build/incremental-implementation.md
@skills/verify/test-driven-development.md
```

Or copy into your project:

```bash
cp skills/build/incremental-implementation.md .claude/skills/
```

---

## Skills

### Define — Clarity before code

| Skill | Use when... |
|-------|-------------|
| [idea-refinement](skills/define/idea-refinement.md) | Requirements are vague, stakeholders misaligned |
| [planning-and-task-breakdown](skills/define/planning-and-task-breakdown.md) | Breaking work into trackable steps |
| [spec-driven-development](skills/define/spec-driven-development.md) | New features, breaking changes, architecture shifts |

### Build — Quality implementation

| Skill | Use when... |
|-------|-------------|
| [incremental-implementation](skills/build/incremental-implementation.md) | Default approach — one step, one commit |
| [context-engineering](skills/build/context-engineering.md) | Setting up AGENTS.md, project context for AI |
| [frontend-ui-engineering](skills/build/frontend-ui-engineering.md) | Building UI components and pages |
| [api-and-interface-design](skills/build/api-and-interface-design.md) | Designing APIs, contracts, interfaces |

### Verify — Prove correctness

| Skill | Use when... |
|-------|-------------|
| [test-driven-development](skills/verify/test-driven-development.md) | Writing tests first (red-green-refactor) |
| [debugging-error-recovery](skills/verify/debugging-error-recovery.md) | Investigating and fixing bugs |
| [browser-testing-devtools](skills/verify/browser-testing-devtools.md) | E2E testing, DevTools debugging |

### Review — Quality gates

| Skill | Use when... |
|-------|-------------|
| [code-review-quality](skills/review/code-review-quality.md) | Reviewing PRs (5-axis framework) |
| [security-hardening](skills/review/security-hardening.md) | Security audit, OWASP checks |
| [performance-optimization](skills/review/performance-optimization.md) | Profiling, bottleneck analysis |

### Ship — Deploy with confidence

| Skill | Use when... |
|-------|-------------|
| [git-workflow-versioning](skills/ship/git-workflow-versioning.md) | Branching, tagging, releases, changelogs |
| [ci-cd-automation](skills/ship/ci-cd-automation.md) | Pipeline setup, quality gates, deployment |
| [documentation-adrs](skills/ship/documentation-adrs.md) | Architecture Decision Records |
| [shipping-launch](skills/ship/shipping-launch.md) | Production readiness checklist |

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

Deep-dive content lives in `reference/` — load on demand when stuck or learning:

```markdown
@reference/build/incremental-implementation/pitfalls.md    # When stuck
@reference/verify/test-driven-development/examples.md      # When learning
```

Available for: idea-refinement, planning-and-task-breakdown, spec-driven-development, api-and-interface-design, context-engineering, frontend-ui-engineering, incremental-implementation, test-driven-development.

---

## Directory Structure

```
skills/
├── skills/                    # Loadable agent skills (~800 tokens each)
│   ├── define/               # idea-refinement, planning, spec-driven-dev
│   ├── build/                # incremental-impl, context-eng, frontend, api
│   ├── verify/               # tdd, debugging, browser-testing
│   ├── review/               # code-review, security, performance
│   └── ship/                 # git-workflow, ci-cd, adrs, shipping
└── reference/                 # Deep-dive material (pitfalls, examples, anti-rationalization)
    ├── define/
    ├── build/
    └── verify/
```
