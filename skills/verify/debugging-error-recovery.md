---
name: "Debugging and Error Recovery"
phase: "verify"
complexity: "intermediate"
duration: "30 minutes - 4 hours (per issue)"
prerequisites: ["browser-testing-devtools"]
version: "1.1.0"
---

## When to Use

- ✅ Bug reported (production or development)
- ✅ Tests failing unexpectedly
- ✅ Error logs appearing
- ✅ Unexpected behavior without obvious cause
- ✅ Performance degradation

---

## Overview

Systematic process for identifying, isolating, and fixing defects using 5-step triage.

**Core Principle:** Reproduce first, hypothesize second, fix last.

---

## Process: 5-Step Triage

### 1. Reproduce
- Gather bug report details
- Identify minimal steps to reproduce
- Document environment (browser, OS, data)
- Write failing test

### 2. Hypothesize
- Review recent changes (git log)
- Check error messages and stack traces
- Form 2-3 testable theories
- Rank by likelihood

### 3. Test Hypothesis
- Add logging/debugging
- Run isolated test
- Verify or disprove each hypothesis
- Iterate until root cause found

### 4. Fix
- Implement minimal fix
- Ensure failing test now passes
- Run full test suite (no regressions)
- Verify fix in production-like environment

### 5. Document
- Add comment explaining bug and fix
- Update docs if behavior misunderstood
- Create ADR if architectural issue
- Share learnings with team

### Common Debugging Techniques

**Binary Search:** Comment out half the code, narrow down
**Rubber Duck:** Explain problem out loud
**Git Bisect:** Find commit that introduced bug
**Diff Comparison:** Compare working vs. broken state

---

## Verification Checklist

- [ ] Bug reproduced consistently
- [ ] Failing test written
- [ ] Root cause identified (not symptoms)
- [ ] Fix implemented
- [ ] All tests pass
- [ ] No regressions introduced
- [ ] Documentation updated
- [ ] Root cause analysis documented

---

## Related Skills

- **Uses:** [Browser Testing & DevTools](browser-testing-devtools.md) - Inspect and debug
- **Uses:** [Test-Driven Development](test-driven-development.md) - Write failing test first
- **After:** [Code Review Quality](../review/code-review-quality.md) - Review fix for quality
