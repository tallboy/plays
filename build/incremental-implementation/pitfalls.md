# Common Pitfalls: Incremental Implementation

**Back to:** [[../incremental-implementation]]

---

## Pitfall 1: Working Ahead

**Symptom:** Implementing multiple steps before committing

**Example:**
```markdown
Work Tracker:
- Step 1: [x] Complete (but not committed yet)
- Step 2: [x] Complete (but not committed yet)
- Step 3: [~] In Progress
```

**Why it happens:**
- "I'm on a roll, don't want to break flow"
- "These steps are related, makes sense to do together"
- "Committing is tedious"

**Cost:**
- Can't pause safely (steps are entangled)
- If step 3 reveals step 1 was wrong, have to untangle
- Lose atomic commit benefits

**Fix:**
- Commit after EACH step, no exceptions
- Set a timer: if 90 min pass without commit, STOP and commit
- Think of commits like saving a game—do it frequently

**Prevention:**
```markdown
# Add to work tracker
⚠️ RULE: No step can be marked "In Progress" while any step is "Complete but uncommitted"
```

---

## Pitfall 2: Skipping Verification

**Symptom:** "Looks good" without running tests/checks

**Example:**
```bash
# Developer does:
git add .
git commit -m "Add feature"

# Should have done:
pytest && ruff check . && mypy src/  # THEN commit
```

**Why it happens:**
- "Tests take too long"
- "I know this works, I tested it manually"
- "CI will catch it"

**Cost:**
- CI fails after pushing (breaks main branch if merged)
- Teammates can't pull your branch (it's broken)
- "Works on my machine" syndrome

**Fix:**
- Make quality checks FAST (run only related tests during dev)
- Use git hooks to enforce (pre-commit hook runs checks)
- Full suite runs in CI, but basic checks run locally

**Pre-commit hook example:**
```bash
#!/bin/bash
# .git/hooks/pre-commit

echo "Running quality checks..."
ruff check --fix . || exit 1
pytest tests/test_*.py -x || exit 1  # -x stops on first failure
echo "✅ Checks passed, proceeding with commit"
```

---

## Pitfall 3: Batching Commits

**Symptom:** 5 steps complete, creating 1 commit at the end

**Example:**
```bash
# Anti-pattern
git add src/models/ src/routes/ src/middleware/ tests/
git commit -m "Add rate limiting feature (#456)"

# Correct
git add src/models/user.py tests/test_user_model.py
git commit -m "Add rate_limit_tier to User model (#456)"

# ... later, separate commit:
git add src/middleware/rate_limiter.py tests/test_rate_limiter.py
git commit -m "Create rate limiter middleware (#456)"
```

**Why it happens:**
- "Committing is overhead"
- "I'll do it all at once at the end"
- Forgot to commit earlier steps

**Cost:**
- Can't review which change caused a bug (git bisect useless)
- Can't cherry-pick one improvement without the rest
- PR reviewer sees 600 line diff, gives up

**Fix:**
- Use `/issue-step` command that auto-commits
- Add git alias: `git done` that commits with work tracker message
- Treat commit as part of "done definition" for each step

**Git alias:**
```bash
# ~/.gitconfig
[alias]
  done = "!f() { \
    git add -A && \
    git commit -m \"$1\" && \
    echo '✅ Step complete and committed'; \
  }; f"

# Usage:
git done "Add rate_limit_tier to User model (#456)"
```

---

## Pitfall 4: "While I'm Here" Refactoring

**Symptom:** Commit diff includes unrelated changes

**Example:**
```diff
# Task: Add rate limiting to /health endpoint

## File: src/routes/api.py
+ @rate_limit('10 per minute')
  def health():
-     return {'status': 'ok'}  # Fixed typo
+     return {'status': 'OK'}  # Fixed typo  ← UNRELATED

## File: src/models/user.py
- class User(Base):  # Refactored to use attrs  ← UNRELATED
+ @attrs.define
+ class User:
```

**Why it happens:**
- "Might as well fix this typo I noticed"
- "This file needs refactoring anyway"
- "Two birds, one stone"

**Cost:**
- Reviewer can't tell what's part of rate limiting vs. unrelated
- If rate limiting needs to be reverted, typo fix also reverts
- Commit message lies ("Add rate limiting" but also did other stuff)

