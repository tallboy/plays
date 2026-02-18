# Advanced: Incremental Implementation

**Back to:** [Incremental Implementation](../../../skills/build/incremental-implementation.md)

---

## Pattern 1: Feature Flags for Long-Running Work

### Problem
Feature takes 2 weeks to complete. Don't want a long-lived branch (merge conflicts), but also can't ship incomplete feature to users.

### Solution
Use feature flags to merge incomplete work safely:

```python
# Step 1: Add flag-protected code (Day 1)
from feature_flags import is_enabled

if is_enabled('payment_processing'):
    # New code path
    process_payment_with_stripe(amount)
else:
    # Old code path (fallback)
    process_payment_legacy(amount)
```

```bash
git commit -m "Add payment processing behind feature flag (#123)"
```

### Benefits
- ✅ Merge to main daily (no long-lived branches)
- ✅ Code tested in CI even if not user-facing
- ✅ Enable for internal testing in staging
- ✅ Gradual rollout (5% users → 50% → 100%)

### Cleanup
```python
# Step 10: Remove flag when complete (Day 14)
process_payment_with_stripe(amount)  # Flag removed, new path is default
```

```bash
git commit -m "Remove payment_processing feature flag, rollout complete (#123)"
```

---

## Pattern 2: Stacked Commits for Related Changes

### Problem
Large feature has dependencies, but you want atomic commits.

### Solution
Stack commits where each builds on previous:

```bash
# Commit 1: Foundation
git commit -m "Add Payment model and database schema"

# Commit 2: Builds on commit 1
git commit -m "Add Stripe integration service using Payment model"

# Commit 3: Builds on commit 2
git commit -m "Add API endpoint that calls Stripe service"

# Commit 4: Builds on commit 3
git commit -m "Add frontend integration with API endpoint"
```

**PR description explains stack:**
```markdown
## Stacked Commits

Each commit is independently reviewable:

1. **Payment model** - Review database schema
2. **Stripe service** - Review integration logic
3. **API endpoint** - Review endpoint implementation
4. **Frontend** - Review UI integration

✅ Review commit-by-commit for context
❌ Don't review final diff (too large)
```

---

## Pattern 3: Checkpoint Commits

### Problem
Experimenting with an approach, not sure if it'll work.

### Solution
Create checkpoint commits you can revert to:

```bash
# Before experimenting
git commit -m "WIP: Checkpoint before trying Redis approach"
git tag checkpoint-before-redis

# Try approach
# ... make changes ...

# If it works:
git commit -m "Implement caching with Redis"

# If it doesn't work:
git reset --hard checkpoint-before-redis
git tag -d checkpoint-before-redis
# Try different approach
```

**Better than stashing:**
- Stash is unnamed (hard to remember what it was)
- Can create multiple checkpoints
- Can share checkpoint tag with team

---

## Pattern 4: Refactor-Then-Feature

### Problem
Can't implement feature cleanly without refactoring existing code first.

### Solution
Separate refactor from feature implementation:

```markdown
## Step 1: Refactor existing code (no behavior change)
- Extract payment logic into service class
- Add tests for existing behavior
- Commit: "Refactor payment logic into PaymentService (no behavior change)"

## Step 2: Add new feature to refactored code
- Add new method to PaymentService
- Implement feature
- Commit: "Add subscription payment support to PaymentService"
```

**Why separate:**
- Refactor commit has no behavior change (easier to review)
- Feature commit shows what's new (clear diff)
- If feature needs reverting, refactor stays

**Commit messages:**
```bash
git commit -m "Refactor: Extract payment logic into PaymentService (no-op)"
git commit -m "Feature: Add subscription payments to PaymentService (#456)"
```

---

## Pattern 5: Test-Driven Commits

### Problem
Complex feature, want confidence each commit is correct.

### Solution
Each commit includes both code AND tests:

```bash
# Commit 1: Model + Tests
git add src/models/subscription.py tests/test_subscription_model.py
git commit -m "Add Subscription model with validation tests"

# Commit 2: Service + Tests
git add src/services/billing.py tests/test_billing_service.py
git commit -m "Add BillingService with unit tests"

# Commit 3: Endpoint + Tests
git add src/routes/billing.py tests/test_billing_api.py
git commit -m "Add billing API endpoints with integration tests"
```

**Rule:** Never commit code without corresponding test in same commit.

**Exception:** Refactor-only commits might not add new tests (but existing tests must still pass).

---

## Pattern 6: Semantic Commit Prefixes

### Problem
Hard to scan git history to understand what changed.

### Solution
Use conventional commit prefixes:

