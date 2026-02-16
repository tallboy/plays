# Examples: Incremental Implementation

**Back to:** [[../incremental-implementation]]

---

## Example 1: Simple 3-Step Feature

**Feature:** Add "remember me" checkbox to login form

### Work Tracker

```markdown
# Work Tracker: Add Remember Me Feature (#234)

## Step 1: Add remember_me field to login form
- **Status:** [ ] Pending
- **Files:** `src/components/LoginForm.tsx`
- **Verification:**
  - [ ] Checkbox renders below password field
  - [ ] Checkbox unchecked by default
  - [ ] Form submission includes remember_me: boolean
- **Commit:** `Add remember_me checkbox to login form (#234)`

## Step 2: Update auth API to handle remember_me
- **Status:** [ ] Pending
- **Files:** `src/routes/auth.py`, `tests/test_auth.py`
- **Verification:**
  - [ ] POST /login accepts remember_me parameter
  - [ ] If remember_me=true, token expires in 30 days
  - [ ] If remember_me=false, token expires in 1 day
  - [ ] Tests cover both scenarios
- **Commit:** `Handle remember_me in authentication endpoint (#234)`

## Step 3: Update documentation
- **Status:** [ ] Pending
- **Files:** `docs/api.md`, `CHANGELOG.md`
- **Verification:**
  - [ ] API docs mention remember_me parameter
  - [ ] CHANGELOG entry added
- **Commit:** `Document remember_me feature (#234)`
```

---

### Iteration 1: Step 1

**Execute:**
```bash
# 1. Mark in progress (edit work tracker)

# 2. Implement
# Edit src/components/LoginForm.tsx:
# <Checkbox name="remember_me" label="Remember me for 30 days" />

# 3. Verify
npm run dev  # Visual check
npm test src/components/LoginForm.test.tsx  # ✅ Pass

# 4. Quality checks
npm run lint  # ✅ Pass
npm run type-check  # ✅ Pass

# 5. Commit
git add src/components/LoginForm.tsx
git commit -m "Add remember_me checkbox to login form (#234)"

# 6. Mark complete in tracker
```

**Git log after step 1:**
```
c8e5f2b Add remember_me checkbox to login form (#234)
```

---

### Iteration 2: Step 2

**Execute:**
```bash
# 1. Mark in progress

# 2. Implement
# Edit src/routes/auth.py:
```python
remember_me = request.json.get('remember_me', False)
expiry = timedelta(days=30 if remember_me else 1)
token = create_token(user.id, expiry=expiry)
```

# 3. Add tests in test_auth.py
# 4. Verify
pytest tests/test_auth.py -v  # ✅ 2 new tests pass

# 5. Quality checks
ruff check --fix .  # ✅ Pass
mypy src/  # ✅ Pass
pytest  # ✅ All pass

# 6. Commit
git add src/routes/auth.py tests/test_auth.py
git commit -m "Handle remember_me in authentication endpoint (#234)"

# 7. Mark complete
```

**Git log after step 2:**
```
b2d4c1a Handle remember_me in authentication endpoint (#234)
c8e5f2b Add remember_me checkbox to login form (#234)
```

---

### Iteration 3: Step 3

**Execute:**
```bash
# 1. Mark in progress

# 2. Update docs/api.md
# 3. Add to CHANGELOG.md:
#   ### Added
#   - Login form includes "Remember me" option for extended sessions

# 4. Verify (docs don't need tests, just review)

# 5. Commit
git add docs/api.md CHANGELOG.md
git commit -m "Document remember_me feature (#234)"

# 6. Mark complete
```

**Final git log:**
```
a7f3e9c Document remember_me feature (#234)
b2d4c1a Handle remember_me in authentication endpoint (#234)
c8e5f2b Add remember_me checkbox to login form (#234)
```

**Result:** Beautiful, reviewable, atomic commits! Each tells a clear story. 🎉

---

## Example 2: Bug Fix with Reproduction Test

**Bug:** Users can't login if email has uppercase letters

### Work Tracker

```markdown
# Work Tracker: Fix Case-Sensitive Email Login (#567)

## Step 1: Write failing test reproducing bug
- **Status:** [ ] Pending
- **Files:** `tests/test_auth.py`
- **Verification:**
  - [ ] Test creates user with lowercase email
  - [ ] Test attempts login with uppercase email
  - [ ] Test FAILS (demonstrates bug exists)
- **Commit:** `Add failing test for case-sensitive email bug (#567)`

## Step 2: Fix email normalization in auth
- **Status:** [ ] Pending
- **Files:** `src/routes/auth.py`
- **Verification:**
  - [ ] Emails converted to lowercase before lookup
  - [ ] Test from step 1 now PASSES
  - [ ] All other auth tests still pass
- **Commit:** `Normalize email to lowercase in authentication (#567)`

## Step 3: Add email normalization to registration
- **Status:** [ ] Pending
- **Files:** `src/routes/register.py`, `tests/test_register.py`
- **Verification:**
  - [ ] Registration also normalizes email
  - [ ] Prevents duplicate users with different cases
  - [ ] Tests cover edge cases
- **Commit:** `Normalize email on registration to prevent duplicates (#567)`
```

---

### Step 1: Red (Failing Test)

```python
# tests/test_auth.py
def test_login_case_insensitive_email():
    """Bug #567: Login should work regardless of email case"""
    # Create user with lowercase email
    user = User.create(email='john@example.com', password='secret')

    # Attempt login with uppercase email
    response = client.post('/login', json={
        'email': 'JOHN@EXAMPLE.COM',  # Different case
        'password': 'secret'
    })

    # Should succeed, but currently fails
    assert response.status_code == 200  # ❌ FAILS (gets 401)
```

```bash
pytest tests/test_auth.py::test_login_case_insensitive_email
# ❌ FAILED - Expected 200, got 401

git add tests/test_auth.py
git commit -m "Add failing test for case-sensitive email bug (#567)"
```

---

### Step 2: Green (Fix the Bug)

```python
# src/routes/auth.py
def login():
    email = request.json.get('email').lower()  # ← FIX
    user = User.query.filter_by(email=email).first()
    # ... rest of logic
```

```bash
pytest tests/test_auth.py::test_login_case_insensitive_email
# ✅ PASSED

pytest  # Run full suite
# ✅ All tests pass

git add src/routes/auth.py
git commit -m "Normalize email to lowercase in authentication (#567)"
```

---

### Step 3: Prevent Future Issues

```python
# src/routes/register.py
def register():
    email = request.json.get('email').lower()  # ← NORMALIZE HERE TOO
    # ... create user
```

```bash
# Add test for registration normalization
# Run tests
pytest

git add src/routes/register.py tests/test_register.py
git commit -m "Normalize email on registration to prevent duplicates (#567)"
```

**Final git log:**
```
f3a9b7c Normalize email on registration to prevent duplicates (#567)
e2c8d4a Normalize email to lowercase in authentication (#567)
d1b5c3a Add failing test for case-sensitive email bug (#567)
```

**Benefits:**
- Commit 1 shows the bug existed (test fails)
- Commit 2 shows the fix (test passes)
- Commit 3 shows prevention (can't happen again)
- If we need to revert the fix, we have clear history

---

## Example 3: Large Refactor (10 steps)

**Refactor:** Migrate from raw SQL to SQLAlchemy ORM

### Condensed Work Tracker

```markdown
# Work Tracker: Migrate to SQLAlchemy ORM (#789)

## Phase 1: Setup (Steps 1-2)
1. Install SQLAlchemy, create base config
2. Create User model in ORM (parallel with legacy)

## Phase 2: Migrate Modules (Steps 3-7)
3. Migrate auth module to ORM User
4. Migrate profile module to ORM User
5. Migrate admin module to ORM User
6. Create Post model, migrate posts module
7. Create Comment model, migrate comments module

## Phase 3: Cleanup (Steps 8-10)
8. Remove legacy User model
9. Remove legacy Post/Comment models
10. Remove raw SQL query utilities
```

### Key Incremental Decisions

**Why not migrate all models at once?**
- One model at a time = smaller commits
- If User model migration breaks something, Posts are still working
- Can deploy after each phase (feature flags protect incomplete work)

**Execution pattern:**
```bash
# After EACH step:
pytest  # Full test suite
git commit -m "[step message]"

# Every 2-3 steps:
git push  # Share progress
gh pr create --draft  # Get early feedback
```

**Final result:**
- 10 commits, each < 200 lines
- Can git bisect if bug introduced
- Can cherry-pick ORM improvements to other projects
- Reviewers review 2-3 commits at a time (not all 10 at once)

---

## Example 4: Parallel Work Streams

**Feature:** Payment processing (2 developers)

### Work Tracker A: Backend (Developer 1)

```markdown
## Stream A: Backend API
A1. Add payment models (Charge, PaymentMethod)
A2. Create Stripe integration service
A3. Add POST /payments endpoint
A4. Add GET /payments/:id endpoint
A5. Add webhook handler for Stripe events
```

### Work Tracker B: Frontend (Developer 2)

```markdown
## Stream B: Frontend UI
B1. Create PaymentForm component
B2. Add payment method selection UI
B3. Integrate with POST /payments API
B4. Add payment status polling
B5. Add success/error UI
```

### Coordination Strategy

**Each developer:**
- Commits after EACH step
- Pushes every 2-3 commits
- Coordinates at integration points

**Integration points:**
```markdown
## Integration Step (Both Developers)
I1. Merge both streams
I2. Resolve any conflicts
I3. Full E2E test of payment flow
I4. Deploy to staging
```

**Git history:**
```
[Dev 2] B5. Add success/error UI
[Dev 1] A5. Add webhook handler
[Dev 2] B4. Add payment status polling
[Dev 1] A4. Add GET /payments/:id endpoint
[Dev 2] B3. Integrate with API
[Dev 1] A3. Add POST /payments endpoint
[Dev 2] B2. Add payment selection UI
[Dev 1] A2. Create Stripe service
[Dev 2] B1. Create PaymentForm
[Dev 1] A1. Add payment models
```

**Benefits:**
- Parallel work without blocking
- Clear handoff points (A3 must be done before B3)
- If one stream breaks, other keeps working
- Can demo partial feature (backend done, frontend in progress)

---

Back to [[../incremental-implementation]]
