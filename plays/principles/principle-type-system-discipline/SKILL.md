---
name: principle-type-system-discipline
description: "Make illegal states unrepresentable. Use types, not checks. Catch errors at compile-time, not runtime."
metadata:
  phase: principle
  pstack_ref: "type-system-discipline"
  version: "1.0.0"
---

# Type System Discipline

**The play:** If a state is impossible, make it impossible to represent. Not with checks—with types.

## When to Apply This

- ✅ API design (shape forces correct usage)
- ✅ Domain modeling (types encode rules)
- ✅ Library design (type safety = good API)
- ✅ Any boundary where mistakes are expensive

## The Rule

**Illegal states should be unrepresentable. Use types to enforce it.**

Not:
- ✗ `authenticate()` returns user or nil, caller must check
- ✗ Multiple booleans that could contradict
- ✗ Optional fields that are sometimes required

Instead:
- ✓ Types that enforce valid states
- ✓ Discriminated unions for state machines
- ✓ Required fields, not optional

## How

### 1. Identify Illegal States
What combinations should never happen?
- User authenticated AND user nil? Illegal.
- Order paid AND order pending? Illegal.

### 2. Use Types to Block Them
```
# Bad: Nil-check required
def get_user(id): User | nil

# Good: Type guarantees
def get_authenticated_user(token): AuthenticatedUser
# Only one type, no nil branch
```

### 3. Use Discriminated Unions
```
# Bad: Multiple booleans
class Order:
    paid: bool
    shipped: bool
    delivered: bool

# Good: One enum, illegal combos impossible
class Order:
    status: Pending | Paid | Shipped | Delivered
```

## Examples

**Bad:** API returns object with optional fields, caller must guess which are set.
**Good:** API returns one of several concrete types; no guessing.

## The Principle in One Sentence

**Type systems prevent mistakes at compile-time. Use them.**
