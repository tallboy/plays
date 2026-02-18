---
name: "API and Interface Design"
phase: "build"
complexity: "intermediate"
duration: "2-6 hours (per API design)"
prerequisites: ["spec-driven-development"]
version: "1.1.0"
---

## When to Use

- ✅ Designing public or partner-facing APIs
- ✅ Creating service boundaries in microservices
- ✅ Building library/SDK interfaces
- ✅ Defining contract between frontend and backend
- ✅ Multiple teams will consume this API

---

## Overview

Treat APIs as products: design the interface before implementation, validate with contract tests, version thoughtfully, and document comprehensively.

**Core Principle:** Interfaces are forever—change is expensive, so design carefully upfront.

---

## Process

### 1. Define Use Cases
- List all intended consumers (web app, mobile, partners)
- Document primary use cases per consumer
- Identify edge cases and error scenarios

### 2. Design API Contract (OpenAPI)
**RESTful Principles:**
- Resource naming: `/users`, `/users/{id}`
- HTTP methods: GET (retrieve), POST (create), PATCH (update), DELETE (remove)
- Status codes: 200 (OK), 201 (Created), 400 (Bad Request), 404 (Not Found), 422 (Validation Error)

**Key Elements:**
- Request/response schemas
- Error response format
- Pagination for collections
- Authentication requirements

### 3. Validate with Contract Tests
```python
# Auto-generate tests from OpenAPI spec
@schema.parametrize()
def test_api_contract(case):
    response = case.call()
    case.validate_response(response)
```

### 4. Choose Versioning Strategy
**URL Path Versioning (Recommended):**
- `/v1/users` → Current version
- `/v2/users` → New version
- Support old versions with deprecation warnings
- 6-month notice before sunset

**Breaking vs. Non-Breaking:**
- ✅ Non-breaking: Add optional fields, new endpoints
- ❌ Breaking: Remove fields, change types, rename fields

### 5. Design Error Handling
**Standard Error Format:**
```json
{
  "code": "VALIDATION_ERROR",
  "message": "Invalid input",
  "details": { "email": ["Invalid format"] },
  "request_id": "req_abc123"
}
```

### 6. Generate Documentation
- Auto-generate from OpenAPI (Redoc, Swagger UI)
- Generate client SDKs (TypeScript, Python, etc.)
- Publish interactive API explorer

---

## Verification Checklist

**Design Phase:**
- [ ] OpenAPI spec written for all endpoints
- [ ] Request/response schemas defined
- [ ] Error responses documented
- [ ] Versioning strategy chosen
- [ ] Idempotency considered for mutations

**Implementation Phase:**
- [ ] Contract tests pass (implementation matches spec)
- [ ] API docs auto-generated and published
- [ ] Error codes consistent across endpoints
- [ ] Rate limiting headers included
- [ ] Pagination for all collections

**Production Readiness:**
- [ ] API versioned in URL path
- [ ] Deprecation policy documented
- [ ] Health/status endpoint exists
- [ ] CORS configured correctly

---

## Related Skills

- **Before:** [Spec-Driven Development](../define/spec-driven-development.md) - Spec the feature first
- **During:** [Incremental Implementation](incremental-implementation.md) - Implement API endpoints
- **During:** [Test-Driven Development](../verify/test-driven-development.md) - Write contract tests
- **Review:** [Security Hardening](../review/security-hardening.md) - Validate auth/input
- **Ship:** [Documentation & ADRs](../ship/documentation-adrs.md) - Document API decisions
