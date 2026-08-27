---
name: principle-migrate-callers-then-delete-legacy
description: "Apply when introducing a new internal API while old callers exist, or planning a rewrite or migration. Migrate callers and delete the old path in the same wave; converge on the target state instead of preserving compatibility layers."
---

# Migrate Callers, Then Delete Legacy

When a new API or architecture is the right design, migrate callers and remove the old path in the same refactor wave instead of preserving compatibility layers.

**Rule:**
- Do not keep legacy paths alive only because internal callers still exist
- Inventory callers, migrate them, and delete the old API immediately
- Treat temporary adapters as exceptional and time-boxed, not default architecture
- Update tests to assert the new contract, and delete tests that only protect pre-refactor implementation details

**Outcome-oriented execution.** For planned rewrites and migrations with explicit phase boundaries, optimize for the intended, verifiable end state rather than preserving smooth intermediate states. Keeping every intermediate step fully stable often creates temporary compatibility code that becomes long-lived debt. Intermediate breakage is acceptable when it is planned, scoped, and reversible — declare where, keep high-signal checks on actively touched areas, and require full static and runtime verification at plan completion.

**When this applies:**
- No external users depend on backward compatibility
- The project can absorb coordinated breaking changes
- The new API is part of a simplification or refactor initiative

Keeping both old and new paths creates dual-path complexity, slows cleanup, and makes the codebase feel append-only.
