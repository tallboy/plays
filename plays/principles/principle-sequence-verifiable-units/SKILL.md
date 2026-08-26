---
name: principle-sequence-verifiable-units
description: "Break work into small units. Each ends in a verifiable state. Each can be tested independently."
metadata:
  phase: principle
  pstack_ref: "sequence-verifiable-units"
  version: "1.0.0"
---

# Sequence Verifiable Units

**The play:** Don't ship a big blob. Ship small, testable pieces that prove themselves as they go.

## When to Apply This

- ✅ Multi-step migrations
- ✅ Refactoring across files
- ✅ Feature rollout
- ✅ Any work that takes more than one session

## The Rule

**Each step should be independently testable and shippable.**

Not:
- ✗ "I'll refactor the whole module, then test"
- ✗ One giant PR with 50 files changed
- ✗ "Let me implement steps 1-5 then we'll see if it works"

Instead:
- ✓ Step 1: Introduce new type, old code still works
- ✓ Step 2: Migrate one caller, test
- ✓ Step 3: Migrate next caller, test
- ✓ Step 4: Delete old code

## How

### 1. Plan Steps
What's the smallest independent piece?

### 2. Each Step Is Provable
```
Step 1: Add NewUserType (old UserType still works)
        Commit. Tests pass.

Step 2: Migrate Controller to NewUserType
        Commit. Tests pass.

Step 3: Migrate Service to NewUserType
        Commit. Tests pass.

Step 4: Delete old UserType
        Commit. Tests pass.
```

### 3. Review Is Easy
Each commit is small, reviewable, provably correct.

## Examples

**Bad:** Refactor 10 files in one commit. Hard to review, hard to undo if broken.
**Good:** Refactor one file per commit. Each commit is provably correct.

## The Principle in One Sentence

**Ship proof at every step. Not just at the end.**
