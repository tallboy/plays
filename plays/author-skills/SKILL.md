---
name: author-skills
description: "Use when writing a new skill, playbook, or principle, or editing an existing one — before drafting the text, and before promoting any change."
---

# Author Skills

A skill is a claim that specific words change agent behavior. Author it like an experiment: observe the failure first, write against the transcript, prove the change blind before promoting it.

**Baseline first.** Before writing, capture the failure without the skill: run the scenario on a fresh agent and transcribe what it actually does — including its rationalizations, verbatim. Write against those transcripts, not against the failure you imagine; the rationalizations are the spec. Editing carries the same contract: reproduce the failure the edit targets before touching the text. Check the repo's own `.claude/skills/OBSERVED-FAILURES.md` first if it exists (the log is per-repo even when the suite is installed globally) — a repo that's been running the suite a while may already have a logged correction there, with its failure mode and rule already named, covering what you'd otherwise have to reproduce from scratch.

**Mine the transcript, when there's no single failure to reproduce.** A long or complex session can hold learnings baseline-first can't target, because nothing failed cleanly enough to name. Spawn three independent reviewers over the session transcript, one lens each — judgment (what recurred, what generalizes), tooling (what could be scripted or gated instead of remembered), divergent (what an outside read would flag that the session's own momentum missed) — then synthesize their findings into Accepted / Rejected / Backlog. Reject anything the existing suite already covers; don't manufacture a gap to fill. Only Accepted items move to drafting a skill edit, and drafting is where this stops: present the Accepted list and wait, don't autonomously spin up your own eval fixtures or sub-agents to chase a finding further — promotion is a separate, deliberate decision for whoever reviews the list, per the eval rule below. This complements baseline-first, not replaces it: reproduce a named failure when you have one, mine the transcript when you don't.

**Match the form to the failure.** The form that fixes one failure type backfires on another:

| Baseline failure | Right form |
|---|---|
| Knows the rule, breaks it under pressure | Prohibition, plus each observed rationalization with its rebuttal |
| Complies, but the output is the wrong shape | Positive recipe: state what the output IS — its parts, in order. Prohibitions here measurably produce *more* of the unwanted content |
| Omits an element it already tries to produce | A required slot in the template it fills |
| Behavior should depend on a condition | A conditional keyed to an observable predicate |

No nuance clauses: "don't X unless it matters" reopens the negotiation — express a real exception as its own conditional. Exemption clauses don't scope ("the limit doesn't apply to code blocks" still suppresses code blocks); restructure so the rule can't reach the exempt part.

**The description is a trigger, not a summary.** Frontmatter states when to load the skill, never how the workflow goes. A description that summarizes the workflow becomes a shortcut: the agent follows the one-line summary and skips the body — observed as an agent doing one review where the body required two, because the description said "with code review".

**Short is load-bearing.** Every word is context spent on every load. Reference sibling skills by name instead of restating them; cut examples to the minimum that disambiguates; push what recurs into structure (the encode-lessons-in-structure principle). The suite's word ratchet enforces this.

**Promote via eval.** A skill that reads well and a skill that works are different claims. Run the Eval playbook — blinded candidates, one judge, compared against the current version — and grade from transcripts and artifacts, never self-report.
