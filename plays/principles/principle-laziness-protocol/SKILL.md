---
name: principle-laziness-protocol
description: "Bias toward deletion and the smallest change that solves the problem. Shawn Kemp didn't waste energy dribbling—straight line to the basket, maximum power."
metadata:
  phase: principle
  pstack_ref: "laziness-protocol"
  player_analogy: "Shawn Kemp's charge"
  version: "1.0.0"
---

# Laziness Protocol

**The Kemp Principle:** Shawn Kemp didn't dribble around defenders or take fancy routes. Straight line. Full speed. Dunk. Done.

In code: **Delete first. Smallest change wins. No abstractions until three copies exist.**

## When to Apply This

- ✅ Starting a new feature
- ✅ Fixing a bug (don't add 10 new things)
- ✅ Refactoring (delete before you reorganize)
- ✅ Stuck on a design choice (pick the smaller one)
- ✅ Tempted to "future-proof" something

## The Rule

**Prefer deletion and the smallest change that solves the problem.**

Not:
- ✗ "I'll build this so it's extensible for future use cases"
- ✗ "Let me add a wrapper layer for flexibility"
- ✗ "I'll refactor this into a generic helper"

Instead:
- ✓ Delete dead code first
- ✓ Make the smallest change that works
- ✓ Let duplication exist until you see the pattern (3 copies = extract)
- ✓ Ship now, design-for-reuse later (if it happens)

## How

### 1. Delete First
Before adding anything, delete:
- Dead code
- Unused parameters
- Unnecessary abstractions
- Redundant comments
- Compat shims that nobody uses

### 2. Make the Smallest Change
- One variable, one function, one file at a time
- If you can do it in 3 lines, don't do it in 30
- If you can do it locally, don't add global state
- If you can do it in existing code, don't create a new module

### 3. Resist Abstraction Urges
Until you see the pattern **three times**, don't extract:
- 1st copy: okay, isolated
- 2nd copy: coincidence
- 3rd copy: pattern
- 3rd copy: NOW extract

### 4. Measure Your Work
- Lines added
- Files changed
- Complexity before/after
- Can you explain it in one sentence?

If you can't, you added too much.

## Examples

**Bad:** "I'm adding a user feature. Let me build a generic user/permission system that could handle roles, orgs, and teams."  
**Good:** "I'm adding a user feature. One user. One ID. One endpoint. Ship it."

**Bad:** "There are two places that format dates. Let me create a DateFormatter utility."  
**Good:** "There are two places that format dates. I'll fix both today. If a third shows up, I'll extract."

**Bad:** "I'm refactoring this class to support future use cases."  
**Good:** "I'm refactoring this class to pass the tests I have, in fewer lines."

## The Principle in One Sentence

**Shorter code, fewer dependencies, smaller surface area, less to maintain.**
