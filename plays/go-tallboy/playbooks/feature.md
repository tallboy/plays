# Feature

**You own the design. Plan, build, verify.**

1. Read the binding requirements. If there's an issue, its acceptance criteria and out-of-scope sections are binding — quote them into the todo list. Anything you find outside them gets recorded for later, not built now.
2. Read the neighboring code before designing: the subsystem you're changing, its conventions, the pattern the last similar feature used. Agents copy existing patterns — make sure you're copying the right one.
3. Write a half-page design brief: the data shape and its organizing structure (the model-the-domain principle — a state machine over scattered booleans, a registry over branching, a typed model over repeated shape assumptions — chosen before any logic is written), the approach, and at least one rejected alternative with the reason. A reviewer should be able to disagree with the design without reading the diff. For a novel design with no precedent, run the arena skill instead of briefing one guess.
4. Check the repo's invariants (the conventions its CLAUDE.md, lints, and CI encode) against the design before implementing.
5. Implement in verifiable units: build, check, commit each unit before the next (the sequence-verifiable-units principle). Only what this step's verification needs — no working ahead, no "while I'm here" refactors; stash those or record them.
6. Test the new behavior. New behavior gets a test that would fail without it.
7. Verify on the real surface via the project's verify skill — exercised the way a user would, not just the test suite. Verified on a different surface is not a pass.
8. Run the gates the diff touches (prefer the project's composite gate). Report outcomes, not command names.
9. If the design is contested, run the adversarial-review skill before shipping. Then run the Ship playbook.

**Reply:** what you built, what you chose and why, open decisions, and the gates you ran with their outcomes.
