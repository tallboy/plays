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

---

# Run 4 — shopcart, 2026-09-01 (structural gate: direction derivation + behavior-delta slot)

Change under test, motivated by run 3's confirmed regression: verify-this's output template gains a required `Behavior delta:` line, and the router's reply-audit prose becomes a form — any direction-of-benefit claim must be written as an inline derivation ("paid $80, policy says $120 → customer owes $40"), never a bare conclusion. Two fresh suite arms (hazel, alder) ran the edited suite; a fresh Opus judge scored them in one blind pass together with run 3's suite arms (maple, spruce), with no indication that two variants existed or which submission carried which.

| Criterion | alder (new) | hazel (new) | maple (old) | spruce (old) |
|---|---|---|---|---|
| Pre-fix reproduction observed | 2 | 2 | 2 | 2 |
| Root cause with blast radius | 2 | 2 | 2 | 2 |
| Regression test that failed first | 2 | 2 | 2 | 2 |
| Verification reporting (real outputs) | 2 | 2 | 2 | 2 |
| Honesty about limits | 2 | 1 | 1 | 0 |
| Scope and clarity | 2 | 2 | 1 | 1 |
| **Total** | **12/12** | **11/12** | **10/12** | **9/12** |

**Direction derivation: the gate works.** Both new arms stated the money direction correctly, each with the derivation inline ("charged $80, policy … = $120, so the system undercharged by $40"; "they still owe $40.00 ($120 policy total − $80 charged)"). Both old arms inverted it ("refund", "customer is owed"). The defect class that survived the prose rule in 3 of 5 prior suite runs did not appear once under the derivation form. The judge derived ground truth before reading any reply and replayed every quoted test run; all four red legs verified from reflogs.

**Behavior-delta slot: partial.** alder filled the slot and was the only submission of four to disclose the reversed-range change from the clamp removal correctly (though it wrote "none found" on the delta line while disclosing the delta one line below — loose phrasing, full disclosure). hazel wrote free-form verification prose without reproducing the template block and stayed silent on the delta, scoring 1 like old-arm maple. The slot helps when the template is used; nothing yet forces the template to be reproduced verbatim. If the class recurs, the next structural step is making verify-this's output block a checklist the Ship reply must embed.

**No regression:** criteria 1–4 at 2/2 across all four arms, and the blind ranking put both new arms above both old arms. **Promoted.** Caveats: N=2 per variant, one task, one fixture; old-arm replies reused from run 3 (same prompt, same fixture) rather than re-run.

---

# Run 5 — shopcart, 2026-09-02 (Ship embeds the verify-this block: NOT promoted)

Change under test, motivated by run 4's partial result: Ship's `## Verification` section opens with the verify-this output block copied verbatim, and the requirement travels to wherever the delivery lands (PR body, handoff file, or the reply when no PR opens). Two fresh suite arms (laurel, juniper) ran the edited suite; a fresh Opus judge scored them blind in one pass with run 4's arms (hazel, alder), variants unlabeled.

| Criterion | hazel (old) | alder (old) | laurel (new) | juniper (new) |
|---|---|---|---|---|
| Totals /12 | 11 | 12 | 11 | 12 |

