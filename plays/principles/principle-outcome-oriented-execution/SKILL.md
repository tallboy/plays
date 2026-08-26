---
name: principle-outcome-oriented-execution
description: "Execute toward the target state, not smooth transitions. Don't preserve compatibility shims during migrations."
metadata:
  phase: principle
  pstack_ref: "outcome-oriented-execution"
  version: "1.0.0"
---

# Outcome-Oriented Execution

**The play:** Migrate to the target design. Don't preserve every old way of doing things during transition.

## When to Apply This

- ✅ Large migrations
- ✅ API versioning
- ✅ Rewriting systems
- ✅ Any work with explicit phases

## The Rule

**Execute to the target architecture. Don't slow down to preserve smooth transitions.**

Not:
- ✗ Maintain v1 and v2 endpoints forever
- ✗ Keep legacy code paths "for backwards compat"
- ✗ Add compatibility layers that slow you down

Instead:
- ✓ Target state: What should the system look like?
- ✓ Phase 1: Build new system
- ✓ Phase 2: Migrate users
- ✓ Phase 3: Delete old system
- ✓ No permanent compat cruft

## How

### 1. Define Target
What's the end state? (Not: "compatible with both", but: "runs only on new system")

### 2. Phase the Work
Build → Migrate → Delete. Not: build, then indefinitely support both.

### 3. Set Deadlines
Old system sunset: Date X. No extensions.

## Examples

**Bad:** Support API v1 and v2 forever.
**Good:** Sunset v1 on date X. Migrate all users to v2 by then.

## The Principle in One Sentence

**Move to target state fast. Don't live indefinitely in transition.**
