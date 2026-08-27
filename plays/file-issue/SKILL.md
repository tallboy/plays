---
name: file-issue
description: "Turn a reported bug or requested feature into an issue with falsifiable Acceptance Criteria and an explicit Out of Scope — the shape Backlog treats as binding. Use for 'file a bug', 'open an issue', 'write this up', or cleaning up any issue before it enters the backlog."
---

# File Issue

An issue without falsifiable Acceptance Criteria and an explicit Out of Scope isn't ready for the backlog — Backlog's claim step treats those sections as binding, and there's nothing to bind if this skill never wrote them. Write the issue in that shape from the start, not as a patch after triage bounces it.

## When to use

- "File a bug", "open an issue", "write this up", "turn this into a ticket".
- An existing issue is vague enough that Backlog would stop and ask the reporter what's missing — rewrite it now instead of letting it bounce later.
- An issue (or a batch someone dumped into the tracker) bundles more than one independently shippable ask — groom it before either half gets shaped.

## Workflow

1. **Split bundled asks first.** More than one independently shippable unit of work in the same report? File one issue per unit before doing anything else in this workflow — a one-line cross-link ("split from #<n>") is enough. Don't force one Acceptance Criteria list to cover unrelated work; a reviewer can't check a box that's really two boxes.
2. **Classify.** Bug (observed diverges from expected) or feature (new behavior, no defect). The two differ in one section — bugs get Repro, features get Scenario — everything else is shared.
4. **Reproduce what you can.** For a bug, try to reproduce it yourself before filing; capture the exact command, input, and error verbatim. Couldn't force it? Say so in the issue rather than writing steps you never ran — don't invent output.
5. **Locate, don't ask.** Grep the codebase yourself for the relevant files, existing tests, and related code. Only ask the reporter for facts only they hold — what they saw, when it started, why it matters (principle-never-block-on-the-human: don't defer an answer you can find yourself).
6. **Write falsifiable Acceptance Criteria.** Each line is a check a reviewer or test can pass or fail — not "works correctly", not "handles edge cases". A criterion that can't be phrased as a check isn't ready to be one; ask, or leave it out and name the gap.
7. **Write Out of Scope explicitly.** Name what looks related but isn't included — the adjacent behavior, the tempting refactor, the second bug in the same area. This is what lets Backlog record found-but-unbuilt work instead of building it.
8. **Too thin to shape?** Missing something only the reporter knows — repro conditions, desired behavior, priority — don't fabricate it to fill the section. Ask the specific question, or file with an explicit gap noted per project conventions, rather than ship invented criteria.
9. **Run it through unslop** before posting — an issue body is a prose surface a person will read.
10. **Post per the project's convention** (`gh issue create`, or edit in place for an existing issue). Never attach a gate label (`ready`, `blocked`) or preset an assignee yourself — claiming happens later, by whoever's convention governs it (label removal, a board Status move), and a pre-set assignee bypasses that mechanism and can silently double-claim.

## Shape

```markdown
## Problem
What's wrong, or what's needed, and why it matters. One paragraph.

## Repro (bugs) / Scenario (features)
Bugs: exact steps, input, environment, expected vs actual, verbatim output.
Features: the concrete case this unlocks.

## Acceptance Criteria
- [ ] Falsifiable check 1
- [ ] Falsifiable check 2

## Out of Scope
- Adjacent thing this issue does not cover, and why

## Relevant Files
- path/to/file.ts — what's there
```

Omit Relevant Files rather than guess — a wrong pointer costs the implementer more time than an absent one.

## Output

The filed or rewritten issue body, the classification, what you reproduced yourself versus what you had to ask for, and any gap you flagged instead of inventing.
