---
name: adversarial-review
description: "Multiple independent reviewers challenge a change from different angles, then a lead synthesizes a verdict. Use for 'review this', 'adversarial review', 'challenge this', 'tear this apart', pre-merge review of a branch or PR diff, or any contested design."
---

# Adversarial Review

Spawn independent reviewers against the same diff, then synthesize their findings into one verdict. The deliverable is the synthesized verdict; do not auto-apply changes.

The adversarial signal comes from reviewer independence and diversity, not assigned personas. Where the harness supports it, put reviewers on different model families — models differ in blind spots, priors, and reasoning patterns. Agreement across independent reviewers is high-confidence signal; lone findings are worth reading but lower confidence.

## Step 1 — Scope and intent

Determine what to review: the diff the user points at, or `git diff <base>...HEAD` on a feature branch. Gather enough surrounding context that reviewers can evaluate without guessing.

State the intent explicitly before spawning: one paragraph on what this change is trying to accomplish, derived from the user's message, commit messages, and the code. Reviewers challenge whether the work achieves the intent well, not whether the intent is correct.

## Step 2 — Spawn reviewers

Launch at least two reviewers in parallel, read-only, each with the same diff, the stated intent, and one lens each:

- **Correctness and security:** bugs, breakages of existing behavior, security vulnerabilities, subtle cross-module side effects, feature-gate leaks, changes that break how developers run or build the code locally (env var renames, port remaps, new required setup steps).
- **Quality and maintainability:** structure, file growth, unnecessary abstractions, reader load, drift from the codebase's conventions.

Scale up (extra reviewers, extra lenses like performance or API compatibility) when the change is large or the user asks for thoroughness.

**Calibration guards — include these in every reviewer's prompt:**

- **Only the diff.** Report issues in code being added or modified. Do not report pre-existing problems in untouched code (note them separately at most).
- **Intended breakage.** If a high-risk finding is the branch's stated purpose (removing a flag, deleting a feature) and well-scoped, don't report it — unless the author seems unaware of the full implications.
- **No over-reporting.** Misreported priority destroys trust and gets the reviewer ignored. Trace an issue end-to-end to full confidence before flagging it as high.
- **No unfinished research.** Never report "X is a problem unless the backend handles it" when you can check the backend yourself. Finish the trace.
- **Fresh eyes first.** Complete the audit before reading existing PR comments or bot findings; then reconcile, crediting what others caught.

## Step 3 — Synthesize

As results return:
1. Deduplicate — different reviewers describe the same issue differently; merge and note who raised it.
2. Weight consensus — findings raised independently by 2+ reviewers are highest signal.
3. Note disagreements — one reviewer flagging what another explicitly cleared is useful context.

## Step 4 — Lead judgment

You are the lead reviewer — a pragmatic senior engineer, not a neutral aggregator. You hold context the reviewers lack (the goal, constraints, tradeoffs already made); use it aggressively. Bucket every finding:

- **Act on** — real issues affecting correctness, security, or maintainability given the actual goals. Would block a merge.
- **Consider** — legitimate, but the cost of addressing may outweigh the benefit right now.
- **Noted** — technically valid but not actionable: context-dependent, premature, low-impact.
- **Dismissed** — wrong, nitpicky, or missing context. Brief reason why, so the user can override your judgment.

## Output

Intent paragraph, then the four buckets (each finding: description, which reviewers raised it, one-line rationale), then an agreement map — where reviewers agreed, where they diverged, and what the pattern says. Keep the dismissed section: showing what was filtered out and why is part of the verdict.
