# Examples: Context Engineering

## Example 1: Minimal AGENTS.md for Solo Project

**Use Case:** Personal side project, want AI to follow basic conventions

```markdown
# AI Guidelines

**Last Updated:** 2026-02-16

## Tech Stack
- Python 3.11, FastAPI, PostgreSQL
- Testing: pytest
- Deploy: Docker

## Conventions
- Files: `snake_case.py`
- Functions: `snake_case`
- Classes: `PascalCase`
- Type hints required on all functions
- Tests in `tests/` mirror `src/` structure

## Before Every Commit
```bash
pytest && mypy src/ && ruff check .
```

## Never
- Don't commit secrets
- Don't use `any` type
- Don't skip tests
```

**Why This Works:** Captures essentials in 5 minutes. Can expand later as project grows.

---

## Example 2: Team Project with Domain Knowledge

**Use Case:** E-commerce platform with multiple developers and critical business rules

```markdown
# AI Development Guidelines

**Last Updated:** 2026-02-16
**Project:** E-commerce Platform

## Project Overview

### What This Project Does
Multi-vendor e-commerce platform for artisan goods. Handles inventory, orders, payments, and shipping across 1000+ vendors.

### Tech Stack
- **Backend:** Python 3.11, FastAPI, PostgreSQL 15
- **Frontend:** React 18, TypeScript 5, Vite
- **Testing:** pytest (backend), Vitest (frontend)
- **Deployment:** Docker on AWS ECS

---

## Domain Knowledge

### Inventory Management
- Products have variants (size, color)
- Inventory tracked per variant (not product-level)
- Stock updates use optimistic locking to prevent overselling
- Negative inventory allowed for pre-orders

### Order Fulfillment
- Order states: `pending → paid → shipped → delivered`
- State transitions are immutable (create new state record, don't update)
- Cancellations after "shipped" require RMA process

### Critical Business Rules
- **Prices:** Stored in cents (integer), never float
- **Tax:** Calculated at checkout, not stored on product
- **Discounts:** Apply before tax
- **Free shipping:** Orders $50 USD or more

---

## Code Conventions

### File Structure
```
src/
├── models/          # Database models (SQLAlchemy)
├── routes/          # API endpoints (FastAPI routers)
├── services/        # Business logic
└── utils/           # Shared utilities

tests/
├── unit/            # Fast, isolated
├── integration/     # Database, external services
└── e2e/             # Full user flows
```

### Naming
- Files: `snake_case.py` (Python), `kebab-case.ts` (TypeScript)
- Functions/Variables: `snake_case` (Python), `camelCase` (TypeScript)
- Classes: `PascalCase`
- Constants: `SCREAMING_SNAKE_CASE`

---

## Quality Standards

### Before Every Commit
```bash
# Backend
ruff check --fix .
mypy src/
pytest

# Frontend
npm run lint
npm run type-check
npm test
```

### Test Coverage
- New code: 80% minimum
- Critical paths (auth, payments): 100%
- Utils: 90%

---

## AI Assistant Constraints

### Always
- ✅ Run full test suite before committing
- ✅ Use type hints (Python) or TypeScript types
- ✅ Handle errors with user-friendly messages
- ✅ Update docs when changing public APIs

### Never
- ❌ Commit failing tests
- ❌ Use `any` type without justification
- ❌ Hard-code secrets (use env vars)
- ❌ Skip type checking

### Preferences
- Use SQLAlchemy ORM over raw SQL
- Prefer functional React components over class components
- Use async/await over callbacks
- Validate input at API boundary
- Log errors with context (user_id, request_id)

---

## Common Tasks

### Run Full Test Suite
```bash
pytest tests/ -v --cov=src --cov-report=html
```

### Database Migrations
```bash
# Create
alembic revision --autogenerate -m "Add user_preferences"

# Apply
alembic upgrade head

# Rollback
alembic downgrade -1
```

---

## Changelog

### 2026-02-16
- Initial AGENTS.md creation
- Added inventory and order domain knowledge
- Documented pricing and tax rules
```

**Why This Works:** Team-wide consistency. New developers learn domain rules immediately.

---

## Example 3: Slash Command for Feature Implementation

**Use Case:** Standardize feature development workflow across team

**File:** `.claude/commands/implement-feature.md`

