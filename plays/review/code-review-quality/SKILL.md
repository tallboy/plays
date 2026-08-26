---
name: code-review-quality
description: "Review code using a 5-axis framework: correctness, design, readability, testing, and security. Use when reviewing pull requests or establishing review standards."
metadata:
  phase: review
  complexity: intermediate
  duration: "30 minutes - 2 hours (per PR)"
  prerequisites: "incremental-implementation"
  version: "1.1.0"
---

## When to Use

- ✅ Reviewing pull requests before merge
- ✅ Conducting code reviews for team members
- ✅ Self-reviewing code before creating PR
- ✅ Onboarding new team members (teaching code quality)
- ✅ Establishing code review standards

---

## Overview

Systematic code review using 5-axis framework ensures comprehensive quality assessment before merge.

**Core Principle:** Review for understanding first, critique second.

---

## Process: 5-Axis Review Framework

### 1. Correctness
- Does it solve the stated problem?
- Are edge cases handled?
- Do tests cover requirements?
- Are there logical errors?

### 2. Design
- Is the approach sound?
- Are abstractions appropriate?
- Is it maintainable long-term?
- Does it fit existing architecture?

### 3. Readability
- Can a new developer understand it?
- Are names descriptive?
- Is complexity necessary?
- Are comments helpful (not redundant)?

### 4. Testing
- Do tests exist?
- Do they test behavior (not implementation)?
- Are edge cases covered?
- Can tests fail for the right reasons?

### 5. Security & Performance
- Input validation present?
- No hardcoded secrets?
- No obvious performance issues?
- SQL injection / XSS prevented?

### Review Etiquette

**Do:**
- Ask questions, don't demand changes
- Praise good solutions
- Provide context for suggestions
- Offer to pair on complex issues

**Don't:**
- Nitpick style (use automated linters)
- Block on personal preferences
- Rewrite code in comments
- Review without running the code

---

## Verification Checklist

- [ ] All 5 axes reviewed (correctness, design, readability, testing, security)
- [ ] Tests run locally and pass
- [ ] No obvious bugs or regressions
- [ ] Code follows project conventions
- [ ] Feedback provided constructively
- [ ] Author has addressed feedback
- [ ] Approved or changes requested clearly

---

## Related Skills

- **After:** [Test-Driven Development](../../verify/test-driven-development/SKILL.md) - Review tests alongside code
- **After:** [Security Hardening](../security-hardening/SKILL.md) - Deep security review
- **After:** [Performance Optimization](../performance-optimization/SKILL.md) - Performance review
- **Before:** [Git Workflow & Versioning](../../ship/git-workflow-versioning/SKILL.md) - Merge after approval
