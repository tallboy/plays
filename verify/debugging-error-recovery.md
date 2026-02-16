# Skill: Debugging and Error Recovery

**Phase:** Verify | **Complexity:** Intermediate | **Duration:** 30 minutes - 4 hours (per issue)
**Prerequisites:** [[browser-testing-devtools]] - Basic debugging tools

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

- **Uses:** [[browser-testing-devtools]] - Inspect and debug
- **Uses:** [[test-driven-development]] - Write failing test first
- **After:** [[../review/code-review-quality]] - Review fix for quality

---

## Tools

- **Debuggers:** Chrome DevTools, VS Code debugger, pdb (Python)
- **Logging:** structured logging libraries
- **Profilers:** py-spy, clinic.js, Chrome Performance
- **Git:** `git bisect`, `git log`, `git blame`

---

## Learn More

- **Why this matters:** [[./debugging-error-recovery/anti-rationalization]]
- **Common mistakes:** [[./debugging-error-recovery/pitfalls]]
- **Detailed examples:** [[./debugging-error-recovery/examples]]

---

**v1.1.0** (2026-02-16): Refactored to progressive disclosure