```bash
git commit -m "feat: Add payment processing (#123)"
git commit -m "fix: Handle null user in auth (#124)"
git commit -m "refactor: Extract validation into helper (#125)"
git commit -m "test: Add edge cases for payment flow (#126)"
git commit -m "docs: Document payment API endpoints (#127)"
git commit -m "chore: Update dependencies (#128)"
```

**Benefits:**
- Quick scan: `git log --oneline --grep="^feat:"`
- Auto-generate CHANGELOG grouped by type
- Enforce with commit hooks

**Pre-commit hook:**
```bash
#!/bin/bash
commit_msg=$(cat $1)
pattern="^(feat|fix|docs|refactor|test|chore|perf|style):"

if ! echo "$commit_msg" | grep -qE "$pattern"; then
  echo "❌ Commit message must start with: feat|fix|docs|refactor|test|chore|perf|style"
  echo "Example: feat: Add payment processing"
  exit 1
fi
```

---

## Pattern 7: Bisect-Friendly Commits

### Problem
Bug introduced sometime in last 50 commits. Need to find which commit.

### Solution
Ensure every commit passes tests (enables git bisect):

```bash
# Start bisect
git bisect start
git bisect bad HEAD  # Current commit has bug
git bisect good a3f5b2c  # This old commit was fine

# Git checks out middle commit
# You test: Does bug exist?
pytest tests/test_feature.py

# If bug exists:
git bisect bad

# If bug doesn't exist:
git bisect good

# Repeat until git identifies exact commit
```

**Critical rule for bisect to work:**
- Every commit must pass tests
- Never commit broken code "will fix in next commit"

**If you violate this:**
```bash
# Mark broken commit as skip
git bisect skip
```

But better to never have broken commits!

---

## Pattern 8: Squash vs. Preserve

### When to Squash Commits

**Before merging PR:**
```bash
# If work tracker had 10 micro-commits like:
# - "Add field"
# - "Fix typo"
# - "Fix tests"
# - "Actually fix tests"
# - "Rename variable"

# Squash into logical commits:
git rebase -i main
# Mark commits as "squash" to combine

# Result:
# - "Add payment processing feature (#123)"
```

**Squash when:**
- Commits are WIP/experimental
- Too granular for long-term history
- Fixup commits (oops, forgot to add file)

### When to Preserve Commits

**Keep atomic commits if:**
- Each tells a clear story
- Each is independently revertible
- Each passes all tests

**Example of GOOD commits to preserve:**
```
feat: Add Payment model and schema
feat: Add Stripe integration service
feat: Add billing API endpoints
test: Add E2E payment flow tests
docs: Document payment API
```

These should NOT be squashed—each is valuable history.

---

## Pattern 9: Draft PRs for In-Progress Work

### Problem
Want feedback on approach before finishing all steps.

### Solution
Create draft PR after first few commits:

```bash
# After completing steps 1-3 of 10:
git push origin feature-branch

gh pr create --draft \
  --title "[WIP] Add payment processing" \
  --body "
## Status
✅ Steps 1-3 complete (models, service, basic endpoint)
🚧 Steps 4-10 in progress

## Questions
1. Is Stripe the right integration?
2. Should we support multiple payment methods?

**Ready for:** Architecture review
**Not ready for:** Final code review (incomplete)
"
```

**Benefits:**
- Get early feedback on approach
- Teammates see what you're working on
- CI runs on every push (catch issues early)
- Convert to real PR when ready

---

## Pattern 10: Commit-Per-File for Large Migrations

### Problem
Migrating 20 files from old pattern to new pattern.

### Solution
One commit per file (or small group):

```bash
git add src/routes/users.py
git commit -m "Migrate users route to new auth pattern"

git add src/routes/posts.py
git commit -m "Migrate posts route to new auth pattern"

git add src/routes/comments.py
git commit -m "Migrate comments route to new auth pattern"

# ... 17 more commits
```

**Why:**
- If migration breaks one file, easy to identify
- Can pause migration, deploy partial progress
- Can cherry-pick successful migrations to other branches

**Automation:**
```bash
#!/bin/bash
# migrate-all.sh

for file in src/routes/*.py; do
  # Apply migration to file
  sed -i 's/old_pattern/new_pattern/g' "$file"

  # Test
  pytest "tests/test_$(basename $file)"

  # Commit if tests pass
  if [ $? -eq 0 ]; then
    git add "$file"
    git commit -m "Migrate $(basename $file) to new auth pattern"
  else
    echo "⚠️  Tests failed for $file, skipping"
    git checkout "$file"  # Revert
  fi
done
```

---

Back to [Incremental Implementation](../../../skills/build/incremental-implementation.md)
