# The 21 Principles: Engineering Fundamentals

The foundation of the Tallboy Plays system. Each principle is a playable skill—read it when you're stuck, invoke it when you need guidance, cite it when you make decisions.

## Core Principles (Read These First)

These apply to every phase, every play, every decision:

| Principle | Analogy | When |
|-----------|---------|------|
| [principle-laziness-protocol](principle-laziness-protocol/SKILL.md) | Shawn Kemp's straight charge | Delete first, smallest change wins |
| [principle-foundational-thinking](principle-foundational-thinking/SKILL.md) | Larry Bird's footwork | Architecture before code |
| [principle-minimize-reader-load](principle-minimize-reader-load/SKILL.md) | Magic's crisp passes | Keep cognitive load low |
| [principle-prove-it-works](principle-prove-it-works/SKILL.md) | MJ in the Finals | Test on real artifacts |

## By Phase

### Define Phase
| Principle | Use When |
|-----------|----------|
| [principle-exhaust-the-design-space](principle-exhaust-the-design-space/SKILL.md) | Before committing to one design, build 2-3 prototypes |
| [principle-foundational-thinking](principle-foundational-thinking/SKILL.md) | Getting the model right before code |

### Build Phase
| Principle | Use When |
|-----------|----------|
| [principle-model-the-domain](principle-model-the-domain/SKILL.md) | Encoding domain logic in structure |
| [principle-type-system-discipline](principle-type-system-discipline/SKILL.md) | Making illegal states impossible |
| [principle-boundary-discipline](principle-boundary-discipline/SKILL.md) | Validating at system edges |

### Verify Phase
| Principle | Use When |
|-----------|----------|
| [principle-fix-root-causes](principle-fix-root-causes/SKILL.md) | Tracing symptoms to source |
| [principle-sequence-verifiable-units](principle-sequence-verifiable-units/SKILL.md) | Breaking work into atomic, testable steps |
| [principle-prove-it-works](principle-prove-it-works/SKILL.md) | Before declaring something fixed |

### Review Phase
| Principle | Use When |
|-----------|----------|
| [principle-type-system-discipline](principle-type-system-discipline/SKILL.md) | Reviewing code for safety |
| [principle-boundary-discipline](principle-boundary-discipline/SKILL.md) | Checking input validation |

### Ship Phase
| Principle | Use When |
|-----------|----------|
| [principle-migrate-callers-then-delete-legacy](principle-migrate-callers-then-delete-legacy/SKILL.md) | No compat shims, migrate and delete |
| [principle-make-operations-idempotent](principle-make-operations-idempotent/SKILL.md) | Converge to same end state |
| [principle-encode-lessons-in-structure](principle-encode-lessons-in-structure/SKILL.md) | Encode rules in lint/config, not prose |
| [principle-never-block-on-the-human](principle-never-block-on-the-human/SKILL.md) | Proceed, let human correct after |

## Advanced Principles

These apply to specific situations or higher-level decisions:

| Principle | Concept |
|-----------|---------|
| [principle-redesign-from-first-principles](principle-redesign-from-first-principles/SKILL.md) | If design breaks, redesign as if constraints were day-one |
| [principle-subtract-before-you-add](principle-subtract-before-you-add/SKILL.md) | Remove dead weight before building |
| [principle-outcome-oriented-execution](principle-outcome-oriented-execution/SKILL.md) | Execute to target architecture, not smooth transitions |
| [principle-experience-first](principle-experience-first/SKILL.md) | Ship fewer polished features, not more rough ones |
| [principle-build-the-lever](principle-build-the-lever/SKILL.md) | Build tools/codemods, don't work by hand |
| [principle-separate-before-serializing-shared-state](principle-separate-before-serializing-shared-state/SKILL.md) | Eliminate sharing first, serialize only when needed |
| [principle-guard-the-context-window](principle-guard-the-context-window/SKILL.md) | Route bulk to subagents, keep summaries main |

## How to Use

**When stuck:** `@plays/principles/principle-<name>/SKILL.md`

**When designing:** Read the relevant principle first, then run the play.

**When reviewing:** Ask "which principle applies here?" before critiquing.

**When teaching:** Show the principle, then the play, then the code.

---

## The Tallboy Philosophy

A principle isn't a rule you follow blindly. It's a **decision lens.** Read it, decide if it applies, apply it deliberately.

If a principle conflicts with your judgment, name the conflict. Make the exception explicit. Learn why.

The best engineers know the principles so well they can break them safely.

Now go run the plays. 🏀
