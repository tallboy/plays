---
name: principle-migrate-callers-then-delete-legacy
description: "Migrate all callers then delete the old API in the same wave. No permanent compat layers."
metadata:
  phase: principle
  pstack_ref: "migrate-callers-then-delete-legacy"
  version: "1.0.0"
---

# Migrate Callers Then Delete Legacy

**The play:** When you have old and new APIs, migrate callers then delete old. Not: old forever for compat.

## When to Apply This

- ✅ API redesigns
- ✅ Large refactors
- ✅ Deprecating code paths
- ✅ Any time you support "both old and new"

## The Rule

**Migrate all callers. Delete the old in the same commit/PR. Don't preserve forever.**

Not:
- ✗ Support both APIs indefinitely
- ✗ "Old API is deprecated, but we'll keep it"
- ✗ Permanent compat shims

Instead:
- ✓ New API ready? Migrate all callers.
- ✓ All callers migrated? Delete old.
- ✓ Both in one PR = atomic, clear transition

## How

### 1. Build New
New API ready for use.

### 2. Migrate All Callers
Every place that uses old → use new.

### 3. Delete Old
In the same PR/commit. Atomic.

## Examples

**Bad:** Support UserService.getUser() and UserService.findUser() forever.
**Good:** Build getUserById(). Migrate all callers. Delete getUser().

## The Principle in One Sentence

**New → migrate → delete old. All in one wave. No permanent cruft.**
