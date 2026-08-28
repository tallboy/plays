# Backlog

**The issue loop, end to end.** For "pick up an issue", "work the backlog", or a specific issue number. This playbook owns the pickup and delivery; it routes the implementation itself to an inner playbook.

1. Find work: the named issue, or list open issues labeled `ready`, priority high → med → low, oldest first. `ready` means a human authorized it. Never set gate labels yourself (`ready`, `blocked`, `needs-human`) — triage owns them.
2. Claim before touching anything: run the claim command named in project-conventions (default: `gh issue edit <n> --remove-label ready`). On abandon, unclaim (restore `ready`) — and never leave a pushed branch without a PR: a half-done pushed branch reads as finished work to pipeline resume paths.
3. Read the issue body and every path under Relevant Files before implementing. Front-loaded context is the single biggest driver of a PR that merges on first review.
4. The Acceptance Criteria and Out of Scope sections are binding — quote them into the todo list. Anything found outside them gets recorded per project conventions (tracker line, new issue), not built.
5. Too vague to implement? Comment on the issue saying exactly what's missing, unclaim, and stop. Refusing to start beats guessing.
6. Route the implementation to the matching playbook (Bug fix, Feature, Refactor, or a project playbook like Migration) — its steps join the todo list under the same verbatim + `skip: <reason>` rules.
7. Ship per the Ship playbook and project conventions. The PR body's first line is `Closes #<n>`.
8. Housekeeping: update the project's tracker per its conventions (`— GH #<n> — PR #<m>` on the captured line).

**Reply:** the issue worked, the inner playbook it routed to, and everything that playbook's reply requires.
