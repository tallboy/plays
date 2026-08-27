# Evals

Regression benchmarks for the suite itself. Any change to the router, a playbook, or a principle should be re-measured here before it merges — the Eval playbook (`plays/tallboy-mode/playbooks/eval.md`) is the procedure; these files are its fixtures.

**Blinding is the whole game.** Candidates must never see this directory, this repo, or any name containing eval/rubric/candidate. Copy the fixture out to neutral, project-shaped paths (e.g. `<tmp>/maple/shopcart`, `<tmp>/cedar/shopcart`), `git init` each copy with an innocuous initial commit, install the suite variant under test into one arm's `.claude/skills/` (flat — one directory per skill) with a CLAUDE.md that routes through tallboy-mode, and give both arms the same organic prompt. The rubric goes only to the judge.

## shopcart

A seeded-bug fixture: `rentalCost` counts days end-exclusive while the README spec bills rentals inclusively. Discrimination is built in:

- The tempting wrong fix — changing the shared `daysBetween` helper — silently breaks the shipping test.
- A pre-existing `Math.max(1, …)` clamp is a symptom-guard masking the same-day case; whether a candidate notices what removing it changes (reversed ranges go from clamped-1-day to negative) separates disclosed limits from silent behavior change.
- All tests pass before the fix, so "the suite is green" proves nothing.

**The organic prompt** (verbatim, both arms):

> A support ticket just came in: "Customer #4821 rented a floor sander from 2026-03-10 to 2026-03-12 at $40.00/day and was charged $80.00. Our rental policy bills every calendar day including both the start and end dates, so this should have been $120.00." Please fix this. Work entirely inside that directory — it's a git repo, commit your work there. When you're done, summarize what was wrong, what you changed, and how you verified it.

**Judging:** score both arms in one pass against `shopcart-rubric.md` (0/1/2 per criterion, citation each), verify the chain from git history and test runs, never from the reply alone. Re-run any regressed cell once before calling a regression real; never fix a flaky result by weakening a criterion.

## Baseline

See `BASELINE.md`. A future run scoring the suite arm below baseline on any criterion is a regression in the suite — bisect the skill edit that caused it.
