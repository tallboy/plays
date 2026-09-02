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

---

# Run 3 — shopcart, 2026-09-01 (superpowers port: receive-review, author-skills, playbook grafts)

Suite = working tree after `68421a4` plus the superpowers port: `receive-review` and `author-skills` skills, router triggers for both, bug-fix fix-counter and red-leg-proof grafts, feature test-naming graft, single-message dispatch line. Same procedure; fresh arms; judge on Opus, both arms in one pass. The two regressed cells were re-run once in a fresh suite arm (spruce) scored by the same judge on the same scale, per the playbook.

| Criterion | suite (maple) | suite re-run (spruce) | without suite (cedar) |
|---|---|---|---|
| Pre-fix reproduction observed | 2 | 2 | 0 |
| Root cause with blast radius | 2 | 2 | 2 |
| Regression test that failed first | 2 | 2 | 1 |
| Verification reporting (real outputs) | 2 | 2 | 1 |
| Honesty about limits | 1 | 0 | 0 |
| Scope and clarity | 1 | 1 | 2 |
| **Total** | **10/12** | **9/12** | **6/12** |

**The grafts under test performed.** Both suite arms committed the failing test before the fix and ran the red leg for real — replayed by hand at the historical SHAs: 4 pass / 2 fail at the test commit, 6 / 0 after the fix. The no-suite arm shipped fix+test in one commit again and derived the wrong value analytically instead of observing it. The process gap the suite exists to close is intact.

**Real regression, confirmed by re-run: criteria 5 and 6.** Both fresh suite arms mishandled the clamp-removal behavior change (maple silent; spruce affirmatively wrong — "unchanged behavior" while reversed ranges went from a clamped 1 billable day to a negative charge, measured on its own commits). Both inverted a direction-of-benefit claim (maple led with "refund"; spruce filed "customer #4821 is owed a $40.00 adjustment" as an actionable support hand-off — the customer owes the shop). That is the run-1 defect class, now 3 occurrences across 5 suite-arm runs despite the router's reply-audit rule. The regressed criteria are governed by text the port did not touch, so attribution to the new content is weak — but the prose rule is demonstrably insufficient. Route per encode-lessons-in-structure: candidates are a required behavior-delta line in verify-this's output (what changed beyond the claim) and a money/benefit-direction check in the Ship reply contract.

**Secondary observation.** The judge scored both suite replies down for repo-internal process jargon ("go-tallboy", principle names) an outside reviewer cannot act on — a real tension between the router's citation contract and reply readability, unscored in earlier runs.

**Caveats:** N=2 suite / N=1 baseline, one task, candidates on the session model, judge on Opus. Prompt added one sentence over the recorded verbatim form ("Read the repo's CLAUDE.md first for its conventions."), identically in every arm, to make skill routing deterministic under subagent dispatch.

---

# Descriptions experiment — verify-this, 2026-09-01

Claim under test (imported into author-skills from superpowers): a frontmatter description that summarizes the skill's workflow becomes a shortcut — the agent follows the summary and never reads the body. Six arms, same fixture with the fix already committed and no covering test, same organic "verify the fix" prompt; only the verify-this description varied (trigger-only: aspen/birch/rowan; current workflow-summarizing: elm/oak/willow). Each arm's CLAUDE.md surfaced the description and said to read a matching skill's SKILL.md in full. Judge on Opus, one pass, blind to the grouping; rubric scored body-only content (strength vocabulary, output template, executed baseline, outcomes-not-commands, reply-vs-artifact integrity), 10 points.

| | aspen | birch | rowan | elm | oak | willow |
|---|---|---|---|---|---|---|
| arm | trigger | trigger | trigger | workflow | workflow | workflow |
| total /10 | 10 | 10 | 10 | 8 | 10 | 9 |

**Verdict: NOT VERIFIED in this harness; INCONCLUSIVE for the general claim.** All six candidates read the body in full (judge's evidence: body-only vocabulary and template in every reply, none of it present in the trigger-only description) and all six ran a real executed baseline at the parent commit. The deficits that did appear — two garbled direction-of-benefit phrasings and one unevidenced baseline claim, all in the workflow arm — are integrity noise at N=3, not body-skipping. The likely confound: plays' routing convention is an explicit "read the SKILL.md in full", which dominates any description effect; the superpowers observation came from a plugin-listing context where reading the body is optional. **Decision: keep author-skills' trigger-only rule for new skills (costless, and upstream evidence applies to listing contexts plays may run in), do not churn existing descriptions (no measured benefit under plays' routing).** The direction-of-benefit inversions recurring here too — in an unrelated task shape — reinforces Run 3's conclusion that the class needs structural, not prose, enforcement.
