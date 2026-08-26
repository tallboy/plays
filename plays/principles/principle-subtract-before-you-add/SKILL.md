---
name: principle-subtract-before-you-add
description: "Delete dead weight before adding features. Simpler base + small feature beats complex base + another feature."
metadata:
  phase: principle
  pstack_ref: "subtract-before-you-add"
  version: "1.0.0"
---

# Subtract Before You Add

**The play:** Before you build something new, cut out what's dead. Smaller base = easier to build on.

## When to Apply This

- ✅ Starting a refactor
- ✅ Adding a new feature (check what's unused first)
- ✅ Inheriting a codebase
- ✅ Seeing code that "might be used later"

## The Rule

**Delete before you add.**

Not:
- ✗ "I'll leave this in case we need it"
- ✗ Add new feature on top of bloat
- ✗ "I'm not sure if this is used, so I'll keep it"

Instead:
- ✓ Kill unused code
- ✓ Then build on clean base
- ✓ Use version control—if you need it later, git log has it

## How

### 1. Audit
What code is never called?
- Dead imports
- Unused functions
- Obsolete configurations

### 2. Delete
No mercy. Version control keeps history.

### 3. Build
On a smaller, cleaner base.

## Examples

**Bad:** Add feature on top of bloated codebase.
**Good:** Delete 2000 lines of dead code. Add feature on 3000-line base.

## The Principle in One Sentence

**Smaller foundation = easier to build. Kill dead code first.**
