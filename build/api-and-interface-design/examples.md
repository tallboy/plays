# Examples: API and Interface Design

## Example 1: Complete OpenAPI Spec for User Management

```yaml
openapi: 3.0.0
info:
  title: User Management API
  version: 1.0.0
  description: API for managing user accounts

servers:
  - url: https://api.example.com/v1
    description: Production

paths:
  /users:
    get:
      summary: List users
      parameters:
        - name: page
          in: query
          schema:
            type: integer
            default: 1
        - name: limit
          in: query
          schema:
            type: integer
            default: 20
            maximum: 100
      responses:
        '200':
          description: Success
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    type: array
                    items:
                      $ref: '#/components/schemas/User'
                  pagination:
                    $ref: '#/components/schemas/Pagination'

    post:
      summary: Create user
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateUserRequest'
      responses:
        '201':
          description: User created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        '422':
          $ref: '#/components/responses/ValidationError'

  /users/{userId}:
    parameters:
      - name: userId
        in: path
        required: true
        schema:
          type: string
          format: uuid

    get:
      summary: Get user
      responses:
        '200':
          description: User found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        '404':
          $ref: '#/components/responses/NotFound'

components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
          format: uuid
        email:
          type: string
          format: email
        name:
          type: string
        createdAt:
          type: string
          format: date-time
      required: [id, email, name, createdAt]

    CreateUserRequest:
      type: object
      properties:
        email:
          type: string
          format: email
        name:
          type: string
          minLength: 1
          maxLength: 100
        password:
          type: string
          format: password
          minLength: 8
      required: [email, name, password]

    Pagination:
      type: object
      properties:
        page:
          type: integer
        limit:
          type: integer
        total:
          type: integer
        totalPages:
          type: integer

    Error:
      type: object
      properties:
        code:
          type: string
        message:
          type: string
        details:
          type: object
      required: [code, message]

  responses:
    ValidationError:
      description: Validation failed
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
          example:
            code: VALIDATION_ERROR
            message: Invalid input
            details:
              email: Invalid email format

    NotFound:
      description: Resource not found
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
          example:
            code: NOT_FOUND
            message: User not found

  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

security:
  - bearerAuth: []
```

---

## Example 2: Contract Testing with Schemathesis

```python
# tests/contract/test_users_api.py
import schemathesis

schema = schemathesis.from_path("openapi/users.yaml")

@schema.parametrize()
def test_api_contract(case):
    """
    Auto-generated tests from OpenAPI spec.
    Validates request/response schemas, status codes.
    """
    response = case.call()
    case.validate_response(response)
```

---

## Example 3: Idempotent Payment API

```yaml
paths:
  /payments:
    post:
      summary: Create payment
      parameters:
        - name: Idempotency-Key
          in: header
          required: true
          schema:
            type: string
            format: uuid
          description: Unique key to prevent duplicate charges
      requestBody:
        content:
          application/json:
            schema:
              type: object
              properties:
                amount:
                  type: integer
                  description: Amount in cents
                currency:
                  type: string
                  enum: [USD, EUR, GBP]
                paymentMethodId:
                  type: string
      responses:
        '201':
          description: Payment created
        '409':
          description: Duplicate idempotency key with different params
```

**Implementation:**
```python
@app.post("/payments")
async def create_payment(
    request: PaymentRequest,
    idempotency_key: str = Header(..., alias="Idempotency-Key")
):
    # Check if already processed
    cached = await redis.get(f"idempotency:{idempotency_key}")
    if cached:
        return JSONResponse(cached, status_code=201)

    # Process payment
    payment = await process_payment(request)

    # Cache result for 24 hours
    await redis.setex(
        f"idempotency:{idempotency_key}",
        86400,
        payment.json()
    )

    return payment
```

---

## Example 4: Versioning with Deprecation

```python
# v1 endpoint (deprecated)
@app.get("/v1/users/{user_id}")
async def get_user_v1(user_id: str, response: Response):
    response.headers["Deprecation"] = "Sun, 01 Aug 2026 00:00:00 GMT"
    response.headers["Sunset"] = "Sun, 01 Nov 2026 00:00:00 GMT"
    response.headers["Link"] = '<https://api.example.com/v2/users>; rel="successor-version"'

    user = await db.get_user(user_id)
    return {
        "id": user.id,
        "name": user.name,  # Old format
    }

# v2 endpoint (current)
@app.get("/v2/users/{user_id}")
async def get_user_v2(user_id: str):
    user = await db.get_user(user_id)
    return {
        "id": user.id,
        "fullName": user.name,  # New format
        "email": user.email,    # New field
    }
```

---

## Example 5: Standard Error Response

```typescript
// Error middleware
app.use((err, req, res, next) => {
  const errorResponse = {
    code: err.code || 'INTERNAL_ERROR',
    message: err.message || 'An unexpected error occurred',
    details: err.details || {},
    requestId: req.id,
    timestamp: new Date().toISOString(),
  };

  const statusCode = err.statusCode || 500;
  res.status(statusCode).json(errorResponse);
});

// Usage
throw new ValidationError('Invalid input', {
  email: ['Invalid email format'],
  password: ['Must be at least 8 characters'],
});
// → 422 with standardized error format
```

---

## Example 6: Rate Limiting Headers

```python
from fastapi import Request, Response
from slowapi import Limiter
from slowapi.util import get_remote_address

limiter = Limiter(key_func=get_remote_address)

@app.get("/api/users")
@limiter.limit("100/minute")
async def list_users(request: Request, response: Response):
    # Add rate limit headers
    response.headers["X-RateLimit-Limit"] = "100"
    response.headers["X-RateLimit-Remaining"] = "95"
    response.headers["X-RateLimit-Reset"] = "1645027200"

    users = await db.get_users()
    return users

# When limit exceeded:
# 429 Too Many Requests
# {
#   "code": "RATE_LIMIT_EXCEEDED",
#   "message": "Too many requests",
#   "retryAfter": 60
# }
```

---

## Example 7: Field Selection for Reduced Payload

```python
@app.get("/api/users")
async def list_users(
    fields: Optional[str] = Query(None, description="Comma-separated fields")
):
    users = await db.get_users()

    if fields:
        # Return only requested fields
        requested_fields = set(fields.split(','))
        return [
            {k: v for k, v in user.dict().items() if k in requested_fields}
            for user in users
        ]

    # Return all fields
    return users

# GET /api/users?fields=id,name,email
# → Only returns those 3 fields
```

---

## Example 8: GraphQL Alternative

```graphql
type User {
  id: ID!
  email: String!
  name: String!
  posts: [Post!]!
  createdAt: DateTime!
}

type Query {
  user(id: ID!): User
  users(page: Int, limit: Int, search: String): UserConnection!
}

type Mutation {
  createUser(input: CreateUserInput!): User!
  updateUser(id: ID!, input: UpdateUserInput!): User!
}
```

**Benefits:**
- Client requests exactly what it needs
- Single request for nested data
- Strong typing with introspection

**Tradeoffs:**
- More complex server setup
- Caching more difficult
- Learning curve
