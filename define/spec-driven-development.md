# Skill: Spec-Driven Development

**Phase:** Define | **Complexity:** Intermediate | **Duration:** 2-8 hours (proposal creation)
**Prerequisites:** [[idea-refinement]]

---

## When to Use

- ✅ Adding features spanning multiple files
- ✅ Making breaking changes to APIs or interfaces
- ✅ Refactoring architecture
- ✅ Changes requiring stakeholder review before implementation
- ✅ Work tracked in GitHub issues needing design approval
- ✅ You'd say "this is complex" or "I need to think through this"

---

## Overview

Write machine-readable specs BEFORE implementation. This creates a reviewable design that catches issues when they're cheap to fix.

**Core Principle:** Changing a spec takes minutes; changing code takes hours.

This skill implements the **OpenSpec Pattern** from [[../../Patterns/OpenSpec-Pattern]].

---

## Process

### 1. Create Change Directory
```bash
mkdir -p openspec/changes/add-[feature-name]      # New capability
mkdir -p openspec/changes/update-[feature-name]   # Enhance existing
mkdir -p openspec/changes/remove-[feature-name]   # Deprecate
mkdir -p openspec/changes/refactor-[feature-name] # Internal changes
```

### 2. Write proposal.md
- **Motivation:** Why is this needed? What problem does it solve?
- **Scope:** In scope, out of scope, explicitly not doing
- **Impact:** Users, code, dependencies
- **Alternatives Considered:** Pros, cons, rejection reason
- **Decision:** Selected approach with rationale

### 3. Write tasks.md
Break implementation into phases with:
- Goal of each phase
- Estimated complexity (Low/Medium/High)
- Specific, testable tasks
- Verification criteria

### 4. Write Spec Deltas
Create `specs/[capability]/spec.md` with:
- **ADDED Requirements:** New features with scenarios
- **MODIFIED Requirements:** Updated features (full text, not diffs)
- **REMOVED Requirements:** Deprecated features with migration path

**Critical:** Every requirement MUST have WHEN/THEN scenarios.

### 5. Validate Proposal
```bash
openspec validate add-[feature-name] --strict
```

### 6. Get Review & Approval
- Share with stakeholders
- Walk through motivation, scope, alternatives
- Iterate on feedback
- Get formal approval, document in proposal

### 7. Implement
Link to [[planning-and-task-breakdown]] and [[../build/incremental-implementation]]

### 8. Archive When Deployed
```bash
openspec archive add-[feature-name] --yes
```

---

## Verification Checklist

- [ ] proposal.md includes: motivation, scope, impact, alternatives
- [ ] tasks.md breaks work into phases < 1 week each
- [ ] Spec deltas include WHEN/THEN scenarios for all requirements
- [ ] `openspec validate --strict` passes with no errors
- [ ] Stakeholders have reviewed and approved in writing
- [ ] Implementation tasks reference specific spec requirements
- [ ] Change archived after deployment to production

---

## Related Skills

- **Before:** [[idea-refinement]] - Clarify vague requirements first
- **After:** [[planning-and-task-breakdown]] - Break specs into work tracker
- **During:** [[../build/incremental-implementation]] - Execute implementation
- **Finally:** [[../ship/documentation-adrs]] - Document architectural decisions

---

## Tools

- [[../../Patterns/OpenSpec-Pattern]] - Full pattern documentation
- [[../../Templates/Template-OpenSpec-Proposal]] - Copy/paste proposal template
- [[../../Templates/Template-OpenSpec-Project]] - Setup project.md conventions
- [[../../Workflows/Workflow-New-Feature]] - End-to-end workflow using OpenSpec
- [[../../Prompts/Prompt-Create-Proposal]] - AI-assisted proposal generation

---

## Learn More

- **Why this matters:** [[./spec-driven-development/anti-rationalization]]
- **Common mistakes:** [[./spec-driven-development/pitfalls]]
- **Detailed examples:** [[./spec-driven-development/examples]]

---

**v1.1.0** (2026-02-16): Refactored to progressive disclosure
