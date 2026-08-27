# Ship

**Invoked at the end of every other playbook.** Turns finished work into a reviewable delivery.

**Branch.** Work from a branch off freshly-fetched main (a worktree when parallel work shares the checkout); never commit to main directly. Fetch first — main moves mid-session.

**Commits.** Commit liberally while working; rebase into small, ordered commits before opening the PR. Each commit lands on its own and the sequence tells the story (the sequence-verifiable-units principle): failing test before fix, subtraction before reshape, scaffold before feature.

**Titles.** Conventional Commits, `type(scope): subject` — `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `perf`; the changed area as scope; short imperative subject naming a real symbol when one carries the change. No trailing period.

**Prose.** Write the PR title, description, and commit bodies clean per the unslop skill. Strip narrating comments from the diff — a comment survives only for a non-obvious *why* the code can't show (this includes test and verify scripts: the assertion message is the only doc a phase needs).

**Description.** These sections in order, dropping any that would be empty:

- `## Why` — the intent, and why this approach fits.
- `## Scope` — facts from the diff. Real paths, real symbols, both sides of a rename. What's in and out when the boundary matters.
- `## Tradeoffs` — real choices only. Drop the heading when there are none.
- `## Blast Radius` — what this touches and who feels it. Schema, auth, and money paths always have one. Say why it's safe — and get the one fact it's safe *because of* down the verify-this evidence ladder, or say it's unproven.
- `## Verification` — each gate you ran and what it printed. Outcomes, not command names. Skipped steps stay visible with their `skip: <reason>`.

Link `Closes #N` when an issue exists. Attach screenshots or recordings when they prove a claim. No `## Summary` or `## Test plan` boilerplate; a commit body doesn't restate its subject.

**Size.** Prefer several narrow PRs to one large one. Stack follow-ups; keep the order visible.

**Stop after the PR.** Open it ready (not draft), post the URL with a short summary — what changed, how it was verified, what the risks are — and stop. Don't merge, don't enable auto-merge; the human is the merge gate unless they've explicitly handed you the landing.
