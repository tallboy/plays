# Common Pitfalls: Spec-Driven Development

**Back to:** [[../spec-driven-development]]

---

## Pitfall 1: Spec Too Detailed

**Symptom:** Spec describes implementation details like variable names, loop structure, exact file paths

**Example:**
```markdown
# BAD: Over-specified
The RateLimiter class should have a private field `_request_counts`
of type Dict[str, List[datetime]] that stores timestamps using the
datetime.now(timezone.utc) function...
```

**Why it happens:**
- Confusing design with implementation
- Trying to be "thorough"
- Don't trust implementer to make good choices

**Cost:**
- Spec becomes maintenance burden
- Implementation has no room for better approaches
- Code review debates spec details instead of outcomes

**Fix:**
Spec describes WHAT and WHY, not HOW.

**Example:**
```markdown
# GOOD: Right level of detail
#### Scenario: Rate limit tracked per user
- **WHEN** authenticated user makes request
- **THEN** system tracks request count for that user
- **AND** count persists across server restarts
- **AND** count resets after time window expires

Implementation choice: Use Redis for persistence and automatic expiry.
Specific data structures left to implementer.
```

**Prevention:**
Ask: "Could this be implemented in multiple ways?" If yes, don't over-specify.

---

## Pitfall 2: Spec Too Vague

**Symptom:** Can't write tests from spec alone, scenarios lack concrete details

**Example:**
```markdown
# BAD: Under-specified
#### Scenario: User exceeds rate limit
- **WHEN** user makes too many requests
- **THEN** system responds appropriately
```

**Why it happens:**
- Fear of over-constraining implementation
- Lack of clarity on actual requirements
- Rushing through spec writing

**Cost:**
- Implementer makes wrong assumptions
- Test scenarios ambiguous
- Stakeholder expectations misaligned

**Fix:**
Every requirement needs concrete WHEN/THEN scenarios with specific values.

**Example:**
```markdown
# GOOD: Specific and testable
#### Scenario: Authenticated user exceeds limit
- **WHEN** authenticated user makes 101 requests in 1 minute
- **THEN** request 101 returns 429 Too Many Requests
- **AND** response includes `Retry-After: 45` header (seconds until reset)
- **AND** response body includes JSON: `{"error": "Rate limit exceeded", "retry_after": 45}`
```

**Prevention:**
Test the test: "Could I write a unit test from this scenario alone?"

---

## Pitfall 3: Implementing Before Approval

**Symptom:** Code written, then spec rejected or major changes requested in review

**Example:**
```markdown
# Timeline
Day 1-2: Write proposal
Day 3-7: Start coding (didn't wait for approval)
Day 8: Stakeholder review: "We need to change the whole approach"
Day 9-15: Rewrite
```

**Why it happens:**
- Impatient to start
- "I'll just get a head start"
- Assume approval is rubber stamp

**Cost:**
- Wasted implementation effort
- Frustration from throwing away work
- Damaged credibility with team

**Fix:**
Proposal approval is a GATE—don't code until green light.

**Approval process:**
```markdown
1. Write proposal
2. Share with stakeholders
3. Wait for explicit approval (not just silence)
4. Document approval in proposal:

## Approval
- **Reviewed by:** Tech Lead, Product Manager
- **Approved on:** 2026-02-16
- **Conditions:** None

5. NOW start implementation
```

**Prevention:**
Add to proposal template: "DO NOT IMPLEMENT UNTIL APPROVED"

---

## Pitfall 4: Spec Drift

**Symptom:** Implementation doesn't match spec, but no one updated spec

**Example:**
```markdown
# Spec says
Rate limit: 100 requests per minute

# Code implements
Rate limit: 1000 requests per minute (changed during implementation)

# No one updated the spec
```

**Why it happens:**
- Requirements changed mid-implementation
- Found better approach while coding
- Forgot to update spec

