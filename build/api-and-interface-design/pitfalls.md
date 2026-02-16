# Common Pitfalls: API and Interface Design

## Pitfall 1: Non-Idempotent Operations

**Symptom:** Duplicate requests create duplicate resources

**Bad:**
```javascript
POST /api/payments
// If network fails, client retries → duplicate charge!
```

**Good:**
```javascript
POST /api/payments
Headers: {
  'Idempotency-Key': 'unique-uuid-123'
}

// Server checks if key already processed:
if (await redis.get(`idempotency:${key}`)) {
  return cached_response;
}
```

**Fix:** Require idempotency keys for POST requests

**Prevention:** All create/update operations should be idempotent

---

## Pitfall 2: Leaking Implementation Details

**Symptom:** Database column names exposed in API

**Bad:**
```json
{
  "user_id": 123,
  "created_at": "2026-02-16T10:30:00Z",
  "is_deleted": false
}
```

**Good:**
```json
{
  "id": "usr_123",
  "userId": 123,
  "createdAt": "2026-02-16T10:30:00Z"
}
```

**Fix:** Use consistent API naming convention (camelCase for JSON, snake_case for Python)

**Prevention:** API schema should be independent of database schema

---

## Pitfall 3: Overfetching/Underfetching

**Symptom:** GET /users returns 50 fields when client needs 3

**Bad:**
```
GET /users
→ Returns all fields for all users (slow, wasteful)
```

**Good:**
```
GET /users?fields=id,name,email
→ Returns only requested fields

// OR use GraphQL for complex requirements
```

**Fix:** Support field selection or use GraphQL

**Prevention:** Monitor API response sizes, optimize hot paths

---

## Pitfall 4: Missing Pagination

**Symptom:** GET /users returns all 100k users at once

**Bad:**
```
GET /users
→ Returns array of all users (times out, crashes)
```

**Good:**
```
GET /users?page=1&limit=20

Response:
{
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 100000,
    "totalPages": 5000
  }
}
```

**Fix:** Always paginate collections with default and max limits

**Prevention:** Never return unbounded arrays

---

## Pitfall 5: Inconsistent Error Formats

**Symptom:** Different endpoints return different error structures

**Bad:**
```json
// Endpoint 1
{ "error": "Invalid email" }

// Endpoint 2
{ "message": "Email is required", "status": 400 }

// Endpoint 3
{ "errors": [{ "field": "email", "error": "invalid" }] }
```

**Good:**
```json
// ALL endpoints use same format
{
  "code": "VALIDATION_ERROR",
  "message": "Invalid input",
  "details": {
    "email": ["Invalid email format"]
  },
  "request_id": "req_abc123"
}
```

**Fix:** Define standard error format in OpenAPI spec

**Prevention:** Use middleware to enforce consistent error responses

---

## Pitfall 6: Missing Rate Limiting

**Symptom:** Single client can overwhelm API with requests

**Bad:**
```
No rate limiting → API abuse, DOS attacks possible
```

**Good:**
```
Headers:
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1645027200

Response (when exceeded):
429 Too Many Requests
{
  "code": "RATE_LIMIT_EXCEEDED",
  "message": "Too many requests",
  "retryAfter": 60
}
```

**Fix:** Implement rate limiting with clear headers

**Prevention:** Rate limit per user, per IP, and per endpoint

---

## Pitfall 7: No Versioning Strategy

**Symptom:** Breaking change forces all clients to update immediately

**Bad:**
```
PATCH /users/:id
// Change field type from string to array
// All existing clients break instantly
```

**Good:**
```
/v1/users/:id → Old behavior (deprecated)
/v2/users/:id → New behavior

Deprecation headers on v1:
Deprecation: Sun, 01 Aug 2026 00:00:00 GMT
Sunset: Sun, 01 Nov 2026 00:00:00 GMT
Link: <https://api.example.com/v2/users>; rel="successor-version"
```

**Fix:** Version in URL path, support old versions with deprecation warnings

**Prevention:** Plan versioning strategy before first release

---

## Pitfall 8: Spec Drift

**Symptom:** OpenAPI spec doesn't match actual implementation

**Bad:**
```yaml
# Spec says:
responses:
  '200':
    schema:
      type: object
      properties:
        name: string

# Actual API returns:
{
  "fullName": "John Doe",  # Different field name!
  "age": 30                # Extra field not in spec!
}
```

**Fix:** Use contract tests to validate implementation matches spec

```python
@schema.parametrize()
def test_api_contract(case):
    response = case.call()
    case.validate_response(response)
```

**Prevention:** Run contract tests in CI, fail build on spec violations
