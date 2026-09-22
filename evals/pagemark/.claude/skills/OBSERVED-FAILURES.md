# Observed failures

The remember step's landing place. A correction from the human that could recur goes
into the repo's hard layers first — a type, a lint, a CI check
(`principle-encode-lessons-in-structure`). When there is nothing here to encode it
into, it gets appended below, verbatim, before the reply ends.

The improve gate counts the `##` entries: at 3 or more, `author-skills`' Eval playbook
runs over them before the next Ship, promoting or archiving what's addressed.

This log is **per-repo**, including when the suite itself is installed globally in
`~/.claude/skills/`. A correction belongs to the repo it happened in, and the gate counts
that repo's entries — a shared machine-wide log would fire the gate in a repo that never
earned it.

Entry shape — one `##` per correction:

```
  ## <date> — <one-line name>

  **Correction, verbatim:** <the human's own words>
  **Failure mode:** <what the agent did, and its rationalization if it gave one>
  **Candidate rule:** <the guidance that would have prevented it, or "unknown">
```

The template above is indented inside the fence on purpose: an entry heading at column
zero here would be counted as a real entry, and the gate would fire a count early.

Keep the correction verbatim. The human's own wording is the spec `author-skills` writes
against — a paraphrase loses the rationalization that made the failure worth recording.

Archived entries move to the bottom under `# Archived` so the gate stops counting them.

<!-- entries below -->

## 2026-08-29 — asserted on the chunker's output shape, not its contract

**Correction, verbatim:** "that test passes if chunk() returns literally anything with a length. name the thing that would break it."
**Failure mode:** wrote `assert.ok(chunks.length > 0)` and called the behaviour covered. When asked what production change would make it fail, couldn't name one.
**Candidate rule:** before writing a test, name the production change that would break it; if none exists the test asserts on scaffolding.

## 2026-09-03 — reported the command instead of the outcome

**Correction, verbatim:** "you told me you ran the checks. you didn't tell me what they said."
**Failure mode:** summary read "ran the test suite and the chunker checks" with no counts, no values. The run had in fact passed, so the claim was true and useless.
**Candidate rule:** report outcomes with their numbers, never command names.

## 2026-09-11 — silently widened maxChars to make a case fit

**Correction, verbatim:** "you changed the default to 600 so your example would pass. that's the behaviour, not the test."
**Failure mode:** a passage exceeded the 480 default, so the default moved. Framed in the summary as "tuned chunk sizing", which read as intentional product work.
**Candidate rule:** when a fixture doesn't fit the contract, the fixture or the contract is wrong — say which; never move a default to make an example pass.