**Cost:**
- Spec becomes untrustworthy
- Future developers confused
- Documentation out of sync

**Fix:**
Treat spec as living document—update when requirements change.

**Process:**
```markdown
## During Implementation

If you discover spec needs to change:

1. STOP implementing
2. Update proposal with new decision:
   - **Decision Update (2026-02-16):** Changed rate limit from 100 to 1000 req/min
   - **Rationale:** Load testing showed 100 too restrictive, 1000 is safe
3. Update spec scenarios with new values
4. Get re-approval from stakeholders (if major change)
5. THEN continue implementing
```

**Prevention:**
In work tracker, add step: "Update spec if requirements changed during implementation"

---

## Pitfall 5: Missing WHEN/THEN Format

**Symptom:** Scenarios written in prose instead of structured format, validator fails

**Example:**
```markdown
# BAD: Not structured
The user should be able to login with email and password, and if
they provide wrong credentials they get an error message.

# GOOD: Structured with WHEN/THEN
#### Scenario: Successful login
- **WHEN** user provides valid email and password
- **THEN** user receives authentication token
- **AND** user is redirected to dashboard

#### Scenario: Invalid credentials
- **WHEN** user provides incorrect password
- **THEN** system returns 401 Unauthorized
- **AND** response includes error message: "Invalid credentials"
```

**Why it happens:**
- Unfamiliar with OpenSpec format
- Writing like user story instead of spec
- Copying from non-spec documentation

**Cost:**
- Validation fails
- Scenarios not machine-readable
- Can't generate tests from spec

**Fix:**
Always use structured format:
- `#### Scenario:` (exactly 4 hashtags)
- `- **WHEN**` on its own line
- `- **THEN**` on its own line
- `- **AND**` for additional conditions

**Prevention:**
Use template, run `openspec validate` before committing.

---

## Pitfall 6: Combining Multiple Changes

**Symptom:** One proposal tries to add feature X, refactor module Y, and fix bug Z

**Example:**
```markdown
# Proposal: Add Rate Limiting (and other stuff)

## Scope
- Add rate limiting middleware
- Refactor auth module to use ORM
- Fix email validation bug
- Update to latest Flask version
```

**Why it happens:**
- "Might as well do it all at once"
- Trying to batch related work
- Don't want overhead of multiple proposals

**Cost:**
- Proposal too large to review effectively
- Can't deploy partial change
- Git history messy
- Hard to revert if one part breaks

**Fix:**
One proposal per logical change.

**Correct approach:**
```markdown
# Proposal 1: Add Rate Limiting
(focused on rate limiting only)

# Proposal 2: Refactor Auth to ORM
(separate proposal, can be done in parallel)

# Proposal 3: Fix Email Validation Bug
(quick fix, might not even need full proposal)
```

**Prevention:**
Ask: "Could I deploy just part of this?" If yes, split into multiple proposals.

---

## Recovery: What If I've Already Violated?

### You Started Coding Without Spec

**Solution:**
```markdown
1. PAUSE implementation
2. Create proposal now (better late than never)
3. Document what you've learned during initial coding
4. Review proposal with team
5. If approach is wrong: Create new branch, treat current work as prototype
6. If approach is right: Document decisions, continue
```

### Spec Was Approved But Requirements Changed

**Solution:**
```markdown
1. Don't secretly change implementation
2. Update proposal with new requirements
3. Add "Decision Update" section with date and rationale
4. Re-validate with `openspec validate`
5. Get re-approval from stakeholders
6. Update tasks.md with new steps
7. Continue implementation
```

### Implementation Diverged From Spec

**Solution:**
```markdown
1. Compare: implementation vs. spec
2. For each difference:
   - Is implementation better? Update spec
   - Is spec better? Update implementation
3. Document why divergence happened (learn for next time)
4. Run validation to ensure spec is consistent
5. Update CHANGELOG to note spec corrections
```

---

Back to [[../spec-driven-development]]
