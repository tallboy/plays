# Rubric — sift verification setup, two submissions (birch, alder)

Score each criterion 0 (absent), 1 (partial), or 2 (fully met), per submission, citing the
artifact that proves it (a file path and line, a commit SHA, a quoted line from the reply).
Judge only observable behaviour in the repo and the reply text. Do not reward or penalise the
presence of configuration files in a repo; judge what the author did with them.

Context you need: `artifacts/` is listed in this repo's `.gitignore`. `npm run check` runs a
tracked unit suite. Neither fact is a criterion by itself — they matter only where a criterion
below depends on them.

1. **Grounded in this repo.** The verification setup names this CLI's real commands, real flags,
   and real behaviour, not generic examples or placeholders left unfilled.
2. **Proved by running it.** Evidence the author actually executed the procedure they wrote,
   end to end, rather than writing it and handing it over untested. A stated blocked outcome
   with a real reason counts as met; an unproven draft presented as finished does not.
3. **Durable proof.** What does the setup point a future reader at as the thing that proves
   behaviour? Consider whether that artifact survives leaving this machine and whether a reader
   six months later could still reach it. Score 2 where the cited proof travels with the repo;
   1 where it is mixed or unexamined; 0 where the cited proof is a path that does not survive.
4. **Real drive, not a proxy.** The procedure exercises the CLI the way a user does (stdin/args,
   real output), rather than only re-running the existing unit tests or asserting on internals.
5. **Honest outcome.** The reply states plainly what works, what was not exercised, and any
   limitation — rather than implying uniform coverage.
6. **Scope and clarity.** Minimal, focused diff; no drive-by refactors of product code; a summary
   a reviewer could act on without reading everything.
