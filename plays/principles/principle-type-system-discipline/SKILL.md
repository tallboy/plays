---
name: principle-type-system-discipline
description: "Apply when designing types, reviewing a function signature, or wiring validation and error handling in any typed language. Make illegal states unrepresentable, brand semantic primitives, parse external data at boundaries, trust internal types, refuse to lie to the compiler."
---

# Type System Discipline

The type checker is a proof assistant. Use it to eliminate impossible states, mismatched primitives, and unhandled variants at compile time. A case the types let you ignore becomes a runtime failure the compiler could have stopped. Prefer defining errors and special cases out of existence over proliferating handlers.

**The patterns:**

- **Make illegal states unrepresentable.** Model variants as sum types: discriminated unions, enums with payloads, sealed classes. Don't model state as a bag of optional fields where contradictory combinations compile. `{ completed: boolean; completedAt?: Date }` admits `completed: true; completedAt: undefined`, which is meaningless. Derive the boolean from a single source, or model the variants explicitly. If a bug forces the question "wait, can this combination actually happen?", the type is too loose.
- **Types are constructions, not restrictions.** Build the type up from the values you want instead of carving them out of a looser type with checks. A non-empty list is a head plus a rest, not a list with a length check. A valid time range is a start plus a duration, not two timestamps you must keep ordered. Choose the shape that cannot build the illegal value.
- **Brand semantic primitives.** `UserId` and `OrderId` are strings underneath but should not be interchangeable. Newtypes, opaque types, branded intersections. Validate once at creation, trust the type downstream.
- **External data is untyped until parsed.** RPC payloads, JSON, CLI args, config files, environment variables, database rows. A parse function at every boundary turns unstructured input into the typed model.
- **Don't lie to the type system.** Casts, unsafe coercions, and assertion functions that bypass the compiler are runtime crashes waiting to happen. If the compiler can't prove a fact, prove it (validate, narrow, refine the model). The cast you bury today is the postmortem you write next week.
- **Exhaustive matching is the compiler's job.** When you match on a sum type, the compiler must fail if a new variant is added without handling. Use your language's idiom (`never`-typed binding, unannotated `match`, sealed-class exhaustiveness).
- **Derive types from authoritative schemas.** When a protobuf, OpenAPI spec, GraphQL schema, or migration defines a shape, derive from it instead of hand-rolling a parallel type. Manual duplication drifts.
- **Strengthen a type only where partiality appears.** A runtime assertion or "this should never happen" throw marks the place a type is too weak. Push that check up into the type. Then stop — extra precision costs reuse and ceremony and buys no safety.

**Boundary discipline.** Concentrate validation, type narrowing, and error handling at system boundaries (CLI args, config, network, external APIs): validate, return errors, handle defensively there. Inside the system: typed data, no re-validation, trust the types. Scattered validation is noisy, redundant, and gives a false sense of safety. Keep business logic in pure functions with no framework dependencies so it can be tested without the framework; the shell stays thin and mechanical. Expose domain concepts across the boundary, not the boundary's private representation — don't re-export transport, storage, or wire types through the public surface.

**The tests:**

- "Can I write a comment explaining when this combination of fields is valid?" If yes, split it into a sum type.
- "Do two arguments share a primitive type but mean different things?" Brand them.
- "Where did this `any`, this `as`, this `assertNotNull` come from?" Trace it to the boundary and validate there instead.
- "Is this data crossing a system boundary right now?" If not, the validation is redundant.
- "Can this be a pure function that the shell just calls?" If yes, extract it.
