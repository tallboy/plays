# Common Pitfalls: Planning and Task Breakdown

**Back to:** [Planning and Task Breakdown](../../../skills/define/planning-and-task-breakdown.md)

---

## Pitfall 1: Steps Too Large

**Symptom:** Step takes 8+ hours, requires multiple commits

**Example:**
```markdown
## Step 1: Implement rate limiting
- Files: (all of them)
- Verification: Rate limiting works
```

**Why it happens:**
- Lazy planning (didn't think through details)
- Afraid of too many steps
- Don't see natural breakpoints

**Cost:**
- Can't pause/resume safely
- Hard to review progress
- One commit has too many changes
- If step fails, lose a lot of work

**Fix:**
Break into sub-steps. Rule of thumb: 1 step = 1 commit = 1-4 hours.

**Example:**
```markdown
## Step 1: Add rate_limit_tier field to User model
- Complexity: Low (1 hour)
- Files: models/user.py, migrations/, tests/test_user_model.py
- Verification: Field exists, migration tested

## Step 2: Create RateLimiter class
- Complexity: Medium (2-3 hours)
- Files: middleware/rate_limiter.py, tests/test_rate_limiter.py
- Verification: Unit tests pass for within/exceed limit

## Step 3: Integrate with one route
- Complexity: Medium (2 hours)
- Files: routes/api.py, tests/test_api.py
- Verification: /health endpoint rate limited
```

**Prevention:**
Ask: "Could I commit after this step and have working code?" If no, break it down further.

---

## Pitfall 2: Steps Too Small

**Symptom:** 20+ steps for a simple feature, overhead exceeds value

**Example:**
```markdown
## Step 1: Add import for datetime
## Step 2: Add import for typing
## Step 3: Add rate_limit_tier field
## Step 4: Add migration file
## Step 5: Add test for migration
## Step 6: Run migration
...
```

**Why it happens:**
- Over-thinking breakdown
- Confusing lines of code with logical steps
- Trying to be "thorough"

**Cost:**
- Tracker becomes noise
- Spend more time updating tracker than coding
- Lose sight of big picture

**Fix:**
Combine related changes. Don't track "add import statement" as separate step.

**Example:**
```markdown
## Step 1: Add rate_limit_tier to User model
- Includes: field definition, migration, tests
- Verification: Field works, migration tested
```

**Prevention:**
Ask: "Would I create a commit for just this?" If no, combine with related work.

---

## Pitfall 3: Horizontal Slicing

**Symptom:** "Update all models" as one step, "Update all routes" as another

**Example:**
```markdown
# BAD: Horizontal slices
## Step 1: Update database models (User, Post, Comment)
## Step 2: Update API routes (auth, posts, comments)
## Step 3: Update tests
## Step 4: Update docs
```

**Why it happens:**
- Thinking in layers instead of features
- Organizing by file type instead of functionality
- Easier to list "all the models"

**Cost:**
- Nothing works until all steps done
- Can't test incrementally
- Hard to review (big diffs)
- Can't deploy partially

**Fix:**
Slice vertically—complete one user journey end-to-end.

**Example:**
```markdown
# GOOD: Vertical slices
## Step 1: Add rate_limit_tier to User model + test
## Step 2: Create RateLimiter middleware + test
## Step 3: Integrate limiter with /health endpoint + test
## Step 4: Extend to all endpoints + tests
## Step 5: Add documentation
```

**Benefit:** System works (partially) after each step.

**Prevention:**
Ask: "Does this step deliver testable value on its own?"

---

## Pitfall 4: Vague Verification

**Symptom:** "Works correctly" or "Tests pass" as verification

**Example:**
```markdown
## Step 2: Implement rate limiting
- Verification: Works correctly
```

**Why it happens:**
- Don't know exact behavior yet
- Copying template without thinking
- Rushing through planning

**Cost:**
- Don't know when step is done
- Can't write tests from criteria
- Ambiguity causes scope creep

**Fix:**
Be specific—what exactly should work?

**Example:**
```markdown
## Step 2: Create RateLimiter middleware
- Verification:
  - [ ] RateLimiter.check_limit(user_id, 100) returns True for request 1-100
  - [ ] RateLimiter.check_limit(user_id, 100) returns False for request 101
  - [ ] Rate limit resets after 1 minute window
  - [ ] Unit tests pass: pytest tests/test_rate_limiter.py
```

**Prevention:**
Write verification criteria you could turn into test cases.

---

## Pitfall 5: Ignoring Dependencies

**Symptom:** Step 3 requires output from step 5, but step 5 comes later

**Example:**
```markdown
## Step 1: Integrate rate limiter with routes
## Step 2: Create User model field
## Step 3: Create RateLimiter class  ← Step 1 needs this!
```

**Why it happens:**
- Listed steps in order they came to mind
- Didn't think through dependencies
- Assumed parallel work is possible

**Cost:**
- Start step 1, realize you need step 3 first
- Constantly reordering steps
- Waste time on impossible tasks

**Fix:**
Map dependencies first, then order steps.

**Process:**
```markdown
1. List all steps (any order)
2. Draw arrows: "A needs B"
3. Topological sort: Dependencies first
4. Number steps in execution order
```

**Example:**
```markdown
# Dependency analysis
- RateLimiter needs: User model field (for tier)
- Route integration needs: RateLimiter class
- Tests need: Everything above

# Correct order
1. User model field
2. RateLimiter class
3. Route integration
4. Tests
```

**Prevention:**
Before numbering steps, ask: "Does any step need output from another?"

---

## Pitfall 6: Abandoned Work Tracker

**Symptom:** Work tracker not updated, diverges from reality

**Example:**
```markdown
# Tracker says
- Step 1: [x] Complete
- Step 2: [ ] Pending

# Git log shows
- Commit 1: Step 1
- Commit 2: Step 3 (skipped step 2!)
- Commit 3: New thing not in tracker
```

**Why it happens:**
- Requirements changed mid-implementation
- Discovered better approach while coding
- Forgot to update tracker

**Cost:**
- Can't resume after interruption (tracker lies)
- Can't report progress accurately
- Future developers don't understand decisions

**Fix:**
Tracker is LIVING document—update in real-time.

**Rules:**
- If you add a step: add to tracker FIRST, then implement
- If you skip a step: mark "[x] Skipped - Reason: [why]"
- If you change approach: update tracker to match

**Example:**
```markdown
## Step 2: Add API endpoint
- **Status:** [x] Skipped
- **Reason:** Realized we can reuse existing endpoint with new parameter
- **Skipped on:** 2026-02-16

## Step 3: Update existing endpoint (ADDED during implementation)
- **Status:** [x] Complete
- **Added on:** 2026-02-16
- **Reason:** Better approach than creating new endpoint
```

**Prevention:**
Treat tracker like code—when you change the plan, update the tracker.

---

## Recovery: What If I've Already Violated?

### You Started Coding Without a Plan

**Solution:**
```markdown
1. PAUSE implementation
2. Create work tracker NOW (better late than never)
3. Document what you've done so far:
   - Completed work → mark [x] Complete, note commit hash
   - Current work → mark [~] In Progress
   - Remaining work → break into steps
4. Continue with tracker from this point
```

### Work Tracker Diverged From Reality

**Solution:**
```markdown
1. Compare: git log vs. work tracker
2. Update tracker to match reality:
   - Completed work: Mark [x], add commit hash
   - Skipped steps: Mark [x] Skipped with reason
   - New work: Add steps with "ADDED during implementation"
3. Add change log to tracker:
   ## Changes
   - 2026-02-16: Updated tracker to match actual implementation
   - Skipped step 2, combined with step 1
   - Added steps 5-6 for error handling
```

### Steps Are Too Large, Mid-Implementation

**Solution:**
```markdown
1. Break current step into sub-steps
2. Mark sub-steps completed for work already done
3. Continue with remaining sub-steps

## Step 2: Implement rate limiting (BROKEN DOWN)

### Step 2a: Add rate_limit_tier field
- [x] Complete (commit abc123)

### Step 2b: Create RateLimiter class
- [~] In Progress

### Step 2c: Integrate with routes
- [ ] Pending

### Step 2d: Add tests
- [ ] Pending
```

---

Back to [Planning and Task Breakdown](../../../skills/define/planning-and-task-breakdown.md)
