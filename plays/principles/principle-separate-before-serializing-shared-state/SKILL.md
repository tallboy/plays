---
name: principle-separate-before-serializing-shared-state
description: "Eliminate the sharing first. Only serialize state when one shared writer is a real invariant."
metadata:
  phase: principle
  pstack_ref: "separate-before-serializing-shared-state"
  version: "1.0.0"
---

# Separate Before Serializing Shared State

**The play:** Shared mutable state is expensive. First question: do you actually need to share?

## When to Apply This

- ✅ Designing distributed systems
- ✅ Multi-process coordination
- ✅ Any shared state concern
- ✅ Before reaching for locks, queues, etc.

## The Rule

**Eliminate sharing first. Then serialize if you must.**

Not:
- ✗ "Multiple writers, so I'll use a lock"
- ✗ "Shared state, so I'll add a queue"
- ✗ Serialize everything

Instead:
- ✓ Can each process have its own state? (segregate)
- ✓ Can one process own it? (centralize)
- ✓ Only if truly shared: serialize

## How

### 1. Ask: Do We Need Shared State?
- Can each writer have its own copy? Yes → segregate.
- Can one writer own it? Yes → centralize.
- Must multiple writers access? Only then → serialize.

### 2. Segregate When Possible
Each process/thread gets its own copy. No coordination.

### 3. Centralize When Possible
One owner. Others read. Simpler than shared.

### 4. Serialize Only When Necessary
Use locks, queues, or databases only when truly needed.

## Examples

**Bad:** Shared counter with locks.
**Good:** Each thread counts locally, aggregate at the end.

## The Principle in One Sentence

**Shared mutable state is a last resort. Segregate first.**
