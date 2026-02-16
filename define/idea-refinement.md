# Skill: Idea Refinement

**Phase:** Define | **Complexity:** Beginner | **Duration:** 30 minutes - 2 hours
**Prerequisites:** None

---

## When to Use

- ✅ Requirements are vague or incomplete
- ✅ Stakeholders haven't aligned on vision
- ✅ User stories lack acceptance criteria
- ✅ Starting a new project or major feature
- ✅ Multiple interpretations of "what" to build exist

---

## Overview

Transform vague ideas into clear, reviewable requirements before writing any code. This skill prevents the expensive cycle of: implement → "that's not what I meant" → rewrite.

**Core Principle:** 10 minutes of clarification saves hours of rework.

---

## Process

### 1. Gather Initial Requirements
- Document what stakeholder said verbatim
- Identify the problem being solved (not just the solution requested)
- Ask: "Who is this for?" and "What outcome do they want?"

### 2. Apply the 5 Ws

| Question | Purpose |
|----------|---------|
| **WHO** | Identify users/stakeholders |
| **WHAT** | Define scope boundaries |
| **WHEN** | Understand triggers/timing |
| **WHERE** | Clarify context/environment |
| **WHY** | Uncover root motivation |

### 3. Identify Assumptions
- List all assumptions you're making
- Mark each as: ✅ Validated, ⚠️ Needs Verification, ❌ False Assumption
- Get explicit confirmation on critical assumptions

### 4. Define Success Criteria
- Write 3-5 specific, measurable outcomes
- Use format: "User can [action] so that [outcome]"
- Get stakeholder sign-off on these criteria

### 5. Document Decisions
- Create decision log for key choices
- Record: Decision, Rationale, Alternatives Considered, Who Decided
- Date-stamp all decisions

---

## Verification Checklist

- [ ] All 5 Ws answered and documented
- [ ] Assumptions explicitly listed and validated
- [ ] Success criteria written and stakeholder-approved
- [ ] Decision log captures key choices with rationale
- [ ] No one on the team says "I'm not sure what we're building"
- [ ] Acceptance criteria are specific enough to write tests from

---

## Related Skills

- **Next Step:** [[spec-driven-development]] - Turn refined ideas into machine-readable specs
- **Alternative:** [[planning-and-task-breakdown]] - If requirements are already clear, skip to planning
- **Related:** [[../ship/documentation-adrs]] - Document decisions as Architecture Decision Records

---

## Tools

- [[../../Prompts/Prompt-Create-Proposal]] - Generate OpenSpec proposals from refined ideas
- [[../../Prompts/Prompt-Greenfield-Project]] - Full project bootstrap including idea refinement

---

## Learn More

- **Why this matters:** [[./idea-refinement/anti-rationalization]]
- **Common mistakes:** [[./idea-refinement/pitfalls]]
- **Detailed examples:** [[./idea-refinement/examples]]

---

**v1.1.0** (2026-02-16): Refactored to progressive disclosure
