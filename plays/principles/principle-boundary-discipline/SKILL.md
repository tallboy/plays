---
name: principle-boundary-discipline
description: "Validate at system edges. Trust internals. Don't leak validation logic throughout the code."
metadata:
  phase: principle
  pstack_ref: "boundary-discipline"
  version: "1.0.0"
---

# Boundary Discipline

**The play:** Draw a line. Outside the line: anything can happen. Validate. Inside the line: everything is trusted. No defensive checks.

## When to Apply This

- ✅ API endpoints (validate input, trust your code)
- ✅ Database boundaries (validate at insert, trust queries)
- ✅ Module boundaries (validate at entry, trust internals)
- ✅ Any system boundary (network, file, external API)

## The Rule

**Concentrate guards at boundaries. Trust internals.**

Not:
- ✗ Validate everywhere (nil checks, type checks scattered throughout)
- ✗ Assume external input is always correct
- ✗ Leak defensive code into business logic

Instead:
- ✓ Validate once at the edge
- ✓ Parse external data into typed/trusted structures
- ✓ Keep business logic pure and simple

## How

### 1. Identify Your Boundary
Where does untrusted data enter?
- HTTP endpoints
- File reads
- External API responses
- User input

### 2. Validate at Boundary
```
# At the edge
def create_user(raw_email: str):
    email = validate_email(raw_email)  # Validate here
    return User(email)

# Inside: assume email is valid
class User:
    def __init__(self, email: str):
        self.email = email  # No validation, trust it
```

### 3. Trust Internals
Once inside, don't re-validate:
```
# Bad: Validating again inside
def send_email(email):
    if not email:  # We validated at the boundary
        raise Error()
    send_smtp(email)

# Good: Trust it
def send_email(email):
    send_smtp(email)
```

## Examples

**Bad:** Nil checks and type checks scattered through the codebase.
**Good:** Parse external data into typed structures at the boundary. Internals assume it's valid.

## The Principle in One Sentence

**Validate once at the edge. Trust everything inside.**
