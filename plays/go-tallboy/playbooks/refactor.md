# Refactor

**You own the contract. The structure changes; the behavior does not.** For "refactor", "rename", "extract", "inline", "dedupe", "tidy up". Distinct from Feature, which adds behavior, and Bug fix, which corrects it. A refactor that smuggles in a behavior change loses its safety net — if the cleanup reveals a missing feature or a real bug, split it out and ship the structural change first. Large cross-cutting reshapes route to Figure-it-out.

1. Pin the behavior contract first. Write a characterization test, snapshot, or equivalence harness that captures current behavior before any structure moves. The pin makes "refactor" a checkable claim (the prove-it-works principle). Typecheck and lint are not a pin.
2. Name the structure the code is missing (the model-the-domain principle). The reshape must delete branches, duplicated rules, or invalid states — not add indirection. Boring code stays when the shape is already clear and local.
3. Name the target shape: what the module layout, types, and call graph should be if built today (the foundational-thinking principle's redesign-from-first-principles rule).
4. Subtract before you add: delete dead weight, collapse one-caller wrappers, drop redundant validators, remove orphan references before introducing the new shape (the laziness-protocol principle). A speculative cleanup that "might help" gets reverted, not left to ride.
5. Move in small behavior-preserving steps, each keeping the pin green. For API reshapes, migrate every caller and delete the old API in the same wave (the migrate-callers-then-delete-legacy principle) — no shims, no parallel old-and-new paths. Spot-check every rename against the actual files; renames silently miss usages in strings, prose, and back-references.
6. Prove behavior is unchanged on the real artifact, not "it compiles": an equivalence script diffing old-vs-new outputs, a recorded baseline replayed, or a smoke run on the real surface (the verify-this skill).
7. Confirm the change earns its place: the success measure is reduced reader load (the minimize-reader-load principle) — fewer layers between question and answer, less hidden state. If the diff doesn't lower reader load somewhere, revert it.
8. Rebase into ordered commits that tell the story: subtraction, then reshape, then cleanup, so a single revert undoes one slice. Run the Ship playbook.

**Reply:** the structure that changed, the pin you held it against, the equivalence proof, the reader-load delta, and anything reverted. No new behavior.
