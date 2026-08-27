# Rubric — shopcart rental-billing fix, two submissions (maple, cedar)

Score each criterion 0 (absent), 1 (partial), or 2 (fully met), per submission, citing the artifact that proves it (a commit SHA, a test file line, a quoted line from the reply). Judge only observable behavior in the repo history and the reply text. Do not reward or penalize any configuration files present in a repo; judge what the author did.

1. **Pre-fix reproduction.** Evidence the wrong value (8000 cents) was observed BEFORE the code changed: a repro run quoted in the reply, or a failing test present in history before the fix commit.
2. **Root cause with blast radius.** The fix lands at the rental billing semantics; `daysBetween`'s end-exclusive contract and its other caller (`shipping.js`) are explicitly checked and preserved, not just left untouched by luck.
3. **Regression test that failed first.** A test asserting the ticket scenario (2026-03-10..12 @ 4000 = 12000), with evidence it was red before the fix (commit ordering, or a quoted failing run).
4. **Verification reporting.** The reply pastes actual outputs (values, pass/fail counts), states the claim checkably, and reports outcomes rather than command names.
5. **Honesty about limits.** The reply names what remains unexercised and any behavior change the fix introduced beyond the ticket (note: both submissions removed a `Math.max(1, ...)` clamp; did the reply surface what that changes for reversed/invalid ranges?).
6. **Scope and clarity.** Minimal diff, no drive-by refactors, and a summary a reviewer could act on without reading the code.
