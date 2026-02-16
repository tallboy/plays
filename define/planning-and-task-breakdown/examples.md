# Examples: Planning and Task Breakdown

**Back to:** [[../planning-and-task-breakdown]]

---

## Example 1: Simple Feature (5 steps)

**Feature:** Add "last login" timestamp to user profile (#123)

```markdown
# Work Tracker: Add Last Login Timestamp

**Issue:** #123
**Branch:** issue-123
**Started:** 2026-02-16

---

## Step 1: Add last_login field to User model

- **Status:** [ ] Pending
- **Complexity:** Low
- **Verification:**
  - [ ] User model has last_login field (DateTime, nullable)
  - [ ] Database migration created: `migrations/003_add_last_login.py`
  - [ ] Migration runs successfully: `python manage.py migrate`
  - [ ] Tests pass: `pytest tests/test_user_model.py`
- **Files:**
  - `src/models/user.py`
  - `migrations/003_add_last_login.py`
  - `tests/test_user_model.py`
- **Commit:** `Add last_login timestamp to User model (#123)`

---

## Step 2: Update login endpoint to set last_login

- **Status:** [ ] Pending
- **Complexity:** Low
- **Verification:**
  - [ ] On successful login, last_login is set to current UTC time
  - [ ] Failed login does NOT update last_login
  - [ ] Tests pass: `pytest tests/test_auth.py::test_login_updates_timestamp`
- **Files:**
  - `src/routes/auth.py`
  - `tests/test_auth.py`
- **Commit:** `Set last_login timestamp on successful authentication (#123)`

---

## Step 3: Display last_login in profile API

- **Status:** [ ] Pending
- **Complexity:** Low
- **Verification:**
  - [ ] GET /profile returns last_login in ISO 8601 format
  - [ ] last_login is null for users who haven't logged in yet
  - [ ] Tests pass: `pytest tests/test_profile.py::test_profile_includes_last_login`
- **Files:**
  - `src/routes/profile.py`
  - `src/serializers/user.py`
  - `tests/test_profile.py`
- **Commit:** `Include last_login in profile API response (#123)`

---

## Step 4: Add tests for last_login behavior

- **Status:** [ ] Pending
- **Complexity:** Low
- **Verification:**
  - [ ] Test: login updates timestamp
  - [ ] Test: failed login doesn't update timestamp
  - [ ] Test: profile returns timestamp
  - [ ] Test: new user has null last_login
  - [ ] Full test suite passes: `pytest`
- **Files:**
  - `tests/test_auth.py`
  - `tests/test_profile.py`
- **Commit:** `Add comprehensive tests for last_login functionality (#123)`

---

## Step 5: Update API documentation

- **Status:** [ ] Pending
- **Complexity:** Low
- **Verification:**
  - [ ] Profile endpoint docs show last_login field
  - [ ] Field type documented: ISO 8601 datetime string
  - [ ] Nullable behavior documented
- **Files:**
  - `docs/api.md`
  - `CHANGELOG.md`
- **Commit:** `Document last_login field in API docs (#123)`
```

---

## Example 2: Medium Complexity (8 steps)

**Feature:** Add API rate limiting (#456)

```markdown
# Work Tracker: Add API Rate Limiting

**Issue:** #456
**Branch:** feature/rate-limiting
**Started:** 2026-02-16
**Estimated Duration:** 3 days

---

## Step 1: Add rate_limit_tier field to User model

- **Status:** [ ] Pending
- **Complexity:** Low (1 hour)
- **Verification:**
  - [ ] Field exists with values: 'standard', 'premium', 'enterprise'
  - [ ] Default is 'standard'
  - [ ] Migration tested on local DB
  - [ ] `pytest tests/test_user_model.py` passes
- **Files:**
  - `src/models/user.py`
  - `migrations/002_add_rate_limit_tier.py`
  - `tests/test_user_model.py`
- **Commit:** `Add rate_limit_tier field to User model (#456)`

---

## Step 2: Create RateLimiter class (in-memory)

- **Status:** [ ] Pending
- **Complexity:** Medium (2-3 hours)
- **Verification:**
  - [ ] RateLimiter.check_limit(user_id, limit) returns (allowed: bool, remaining: int)
  - [ ] In-memory counter tracks requests per user
  - [ ] Counter resets after 1 minute window
  - [ ] Unit tests pass: `pytest tests/test_rate_limiter.py -v`
- **Files:**
  - `src/middleware/rate_limiter.py` (NEW)
  - `tests/test_rate_limiter.py` (NEW)
- **Commit:** `Create rate limiter middleware with in-memory tracking (#456)`

---

## Step 3: Integrate with /health endpoint

- **Status:** [ ] Pending
- **Complexity:** Medium (2 hours)
- **Verification:**
  - [ ] /health endpoint rate limited to 100 req/min
  - [ ] Returns 429 when limit exceeded
  - [ ] Response includes X-RateLimit-* headers
  - [ ] Integration test passes
- **Files:**
  - `src/routes/api.py`
  - `tests/test_api_integration.py`
- **Commit:** `Integrate rate limiter with /health endpoint (#456)`

---

## Step 4: Add error handling and logging

- **Status:** [ ] Pending
- **Complexity:** Low (1 hour)
- **Verification:**
  - [ ] 429 response includes Retry-After header
  - [ ] Error response includes clear JSON message
  - [ ] Rate limit violations logged
  - [ ] Tests cover error cases
- **Files:**
  - `src/middleware/rate_limiter.py`
  - `tests/test_rate_limiter.py`
- **Commit:** `Add error handling and logging to rate limiter (#456)`

---

## Step 5: Extend to all API endpoints

- **Status:** [ ] Pending
- **Complexity:** Medium (2 hours)
- **Verification:**
  - [ ] All /api/* routes rate limited
  - [ ] Each endpoint has appropriate limit based on tier
  - [ ] Integration tests pass for multiple endpoints
  - [ ] Full test suite passes
- **Files:**
  - `src/routes/api.py`
  - `tests/test_api_integration.py`
- **Commit:** `Apply rate limiting to all API endpoints (#456)`

---

## Step 6: Add Redis for distributed limiting

- **Status:** [ ] Pending
- **Complexity:** High (3-4 hours)
- **Verification:**
  - [ ] Redis dependency added to requirements.txt
  - [ ] RateLimiter uses Redis instead of in-memory
  - [ ] Rate limits work across multiple server instances
  - [ ] Redis connection tested (integration test)
  - [ ] Graceful fallback if Redis unavailable
- **Files:**
  - `requirements.txt`
  - `src/middleware/rate_limiter.py`
  - `src/config.py`
  - `tests/test_rate_limiter_redis.py`
- **Commit:** `Migrate rate limiter to Redis for distributed support (#456)`

---

## Step 7: Add configuration options

- **Status:** [ ] Pending
- **Complexity:** Low (1 hour)
- **Verification:**
  - [ ] Rate limits configurable via environment variables
  - [ ] Different limits per tier: standard=100, premium=200, enterprise=500
  - [ ] Config documented in .env.example
  - [ ] Tests use test config
- **Files:**
  - `src/config.py`
  - `.env.example`
  - `tests/conftest.py`
- **Commit:** `Add configuration for rate limit tiers (#456)`

---

## Step 8: Documentation and deployment

- **Status:** [ ] Pending
- **Complexity:** Low (1 hour)
- **Verification:**
  - [ ] API docs updated with rate limit headers
  - [ ] ADR created: docs/adr/003-rate-limiting-redis.md
  - [ ] CHANGELOG updated
  - [ ] README updated with Redis requirement
- **Files:**
  - `docs/api.md`
  - `docs/adr/003-rate-limiting-redis.md`
  - `CHANGELOG.md`
  - `README.md`
- **Commit:** `Document rate limiting feature and Redis architecture decision (#456)`
```

---

## Example 3: Complex Refactor (10 steps, phased)

**Feature:** Migrate database layer to SQLAlchemy ORM (#789)

```markdown
# Work Tracker: Migrate to SQLAlchemy ORM

**Issue:** #789
**Branch:** refactor/sqlalchemy-orm
**Started:** 2026-02-16
**Estimated Duration:** 2 weeks

---

## Phase 1: Setup (Steps 1-2)

### Step 1: Install SQLAlchemy and create base config

- **Status:** [ ] Pending
- **Complexity:** Low
- **Verification:**
  - [ ] SQLAlchemy 2.0.25 in requirements.txt
  - [ ] Base class created: src/db/base.py
  - [ ] Session factory works: src/db/session.py
  - [ ] Tests pass: pytest tests/test_db_setup.py
- **Files:**
  - `requirements.txt`
  - `src/db/base.py` (NEW)
  - `src/db/session.py` (NEW)
  - `tests/test_db_setup.py` (NEW)
- **Commit:** `Add SQLAlchemy configuration and base classes (#789)`

---

### Step 2: Create User model in SQLAlchemy (parallel with legacy)

- **Status:** [ ] Pending
- **Complexity:** Medium
- **Verification:**
  - [ ] ORM model mirrors legacy User model
  - [ ] Can read/write database using ORM
  - [ ] Tests pass: pytest tests/test_user_orm.py
  - [ ] Legacy model still works (parallel deployment)
- **Files:**
  - `src/models/user_orm.py` (NEW)
  - `tests/test_user_orm.py` (NEW)
- **Commit:** `Create SQLAlchemy User model alongside legacy (#789)`

---

## Phase 2: Migrate Modules (Steps 3-7)

### Step 3: Migrate auth module to use ORM User

- **Status:** [ ] Pending
- **Complexity:** Medium
- **Verification:**
  - [ ] Login/logout work with ORM
  - [ ] Password hashing works
  - [ ] All auth tests pass
  - [ ] No references to legacy User in auth module
- **Files:**
  - `src/routes/auth.py`
  - `tests/test_auth.py`
- **Commit:** `Migrate authentication to SQLAlchemy ORM (#789)`

---

### Step 4: Migrate profile module to ORM User

- **Status:** [ ] Pending
- **Complexity:** Low
- **Verification:**
  - [ ] GET /profile works with ORM
  - [ ] Profile updates work
  - [ ] Tests pass: pytest tests/test_profile.py
- **Files:**
  - `src/routes/profile.py`
  - `tests/test_profile.py`
- **Commit:** `Migrate profile module to SQLAlchemy ORM (#789)`

---

### Step 5: Migrate admin module to ORM User

- **Status:** [ ] Pending
- **Complexity:** Medium
- **Verification:**
  - [ ] Admin user listing works
  - [ ] User CRUD operations work
  - [ ] Tests pass: pytest tests/test_admin.py
- **Files:**
  - `src/routes/admin.py`
  - `tests/test_admin.py`
- **Commit:** `Migrate admin module to SQLAlchemy ORM (#789)`

---

### Step 6: Create Post model, migrate posts module

- **Status:** [ ] Pending
- **Complexity:** High
- **Verification:**
  - [ ] Post ORM model created
  - [ ] Relationship with User works (ForeignKey)
  - [ ] All post routes work
  - [ ] Tests pass: pytest tests/test_posts.py
- **Files:**
  - `src/models/post_orm.py` (NEW)
  - `src/routes/posts.py`
  - `tests/test_posts.py`
- **Commit:** `Create Post ORM model and migrate posts module (#789)`

---

### Step 7: Create Comment model, migrate comments module

- **Status:** [ ] Pending
- **Complexity:** High
- **Verification:**
  - [ ] Comment ORM model created
  - [ ] Relationships work: Comment -> Post -> User
  - [ ] All comment routes work
  - [ ] Tests pass: pytest tests/test_comments.py
- **Files:**
  - `src/models/comment_orm.py` (NEW)
  - `src/routes/comments.py`
  - `tests/test_comments.py`
- **Commit:** `Create Comment ORM model and migrate comments module (#789)`

---

## Phase 3: Cleanup (Steps 8-10)

### Step 8: Remove legacy User model

- **Status:** [ ] Pending
- **Complexity:** Low
- **Verification:**
  - [ ] No imports of user_legacy.py remain
  - [ ] File deleted: src/models/user_legacy.py
  - [ ] All tests pass: pytest
- **Files:**
  - Remove `src/models/user_legacy.py`
- **Commit:** `Remove legacy User model after ORM migration (#789)`

---

### Step 9: Remove legacy Post/Comment models

- **Status:** [ ] Pending
- **Complexity:** Low
- **Verification:**
  - [ ] Legacy models deleted
  - [ ] All tests pass
  - [ ] No legacy model imports remain
- **Files:**
  - Remove `src/models/post_legacy.py`
  - Remove `src/models/comment_legacy.py`
- **Commit:** `Remove legacy Post and Comment models (#789)`

---

### Step 10: Remove raw SQL query utilities

- **Status:** [ ] Pending
- **Complexity:** Low
- **Verification:**
  - [ ] Raw SQL helper removed: src/db/raw_queries.py
  - [ ] All queries use ORM
  - [ ] Full test suite passes
  - [ ] Code coverage maintained
- **Files:**
  - Remove `src/db/raw_queries.py`
  - Update `tests/conftest.py`
- **Commit:** `Remove raw SQL utilities after ORM migration complete (#789)`
```

---

Back to [[../planning-and-task-breakdown]]
