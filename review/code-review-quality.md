# Skill: Code Review Quality

**Phase:** Review | **Complexity:** Intermediate | **Duration:** 30 minutes - 2 hours (per PR)
**Prerequisites:** [[../build/incremental-implementation]]

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

- **After:** [[../verify/test-driven-development]] - Review tests alongside code
- **After:** [[security-hardening]] - Deep security review
- **After:** [[performance-optimization]] - Performance review
- **Before:** [[../ship/git-workflow-versioning]] - Merge after approval

---

## Tools

- **GitHub PR Reviews** - Comment, approve, request changes
- **GitLab Merge Requests** - Similar to GitHub
- **Review checklists** - Automated reminders
- **CI/CD integration** - Automated quality gates

---

## Learn More

- **Why this matters:** [[./code-review-quality/anti-rationalization]]
- **Common mistakes:** [[./code-review-quality/pitfalls]]
- **Detailed examples:** [[./code-review-quality/examples]]

---

**v1.1.0** (2026-02-16): Refactored to progressive disclosure
