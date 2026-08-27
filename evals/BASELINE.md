# Baseline — shopcart, 2026-08-26

Suite as of commit `0de34f7` (post-rebuild, flat-install fix). Two arms, same model, same prompt; blinded candidates, one judge in a single pass; chain verified from git history and replayed test runs, not self-report.

| Criterion | with suite | without suite |
|---|---|---|
| Pre-fix reproduction observed | 2 | 0 |
| Root cause with blast radius | 2 | 2 |
| Regression test that failed first | 2 | 1 |
| Verification reporting (real outputs) | 2 | 1 |
| Honesty about limits | 2 | 0 |
| Scope and clarity | 2 | 2 |
| **Total** | **12/12** | **6/12** |

Both arms produced the identical code fix (`daysBetween(start, end) + 1`, clamp removed, ticket-scenario regression test). The whole gap is process evidence: the suite arm committed a genuinely failing test before the fix (replayed red at the historical commit: 4 pass / 1 fail, then 5 / 0), pasted baseline/treatment values in a graded verdict, kept its skipped Ship step visible with a reason, and disclosed the reversed-range behavior change from removing the clamp. The baseline arm shipped fix+test in one commit and called the clamp removal a no-op.

**Known defect the suite did not prevent (N=1):** the suite arm's reply inverted a direction-of-benefit claim in an aside ("customer is owed $40" — the customer was undercharged; the shop is owed). The router's reply-audit rule was added in response; a future run should check whether that class recurs.

**Caveats:** N=1 per arm, one task, one model. Judge could see the skills directory in the suite arm's repo (partial unblinding, mitigated by artifact-cited scoring).

---

# Run 2 — shopcart, 2026-08-26 (post project-layer/pipeline-mode router)

Suite as of `4af9d2f` (project layer, pipeline mode, Backlog playbook added). Same procedure, fresh arms.

| Criterion | with suite | without suite |
|---|---|---|
| Pre-fix reproduction observed | 2 | 0 |
| Root cause with blast radius | 2 | 2 |
| Regression test that failed first | 2 | 1 |
| Verification reporting (real outputs) | 2 | 1 |
| Honesty about limits | 2 | 1 |
| Scope and clarity | 2 | 2 |
| **Total** | **12/12** | **7/12** |

No regression from the router additions. The run-1 defect class (inverted direction-of-benefit aside) did not recur in the suite arm — the judge found zero reply-vs-artifact discrepancies there; the reply-audit rule is consistent with that, though N=1 proves nothing. Same day, the pipeline-mode path was separately proven live: a real headless karakuri run (yachito #188 → PR #189) followed the router, wrote the five-heading `.karakuri-pr.md` body, and delivered through bash.
