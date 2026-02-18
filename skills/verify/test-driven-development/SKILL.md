---
name: test-driven-development
description: "Write tests before implementation using the Red-Green-Refactor cycle. Ensures code is testable, requirements are clear, and regressions are caught immediately."
metadata:
  phase: verify
  complexity: intermediate
  duration: "Continuous (per-feature)"
  prerequisites: "incremental-implementation"
  version: "1.1.0"
---

## When to Use

- ✅ Always (default development approach)
- ✅ Building features with clear acceptance criteria
- ✅ Fixing bugs (write failing test first)
- ✅ Refactoring (tests ensure behavior unchanged)
- ✅ Critical code paths (auth, payments, data integrity)

---

## Overview

Write tests before implementation using the Red-Green-Refactor cycle. This ensures code is testable, requirements are clear, and regressions are caught immediately.

**Core Principle:** If you can't test it, you don't understand it well enough to build it.

---

## Process

### The Red-Green-Refactor Cycle

**1. RED:** Write a failing test
- Choose smallest testable behavior
- Run test → verify it fails for the right reason

**2. GREEN:** Write minimal code to make it pass
- Don't over-engineer or add extra features
- Run test → verify it passes

**3. REFACTOR:** Improve code quality
- Remove duplication, clarify names
- Keep tests green

**4. REPEAT:** Next test

### Test Hierarchy

**Unit Tests (75%):** Fast (< 1ms), isolated, test single function/class
**Integration Tests (20%):** Slower (10-100ms), test component interactions
**E2E Tests (5%):** Slowest (100ms-10s), test complete user flows

### Test Structure (AAA Pattern)

```python
def test_user_creation():
    # ARRANGE: Set up test data
    email = "test@example.com"
    password = "SecurePass123"

    # ACT: Perform action
    user = create_user(email, password)

    # ASSERT: Verify outcome
    assert user.email == email
    assert user.password != password  # Should be hashed
```

---

## Verification Checklist

- [ ] All new features have tests written first (TDD)
- [ ] Tests follow AAA pattern (Arrange, Act, Assert)
- [ ] Test names describe behavior clearly
- [ ] Each test tests one behavior
- [ ] Tests are independent (no shared state)
- [ ] Coverage ≥ 80% for new code
- [ ] All tests pass before committing

---

## Related Skills

- **Before:** [Incremental Implementation](../../build/incremental-implementation/SKILL.md) - TDD integrates into each step
- **During:** [Browser Testing & DevTools](../browser-testing-devtools/SKILL.md) - E2E testing for UI
- **After:** [Code Review Quality](../../review/code-review-quality/SKILL.md) - Tests reviewed alongside code
