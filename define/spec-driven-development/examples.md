# Examples: Spec-Driven Development

**Back to:** [[../spec-driven-development]]

---

## Example 1: API Rate Limiting Feature

### proposal.md (Excerpt)

```markdown
# Proposal: Add Rate Limiting to API

## Motivation

Currently, API has no rate limiting. This allows:
- Accidental DOS from misconfigured clients (saw 10k req/s from Partner X last week)
- Abuse from malicious actors
- Uneven resource distribution (one user can starve others)

Recent incidents:
- 2026-02-10: Partner X's misconfigured script took down API for 2 hours
- 2026-02-05: Detected suspicious traffic pattern, no way to throttle

Cost: $50k in SLA credits + customer trust.

## Scope

### In Scope
- Per-user rate limits: 100 req/min, 10k req/day
- Per-IP rate limits for unauthenticated: 10 req/min
- 429 responses with Retry-After header
- Redis-based distributed rate limiting (works across multiple servers)

### Out of Scope (Future Work)
- Custom rate limits per user tier (future: paid plans get higher limits)
- Rate limit dashboard/analytics (separate project)
- Geographic rate limiting (not needed yet)

### Explicitly NOT Doing
- Throttling (we return 429, don't slow down requests)
- CAPTCHA challenges (out of scope)
- IP blocking/banning (separate security feature)

## Impact

### Users
- **Breaking change:** Users exceeding limits will start seeing 429 errors
- **Migration:** Email top 10 API users 1 week before deployment
- **Benefit:** Improved reliability for all users

### Code
- New module: `src/middleware/rate_limiter.py`
- Modified: `src/routes/api.py` (add middleware to all routes)
- Modified: `src/models/user.py` (add rate_limit_tier field)
- Tests: `tests/test_rate_limiting.py`

### Dependencies
- **Add:** redis==5.0.1 (for distributed rate limiting)
  - Justification: In-memory doesn't work with multiple servers
  - Already using Redis for caching, no new infrastructure
- **Add:** redis-py-cluster==2.1.3 (for Redis cluster support)

## Alternatives Considered

### Alternative 1: In-memory rate limiting
- **Pros:** Simple, no new dependencies
- **Cons:** Doesn't work across multiple servers (we have 5)
- **Rejected because:** Must work in distributed environment

### Alternative 2: API Gateway (AWS, Cloudflare)
- **Pros:** Managed service, no code to maintain
- **Cons:** Additional cost ($500/mo), vendor lock-in, less control
- **Rejected because:** Want flexibility for custom rules, cost

### Alternative 3: Token bucket algorithm
- **Pros:** Allows burst traffic (smoother for users)
- **Cons:** More complex implementation, harder to reason about
- **Rejected because:** Fixed window is good enough for v1

## Decision

We chose **Redis-based fixed window rate limiting** because:
1. Works across distributed servers (required)
2. Leverages existing Redis infrastructure (low cost)
3. Simple to implement and reason about (maintainable)
4. Can be upgraded to token bucket later if needed
```

---

### tasks.md

```markdown
# Implementation Tasks: Add Rate Limiting

## Phase 1: Foundation (Estimated: 1 day)

**Goal:** Add infrastructure for rate limiting without enforcing limits yet

- [ ] Add Redis dependency to requirements.txt
- [ ] Create `src/middleware/rate_limiter.py` with RateLimiter class
- [ ] Implement `check_limit(user_id, limit)` method (returns allowed: bool)
- [ ] Add unit tests for RateLimiter class

**Verification:**
- Unit tests pass for within-limit and exceed-limit scenarios
- RateLimiter can connect to Redis (integration test)

## Phase 2: Model Updates (Estimated: 0.5 days)

**Goal:** Add rate_limit_tier field to User model

- [ ] Add `rate_limit_tier` field to User model (default: 'standard')
- [ ] Create database migration
- [ ] Test migration on local DB

**Verification:**
- Migration runs successfully
- Existing users get default 'standard' tier
- `pytest tests/test_user_model.py` passes

## Phase 3: Route Integration (Estimated: 1 day)

**Goal:** Integrate rate limiter with one endpoint as proof of concept

- [ ] Add rate limiting to `/api/health` endpoint
- [ ] Return 429 with Retry-After header when limit exceeded
- [ ] Add `X-RateLimit-*` headers to all responses
- [ ] Write integration test for rate limit behavior

**Verification:**
- `/api/health` returns 429 after 100 requests in 1 minute
- Headers present: `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`
- Integration test passes

## Phase 4: Full Rollout (Estimated: 1 day)

**Goal:** Apply rate limiting to all API endpoints

- [ ] Apply rate limiter middleware to all routes
- [ ] Add special handling for unauthenticated requests (IP-based)
- [ ] Add config for rate limits (environment variables)
- [ ] Write comprehensive integration tests

**Verification:**
- All endpoints rate limited
- Config works: can change limits without code changes
- Full test suite passes

## Phase 5: Documentation & Deployment (Estimated: 0.5 days)

- [ ] Update API documentation with rate limit headers
- [ ] Add ADR documenting Redis choice
- [ ] Update CHANGELOG
- [ ] Deploy to staging
- [ ] Load test on staging
- [ ] Deploy to production

**Verification:**
- Docs include rate limit behavior and headers
- Load test shows rate limiting works under high traffic
- Production deployment successful
```

---

### specs/api/spec.md (Excerpt)

