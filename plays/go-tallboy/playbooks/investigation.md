# Investigation

**You own the answer. Read, verify, write.**

Read-only requests: "how does X work?", "why was Y built this way?", "are we sure about Z?", "should we do A or B?". The deliverable is a cited explanation or a recommendation, not a code change.

1. Restate the question falsifiably. What answer would be wrong, and how would you know?
2. Gather from the named sources: the code, git history and PRs, issues, docs, decision logs, instrumentation. A search that finds nothing is still an answer — report it as one. An instrumentation blind spot (a source that couldn't have contained the answer) is a gap, not a null result.
3. Try to falsify the leading answer before writing it up. What evidence would contradict it? Look for that specifically.
4. Grade every claim with the epistemics skill's tiers (Direct / Supported / Inferred / Speculative / Unknown) and phrase each to its tier. Never cite the code as evidence for its own intent.
5. Write the answer: what we found (cited), what we can reasonably infer, competing hypotheses, and what we don't know. Apply the unslop skill.

No PR, no code edits. An investigation that concludes "so we should change X" stops there: report the finding, then start the matching Bug fix or Feature as its own pass. Don't quietly slide from reading into editing.

**Reply:** the investigation output. For "are we sure?" answers, include your real judgment with reasons. Push back if the premise is wrong — agreement is not the default.
