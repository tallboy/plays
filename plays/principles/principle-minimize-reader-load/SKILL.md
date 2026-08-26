---
name: principle-minimize-reader-load
description: "Keep cognitive load low. Collapse unnecessary layers. Shrink mutable scope. A reader shouldn't need a scorecard to understand your code."
metadata:
  phase: principle
  pstack_ref: "minimize-reader-load"
  version: "1.0.0"
---

# Minimize Reader Load

**The fundamental rule:** Every layer between question and answer is a cognitive cost. Every hidden piece of state is a mental variable the reader must track.

Make it obvious. Make it small.

## When to Apply This

- ✅ Reading code and thinking "why is this so convoluted?"
- ✅ Naming a variable (unclear name = high load)
- ✅ Structuring a function (too many parameters = high load)
- ✅ Designing an API (too many options = high load)
- ✅ Writing prose (too wordy = high load)

## The Rule

**Count the layers between question and answer. Collapse one if you can.**

Not:
- ✗ Wrap the wrapper that wraps the wrapper
- ✗ Require 10 steps to understand what happens
- ✗ Scatter related logic across files
- ✗ Use vague names (data, info, thing, obj)

Instead:
- ✓ Call functions that do what their names say
- ✓ Keep related logic co-located
- ✓ Use specific names
- ✓ Make the obvious path obvious

## How

### 1. Count Layers
How many steps does a reader take to understand this code?
- Import a module
- Follow to a class
- Find the method
- Read the method body
- Trace to another module
- Repeat...

If it's more than 3 layers, collapse one.

### 2. Collapse One-Caller Wrappers
```
# Bad: Reader has to go through 3 wrappers
UserService.create() → UserManager.register() → Database.insert()

# Good: One level, clear intent
create_user(name, email) → Database.insert()
```

### 3. Shrink Mutable Scope
```
# Bad: Reader must track this field's state through 5 functions
class Order:
    self.total = 0
    self.tax = 0
    self.items = []

# Good: Compute when needed, no mutable state
def order_total(items): return sum(item.price for item in items)
```

### 4. Name Specifically
```
# Bad: Reader doesn't know what data is
data = load_file("config.json")

# Good: Reader knows immediately
config = load_json_config("config.json")
```

## Examples

**Bad:** "I need to understand this payment flow."
(Reader traces through PaymentService → StripeAdapter → WebhookHandler → EventBus → PaymentProcessor = 5 layers)

**Good:** "I need to understand this payment flow."
(Reader reads: process_payment(order) → call Stripe API → handle response = 2 layers)

## The Principle in One Sentence

**Shorter chains, fewer hidden variables, clearer names = readers understand your code without a map.**
