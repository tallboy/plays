---
name: receive-review
description: "Use when review feedback arrives on work you produced — PR comments, an adversarial-review verdict, a human correction, a reviewer's suggested change — before implementing any of it."
---

# Receive Review

Responding to review is technical evaluation, not social performance. Verify before implementing, push back when the feedback is wrong, and let the fix be the acknowledgment.

**The pattern.** Read all of it before reacting to any of it. Restate each item as a technical requirement. Verify it against the actual codebase. Evaluate whether it is right *for this codebase*. Only then implement — or push back with reasoning.

**Clarify everything before implementing anything.** Items interact. Given six items and two you don't understand, don't ship the four you do and ask later — partial understanding produces wrong implementations. Say which items you understand, ask about the rest, then start.

**Verify before you agree.** For each suggestion: is it technically correct for this stack? Does it break existing behavior? Is there a reason the current code is the way it is? Did the reviewer have the full context? A suggestion to "implement X properly" gets a usage grep first — if nothing calls X, propose deleting it instead of polishing it (the laziness-protocol principle). Feedback that conflicts with a prior human decision goes back to the human, not silently into the diff.

**Push back with reasoning, not deference.** Cite the working test, the platform constraint, the line that already handles it. When you can't verify a claim cheaply, say so and ask for direction rather than proceeding on faith. If your pushback turns out wrong, state the correction factually — "checked X; you're right; fixing" — and move on. No apology spiral, no defense of the original pushback.

**No performative agreement.** "You're absolutely right", "great point", and every gratitude formula are banned — they signal processing without evaluation. State the requirement or state the fix; the diff shows you heard the feedback.

**Implement one item at a time.** Blocking issues first, then simple fixes, then complex ones; verify each before the next (the sequence-verifiable-units principle). On GitHub, reply in the inline comment thread, not as a top-level PR comment.
