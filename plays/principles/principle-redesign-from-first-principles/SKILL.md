---
name: principle-redesign-from-first-principles
description: "If the design breaks, redesign from scratch as if constraints were day-one assumptions. Don't bolt patches on."
metadata:
  phase: principle
  pstack_ref: "redesign-from-first-principles"
  version: "1.0.0"
---

# Redesign from First Principles

**The play:** When a design keeps breaking, don't patch it. Redesign as if the constraint had been there day one.

## When to Apply This

- ✅ Same type of bug appears 3+ times
- ✅ Architecture bends under load
- ✅ Features keep conflicting
- ✅ You're adding special cases to a special case

## The Rule

**If a design can't absorb the requirement, the design is wrong. Redesign.**

Not:
- ✗ "I'll add another flag to handle this case"
- ✗ "Let me bolt on compatibility"
- ✗ "I'll add a layer to work around this"

Instead:
- ✓ What would the design look like if this constraint had been there day one?
- ✓ Redesign from that ground truth
- ✓ Throw away the old design

## How

### 1. Identify the Pattern
Where does the design break? (3+ times = pattern)

### 2. Reground
What would day-one design look like with this constraint?

### 3. Redesign
From scratch. Not incrementally.

### 4. Migrate
One piece at a time from old design to new.

## Examples

**Bad:** "The user model keeps breaking when we add new fields. Let me add a dynamic field store."
**Good:** Redesign user model from scratch assuming dynamic fields were a day-one requirement.

## The Principle in One Sentence

**Throw it away and rebuild right, not patch it wrong.**