**Fix:**
- Create `backlog.md` file to note improvements for later
- Separate commit for refactoring (before or after feature commit)
- Ask: "If I reverted this commit, would I lose something unrelated to the commit message?"

**Backlog pattern:**
```markdown
# backlog.md

## Code Quality Improvements (Do Later)
- [ ] Fix typo in health endpoint response
- [ ] Refactor User model to use attrs
- [ ] Add type hints to auth.py
```

---

## Pitfall 5: Abandoned Work Tracker

**Symptom:** Work tracker not updated, diverges from reality

**Example:**
```markdown
# Work Tracker says:
- Step 1: [x] Complete
- Step 2: [ ] Pending
- Step 3: [ ] Pending

# Reality (git log shows):
- Commit 1: Step 1
- Commit 2: Step 3 (skipped step 2)
- Commit 3: Added new step not in tracker
```

**Why it happens:**
- Requirements changed mid-implementation
- Discovered a necessary step not in original plan
- Forgot to update tracker after improvising

**Cost:**
- Can't resume work after interruption (tracker doesn't match reality)
- Can't report accurate progress
- Future developers don't understand decision rationale

**Fix:**
- Tracker is LIVING document (update in real-time)
- If you add a step: add it to tracker FIRST, then implement
- If you skip a step: mark it "[x] Skipped - Reason: [why]"

**Example of tracker evolution:**
```markdown
## Original Plan:

### Step 1: Add model field
- [x] Complete

### Step 2: Add API endpoint
- [x] Skipped - Reason: Realized we can use existing endpoint, just add parameter

### Step 3: Update frontend (ADDED during implementation)
- [~] In Progress - Discovered this was needed after testing backend

### Step 4: Add tests
- [ ] Pending
```

**Tracker with change log:**
```markdown
# Work Tracker: Add Rate Limiting

**Changes:**
- 2026-02-16 10:00: Initial plan created (4 steps)
- 2026-02-16 14:30: Skipped step 2, combined with step 1
- 2026-02-16 16:00: Added step 5 - discovered need for Redis config
```

---

## Meta-Pitfall: "I'll Be More Careful Next Time"

**Symptom:** Falling into same pitfall repeatedly

**Why it happens:**
- Relying on discipline instead of systems
- No automated enforcement
- Team doesn't review process, only code

**Fix:**

### Level 1: Awareness
- Read this document when pitfall occurs
- Note which pitfall in commit/PR

### Level 2: Checklist
- Print work tracker process
- Check off each step before proceeding

### Level 3: Automation
```bash
# Pre-commit hook that checks work tracker exists
if [ ! -f scratch/WORK_TRACKER.md ]; then
  echo "❌ No work tracker found. Create one before committing."
  exit 1
fi

# Check that you're not skipping steps
# (could parse tracker and verify steps are sequential)
```

### Level 4: Peer Accountability
- Pair programming (pair won't let you skip steps)
- Code review checks: "Are commits atomic?"
- Retros: "Did we follow incremental implementation this sprint?"

---

## Recovery: What If I've Already Violated?

### You Have Uncommitted Work Across Multiple Steps

**Solution:**
```bash
# Stash everything
git stash

# Pop stash
git stash pop

# Commit files for step 1 only
git add [files-from-step-1]
git commit -m "Step 1 message"

# Commit files for step 2
git add [files-from-step-2]
git commit -m "Step 2 message"

# Repeat for remaining steps
```

### You Have One Big Commit, Need to Split

**Solution:**
```bash
# Undo commit but keep changes
git reset HEAD~1

# Now commit in smaller pieces
git add [files-for-step-1]
git commit -m "Step 1 message"

git add [files-for-step-2]
git commit -m "Step 2 message"
```

### You Have Multiple Commits Pushed, PR is Too Big

**Solution:**
```bash
# Create smaller PRs from the same branch
# PR 1: Commits 1-3
# PR 2: Commits 4-6 (mark as depends on PR 1)

# Or: Create separate branches for each logical chunk
git checkout -b feature-part1 main
git cherry-pick [commit1] [commit2] [commit3]
gh pr create --title "Part 1: ..."

git checkout -b feature-part2 main
git cherry-pick [commit4] [commit5]
gh pr create --title "Part 2: ..." --base feature-part1
```

---

Back to [[../incremental-implementation]]
