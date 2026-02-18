# Advanced: Planning and Task Breakdown

**Back to:** [Planning and Task Breakdown](../SKILL.md)

---

## Advanced Pattern: Parallel Work Streams

For large features, break into parallel work streams:

```markdown
# Work Tracker: Add Payment Processing

**Issue:** #999
**Team:** 2-3 developers
**Duration:** 2 weeks

---

## Stream A: Backend API (Developer 1)

### Step A1: Add payment models (Charge, PaymentMethod)
- **Status:** [ ] Pending
- **Complexity:** Medium
- **Dependencies:** None
- **Commit:** `Add payment models (#999)`

### Step A2: Create Stripe integration service
- **Status:** [ ] Pending
- **Complexity:** High
- **Dependencies:** A1
- **Commit:** `Create Stripe payment service (#999)`

### Step A3: Add POST /payments endpoint
- **Status:** [ ] Pending
- **Complexity:** Medium
- **Dependencies:** A2
- **Commit:** `Add payment creation endpoint (#999)`

### Step A4: Add GET /payments/:id endpoint
- **Status:** [ ] Pending
- **Complexity:** Low
- **Dependencies:** A1
- **Commit:** `Add payment retrieval endpoint (#999)`

### Step A5: Add webhook handler for Stripe events
- **Status:** [ ] Pending
- **Complexity:** High
- **Dependencies:** A2
- **Commit:** `Add Stripe webhook handler (#999)`

---

## Stream B: Frontend UI (Developer 2)

### Step B1: Create PaymentForm component
- **Status:** [ ] Pending
- **Complexity:** Medium
- **Dependencies:** None (mock data initially)
- **Commit:** `Create payment form component (#999)`

### Step B2: Add payment method selection UI
- **Status:** [ ] Pending
- **Complexity:** Medium
- **Dependencies:** B1
- **Commit:** `Add payment method selection (#999)`

### Step B3: Integrate with POST /payments API
- **Status:** [ ] Pending
- **Complexity:** Medium
- **Dependencies:** A3, B2 (INTEGRATION POINT)
- **Commit:** `Integrate payment form with API (#999)`

### Step B4: Add payment status polling
- **Status:** [ ] Pending
- **Complexity:** Low
- **Dependencies:** A4, B3
- **Commit:** `Add payment status polling (#999)`

### Step B5: Add success/error UI
- **Status:** [ ] Pending
- **Complexity:** Low
- **Dependencies:** B4
- **Commit:** `Add payment success and error handling (#999)`

---

## Stream C: Testing (Both Developers or QA)

### Step C1: Unit tests for payment service
- **Status:** [ ] Pending
- **Complexity:** Medium
- **Dependencies:** A2
- **Assigned:** Developer 1
- **Commit:** `Add unit tests for payment service (#999)`

### Step C2: Integration tests for API
- **Status:** [ ] Pending
- **Complexity:** Medium
- **Dependencies:** A3, A4
- **Assigned:** Developer 1
- **Commit:** `Add integration tests for payment API (#999)`

### Step C3: E2E tests for checkout flow
- **Status:** [ ] Pending
- **Complexity:** High
- **Dependencies:** B5 (everything done)
- **Assigned:** Both
- **Commit:** `Add E2E tests for payment checkout (#999)`

---

## Integration Steps (Both Developers)

### Step D1: Merge streams, resolve conflicts
- **Status:** [ ] Pending
- **Complexity:** Low
- **Dependencies:** A5, B5, C2
- **Verification:**
  - [ ] No merge conflicts
  - [ ] All tests pass
  - [ ] Manual smoke test of full flow

### Step D2: Full regression test
- **Status:** [ ] Pending
- **Complexity:** Medium
- **Dependencies:** D1
- **Verification:**
  - [ ] Full test suite passes
  - [ ] Performance tested (< 2s checkout time)
  - [ ] Security review passed

### Step D3: Deploy to staging
- **Status:** [ ] Pending
- **Complexity:** Low
- **Dependencies:** D2
- **Verification:**
  - [ ] Staging deployment successful
  - [ ] Staging smoke tests pass
  - [ ] Ready for production
```

---

## Advanced Pattern: Risk-First Ordering

For uncertain projects, tackle highest-risk steps first:

```markdown
# Work Tracker: Integrate with External API

## Phase 1: Validate Feasibility (Risk Reduction)

### Step 1: Test external API authentication
- **Risk:** API docs might be wrong, auth might not work
- **Why first:** If auth fails, entire project blocked
- **Verification:** Successfully get auth token from API

### Step 2: Test rate limits and performance
- **Risk:** API might be too slow or restrictive
- **Why first:** If too slow, need to redesign architecture
- **Verification:** Can make 100 req/min, responses < 500ms

### Step 3: Test error handling scenarios
- **Risk:** API might not handle errors as documented
- **Why first:** Need to know real error behavior before building retry logic
- **Verification:** Document actual error responses

## Phase 2: Build (Lower Risk, Now Confident)

### Step 4: Create API client wrapper
### Step 5: Add retry and circuit breaker logic
### Step 6: Integrate with application
### Step 7: Add monitoring and alerts
```

**Benefit:** If high-risk steps fail, you find out early before wasting time on low-risk work.

---

## Advanced Pattern: Feature Flags for Partial Deployment

For large features, use feature flags to deploy incrementally:

```markdown
# Work Tracker: New Dashboard (Large UI Overhaul)

## Step 1: Add feature flag `new_dashboard`
- **Commit:** `Add feature flag for new dashboard (#456)`
- **Deployment:** Can deploy to production (flag off)

## Step 2: Build new dashboard layout (behind flag)
- **Commit:** `Create new dashboard layout (behind feature flag) (#456)`
- **Deployment:** Can deploy to production (flag still off)

## Step 3: Test with internal users (flag on for admins only)
- **Commit:** `Enable new dashboard for admin users (#456)`
- **Deployment:** Deploy to production, only admins see it

## Step 4: Gradual rollout (flag on for 10% of users)
- **Commit:** `Roll out new dashboard to 10% of users (#456)`
- **Deployment:** Monitor metrics, gather feedback

## Step 5: Full rollout (flag on for everyone)
- **Commit:** `Enable new dashboard for all users (#456)`
- **Deployment:** 100% traffic on new dashboard

## Step 6: Remove old dashboard and feature flag
- **Commit:** `Remove old dashboard after full rollout (#456)`
- **Deployment:** Clean up code
```

**Benefit:** Can deploy each step to production without disrupting users.

---

## Advanced Pattern: Work Tracker Evolution

Track how plan changes over time:

```markdown
# Work Tracker: Add Rate Limiting

**Original Plan:** 2026-02-16 10:00
**Last Updated:** 2026-02-16 16:00

---

## Change Log

### 2026-02-16 10:00 - Initial Plan
- Created 5 steps based on OpenSpec proposal

### 2026-02-16 14:30 - Skipped Step 2
- **Reason:** Discovered existing middleware can be reused
- **Impact:** Saved 2 hours, simplified architecture

### 2026-02-16 16:00 - Added Step 6
- **Reason:** Load testing revealed need for Redis connection pooling
- **Impact:** +1 hour work, but prevents production issues

---

## Step 1: Add rate_limit_tier to User model
- **Status:** [x] Complete
- **Completed:** 2026-02-16 12:00
- **Commit:** abc123

## Step 2: Create rate limiter middleware
- **Status:** [x] Skipped
- **Skipped:** 2026-02-16 14:30
- **Reason:** Reusing existing middleware, just adding rate limit logic

## Step 3: Add rate limit logic to existing middleware
- **Status:** [x] Complete
- **Added:** 2026-02-16 14:30 (replaced skipped step 2)
- **Completed:** 2026-02-16 15:30
- **Commit:** def456

[... remaining steps ...]

## Step 6: Add Redis connection pooling
- **Status:** [ ] Pending
- **Added:** 2026-02-16 16:00
- **Complexity:** Low
- **Reason:** Load testing showed connection exhaustion at high traffic
```

**Benefit:** Future developers understand the decision-making process.

---

## Advanced Pattern: Dependency Visualization

For complex projects, visualize dependencies:

```markdown
# Work Tracker: Complex Feature

## Dependency Graph

```
Step 1 (Model) ─┬─→ Step 3 (API Read)
                └─→ Step 4 (API Write)

Step 2 (Service) ──→ Step 4 (API Write)
                   └─→ Step 5 (Integration)

Step 3 (API Read) ──→ Step 6 (Tests)

Step 4 (API Write) ─┬→ Step 6 (Tests)
                    └→ Step 7 (Docs)

Step 5 (Integration)→ Step 6 (Tests)
```

## Critical Path (Longest Sequence)
1 → 4 → 6 → 7 (Must complete in order)

## Parallelizable
- Step 3 can happen anytime after Step 1
- Step 2 can happen in parallel with Step 1
- Step 5 can happen in parallel with Steps 3-4
```

**Benefit:** Identify which steps block others, optimize for parallel work.

---

## Advanced Pattern: Time Estimation Calibration

Track estimated vs. actual time to improve future estimates:

```markdown
## Step 1: Add field to model
- **Estimated:** 1 hour
- **Actual:** 45 minutes
- **Reason for difference:** Simpler than expected

## Step 2: Create API endpoint
- **Estimated:** 2 hours
- **Actual:** 4 hours
- **Reason for difference:** Didn't account for authentication edge cases

## Step 3: Add tests
- **Estimated:** 1 hour
- **Actual:** 1.5 hours
- **Reason for difference:** Found additional edge case during testing

---

## Retrospective

**Total estimated:** 8 hours
**Total actual:** 10.5 hours
**Accuracy:** 76%

**Lessons for next time:**
- Add 50% buffer for "authentication" tasks (always complex)
- Testing is usually 1.5x estimate (finding edge cases takes time)
- Model work is usually accurate
```

**Benefit:** Improve estimation accuracy over time.

---

Back to [Planning and Task Breakdown](../SKILL.md)
