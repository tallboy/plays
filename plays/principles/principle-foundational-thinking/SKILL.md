---
name: principle-foundational-thinking
description: "Apply before writing logic: choosing core types and data structures, sequencing scaffold-vs-feature work, integrating a new requirement into an existing design, or sharing state between concurrent actors. Get the data structures right so downstream code becomes obvious."
---

# Foundational Thinking

**Structural decisions** protect option value. **Code-level decisions** protect simplicity. Over-engineering is often a premature decision that closes doors. The right foundational data structure keeps doors open.

**Data structures first.** Get the data shape right before writing logic. The right shape makes downstream code obvious. Define core types early, trace every access pattern, and choose structures that match the dominant paths. A data-structure change late is a rewrite. Early, it is often a one-line diff.

At code level, DRY the structure, not every line. Types and data models should converge. Prefer explicit over clever. Test behavior and edge cases, not line counts.

**Scaffold first.** If something helps every later phase, do it first. Ask "does every subsequent phase benefit from this existing?" CI, linting, test infrastructure, and shared types are scaffold. Sequence for option value: setup before features, tests before fixes. Subtraction comes before scaffolding: remove dead weight first, then lay foundations.

Each increment should land a coherent abstraction or deepen one that exists. Do not spread a new capability across callers as special-case coordination.

**Redesign from first principles when integrating.** When a new requirement lands on an existing design, don't bolt it on. Redesign as if the requirement had been there from day one: read the affected files holistically, ask "what would we build from scratch knowing this?", propagate the change through every reference (types, docs, examples), then deliver the redesign incrementally.

**Concurrency corollary.** Before sharing state between actors — human, agent, or process — ask "what happens if another actor modifies this concurrently?" If the answer is not "nothing", separate before you serialize:
1. Identify the shared mutable state (files both write, branches both push to, keys both set).
2. Default to eliminating the shared write target. Give each actor its own owned file, key, branch, or directory, and merge only at the read boundary. Two workers writing their own field into one `state.json` is still shared mutation; two separate state files are not.
3. Only when one shared write target is a real invariant, serialize access structurally (lockfiles, sequential phases, single-writer ownership). Instructions and conventions are not concurrency control, and "we need a lock" is a design smell to check, not the default answer.
