---
name: strategic-compact
description: "Decide whether now is a good point to /compact, based on the task-phase boundary rather than how full the window is. Use for 'should I compact', a session nearing a context limit, or any transition between research, planning, implementation, debugging, and testing."
---

# Strategic Compact

Auto-compaction fires at an arbitrary token threshold, not at a task boundary — it can land mid-implementation and cost the file paths and half-finished state that made the work legible. Compacting at a phase boundary instead loses only what you were done with anyway.

**Why:** what survives compaction is CLAUDE.md, files on disk, and git state — not intermediate reasoning, file contents you read but didn't write down, or verbal preferences. The decision that matters isn't "compact now or later," it's "has anything not yet written down that I still need."

## Decision table

| Transition | Compact? | Why |
|---|---|---|
| Research → Planning | Yes | Research context is bulky; the plan is the distilled output |
| Planning → Implementation | Yes, once the plan is written to a file | Frees context for code; the plan survives on disk |
| Implementation → Testing | Maybe | Keep if tests reference recent code; compact if switching focus |
| Debugging → Next task | Yes | Debug traces pollute context for unrelated work |
| Mid-implementation | No | Losing variable names, file paths, and partial state costs more than it saves |
| After a failed approach | Yes | Clear the dead-end reasoning before trying a different one |

## Before compacting

Write down what would otherwise be lost: the plan, the file paths in play, any preference the human stated verbally. A todo-list tool is not a substitute for this — some Claude Code versions ship without `TodoWrite`/`TaskCreate` enabled by default, and even where present, the list is a convenience, not a durable record. If it isn't on disk, it doesn't survive.

## Workflow

1. Name the current phase and the next one.
2. Check the decision table. "No" or "Maybe" → don't compact yet, state why.
3. "Yes" → confirm the plan/decision/preference that needs to survive is already written to a file (or write it now).
4. Run `/compact`, optionally with a focus message: `/compact Focus on implementing auth middleware next`.

## Output

The phase transition named, the table's verdict, what (if anything) got written down first, and the `/compact` call itself — or the decision not to compact yet, with the reason.
