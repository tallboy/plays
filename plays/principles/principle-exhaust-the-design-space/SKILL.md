---
name: principle-exhaust-the-design-space
description: "Build 2-3 competing prototypes before committing. The best design isn't obvious until you see alternatives."
metadata:
  phase: principle
  pstack_ref: "exhaust-the-design-space"
  version: "1.0.0"
---

# Exhaust the Design Space

**The play:** Don't commit to one design. Build 2-3 competing approaches. Compare. Pick the best. Move.

## When to Apply This

- ✅ Architecture decisions (monolith vs. microservices vs. hybrid)
- ✅ Data model design (normalized vs. denormalized, relational vs. document)
- ✅ API contract design (REST vs. GraphQL vs. gRPC)
- ✅ Before writing production code on any complex system

## The Rule

**Commit after seeing at least 2 structurally different alternatives. One design is not a choice.**

Not:
- ✗ "I have one design, let me code it up"
- ✗ "I'm pretty sure this is the best approach"
- ✗ "Let's refactor later if needed"

Instead:
- ✓ Sketch 2-3 alternatives (quick, not full implementations)
- ✓ Compare on key dimensions (flexibility, performance, complexity)
- ✓ Pick one with full confidence
- ✓ Commit to it

## How

### 1. Identify Constraints
What matters for this design?
- Performance? Correctness? Flexibility? Simplicity?
- What's the cost of being wrong?

### 2. Sketch 2-3 Alternatives
Don't code. Sketch:
- Approach A: Monolithic, simple
- Approach B: Distributed, flexible
- Approach C: Hybrid, pragmatic

### 3. Compare
On each key dimension:
- Approach A: Simple to build, hard to scale
- Approach B: Complex to build, easy to scale
- Approach C: Moderate both

### 4. Pick
Which tradeoff do you want to live with?

## Examples

**Bad:** "I'll just use a relational database. That's the obvious choice."
(Reader: Did you consider document DB? Graph DB? When would that be better?)

**Good:** "I sketched 3 data models: normalized relational, denormalized document, graph. 
For this use case (user-centric queries, denormalized data), document DB wins. Committed."

## The Principle in One Sentence

**One design is a guess. Two designs let you decide.**
