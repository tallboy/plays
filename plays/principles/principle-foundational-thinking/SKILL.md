---
name: principle-foundational-thinking
description: "Get the foundation right before building up. Larry Bird's textbook footwork. Architecture before code. Data model before logic. Frame before paint."
metadata:
  phase: principle
  pstack_ref: "foundational-thinking"
  player_analogy: "Larry Bird's fundamentals"
  version: "1.0.0"
---

# Foundational Thinking

**The Bird Principle:** Larry Bird's shot was unguardable not because it was fancy—because the foundation was perfect. Footwork. Balance. Release. The basics, executed flawlessly.

In code: **Get the data structure and architecture right before writing logic.**

## When to Apply This

- ✅ Before you write the first line of code
- ✅ When a feature feels "sticky" (design is wrong)
- ✅ When you're about to add the 5th parameter to a function
- ✅ When tests are hard to write
- ✅ When someone asks "why is this so complicated?"

## The Rule

**Encoding domain logic in structure is 10x more powerful than hiding it in conditionals.**

Not:
- ✗ "I'll add some flags and handle all the cases"
- ✗ "I'll figure out the model as I go"
- ✗ "Let me just start coding and refactor later"

Instead:
- ✓ Name the domain objects (User, Payment, Order)
- ✓ Model the state (what states can each object be in?)
- ✓ Choose your data shapes (immutable records, not bags of fields)
- ✓ Encode constraints in the type system
- ✓ Then the code writes itself

## How

### 1. Name the Core Entities
What are the main nouns in your problem?
- User, Product, Order (ecommerce)
- Run, Finding, Verdict (QA system)
- Request, Response, State (API)

### 2. Model the State
For each entity, what are the valid states?
- Order: pending, paid, shipped, delivered, returned
- User: new, active, suspended, deleted
- Finding: open, in-progress, resolved, verified

Write these down. Type them. Enforce them.

### 3. Model the Relationships
How do entities connect?
- One-to-many? One-to-one? Many-to-many?
- Can X exist without Y? Must Z be present?
- What happens if X changes? (cascade? restrict?)

### 4. Make Illegal States Impossible
If you have 5 separate boolean fields, you've lost. Consolidate:
```
# Bad
is_paid: bool
is_shipped: bool
is_delivered: bool

# Good
status: Enum[Pending, Paid, Shipped, Delivered]
```

### 5. Then Write Code
Now the code is obvious. No flags. No special cases. Just logic flowing through the model.

## Examples

**Bad:** Start coding an auth system. Add login logic. Realize halfway through you need to handle roles. Bolt on more code.  
**Good:** Before coding, design: User → has Roles → have Permissions. Then code the system.

**Bad:** Add a field, then an if-check, then another field, then more if-checks.  
**Good:** Model the domain first. One state enum. All code flows from it.

**Bad:** "Why is this feature so hard to test?"  
**Good:** (Read your model first. Usually the issue is design, not code.)

## The Principle in One Sentence

**Spend 20% of time on design, 10% on coding. Not the other way around.**