```markdown
## ADDED Requirements

### Requirement: API Rate Limiting

**Context:** Protect API from abuse and ensure fair resource distribution.

#### Scenario: Authenticated user within limits
- **WHEN** authenticated user makes 50 requests in 1 minute
- **THEN** all requests succeed with 200/2xx status
- **AND** response includes `X-RateLimit-Limit: 100` header
- **AND** response includes `X-RateLimit-Remaining: 50` header
- **AND** response includes `X-RateLimit-Reset: [timestamp]` header

#### Scenario: Authenticated user exceeds per-minute limit
- **WHEN** authenticated user makes 101 requests in 1 minute
- **THEN** request 101 returns 429 Too Many Requests
- **AND** response includes `Retry-After: 45` header (seconds until reset)
- **AND** response body is JSON: `{"error": "Rate limit exceeded", "retry_after": 45}`
- **AND** response includes `X-RateLimit-Limit: 100` header
- **AND** response includes `X-RateLimit-Remaining: 0` header

#### Scenario: Authenticated user exceeds per-day limit
- **WHEN** authenticated user makes 10,001 requests in 24 hours
- **THEN** request 10,001 returns 429 Too Many Requests
- **AND** response includes error: "Daily rate limit exceeded"
- **AND** Retry-After header shows seconds until midnight UTC

#### Scenario: Unauthenticated request within limits
- **WHEN** IP address 1.2.3.4 makes 5 requests in 1 minute
- **THEN** all requests succeed
- **AND** response includes `X-RateLimit-Limit: 10` header
- **AND** response includes `X-RateLimit-Remaining: 5` header

#### Scenario: Unauthenticated request exceeds limit
- **WHEN** IP address 1.2.3.4 makes 11 requests in 1 minute
- **THEN** request 11 returns 429 Too Many Requests
- **AND** response includes `Retry-After: [seconds]` header

#### Scenario: Rate limit resets after window
- **WHEN** user exceeds limit at 10:00:00
- **AND** user waits until 10:01:00 (1 minute window)
- **THEN** next request succeeds (limit window reset)
- **AND** `X-RateLimit-Remaining` is reset to limit value

#### Scenario: Premium user has higher limits
- **WHEN** user with rate_limit_tier='premium' makes 150 requests in 1 minute
- **THEN** all requests succeed
- **AND** response includes `X-RateLimit-Limit: 200` header
- **AND** requests 201+ return 429 (premium limit is 200/min)

#### Scenario: Distributed rate limiting
- **WHEN** user makes 50 requests to server A
- **AND** user makes 51 requests to server B (different server)
- **THEN** request 101 (total across both servers) returns 429
- **AND** rate limit is enforced globally, not per-server
```

---

## Example 2: Bug Fix with Spec

**Bug:** Users can't login if email has uppercase letters (#567)

### specs/auth/spec.md (Modified)

```markdown
## MODIFIED Requirements

### Requirement: Email Authentication

**What Changed:** Email comparison is now case-insensitive

#### Scenario: Login with lowercase email
- **WHEN** user with email "john@example.com" logs in with "john@example.com"
- **THEN** authentication succeeds
- **AND** user receives authentication token

#### Scenario: Login with different case (NEW)
- **WHEN** user registered with email "john@example.com"
- **AND** user logs in with email "JOHN@EXAMPLE.COM" (uppercase)
- **THEN** authentication succeeds (case-insensitive comparison)
- **AND** user receives authentication token

#### Scenario: Registration normalizes email (NEW)
- **WHEN** user registers with email "JOHN@EXAMPLE.COM"
- **THEN** email is stored as "john@example.com" (normalized to lowercase)
- **AND** prevents duplicate accounts with different cases
```

**Note:** Even for bug fixes, updating the spec ensures the requirement is clear and tested.

---

## Example 3: Breaking Change Proposal

**Feature:** Migrate authentication from cookies to JWT tokens

### proposal.md (Excerpt)

```markdown
# Proposal: Migrate to JWT Authentication

## Motivation

Current cookie-based auth has issues:
- Can't authenticate mobile app (cookies don't work well in mobile)
- CSRF vulnerabilities require additional middleware
- Can't scale to multiple domains (cookie scope issues)

## Scope

### In Scope
- Replace session cookies with JWT tokens
- Update all API endpoints to accept `Authorization: Bearer <token>` header
- Maintain backwards compatibility for 3 months (support both methods)

### Migration Plan
1. **Month 1:** Deploy JWT support alongside cookies
2. **Month 2:** Email all API users about deprecation
3. **Month 3:** Remove cookie authentication

### Explicitly NOT Doing
- OAuth 2.0 (too complex for our needs)
- Refresh tokens (JWTs valid for 24 hours, user logs in daily)

## Impact

### Users (BREAKING CHANGE)
- **API users must update code** to send Authorization header
- **Web app users:** No change (automatically handled by frontend)
- **Migration guide:** Provided at `/docs/jwt-migration`

### Code
- New module: `src/auth/jwt.py`
- Modified: All route handlers (accept header OR cookie)
- Removed (after 3 months): `src/auth/sessions.py`

## Alternatives Considered

### Alternative 1: Keep cookies, add JWT for mobile only
- **Pros:** Less breaking change
- **Cons:** Maintain two auth systems forever
- **Rejected because:** Technical debt, complexity

### Alternative 2: Immediate cutover (no backwards compatibility)
- **Pros:** Clean break, simpler code
- **Cons:** Breaks existing integrations without warning
- **Rejected because:** Poor user experience, violates API contract

## Decision

Gradual migration with 3-month overlap period balances:
- Clean architecture (eventually)
- User-friendly migration (no surprise breakage)
```

**Key insight:** Breaking changes require extra attention to migration path and user impact.

---

Back to [[../spec-driven-development]]
