---
name: principle-model-the-domain
description: "Encode domain logic in structure, not scattered conditionals. Let the model guide the code."
metadata:
  phase: principle
  pstack_ref: "model-the-domain"
  version: "1.0.0"
---

# Model the Domain

**The play:** What does your domain actually look like? Not your code—the domain. Encode that shape in types. Then code writes itself.

## When to Apply This

- ✅ Starting a new domain
- ✅ When business logic is scattered
- ✅ When conditionals keep multiplying
- ✅ When you're unsure about the design

## The Rule

**The structure should encode domain rules, not conditionals.**

Not:
- ✗ `if user.is_admin then... else if user.is_moderator then...`
- ✗ `if order.status == "paid" and order.shipped == false then...`
- ✗ Scattered if-statements representing domain knowledge

Instead:
- ✓ `UserRole: Admin | Moderator | User` (type encodes roles)
- ✓ `OrderStatus: Pending | Paid | Shipped | Delivered` (type encodes states)
- ✓ Code flows through the model

## How

### 1. Name Domain Entities
What are the core concepts?
- User, Payment, Order (ecommerce)
- Finding, Verdict, Run (QA system)

### 2. Model Their States
What states can each entity be in?
```
Order: Pending → Paid → Shipped → Delivered → (returned?)
User: NewSignup → Active → Suspended → Deleted
```

### 3. Encode in Types
```
class Order:
    status: Enum[Pending, Paid, Shipped, Delivered]
    # No: paid_on, shipped_on, delivered_on booleans scattered
    # Yes: status captures it all
```

### 4. Code Flows from Model
```
match order.status:
    Pending: charge_card()
    Paid: ship_order()
    Shipped: wait()
    Delivered: send_thank_you()
```

## Examples

**Bad:** Multiple booleans (is_paid, is_shipped, is_pending)
**Good:** Single status enum

## The Principle in One Sentence

**Structure should encode rules. Conditionals should be minimal.**
