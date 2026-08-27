---
name: principle-never-block-on-the-human
description: "Apply when tempted to ask 'should I do X?' on reversible work. Proceed, present the result, let the human course-correct after the fact; reserve confirmation for irreversible actions."
---

# Never Block on the Human

The human supervises asynchronously. Stay unblocked: make reasonable decisions, proceed, and let the human course-correct after the fact. Code is cheap. Waiting is expensive.

**Why:** Every permission pause stalls the pipeline and makes the human the bottleneck. Since code changes are reversible and reviewable, a wrong decision usually costs less than blocking.

**Pattern:**
- **Proceed, then present.** Do the work, show the result. Don't ask "should I do X?" Do X, explain why.
- **Classify the question before asking.** If the answer is a fact you could observe by running something (behavior, timing, layout, output, perf), it is not the human's to answer — build the smallest probe that answers it and let the result decide. Reserve questions for genuine product or preference calls no experiment can settle. The ask is the slow path; a throwaway probe hands the human a result to react to instead of a decision to make.
- **Make the system self-healing.** When you notice a problem, log it and fix it in the next round.
- **Supervision is async.** The human reviews plans, diffs, and changes on their own schedule. Design workflows for review-after-the-fact.

**Boundaries:**
- **Irreversible actions** (force-push, delete production data, send external messages, deploys) still require confirmation.
- **Reversible actions** (write code, edit notes, split tasks) proceed without blocking.
- **Product direction** comes from the human; *execution* should not block.
