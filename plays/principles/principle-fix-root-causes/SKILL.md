---
name: principle-fix-root-causes
description: "Trace each symptom to root cause. Resist nil-check guards. Fix it there, not on the surface."
metadata:
  phase: principle
  pstack_ref: "fix-root-causes"
  version: "1.0.0"
---

# Fix Root Causes

**The play:** Symptom: Crash. Root cause: Nil pointer because initialization order is wrong. Fix initialization, not the nil check.

## When to Apply This

- ✅ Debugging a bug (before adding guards)
- ✅ Seeing the same failure pattern twice
- ✅ Tempted to add a nil check or try/catch
- ✅ Symptoms that feel preventable

## The Rule

**Don't patch symptoms. Trace to root cause and fix it there.**

Not:
- ✗ `if user { ... }` (guards the symptom)
- ✗ `try { risky_operation() } catch { ... }` (catches the symptom)
- ✗ Adding defensive code throughout

Instead:
- ✓ Why is user nil? Fix that.
- ✓ Why does risky_operation fail? Fix that.
- ✓ Make the failure impossible.

## How

### 1. Reproduce
Get the exact failure. What triggers it?

### 2. Trace
Follow the code backwards:
- Crash here? Why?
- That's nil. Why is it nil?
- It wasn't initialized. Why?
- Load order is wrong. Fix it.

### 3. Ask "Why" Five Times
- Crash (why?)
- Nil pointer (why?)
- Initialization missing (why?)
- Order dependency not tracked (why?)
- No dependency graph

Fix: Add dependency graph, init in order.

### 4. Verify
The crash should now be impossible. No guard needed.

## Examples

**Bad:** Add `if user { ... }` to prevent crash
**Good:** Fix initialization order so user is never nil

## The Principle in One Sentence

**Trace to source. Fix there. Guards only mask symptoms.**
