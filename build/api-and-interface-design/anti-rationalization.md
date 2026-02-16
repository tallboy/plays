# Anti-Rationalization: API and Interface Design

## Why This Matters

| Excuse | Reality |
|--------|---------|
| "We'll document after implementation" | Docs never match implementation, clients get broken integrations |
| "OpenAPI is too much overhead" | Auto-generated docs/tests/clients save 10x the time invested |
| "Breaking changes are rare" | Without versioning, one breaking change destroys all client trust |
| "Error codes are overkill" | Generic errors make debugging impossible for API consumers |
| "Contract tests are redundant" | They're the only way to prevent spec drift over time |

## Cost of Skipping

**Without API-First Design:**
- Breaking changes discovered in production
- Inconsistent error formats across endpoints
- No client SDKs (every consumer writes their own)
- Documentation becomes outdated immediately
- Contract disputes with partners ("spec said X, API does Y")
- Can't evolve API without breaking existing clients

**With API-First Design:**
- Breaking changes caught in design review
- Auto-generated client libraries in multiple languages
- Documentation always matches implementation
- Contract tests prevent regressions
- Clear versioning enables safe evolution
- Partner integrations smoother and faster

## When It's OK to Skip

Skip this skill when:
- ❌ Internal function signatures (no external consumers)
- ❌ Throwaway prototype code
- ❌ Single-use script
- ❌ Private APIs with single known consumer

## Time Investment

**Per API Design:**
- Simple CRUD API: 2-4 hours (OpenAPI spec + contract tests)
- Complex API with relationships: 4-8 hours
- Public/partner API: 8-16 hours (includes client SDK generation)

**ROI:**
- Prevents 80% of integration bugs before code is written
- Auto-generated docs save 20+ hours of manual documentation
- Client SDKs reduce consumer integration time by 60%
- Contract tests catch regressions automatically
