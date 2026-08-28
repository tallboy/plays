# Figure it out

**When the task matches no playbook, design one.** The deliverable before any code is the workflow itself: phases that scale rigor to the task, run the scientific method, and leave a decision trail a human can audit after stepping away. Bias toward more rigor — the cost of building the wrong thing dwarfs the cost of being careful.

Don't reinvent a playbook you already have: a focused single-unit task routes to its narrow playbook. But a large or cross-cutting version of one (a migration across many call sites, an ambitious multi-part change), or work the user reviews after stepping away, belongs here even when a single-unit version would be a Feature.

## Phase A — Frame

Ground first. Don't start until you can state, in writing:

- **The definition of done as a falsifiable predicate.** "Cost totals match `SELECT SUM(...)` for two users with mixed inventory" is a predicate; "dashboard works" is not. If you can't say what observation would prove you wrong, you don't have a predicate yet.
- **Scope, quantified:** rough units and effort, plus every blocker already visible (an unset env var, a pending decision). Surface blockers now, not after an hour of doomed edits.
- **The rigor level, and why.** One-way doors (schema, auth, money paths) get more gates and artifacts; reversible low-stakes steps get fewer. Rigor is gates and artifacts, not "try harder".

Present the framing before committing to a long run. Reversible work proceeds; a multi-hour run earns one checkpoint.

## Phase B — Design the workflow

Decompose into atomic, independently-landable units — vertical slices, not horizontal layers. Sequence riskiest-unknown-first so option value stays high (validate the external API's feasibility before building three phases on it). Scaffold and verification come before features.

- **Build the verification harness before the work**, with the baseline captured from the pre-change state, so every check reads as "old value vs new value".
- For one-way-door design decisions, run the arena skill. Skip it for mechanical work whose shape is already concrete.
- Decide what fans out. Parallelize only across genuine seams, each worker in its own worktree or branch. Don't over-fan.
- Write the designed phase list down; that list is what the human reviews. Add its steps to the todo list under the same verbatim + `skip: <reason>` rules as any playbook.

## Phase C — Run the loop

Each unit is an experiment: state the hypothesis, make the smallest change, measure against the predicate on the real artifact, keep it if it advanced, revert it if it didn't.

- Verify by inspecting the artifact, never a self-report. When something passes too easily, suspect the observation method before the system — a blank screenshot passes a lazy gate.
- Audit delegates' artifacts yourself before trusting them. If a worker games the gate, reset and harden the contract. If the gate itself is wrong, fix the gate in its own change rather than routing around it.
- Verdicts per the verify-this skill: VERIFIED / NOT VERIFIED / INCONCLUSIVE. Inconclusive is not a pass. Don't hide a negative.

## Phase D — Keep the decision trail

One log, a row per decision and per unit: what was decided, why, and a pointer to the evidence (not prose). Weave it through the run — a row as each unit lands — rather than reconstructing at the end. Before delivering, audit the log against what actually happened and cut invented or aspirational entries; fix the log, not the story. Commit the trail when confidence has to be shown later.

## Phase E — Verify and hand back

Check the whole against the Phase A predicate on the real product, not just the harness. Encode any recurring correction as a gate, a lint rule, a check, or a script, so the win can't silently regress (the encode-lessons-in-structure principle).

**Reply:** the playbook you designed, the rigor level and why, the decision-trail location, what's verified against the predicate, and what's still open.
