---
name: principle-guard-the-context-window
description: "Route bulk work to subagents. Keep summaries in main thread, not raw payloads. Preserve context for decisions."
metadata:
  phase: principle
  pstack_ref: "guard-the-context-window"
  version: "1.0.0"
---

# Guard the Context Window

**The play:** Don't blow your mental (or actual) context on bulk work. Delegate it, keep the summary.

## When to Apply This

- ✅ Reviewing 100 files (summarize by file)
- ✅ Processing large datasets (sample + stats)
- ✅ Reading dense logs (extract signal)
- ✅ Any bulk operation

## The Rule

**Work on bulk elsewhere. Bring back the summary.**

Not:
- ✗ Full log output (read first 10MB)
- ✗ All 100 files in one context
- ✗ Complete raw data (lose the forest)

Instead:
- ✓ Run analysis elsewhere
- ✓ Bring back key findings
- ✓ Keep decision-making context clear

## How

### 1. Identify Bulk
What's too much to hold in context?

### 2. Delegate It
Process elsewhere (subagent, script, tool).

### 3. Bring Back Summary
"Out of 10K logs, 50 errors. Pattern: timeout. Root: DB pool exhaustion."

## Examples

**Bad:** Paste entire log into conversation.
**Good:** "I analyzed 10K logs. 50 errors, pattern X, cause Y. Recommendation: Z."

## The Principle in One Sentence

**Preserve mental bandwidth. Summarize bulk. Delegate detail.**
