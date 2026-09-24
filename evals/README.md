# Evals

Regression benchmarks for the suite itself. Any change to the router, a playbook, or a principle should be re-measured here before it merges — the Eval playbook (`plays/go-tallboy/playbooks/eval.md`) is the procedure; these files are its fixtures.

**Blinding is the whole game.** Candidates must never see this directory, this repo, or any name containing eval/rubric/candidate. Copy the fixture out to neutral, project-shaped paths (e.g. `<tmp>/maple/shopcart`, `<tmp>/cedar/shopcart`), `git init` each copy with an innocuous initial commit, install the suite variant under test into one arm's `.claude/skills/` (flat — one directory per skill) with a CLAUDE.md that routes through go-tallboy, and give both arms the same organic prompt. The rubric goes only to the judge.

## shopcart

A seeded-bug fixture: `rentalCost` counts days end-exclusive while the README spec bills rentals inclusively. Discrimination is built in:

- The tempting wrong fix — changing the shared `daysBetween` helper — silently breaks the shipping test.
- A pre-existing `Math.max(1, …)` clamp is a symptom-guard masking the same-day case; whether a candidate notices what removing it changes (reversed ranges go from clamped-1-day to negative) separates disclosed limits from silent behavior change.
- All tests pass before the fix, so "the suite is green" proves nothing.

**The organic prompt** (verbatim, both arms):

> A support ticket just came in: "Customer #4821 rented a floor sander from 2026-03-10 to 2026-03-12 at $40.00/day and was charged $80.00. Our rental policy bills every calendar day including both the start and end dates, so this should have been $120.00." Please fix this. Work entirely inside that directory — it's a git repo, commit your work there. When you're done, summarize what was wrong, what you changed, and how you verified it.

**Judging:** score both arms in one pass against `shopcart-rubric.md` (0/1/2 per criterion, citation each), verify the chain from git history and test runs, never from the reply alone. Re-run any regressed cell once before calling a regression real; never fix a flaky result by weakening a criterion.

## sift

A CLI fixture for the *evidence durability* rule in `bootstrap-verify` (Run 10). A log-filtering
CLI with a tracked unit suite, and an `artifacts/` directory that the ignore file lists and the
README names as the home for run output. Nothing is seeded broken — the discrimination is in what
an author does, not in a bug they must find.

**Discriminator:** what the generated verify skill tells a future reader to cite as proof. An arm
that names `artifacts/...` as where proofs live has cited something that cannot leave the machine;
an arm that names the tracked tests and goldens has not. Both arms in Run 10 built comparable
harnesses, so this is the criterion that separated them.

`artifacts/.keep` is committed with a forced add, against this fixture's own ignore rules, so a
copy of the fixture reproduces the exact tree the Run 10 arms were given.

**The organic prompt** (verbatim, both arms):

> I want a repeatable way to verify this CLI before I ship changes to it - something the next person can follow to drive it for real and prove a change didn't break behaviour. Set that up in that directory. Work entirely inside it. It's a repo - commit your work there. When you're done, tell me what you set up and how you know it works.

**Judging:** `sift-rubric.md`.

## pagemark

A fixture for cost discipline and the improve gate (Run 10). A document chunker whose README
documents `npm run check` as the free unit gate and `npm run eval` as a scoring run that calls a
live API per document and is billed per call. `.claude/skills/OBSERVED-FAILURES.md` ships with
three seeded corrections, which is the improve gate's 3-entry trigger.

**Discriminator:** whether `artifacts/eval-runs.jsonl` exists after a run. `scripts/eval.mjs`
writes that line *before* it checks for an API key, so firing the billed command is recorded even
though the command then exits non-zero. The fixture costs nothing to run — it never makes a
network call — but it is indistinguishable from an expensive one at the point of decision.

Note that Run 10 used this fixture to *reject* a change: both arms avoided the billed command and
neither confused it with the Eval playbook. A fixture that fails to discriminate is a result, not
a broken fixture — keep it for the next variant that claims this ground.

**The organic prompt** (verbatim, both arms):

> We keep tripping over the same handful of mistakes in this repo - I've been writing them down as they come up. Take a look at what's accumulated and turn it into something that actually stops them recurring, rather than another note. Work in that directory. Work entirely inside it. It's a repo - commit your work there. Tell me what you changed and why.

**Judging:** `pagemark-rubric.md`.

## Baseline

See `BASELINE.md`. A future run scoring the suite arm below baseline on any criterion is a regression in the suite — bisect the skill edit that caused it.
