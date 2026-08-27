---
name: verify-this
description: "Verify a claim with fresh evidence: restate it falsifiably, capture baseline and treatment, compare artifacts, and return VERIFIED, NOT VERIFIED, or INCONCLUSIVE with a named evidence strength. Use for 'verify this', 'prove it works', 'did this fix it', or any bug fix, perf, UI, or behavior claim that needs proof."
---

# Verify This

Verification is not a recap. It proves or disproves a specific claim with repeatable evidence. Run the code — reading the diff is not verification.

## When to use

- "Verify this", "prove it works", "did this fix it", "show me the evidence".
- A bug fix needs a before/after repro.
- A UI, CLI, API, performance, or memory claim needs measurement.
- A test passes but the user-visible behavior still needs confirmation.

Do not use this for vague claims like "the code is cleaner". Ask for a measurable claim first.

## Workflow

1. Restate the claim in falsifiable form: condition, metric, and threshold.
2. Pick the smallest surface that can disprove it. Prefer the project's own verification skill (see the bootstrap-verify skill) or documented gate command; a repo's composite gate (`make preflight`, `npm run preflight`) beats a hand-picked subset that drifts.
3. Capture a baseline from the old state: merge base, parent commit, failing branch, or current broken repro. A verification with no baseline is INCONCLUSIVE, not VERIFIED.
4. Capture treatment from the changed state with the same command, data, warmup, and environment.
5. Compare raw artifacts: numbers, screenshots, terminal transcripts, HTTP responses, profiles, test output.
6. Return exactly one verdict, with the strength of the evidence named.

## Verdict rules

- `VERIFIED`: baseline and treatment differ in the predicted direction, by the claimed threshold, with no obvious confound.
- `NOT VERIFIED`: the behavior is unchanged, moves the wrong way, or misses the threshold.
- `INCONCLUSIVE`: no valid baseline, noisy signal, failed measurement, or an environment difference invalidates the comparison.

Inconclusive is not a pass. A gate that errored for an unrelated reason is a gate you have not run; say so rather than rounding it up to green. A gate that silently skips its check is not a gate — hard-fail on an unrunnable check rather than reporting green. Do not soften a negative result; a clear `NOT VERIFIED` is useful.

**Evidence strength.** A VERIFIED verdict states the strongest claim the execution evidence supports, no stronger:

- `live-verified` — you exercised the real surface (real browser, real binary, real CLI) and observed the behavior. Required for UI and interactive claims when the environment permits.
- `test-verified` — a targeted test exercises the changed path and passes. No live confirmation.
- `static-only` — only typecheck/build/lint passes. Claim this only when the change is typing-only or compile-only.

Environment failures (port conflicts, missing creds, broken harness) that prevent the check → `INCONCLUSIVE (blocked: <reason>)`. Never report `static-only` for a check you didn't run end-to-end; that disguises an environment failure as a thin verification. If you're tempted to write a verdict without running anything, the verdict is blocked — say why.

## Grading individual facts

When the claim decomposes into safety facts ("this call only drops dead cache entries"), get each fact as far down this ladder as is cheap, and say where it stopped:

1. You said so. Worthless on its own.
2. You pointed at the line. A real `file:line`, or the library's own source.
3. You showed the bad case can't happen. You walked the failure step by step and it doesn't reach.
4. You ran it. A script or test that calls the real code and fails loud if you're wrong.
5. You reproduced it in the running app.

Any fact you can't get to rung 4, say so out loud. Don't write it up as settled. Rung 4 is usually one small script that imports the same library the app ships and calls the exact function you're worried about.

## Output

```text
VERIFIED (live-verified) | VERIFIED (test-verified) | VERIFIED (static-only) | NOT VERIFIED | INCONCLUSIVE (<reason>)
Claim: <falsifiable claim>

Execution:
- <command run> → <outcome>
- <test suite> → <pass/fail counts>
(every meaningful thing you actually ran — this section is what distinguishes real verification from pattern-matching)

Evidence:
<metric/artifact>: baseline=<...>, treatment=<...>, delta=<...>, threshold=<...>

Still unexercised: <edge cases untested, load unsimulated, environments not run>

Reasoning: <one tight paragraph naming the evidence and any confounds>
```

Report outcomes, not command names. When artifacts may contain sensitive code, prompts, or data, keep only the minimal inline evidence unless the user agrees to disk storage.
