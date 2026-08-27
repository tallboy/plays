---
name: principle-encode-lessons-in-structure
description: "Apply when you catch yourself writing the same instruction a second time, notice a recurring correction, or leave the same review comment twice. Encode the rule as a lint, CI check, type, or convention instead of more text — and design the repo so the shortest path is the correct path."
---

# Encode Lessons in Structure

Encode recurring fixes in mechanisms (types, lints, CI checks, conventions, automation) instead of textual instructions. Every error, human correction, and unexpected outcome is a learning signal. Capture it, route it, and close the loop.

**Why:** Textual instructions are easy to miss. They require the reader to notice, remember, and comply. Structural mechanisms enforce the rule without cooperation.

**The enforcement hierarchy.** Layers, strongest first:

1. **Architecture and conventions** — the codebase's shape makes the wrong thing hard to write (collocated features, banned imports between directories, one conventional way to add a thing).
2. **Compiler, types, lints, CI** — the wrong thing fails red. An unrepresentable state that cannot compile, then a lint or banned API that fails CI, then a canonical helper, then a runtime check.
3. **Rules, skills, review bots** — soft. Agents can forget them or apply them inconsistently.
4. **Human review comments** — the weakest layer, and a smell: every recurring review comment is a rule that wants to move up the hierarchy.

Skills — including this one — live at layer 3. Layer them over hard enforcement, never in place of it. A codebase guarded only by prose rules degrades; it's only a matter of time. When a correction recurs, push it down: "how do I turn this comment into a lint rule, a CI failure, or a categorical elimination of the problem?"

**Make the shortest path the best path.** Agents copy existing patterns and take the quickest route to a solution — so design the repo where the laziest solution is the correct one. Collocate everything a feature needs in one place so the obvious edit is the right edit. Make the conventional way the easy way, and the footgun a hard CI failure rather than a warning. A weaker guard becomes the next template.

**Pattern.** When you catch yourself writing the same instruction a second time:
1. Ask: can this be a type, a lint rule, a CI check, or a script?
2. If yes, encode it at the strongest rung the situation allows. Delete the instruction.
3. If no (genuinely requires judgment), make the instruction more prominent and add an example of the failure mode.

**Corollary:** Don't paper over symptoms. If the fix is structural, only use the structural fix. The instruction IS the symptom.

**Feedback loop:**
- **Capture every correction.** When the human intervenes or tests fail, decide if it's a one-off or a pattern.
- **Route to the right layer.** One-off → note. Recurring fix → lint rule or skill. Systemic issue → principle.
- **Close the loop.** Don't just record. Apply now or create a concrete todo.

**Anti-patterns:**
- Acknowledging without recording ("I'll keep that in mind" does not persist)
- Recording without routing (a note about a lint rule that should exist is wasted unless the lint rule gets implemented)
- Fixing without generalizing (fixing one instance while leaving the recurring pattern intact)
