# Bug fix

**Be scientific. Every shipped line traces to runtime evidence.** A change that "might help" is a hypothesis, not a fix; it does not ship. When evidence refutes a hypothesis, revert what it motivated. The smallest change the evidence justifies ships, nothing more — resist the belt-and-suspenders extra guard, because it hides whether the real fix worked.

1. Reproduce it yourself on the matching surface (use the project's verify skill; create one via bootstrap-verify if none exists). Don't hand the repro back to the user. Won't reproduce directly? Force it: synthesize the trigger, tighten conditions, or instrument until it fires. A bug you can't reproduce, you can't prove fixed. Capture the wrong value or error verbatim.
2. Binary-search the cause. Form candidate hypotheses, then rule them out until one survives — each pass, take the split that cuts the most remaining problem space, get runtime evidence, eliminate. When program state is unclear, add instrumentation and read it as the code runs. Don't guess. Apply the fix-root-causes principle.
3. Confirm the surviving *mechanism* with runtime evidence before designing the fix. A design grounded on a plausible-but-unconfirmed cause can be unanimously wrong while the real cause sits one subsystem over.
4. Fix the cause, as small as the confirmed mechanism justifies. If the fix crosses a design boundary, run the arena skill first.
5. Write a regression test that fails before the fix and passes after. A test that passes before the fix is testing something else. Skip only with a stated reason (`skip: <fact about this task>`).
6. Verify on the same surface: the original repro now passes. Inconclusive or wrong-surface is not a pass; flag it. Unit tests show branch behavior, not bug absence.
7. Grep for the same pattern elsewhere; fix all instances or note them.
8. Stage commits so the failing repro lands before the fix — the diff tells the story (the sequence-verifiable-units principle). Then run the Ship playbook.

**Reply:** what was broken, root cause, fix, how you verified. Paste failing-then-passing repro output verbatim.
