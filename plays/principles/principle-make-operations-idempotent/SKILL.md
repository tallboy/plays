---
name: principle-make-operations-idempotent
description: "Operations should converge to the same end state regardless of how many times you run them. No partial states."
metadata:
  phase: principle
  pstack_ref: "make-operations-idempotent"
  version: "1.0.0"
---

# Make Operations Idempotent

**The play:** Running an operation twice should give the same result as running it once.

## When to Apply This

- ✅ Deployments
- ✅ Migrations
- ✅ Infrastructure setup
- ✅ Any operation that might be retried

## The Rule

**Same end state whether you run once, twice, or ten times.**

Not:
- ✗ Deploy fails, manual recovery needed
- ✗ Migration fails halfway, unclear state
- ✗ Running twice causes problems

Instead:
- ✓ Deploy: Converge to target state
- ✓ Migration: Idempotent, safe to retry
- ✓ Run it again: Same state, no issues

## How

### 1. Define End State
What should be true after operation completes?

### 2. Make It Retrievable
Can you check if end state is met?

### 3. Skip If Already Done
If already in end state, do nothing.

### 4. Error Only If Can't Reach State
Not "already done", but "can't reach target".

## Examples

**Bad:** Deployment adds a field. Run twice = error (field already exists).
**Good:** Deployment checks if field exists. If not, add it. If yes, continue.

## The Principle in One Sentence

**Same result every time you run it. Idempotent operations are safe to retry.**