```markdown
---
name: implement-feature
description: Implement feature using spec-driven approach
usage: /implement-feature [issue-number]
---

# Feature Implementation Workflow

## Process

1. **Load Planning Skill**
   - Load: @skills/define/planning-and-task-breakdown.md
   - Create work tracker: `scratch/WORK_TRACKER.md`

2. **Create Spec (if complex)**
   - If > 3 files changed: Load @skills/define/spec-driven-development.md
   - Create OpenSpec proposal in `openspec/changes/`
   - Get stakeholder approval before coding

3. **Execute Implementation**
   - Load: @skills/build/incremental-implementation.md
   - Execute each step from work tracker
   - Run verification per step
   - Create atomic commits

4. **Create Pull Request**
   - Push branch
   - Create PR with summary
   - Link to issue and spec

## Verification Before PR

- [ ] All work tracker steps complete
- [ ] Full test suite passes: `pytest` or `npm test`
- [ ] Type checking passes: `mypy src/` or `npm run type-check`
- [ ] Linting passes: `ruff check .` or `npm run lint`
- [ ] CHANGELOG.md updated (if user-facing)
- [ ] Docs updated (if API change)

## Quality Checklist

- [ ] No hard-coded secrets
- [ ] Error messages are user-friendly
- [ ] Input validation at API boundary
- [ ] Tests cover happy path + edge cases + errors
- [ ] No `any` types without justification
```

**Why This Works:** One command standardizes entire workflow. Copy/paste consistency.

---

## Example 4: AGENTS.md Template Sections

### Project-Specific Patterns

```markdown
## Project-Specific Patterns

### API Response Format
All endpoints return:
```json
{
  "success": true,
  "data": { ... },
  "error": null,
  "metadata": {
    "timestamp": "2026-02-16T10:30:00Z",
    "request_id": "abc-123"
  }
}
```

### Error Response Format
```json
{
  "success": false,
  "data": null,
  "error": {
    "code": "INVALID_INPUT",
    "message": "Email address is invalid",
    "field": "email"
  }
}
```

### React Component Pattern
```typescript
// Functional component with hooks
export function UserProfile({ userId }: UserProfileProps) {
  const { data, loading, error } = useUser(userId);

  if (loading) return <Spinner />;
  if (error) return <ErrorMessage error={error} />;
  if (!data) return <NotFound />;

  return <div>...</div>;
}
```
```

### Authentication Flow Documentation

```markdown
## Authentication Flow

### How It Works
1. User authenticates with email/password
2. Server returns JWT access token (24h expiry) + refresh token (30d)
3. Access token in Authorization header: `Bearer <token>`
4. Refresh token in httpOnly cookie

### Token Management
- Access tokens: Short-lived (24h), stored in memory
- Refresh tokens: Long-lived (30d), httpOnly cookie
- Auto-refresh when access token expires
- Rate limit: 100 req/min per user, 10 req/min unauthenticated

### Security Rules
- Passwords: bcrypt with cost factor 12
- MFA: TOTP (6-digit, 30s window)
- Session invalidation: On password change, logout
- Failed logins: 5 attempts → 15 min lockout
```

### Environment-Specific Behavior

```markdown
## Environment-Specific Behavior

### Development
- DEBUG=true
- Verbose logging to console
- Fake payment gateway (Stripe test mode)
- Email logged to console (no SMTP)
- Hot reload enabled

### Staging
- DEBUG=false
- Standard logging
- Stripe test mode
- Real SMTP (Mailgun sandbox)
- Mimics production config

### Production
- DEBUG=false
- Structured JSON logs → CloudWatch
- Stripe live mode
- Real SMTP with retry queue
- Feature flags control rollout
- Auto-scaling enabled
```

---

## Example 5: Validation Testing

**Test Your AGENTS.md:**

```markdown
## AGENTS.md Validation Tests

### Test 1: Create API Endpoint
**Prompt:** "Create a new endpoint POST /api/users that creates a user"

**Expected AI Behavior:**
- [ ] Uses FastAPI router in `src/routes/users.py`
- [ ] Pydantic models for request/response
- [ ] Business logic in `src/services/user_service.py`
- [ ] Returns standardized JSON format
- [ ] Creates unit test in `tests/unit/test_user_service.py`
- [ ] Creates integration test in `tests/integration/test_users_api.py`
- [ ] Validates input at API boundary
- [ ] Handles errors with error codes

### Test 2: Debug Issue
**Prompt:** "Debug why users can't login with valid credentials"

**Expected AI Behavior:**
- [ ] Loads debugging skill
- [ ] Writes failing test first
- [ ] Checks logs for request_id and error
- [ ] Hypothesizes root cause
- [ ] Tests hypothesis with isolated test
- [ ] Fixes issue
- [ ] Verifies full test suite passes

### Test 3: Refactor Code
**Prompt:** "Refactor authentication module for better testability"

**Expected AI Behavior:**
- [ ] Maintains existing behavior (no breaking changes)
- [ ] Adds/improves unit tests
- [ ] Runs full test suite before committing
- [ ] Uses dependency injection for testability
- [ ] Documents why refactoring was needed (comment or ADR)
```

**How to Use:**
1. Run each test prompt with fresh AI session
2. Check if AI follows all expected behaviors
3. If AI deviates, add/clarify constraint in AGENTS.md
4. Re-test until consistent
