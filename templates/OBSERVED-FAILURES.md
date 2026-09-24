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

When an entry gets encoded into the repo's hard layers, record where it landed:

```
  **Encoded as:** <the check, lint, type, or test that now fails when this recurs>
```

Then move it to the bottom under `# Archived`, so the gate stops counting it. An entry
earns that move only once something in the repo goes red when the mistake recurs — if only
part of it is mechanised, write `**Encoded as (partial):**`, say which half is still held
by prose, and leave the entry open where the gate can still see it. Archiving on a rule
nothing enforces is how a log starts overstating what the repo actually catches.

<!-- entries below -->
