---
name: arena
description: "Spawn N parallel candidates at the same task, cross-judge blind, pick a base, graft the strongest parts of the losers into it. Use for 'arena this', design bakeoffs, architectural decisions with no precedent, or when one attempt at a non-trivial artifact would lock in the wrong shape."
---

# Arena

Fan out N parallel attempts at the same task. Read every candidate end to end. Pick the strongest as the base. Graft the best ideas from the others into it. Verify the synthesized result.

This is the operational form of "exhaust the design space": when a novel interaction or architectural decision has no established precedent, one design is a guess. A second flavor of the first shape does not count as an alternative. Skip the arena for mechanical work whose shape is already established — a second arena over a settled design is over-engineering.

Open a todolist with one entry per phase before launching anything; the arena runs autonomously and the list keeps phases from silently disappearing.

## Phase A — Frame

The N candidates receive the same prompt, so the prompt is the contract. Get it right before spawning.

1. State the artifact each candidate is producing.
2. Derive the rubric: what success looks like for *this* task, as 3–6 concrete gradeable criteria. Concrete: "adds a --dry-run flag that skips writes". Vague: "code is correct". **The rubric is shown only to the judge; candidates see only the task.**
3. Pick the runners: 2–4 candidates, on different model families where the harness supports it. Same model N times when the work is generation-bound rather than judgment-sensitive. Spawn more when the arena covers multiple design directions.
4. Assign output paths: each candidate writes to its own location (a git worktree where possible). N candidates writing to one path is shared mutable state — see the foundational-thinking principle's concurrency corollary.

## Phase B — Fan out

Spawn all candidates in one message, in parallel, each with the task, its own output path, and instructions to produce the artifact **and a short rationale naming the alternatives it considered and rejected**. The rationale is mandatory — without it you can't tell whether a candidate's structure is principled or accidental, which makes grafting unreliable. A candidate that fails to produce output: proceed with N−1 and note the dropout.

## Phase C — Cross-judge

After all candidates complete, spawn one read-only judge, preferring a different model family from your own. It sees the rubric and the candidates by path label — never a model name — scores each criterion, and recommends a base with rationale.

## Phase D — Pick a base

Read every candidate end to end before picking; skimming surfaces only the candidate whose surface looks most familiar. Score criterion by criterion, not on holistic feel. Compare with the judge: agreement confirms the pick; disagreement means one of you is biased or the rubric was ambiguous — read both rationales before deciding. Pick on which candidate a future maintainer can extend most easily without breaking invariants; prefer the smaller surface when tied.

## Phase E — Graft

Walk each losing candidate once more for what's worth porting — usually one or two things per candidate, not most of it. Fold each graft in by hand so the result stays coherent under one mental model. Record what was grafted, from which candidate, and what was rejected and why. The rejection notes are the highest-signal part of the record.

Convergence across candidates on one shape → strong agreement signal; ship the consensus, no graft needed. Wild divergence → Phase A was under-specified; reframe and re-run rather than averaging.

## Phase F — Verify

The synthesized artifact holds to the same scrutiny as any other output (the prove-it-works principle, or the verify-this skill for a checkable claim). **The arena does not earn you a pass.** If verification surfaces a problem the arena missed, either Phase A was wrong (re-frame, re-run) or one candidate caught it and you missed the graft (back to Phase E). Don't paper over.

## Output

One synthesized artifact, plus a short synthesis note naming the base, the grafts with source, the rejections, any dropouts, and the verification result.