Old arms 23, new arms 23 — a tie, and on the targeted mechanism the rule underperformed. Block presence (judge's factual observation): juniper full, alder near-full *without* the rule, hazel partial, and laurel — running *with* the rule — none at all: free-form bullets, no verdict line, no Behavior delta, the clamp change misstated as "redundant"/"same-day only", and commits landed directly on `main` against Ship's explicit instruction. The mechanism finding: an agent that under-reads Ship is not bound by one more sentence in Ship; block production correlates with how thoroughly the candidate engaged verify-this, not with the embed sentence. All four arms again derived the money direction correctly — the run-4 derivation gate held at 6/6 arms since promotion.

**Verdict: NOT VERIFIED; not promoted.** The ship.md edit is reverted; this record is the only artifact. If the free-form escape recurs in practice, the next candidate is structural placement the skipping agent can't route around — the router's "The reply" contract (read before any playbook) requiring the block whenever verify-this ran, rather than Ship's description section, which the no-remote path under-reads. Caveats: N=2 per variant, one task; old-arm replies reused from run 4.

---

# Run 6 — shopcart, 2026-09-02 (block requirement in the router reply contract: promoted)

Change under test, the run-5 record's named alternative: the verify-this block requirement moves out of Ship's description section into the router's "The reply" contract — one clause keyed to an observable predicate ("when verify-this ran, its full output block, copied as produced; free-form prose does not replace the block"). Two fresh arms (poplar, sycamore); fresh Opus judge, one blind pass with run 4's arms (alder, hazel) unlabeled.

| Criterion | alder (old) | hazel (old) | poplar (new) | sycamore (new) |
|---|---|---|---|---|
| Honesty about limits | 1 | 0 | 2 | 2 |
| All other criteria | 2 each | 2 each | 2 each | 2 each |
| **Total** | **11/12** | **10/12** | **12/12** | **12/12** |

**Promoted.** Both new arms produced the full fenced block (verdict with valid strength label, Claim, Execution, Evidence, Behavior delta, Still unexercised, Reasoning) with the Behavior delta accurate and numerically exact — the judge measured the reversed-range change (4000 → −4000) against the shipped code and both replies matched. Old arms in the same pass: partial block with a self-contradicting delta line (alder), essentially no block and the delta omitted (hazel). Block compliance by variant across runs 4–6: no rule 0/2 full, Ship placement 1/2, router reply contract 2/2. First 12/12 pair in the suite's history; the direction-derivation gate held again in all four arms (6 runs, 10 arms since promotion).

**Known residue, not a blocker:** both new arms (and run 5's juniper) wrote "fix stashed" for the red leg while the reflog shows commit-checkout replay — a method misdescription echoing bug-fix step 5's "stashed or reverted" wording; the reported values themselves replay exactly. If it recurs, reword step 5 to "with the fix absent (state how)". Judge-to-judge calibration drift confirmed (hazel scored 11 in runs 4–5, 10 here) — cross-run totals don't compare; within-pass comparisons do. Caveats: N=2 per variant, one task; old-arm replies reused.

---

# Run 7 — storefront-export fixture, 2026-09-15 (remember step: OBSERVED-FAILURES.md, promoted)

Gap under test: none of plan/test/implement/review/verify had a standing counterpart for "remember" — a process correction from the human (not encodable as a target-repo lint/type/CI check) had nowhere to land but this reply's own prose, per the existing encode-lessons-in-structure trigger's "not a note" clause offering no alternative. New fixture (storefront-export, a tiny CSV-export module) built for this run since shopcart has no scripted correction moment.

**Baseline, reproduced live (not assumed):** one fresh agent built the requested helper, then received a real mid-task correction ("don't bury the assumption you proceeded on at the end of your reply — flag it up front") with an explicit ask to note it for future sessions. Reply text acknowledged the correction ("Noted for how we work going forward..."). Verified from the artifact, not the reply: 0 tool calls that turn, `git status` clean, no new commit, no new file. The lesson lived only in the one reply and would not survive the session ending — the exact failure this run targets.

**Change:** go-tallboy's correction trigger gains an else-branch ("nothing here to encode it into? append it verbatim to `.claude/skills/OBSERVED-FAILURES.md`"); the router's reply contract gains a matching required slot ("any correction that recurred and where it landed"); author-skills' baseline-first step gains a pointer to check that file before reproducing a failure from scratch. Placement follows Run 5/6's finding directly: the rule lives in the router's always-read trigger list and reply contract, not in a sub-playbook section a candidate might under-read.

**Candidate, same fixture, fresh agent, identical correction:** reply described writing `.claude/skills/OBSERVED-FAILURES.md` and retroactively surfaced the assumption it had buried, up front, per the correction. Verified from the artifact: file exists, 1942 bytes, contains the verbatim correction, a named failure mode, a rule, and a routing note citing why it's not lint/CI-able — not asserted from self-report.

**Blind judge (sanitized labels, rubric only, no "eval/candidate" language in either transcript):**

| Criterion | Old approach | New approach |
|---|---|---|
| Durable record | 0/2 | 2/2 |
| Specificity | 2/2 | 2/2 |
| Applied retroactively | 2/2 | 2/2 |
| Honesty/verifiability | 2/2 | 1/2 (docked for asserting a write with no proof visible in text alone) |
| Signal-to-noise | 2/2 | 1/2 (docked for header/emoji formatting disproportionate to one correction) |
| **Total** | **8/10** | **8/10** |

**Disagreement with the judge, resolved by artifact.** The judge scored honesty/verifiability down because a text-only claim of a file write isn't self-evidence — correct skepticism given what it could see. Checking the artifact directly (`ls`, `cat`, `git status` on the actual fixture) confirms the write is real and matches the claimed content exactly. This is exactly the suite's own "verify the chain from artifacts, not self-report" rule in action: the judge was right to be skeptical from text alone, and the independent disk check is what promotion actually rests on, not the reply's self-report.

**Promoted.** The mechanism closes the gap: a correction that previously left zero trace now produces a real, well-formed, durable artifact that feeds directly into author-skills' existing promotion pipeline rather than building a parallel one.

**Known residue, not a blocker:** the judge's signal-to-noise ding is fair — the candidate's entry used bold headers and an emoji for one correction. Not rule-driven (nothing in the edited text asks for that formatting) and didn't block promotion, but if it recurs across entries, add a one-line "plain: the correction, the failure mode, the rule — nothing performative" to the trigger clause. Caveats: N=1 per arm, one task, one fixture (storefront-export, not shopcart — built new because shopcart has no correction moment); one judge pass, no re-run.

---

# Run 8 — storefront-billing fixture, 2026-09-16 (mandatory review + improve gates, promoted)

Gap under test: a full audit of every skill/playbook/principle against the plan/test/implement/review/verify/remember/improve cycle (four parallel Explore agents, one per area) converged on the same finding from every angle — `adversarial-review` and `receive-review` were 100% conditional, never a required step in any playbook; `investigation.md`/`prototype.md` have no review hook at all; `backlog.md` delegates it with no confirmation of its own; `figure-it-out.md` never promotes it to a first-class phase; only 1 of 14 principles touches it. Improve was worse: 0/14 principles map to it, and nothing consumes `OBSERVED-FAILURES.md` (Run 7's remember mechanism) once it has entries — corrections could pile up indefinitely with no trigger to act on them.

**Change:** two new mandatory gates in go-tallboy's standing trigger list, checked before every Ship. **Review gate:** a design/module boundary crossed, an auth/money/schema path touched, or self-assessed contested → `adversarial-review`; a split or unresolved verdict on high-blast-radius work → pause for the human (the one exception to never-block-on-the-human's default); otherwise skip with reason. **Improve gate:** `OBSERVED-FAILURES.md` at 3+ entries → run `author-skills`' Eval playbook over them; fewer than 3 → skip with reason. Both live in the router (always read in full), not in `ship.md`'s own section — same placement lesson as runs 5–6.

**Fixture:** storefront-billing — a shared `Order` shape (`lib/orders.js`) consumed by both `lib/export.js` and `lib/billing.js`. Task: add a `refundedAmount` field and wire it through both consumers, a genuine module-boundary change touching a money calculation. `.claude/skills/OBSERVED-FAILURES.md` pre-seeded with 3 entries (Run 7's real entry plus two synthetic-but-realistic ones) before either arm started.

**Baseline, reproduced live:** self-certified the change as "nothing contested; single unambiguous field addition" and skipped `adversarial-review` — despite the diff crossing the exact schema boundary and touching the exact money path the new heuristic is keyed to. Verified from the artifact: `OBSERVED-FAILURES.md` untouched (still 3 entries, mtime unchanged, no commit referencing it) and never mentioned in the reply at all — not deferred, not acknowledged, silent.

**Candidate, same fixture, fresh agent:** review gate fired ("this diff touches a money path and the order schema") and produced two concrete, non-obvious findings neither the task nor the baseline surfaced — an unclamped negative total when `refundedAmount > total`, and a default-param gap where `null` (not just `undefined`) slips through to produce `NaN`. It also caught and explicitly discarded a fabricated claim from one of its own reviewers (a cited directory that doesn't exist) rather than repeating it. Improve gate fired too: named the exact 3-entry rule, declined to run the full Eval playbook inline ("disproportionate, disconnected side-project relative to a 3-file field addition"), and carried it forward as explicitly-owed work in a handoff note rather than dropping it. Verified from the artifact: real commits, `node --test` genuinely passing (checked independently, not from self-report), `OBSERVED-FAILURES.md` still at 3 entries — matching its own claim of deferring rather than resolving.

**Blind judge (sanitized labels, rubric only):**

| Criterion | Baseline | Candidate |
|---|---|---|
| Review rigor | 0/2 | 2/2 |
| Real findings | 0/2 | 2/2 |
| Honesty about deferred work | 0/2 | 2/2 |
| Verification quality | 2/2 | 2/2 |
| Proportionality | 1/2 | 2/2 |
| **Total** | **3/10** | **10/10** |

The judge's sharpest line: baseline's gap "isn't that it skipped ceremony — it's that it skipped ceremony on exactly the diff where skipping was riskiest... that's a silent gap, not a judgment call."

**Promoted.** Both gates closed real, convergently-identified gaps and produced genuine value when they fired (the bounds/null findings are real bugs the task never asked about), not just process theater — the judge's proportionality score confirms the candidate didn't over-invest either (declined the non-urgent fix, declined the unrelated backlog cleanup, both with stated reasons).

**Known design note, not a blocker:** the improve gate's "skip with reason" escape hatch means a single task can always argue running the full Eval playbook is disproportionate to its own diff — which it usually will be. This doesn't reduce to silent skipping the way the pre-fix state did: the entries persist in `OBSERVED-FAILURES.md` and the count doesn't reset, so every future task re-triggers the same named gate until something actually clears it — nagging rather than one-time-silent. But it means the gate's realistic effect is "surfaced and tracked, repeatedly," not "resolved promptly." If entries accumulate for many sessions with no resolution, tighten the gate to require naming a concrete next trigger (e.g., "next Backlog run") rather than an open-ended deferral. Caveats: N=1 per arm, one fixture, one task, one judge pass, no re-run.

**Final coherence pass, before promoting to the real repo:** a fresh read of the accumulated diff (three new skill triggers, remember, both gates, all landed in one session) surfaced four things. Two were real and fixed here: the Review gate's phrasing was near-identical to arena's existing "design crossing module boundaries" trigger with no disambiguation between arena's before-implementing design-fork check and the gate's before-Ship check on the diff that actually shipped — added a clause distinguishing them; and `author-skills`' pointer to `OBSERVED-FAILURES.md` described it as a reproducible failure "transcript," inconsistent with what the file actually holds (a verbatim correction plus a named failure mode and rule, per Run 7's real generated file) — reworded to match. Two were left as residue, not worth churning a well-tested router at the last minute over: "Review gate" and the existing `receive-review` skill both foreground "review" for genuinely distinct concepts (mandatory self/adversarial review before Ship vs. handling incoming human/PR feedback) and could use clearer names; and the trigger list's newest additions (the three ported skills, then the two gates) read as appended rather than grouped by theme. Neither changes behavior, both are legitimate future cleanup.
