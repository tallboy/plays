# Common Pitfalls: Idea Refinement

**Back to:** [Idea Refinement](../SKILL.md)

---

## Pitfall 1: Accepting Solution Instead of Problem

**Symptom:** Stakeholder says "Add a button that does X"

**Why it happens:**
- Stakeholders often jump to solutions
- We take requests at face value
- Faster to say "yes" than to probe

**Cost:**
- Miss better solutions to underlying problem
- Build features that don't solve real pain point
- Create UX debt (buttons proliferate)

**Fix:**
Ask "What problem are you solving?" to uncover actual need.

**Example:**
```markdown
# Request
"Add export to CSV button"

# After asking WHY
Problem: Accountant needs transaction data in Excel for monthly reports
Better solution: Automated monthly email with CSV attachment (no button needed)
```

**Prevention:**
Always ask "What outcome do you want?" before agreeing to implementation.

---

## Pitfall 2: Analysis Paralysis

**Symptom:** Spending days refining requirements for small change

**Why it happens:**
- Fear of missing something
- Perfectionism
- Lack of timeboxing

**Cost:**
- Opportunity cost (could have shipped already)
- Team frustration
- Diminishing returns

**Fix:**
Timebox to 1-2 hours; some ambiguity is fine for small changes.

**Rule of thumb:**
- Small change (< 1 day work): 15-30 min refinement
- Medium feature (1-3 days): 1-2 hour refinement
- Large feature (> 3 days): Half-day to full-day refinement

**Prevention:**
Set timer before starting refinement session.

---

## Pitfall 3: Skipping Assumption Validation

**Symptom:** Building on false assumptions discovered mid-implementation

**Why it happens:**
- Assumptions feel obvious
- Don't want to "bother" stakeholders
- Assume we know the domain

**Cost:**
- Wrong architecture choices
- Wasted implementation effort
- Late-stage pivots

**Fix:**
Validate high-risk assumptions before moving to spec/code.

**High-risk assumption checklist:**
- [ ] Assumptions about user behavior
- [ ] Assumptions about existing system capabilities
- [ ] Assumptions about performance requirements
- [ ] Assumptions about security/compliance needs
- [ ] Assumptions about integration with other systems

**Example:**
```markdown
## Assumptions (Before Validation)
- ⚠️ Users want real-time notifications (needs verification)
- ⚠️ Email service can handle 10k emails/hour (needs verification)

## After Validation
- ❌ Users want real-time notifications → FALSE: Survey shows batched daily digest preferred
- ✅ Email service can handle 10k emails/hour → TRUE: Confirmed with infra team
```

---

## Pitfall 4: Vague Success Criteria

**Symptom:** Success criteria like "Works well" or "Users are happy"

**Why it happens:**
- Easier to stay vague than get specific
- Fear of over-committing
- Unclear on how to measure

**Cost:**
- Can't write tests (no clear pass/fail)
- Scope creep (no definition of "done")
- Moving goalposts

**Fix:**
Make criteria specific, measurable, and testable.

**Bad vs Good:**

| Bad (Vague) | Good (Specific) |
|-------------|-----------------|
| "Fast performance" | "Page loads in < 2 seconds on 3G connection" |
| "Easy to use" | "New user completes signup in < 3 minutes without help" |
| "Works reliably" | "99.9% uptime, < 5 errors per 1000 requests" |
| "Looks good" | "Passes WCAG 2.1 AA contrast requirements" |

---

## Pitfall 5: Not Documenting Decisions

**Symptom:** Team forgets why choices were made 3 months later

**Why it happens:**
- Feels like overhead
- Decisions seem obvious in the moment
- No clear place to document

**Cost:**
- Re-litigating old decisions
- Inconsistent architecture (forgot rationale)
- Loss of institutional knowledge

**Fix:**
Maintain decision log with rationale and alternatives considered.

**Template:**
```markdown
## Decision Log

### Decision 1: Use polling instead of WebSockets
- **Date:** 2026-02-16
- **Decided by:** Tech Lead + Product Manager
- **Rationale:** Simpler implementation, 5-min refresh acceptable for use case
- **Alternatives considered:**
  - WebSockets: Real-time but adds infrastructure complexity
  - Manual refresh: Simplest but poor UX
- **Trade-offs:** Slight delay in data vs. implementation complexity
- **Revisit if:** User feedback indicates real-time updates are critical
```

**Prevention:**
Create decision log template at start of refinement session.

---

## Recovery: What If I've Already Skipped?

### You've Started Coding Without Refinement

**Solution:**
```markdown
1. STOP coding immediately
2. Create refinement doc now (better late than never)
3. Share with stakeholder: "Want to confirm I'm on right track"
4. If misaligned: Create new branch, preserve old work as reference
5. If aligned: Document assumptions for future
```

### Stakeholder Says "That's Not What I Meant"

**Solution:**
```markdown
1. Don't blame: "Let me make sure I understand correctly now"
2. Run through 5 Ws with stakeholder
3. Document correct requirements
4. Estimate: fix current code vs. start fresh
5. Create decision: which path forward
6. Add to decision log: what caused misalignment
```

**Learning opportunity:**
- What assumption was wrong?
- What question would have caught it?
- Add that question to future refinement checklist

---

Back to [Idea Refinement](../SKILL.md)
