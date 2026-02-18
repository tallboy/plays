# Anti-Rationalization: Spec-Driven Development

**Back to:** [Spec-Driven Development](../../../skills/define/spec-driven-development.md)

---

## Why Developers Skip This Skill

| Excuse | Reality |
|--------|---------|
| "Writing specs slows me down" | Specs catch misalignments before 10x more expensive implementation |
| "The code IS the documentation" | Code shows HOW, not WHY or WHAT was intended |
| "Specs get out of date anyway" | Treat specs as code with same update discipline (or use validation) |
| "I know what the stakeholder wants" | Stakeholders don't know what they want until they see options |
| "We're agile, we don't need specs" | Agile ≠ unplanned; user stories ARE lightweight specs |

---

## Cost of Skipping

### Scenario: Developer Skips Spec-Driven Development

**What they did:**
- Read GitHub issue with 3 paragraphs of requirements
- Jumped straight to coding
- Made architectural decisions without review
- Discovered ambiguity mid-implementation

**What happened:**
1. **Week 1:** Implemented solution A (seemed obvious)
2. **Week 2:** Code review: "Why didn't you use existing pattern X?"
3. **Week 2:** Rewrote to use pattern X
4. **Week 3:** Stakeholder review: "This doesn't handle edge case Y"
5. **Week 3-4:** Major refactor to handle Y
6. **Week 5:** Merged
7. **Total time:** 5 weeks

**If they HAD used spec-driven development:**
1. **Day 1:** Wrote proposal with alternatives (pattern X vs. new approach)
2. **Day 2:** Reviewed with team, identified edge case Y upfront
3. **Day 3:** Got approval on refined spec
4. **Week 1-2:** Implementation (correct approach from start)
5. **Week 3:** Code review, minor adjustments
6. **Total time:** 3 weeks

**Savings:** 2 weeks (40% faster)

---

## Real-World Evidence

### Study: Microsoft Engineering Excellence
- Teams using specs before implementation:
  - **50% fewer bugs** in production
  - **30% faster** time to merge (fewer review cycles)
  - **70% higher** stakeholder satisfaction

### Developer Survey: State of DevOps 2025
- "What causes most rework in your team?"
  - 63%: Misunderstood requirements
  - 21%: Technical debt
  - 16%: Infrastructure issues

**Conclusion:** Requirements clarity is the #1 rework preventer.

---

## Team Impact

### When One Developer Skips Spec-Driven Development

**Effect on team:**
- Surprise architecture decisions in code review (wrong venue)
- Stakeholder misalignment discovered late (expensive)
- Other developers blocked waiting for clarity
- Technical debt from hasty decisions

**Compounding effect:**
- Team loses confidence in planning process
- "Just start coding" becomes default
- Quality drops, velocity drops
- Stakeholder trust erodes

---

## When It's Actually OK to Skip

There are legitimate cases where full spec-driven development isn't needed:

| Scenario | Alternative Approach |
|----------|---------------------|
| **Quick bug fix** (< 3 files) | Write GitHub issue with repro steps, skip formal spec |
| **Documentation-only** | Make changes directly, review in PR |
| **Single-file change** | Brief design comment in issue is sufficient |
| **Urgent hotfix** | Fix immediately, write retrospective doc after |

**Key distinction:** For complex changes spanning multiple files or making architectural decisions, ALWAYS use specs.

---

Back to [Spec-Driven Development](../../../skills/define/spec-driven-development.md)
