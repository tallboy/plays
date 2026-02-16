# Skills

A curated library of software engineering skills designed to be loaded into AI coding assistants (Claude Code, Cursor, Windsurf, etc.) as context. Each skill encodes a proven development practice — from planning and TDD to security hardening and shipping — in a format optimized for AI consumption.

**Why this exists:** AI assistants are more effective when given explicit process guidance rather than relying on general training. These skills provide that guidance as modular, composable documents you can load on demand.

**How it works:** Skills are organized by development phase (define, build, verify, review, ship). Each skill has a lean core (~800 tokens) for daily use, plus optional deep-dive references you load only when needed. This keeps context window usage minimal while giving you access to detailed examples, pitfalls, and rationale when you need them.

**How to use it:** Reference skill files in your `CLAUDE.md`, `AGENTS.md`, `.cursorrules`, or chat prompts using `@` syntax. Load 2-3 skills relevant to your current task — not all of them at once. See [Quick Start](#quick-start) below.

---

## Progressive Disclosure Design

Each skill uses **progressive disclosure** to minimize AI context window usage:

### Lean Core (~800 tokens)

- ✅ **When to Use** - Decision criteria
- ✅ **Process** - Step-by-step execution
- ✅ **Verification** - Completion checklist
- ✅ **Related Skills** - Navigation links

**Use for:** Daily execution, loading multiple skills at once

### Deep Dive References (load on-demand)

- 📖 **anti-rationalization.md** - Why shortcuts hurt (load when justifying approach)
- 🔧 **pitfalls.md** - Common mistakes & fixes (load when stuck)
- 💡 **examples.md** - Detailed walkthroughs (load when learning)
- 🚀 **advanced.md** - Complex patterns (load for edge cases)

**Use for:** Learning, troubleshooting, teaching team

### Context Window Impact

**Before refactor:**

- Loading 4 skills = ~14,000 tokens
- Heavy for AI context

**After refactor:**

- Loading 4 lean cores = ~3,200 tokens (77% reduction)
- Can load 10+ skills when needed
- Add references selectively

---

## Quick Start

### Option 1: Load Core Only (Recommended for Execution)

**In AGENTS.md or chat prompt:**

```markdown
# Load lean cores for daily work (minimal context usage)

@skills/build/incremental-implementation.md
@skills/verify/test-driven-development.md
@skills/ship/git-workflow-versioning.md

# Total: ~2,400 tokens for 3 skills
```

### Option 2: Load Core + Specific References (When Needed)

**When stuck on a pitfall:**

```markdown
@skills/build/incremental-implementation.md # Core process
@skills/build/incremental-implementation/pitfalls.md # Troubleshooting
```

**When teaching/justifying:**

```markdown
@skills/verify/test-driven-development.md # Core process
@skills/verify/test-driven-development/anti-rationalization.md # Why it matters
```

**When learning:**

```markdown
@skills/define/spec-driven-development.md # Core process
@skills/define/spec-driven-development/examples.md # Detailed walkthroughs
```

### Option 3: Copy to Project

**For permanent project reference:**

```bash
# Copy lean cores only
cp skills/build/incremental-implementation.md .claude/skills/
cp skills/verify/test-driven-development.md .claude/skills/

# Or copy with references for complete docs
cp -r skills/build/incremental-implementation/ .claude/skills/build/
```

**In AGENTS.md:**

```markdown
# Development Standards

## Core Skills

Load for every task:

- @.claude/skills/incremental-implementation.md
- @.claude/skills/test-driven-development.md

## Reference When Needed

If encountering pitfalls: @.claude/skills/incremental-implementation/pitfalls.md
If need examples: @.claude/skills/test-driven-development/examples.md
```

---

## Directory Structure

```
skills/
├── README.md
│
├── define/                              # Phase 1: Clarity before code
│   ├── idea-refinement.md
│   ├── idea-refinement/
│   │   ├── anti-rationalization.md
│   │   ├── examples.md
│   │   └── pitfalls.md
│   ├── planning-and-task-breakdown.md
│   ├── planning-and-task-breakdown/
│   │   ├── advanced.md
│   │   ├── anti-rationalization.md
│   │   ├── examples.md
│   │   └── pitfalls.md
│   ├── spec-driven-development.md
│   └── spec-driven-development/
│       ├── anti-rationalization.md
│       ├── examples.md
│       └── pitfalls.md
│
├── build/                               # Phase 2: Quality implementation
│   ├── api-and-interface-design.md
│   ├── api-and-interface-design/
│   │   ├── anti-rationalization.md
│   │   ├── examples.md
│   │   └── pitfalls.md
│   ├── context-engineering.md
│   ├── context-engineering/
│   │   ├── anti-rationalization.md
│   │   ├── examples.md
│   │   └── pitfalls.md
│   ├── frontend-ui-engineering.md
│   ├── frontend-ui-engineering/
│   │   ├── advanced.md
│   │   ├── anti-rationalization.md
│   │   ├── examples.md
│   │   └── pitfalls.md
│   ├── incremental-implementation.md
│   └── incremental-implementation/
│       ├── advanced.md
│       ├── anti-rationalization.md
│       ├── examples.md
│       └── pitfalls.md
│
├── verify/                              # Phase 3: Prove correctness
│   ├── browser-testing-devtools.md
│   ├── debugging-error-recovery.md
│   ├── test-driven-development.md
│   └── test-driven-development/
│       ├── anti-rationalization.md
│       ├── examples.md
│       └── pitfalls.md
│
├── review/                              # Phase 4: Quality gates
│   ├── code-review-quality.md
│   ├── performance-optimization.md
│   └── security-hardening.md
│
└── ship/                                # Phase 5: Deploy with confidence
    ├── ci-cd-automation.md
    ├── documentation-adrs.md
    ├── git-workflow-versioning.md
    └── shipping-launch.md
```

**Each skill follows this pattern:**

- `skill-name.md` — Lean core (~800 tokens): When to Use, Process, Verification
- `skill-name/` — Deep-dive references (load selectively):
  - `anti-rationalization.md` — Why this skill matters, cost of skipping
  - `pitfalls.md` — Common mistakes with symptoms and fixes
  - `examples.md` — Detailed code examples and walkthroughs
  - `advanced.md` — Complex patterns and edge cases (when applicable)

---

## Skill Selection Guide

### By Development Phase

| Current Phase          | Load These Skills                                                                                                                                                                                                         |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Project Kickoff**    | [define/idea-refinement](define/idea-refinement.md), [define/spec-driven-development](define/spec-driven-development.md), [build/context-engineering](build/context-engineering.md)                                       |
| **Active Development** | [define/planning-and-task-breakdown](define/planning-and-task-breakdown.md), [build/incremental-implementation](build/incremental-implementation.md), [verify/test-driven-development](verify/test-driven-development.md) |
| **Stabilization**      | [verify/debugging-error-recovery](verify/debugging-error-recovery.md), [review/code-review-quality](review/code-review-quality.md), [review/security-hardening](review/security-hardening.md)                             |
| **Pre-Release**        | [review/performance-optimization](review/performance-optimization.md), [ship/ci-cd-automation](ship/ci-cd-automation.md), [ship/shipping-launch](ship/shipping-launch.md)                                                 |

### By Change Type

| Change Type           | Recommended Skills                                                                                                                                                                                      |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Bug Fix**           | [verify/debugging-error-recovery](verify/debugging-error-recovery.md), [verify/test-driven-development](verify/test-driven-development.md)                                                              |
| **Small Feature**     | [define/planning-and-task-breakdown](define/planning-and-task-breakdown.md), [build/incremental-implementation](build/incremental-implementation.md)                                                    |
| **Large Feature**     | [define/spec-driven-development](define/spec-driven-development.md), [define/planning-and-task-breakdown](define/planning-and-task-breakdown.md), [ship/documentation-adrs](ship/documentation-adrs.md) |
| **Refactor**          | [verify/test-driven-development](verify/test-driven-development.md), [review/code-review-quality](review/code-review-quality.md)                                                                        |
| **Security Issue**    | [review/security-hardening](review/security-hardening.md), [verify/test-driven-development](verify/test-driven-development.md)                                                                          |
| **Performance Issue** | [review/performance-optimization](review/performance-optimization.md), [verify/browser-testing-devtools](verify/browser-testing-devtools.md)                                                            |

### By Team Experience Level

| Team Level               | Essential Skills                                                                                                                                                                                                    |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Junior Developers**    | [build/incremental-implementation](build/incremental-implementation.md), [verify/test-driven-development](verify/test-driven-development.md), [ship/git-workflow-versioning](ship/git-workflow-versioning.md)       |
| **Mid-Level Developers** | [define/spec-driven-development](define/spec-driven-development.md), [review/code-review-quality](review/code-review-quality.md), [ship/documentation-adrs](ship/documentation-adrs.md)                             |
| **Senior Developers**    | [define/idea-refinement](define/idea-refinement.md), [review/security-hardening](review/security-hardening.md), [review/performance-optimization](review/performance-optimization.md)                               |
| **QA → Dev Transition**  | [verify/test-driven-development](verify/test-driven-development.md), [verify/debugging-error-recovery](verify/debugging-error-recovery.md), [build/incremental-implementation](build/incremental-implementation.md) |

---

## Quick Decision Tree

```
What are you working on?
│
├─► New project from scratch?
│   └─► Load: define/* + build/context-engineering
│
├─► Implementing a feature?
│   ├─► Complex/breaking change?
│   │   └─► Load: define/spec-driven-development + define/planning-and-task-breakdown
│   └─► Simple/clear scope?
│       └─► Load: define/planning-and-task-breakdown + build/incremental-implementation
│
├─► Fixing a bug?
│   ├─► Root cause unclear?
│   │   └─► Load: verify/debugging-error-recovery + verify/test-driven-development
│   └─► Root cause known?
│       └─► Load: verify/test-driven-development
│
├─► Reviewing code?
│   └─► Load: review/code-review-quality + review/security-hardening
│
├─► Performance problem?
│   └─► Load: review/performance-optimization + verify/browser-testing-devtools
│
└─► Ready to ship?
    └─► Load: ship/ci-cd-automation + ship/shipping-launch
```

---

## Progressive Disclosure Usage Patterns

### Pattern 1: Lean Execution (Daily Development)

**Scenario:** Implementing a feature, need guidance on process

**Load:** Lean cores only

```markdown
@skills/define/planning-and-task-breakdown.md # ~800 tokens
@skills/build/incremental-implementation.md # ~800 tokens
@skills/verify/test-driven-development.md # ~800 tokens

# Total: ~2,400 tokens
```

**Result:** Fast loading, clear process, minimal context usage

---

### Pattern 2: Learning + Execution

**Scenario:** New to TDD, need examples while working

**Load:** Core + examples

```markdown
@skills/verify/test-driven-development.md # Process
@skills/verify/test-driven-development/examples.md # Walkthroughs

# Total: ~2,000 tokens (core + examples)
```

**Result:** Learn by example while executing

---

### Pattern 3: Troubleshooting

**Scenario:** Commits getting too large, violating incremental implementation

**Load:** Core + pitfalls

```markdown
@skills/build/incremental-implementation.md # Reminder of process
@skills/build/incremental-implementation/pitfalls.md # "Batching Commits" pitfall

# Total: ~2,600 tokens
```

**Result:** Identify exact mistake and fix

---

### Pattern 4: Team Justification

**Scenario:** Team resists writing tests first, need to convince

**Load:** Core + anti-rationalization

```markdown
@skills/verify/test-driven-development.md # What to do
@skills/verify/test-driven-development/anti-rationalization.md # Why it matters

# Total: ~2,000 tokens
```

**Result:** Data-driven arguments for practice

---

### Pattern 5: Advanced Scenarios

**Scenario:** Need feature flags for long-running work

**Load:** Core + advanced

```markdown
@skills/build/incremental-implementation.md # Basic process
@skills/build/incremental-implementation/advanced.md # Feature flags pattern

# Total: ~2,200 tokens
```

**Result:** Access to advanced techniques when needed

---

## Integration Patterns

### Pattern 1: Minimal Context in CLAUDE.md

```markdown
# Claude Instructions

Load all skills from the skills library:
@skills/define/spec-driven-development.md
@skills/build/incremental-implementation.md
@skills/verify/test-driven-development.md
@skills/review/code-review-quality.md
@skills/ship/git-workflow-versioning.md
```

### Pattern 2: Selective Skills in AGENTS.md

```markdown
# Development Standards

For feature implementation, follow:

- [[skills/define/planning-and-task-breakdown]]
- [[skills/build/incremental-implementation]]

For code review, reference:

- [[skills/review/code-review-quality]]
```

### Pattern 3: Just-In-Time Loading

```markdown
# AGENTS.md

## Context-Specific Skills

When implementing features:

> Load @skills/build/incremental-implementation.md

When debugging issues:

> Load @skills/verify/debugging-error-recovery.md

When reviewing PRs:

> Load @skills/review/code-review-quality.md
```

### Pattern 4: Slash Command Integration

```yaml
# .claude/commands/implement-feature.md
---
skill: implement-feature
description: Implement a feature using spec-driven approach
---

# Implementation Process

1. Load planning skill: @skills/define/planning-and-task-breakdown.md
2. Create work tracker with atomic steps
3. Load implementation skill: @skills/build/incremental-implementation.md
4. Execute each step with verification
```

---

## Usage Examples

### Example 1: Starting a New Feature

**Scenario:** You're building a new API endpoint for user authentication.

**Skills to Load:**

1. [define/spec-driven-development](define/spec-driven-development.md) - Write OpenSpec proposal with WHEN/THEN scenarios
2. [define/planning-and-task-breakdown](define/planning-and-task-breakdown.md) - Break into steps (model, endpoint, tests, docs)
3. [build/incremental-implementation](build/incremental-implementation.md) - Implement step-by-step with commits
4. [verify/test-driven-development](verify/test-driven-development.md) - Write tests before implementation

**Prompt:**

```
I need to implement JWT authentication.
Load skills: spec-driven-development, planning-and-task-breakdown
Help me create an OpenSpec proposal and work tracker.
```

---

### Example 2: Debugging a Production Issue

**Scenario:** Users report intermittent 500 errors on checkout.

**Skills to Load:**

1. [verify/debugging-error-recovery](verify/debugging-error-recovery.md) - Systematic 5-step triage
2. [verify/browser-testing-devtools](verify/browser-testing-devtools.md) - Inspect network/console logs
3. [verify/test-driven-development](verify/test-driven-development.md) - Write failing test that reproduces bug

**Prompt:**

```
We have intermittent 500 errors on /checkout.
Load skill: debugging-error-recovery
Walk me through the 5-step triage process.
```

---

### Example 3: Code Review

**Scenario:** Reviewing a PR that adds a new database migration.

**Skills to Load:**

1. [review/code-review-quality](review/code-review-quality.md) - 5-axis review framework
2. [review/security-hardening](review/security-hardening.md) - Check for SQL injection, secrets
3. [verify/test-driven-development](verify/test-driven-development.md) - Verify tests exist

**Prompt:**

```
Review PR #456 that adds user_preferences table.
Load skills: code-review-quality, security-hardening
Provide feedback using the 5-axis framework.
```

---

### Example 4: Performance Optimization

**Scenario:** Dashboard loads slowly with large datasets.

**Skills to Load:**

1. [review/performance-optimization](review/performance-optimization.md) - Measurement-first approach
2. [verify/browser-testing-devtools](verify/browser-testing-devtools.md) - Profile performance timeline

**Prompt:**

```
Dashboard is slow with 10k+ records.
Load skill: performance-optimization
Help me identify bottlenecks using measurement-first approach.
```

---

## Skill Dependencies

Some skills reference others. Load dependencies for full context:

| Skill                                                                   | Dependencies                                                                                                                                 |
| ----------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| [define/spec-driven-development](define/spec-driven-development.md)     | [define/planning-and-task-breakdown](define/planning-and-task-breakdown.md)                                                                  |
| [build/incremental-implementation](build/incremental-implementation.md) | [define/planning-and-task-breakdown](define/planning-and-task-breakdown.md), [ship/git-workflow-versioning](ship/git-workflow-versioning.md) |
| [verify/test-driven-development](verify/test-driven-development.md)     | [build/incremental-implementation](build/incremental-implementation.md)                                                                      |
| [review/code-review-quality](review/code-review-quality.md)             | [review/security-hardening](review/security-hardening.md), [review/performance-optimization](review/performance-optimization.md)             |
| [ship/shipping-launch](ship/shipping-launch.md)                         | [ship/ci-cd-automation](ship/ci-cd-automation.md)                                                                                            |

---

## Anti-Patterns

### ❌ Don't Load All Skills at Once

**Why:** Token bloat, cognitive overload for AI
**Instead:** Load 2-3 skills relevant to current task

### ❌ Don't Skip Verification Steps

**Why:** Skills include verification for a reason
**Instead:** Follow checklist even if it feels slow

### ❌ Don't Modify Skills In-Place

**Why:** Breaks consistency across projects
**Instead:** Extend skills in project-specific AGENTS.md

### ❌ Don't Use Skills Without Reading First

**Why:** Context matters—not all steps apply to all situations
**Instead:** Skim skill, then apply relevant sections

---

## Extending Skills

### For Your Project

Create `AGENTS.md` that extends/overrides:

```markdown
# Project-Specific Extensions

## Incremental Implementation (Extended)

Base skill: [[skills/build/incremental-implementation]]

Project-specific additions:

- Run `npm run type-check` after each step
- Update API docs in `/docs` when changing endpoints
- Notify #dev-updates Slack channel on merge
```

### For Your Organization

Fork and customize:

```bash
# Copy skills to organization repo
cp -r skills/ /org-repo/.github/skills/

# Customize for org standards
# Example: Add org-specific security checklist to review/security-hardening.md
```

---

## Skill Maintenance

### Updating Skills

1. Test changes on sample project first
2. Update version number in skill header
3. Document changes in skill changelog
4. Notify teams of breaking changes

### Versioning

Skills use semantic versioning in frontmatter:

```yaml
---
version: 1.2.0
last_updated: 2026-02-16
breaking_changes: false
---
```

---

## Contributing

### Adding New Skills

1. Follow existing skill template structure
2. Include: When to Use, Process, Verification, Anti-Rationalization
3. Use wiki-style [[links]] to related skills
4. Test with AI agent before committing

---

## FAQ

**Q: Do I need all skills in every project?**
A: No. Start with 3-5 skills for your current phase, add more as needed.

**Q: Can I use these with Cursor/Windsurf/other AI tools?**
A: Yes. Copy to `.cursorrules`, `.windsurfrules`, or equivalent.

**Q: How do skills differ from your existing patterns?**
A: Skills are atomic and portable. Patterns are comprehensive workflows. Skills compose into patterns.

**Q: What if a skill conflicts with my team's process?**
A: Override in project AGENTS.md. Skills are defaults, not mandates.

**Q: Can I use these without OpenSpec/slash commands?**
A: Yes. Skills are tool-agnostic. Tool references are optional enhancements.
