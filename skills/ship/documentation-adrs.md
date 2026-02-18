---
name: "Documentation and ADRs"
phase: "ship"
complexity: "beginner"
duration: "30 minutes - 2 hours (per ADR)"
prerequisites: []
version: "1.1.0"
---

## When to Use

- ✅ Making significant architectural decisions
- ✅ Choosing between competing solutions
- ✅ Documenting design rationale
- ✅ Onboarding new team members
- ✅ Preventing repeated debates

---

## Overview

Document architectural decisions with Architecture Decision Records (ADRs) to capture context, alternatives, and rationale.

**Core Principle:** Document decisions when they're made, not when they're questioned.

---

## Process

### 1. Create ADR for Significant Decisions
**What qualifies:**
- Technology choices (database, framework)
- Architecture patterns (microservices vs monolith)
- API design approaches
- Security strategies
- Deployment strategies

### 2. ADR Template
```markdown
# ADR-XXX: [Decision Title]

**Status:** Proposed | Accepted | Deprecated | Superseded
**Date:** 2026-02-16
**Deciders:** [Names]

## Context

What is the issue we're facing? What factors are driving this decision?

## Decision

What did we decide? Be specific about the chosen approach.

## Consequences

### Positive
- Benefit 1
- Benefit 2

### Negative
- Tradeoff 1
- Tradeoff 2

### Neutral
- Side effect 1

## Alternatives Considered

### Option A
- Pros: ...
- Cons: ...
- Why rejected: ...

### Option B
- Pros: ...
- Cons: ...
- Why rejected: ...

## References

- Link to relevant discussions
- Link to specs
- External resources
```

### 3. Document Location
```
docs/
├── adr/
│   ├── README.md (index of all ADRs)
│   ├── 001-choose-database.md
│   ├── 002-api-versioning-strategy.md
│   └── 003-authentication-approach.md
```

### 4. Keep ADRs Immutable
- Don't edit old ADRs (append only)
- Create new ADR to supersede old one
- Mark old ADR as "Superseded by ADR-XXX"

---

## Verification Checklist

- [ ] ADR created for significant decision
- [ ] Context clearly explained
- [ ] Decision explicitly stated
- [ ] Consequences documented (positive, negative, neutral)
- [ ] Alternatives considered and documented
- [ ] ADR reviewed and accepted by team
- [ ] ADR index updated

---

## Related Skills

- **Before:** [Spec-Driven Development](../define/spec-driven-development.md) - Decisions captured in specs
- **After:** [Shipping & Launch](shipping-launch.md) - Document production readiness decisions
