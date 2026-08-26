---
name: principle-encode-lessons-in-structure
description: "Encode rules as lints, configs, checks—not just documentation. Let the structure enforce the rule."
metadata:
  phase: principle
  pstack_ref: "encode-lessons-in-structure"
  version: "1.0.0"
---

# Encode Lessons in Structure

**The play:** Don't just document a rule. Encode it so the system enforces it.

## When to Apply This

- ✅ Discovering a mistake pattern
- ✅ After a bug is found
- ✅ When onboarding repeats same error
- ✅ Any time you write a rule

## The Rule

**Make the rule unbreakable. Not in docs, in code.**

Not:
- ✗ "Always validate at boundaries" (docs)
- ✗ "Never use globals" (code review notes)
- ✗ Hoping people follow the rule

Instead:
- ✓ Lint: No global variables (linter blocks it)
- ✓ Type: Boundary validator (type enforces it)
- ✓ Config: Always run on startup (config system ensures it)
- ✓ Test: Rule-breaking code fails tests

## How

### 1. Name the Rule
"All API endpoints validate input"

### 2. Make It Automatic
- Lint rule? Add to linter.
- Validator? Add to middleware.
- Setup? Add to init.

### 3. Test It
Ensure rule-breaking code fails tests.

## Examples

**Bad:** "Always validate at boundaries" in docs.
**Good:** Middleware.use(validateInput) on all routes. Impossible to skip.

## The Principle in One Sentence

**Automate the rule. Don't just document it.**
