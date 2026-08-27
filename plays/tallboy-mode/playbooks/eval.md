# Eval

**You own the experiment design. Plan, blind, run, synthesize.**

Evals test how a change affects agent behavior before promoting it: a new skill variant, a structural change, a prompt tweak. The failure mode is the observer effect — an agent that knows it's being evaluated behaves differently, so candidates must run blind.

**Non-negotiables for blinding:**

- No `eval`, `test`, `judge`, `rubric`, `score`, `benchmark`, `candidate`, or `arena` in any directory, file, or prompt the candidate sees.
- The candidate prompt looks like an organic user request. State the goal, not the meta: "build me a small todo CLI", not "show me how you follow the principles".
- No chain-eliciting cues. Don't ask candidates which skills or principles they applied — that meta-prompt inflates citation behavior. Grade chain-following from the files they actually read and the shape of the code, never from self-report.
- Sanitize directory and slug names: project-shaped names a user might pick, not `candidate-1`.
- Don't tell the candidate other candidates exist.
- The judge can know it's judging but sees outputs by sanitized label only, never by model or variant name.
- Comparing two variants: one judge scores both sets in a single pass on one scale, blind to which set each came from. Two judge runs with different prompts don't compare — the calibration drifts.

**Steps:**

1. **Frame.** State the variant under test and what behavior counts as success. Write the rubric (3–6 concrete criteria) for the judge only.
2. **Set up sanitized environments.** Per-candidate working dir with the variant in place, plus the context an organic task would have.
3. **Author one organic prompt.** What a user would type. No leakage of what's being measured.
4. **Spawn N parallel candidates**, each in its own sanitized dir, same prompt.
5. **Spawn one blinded judge**, preferring a different model family, with the rubric and the outputs by label.
6. **Verify the chain from transcripts and artifacts, not self-report.** Which files did each candidate actually read? Citing a principle is not reading it, and reading it is not applying it.
7. **Read every candidate output yourself** end to end and compare with the judge. Disagreement means a bias or an ambiguous rubric. Synthesize.

Statistical honesty: N=1 per cell means a one-off failure is a re-run signal, not truth — re-run a regressed cell once before calling the regression real. And never fix a flaky eval by weakening the assertion: either the fixture is wrong or the behavior genuinely regressed.

**Reply:** variant under test, rubric, per-candidate notes, judge's verdict, your synthesis, and a promote/don't-promote recommendation.
