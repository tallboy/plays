# Common Pitfalls: Context Engineering

## Pitfall 1: Too Prescriptive

**Symptom:** AGENTS.md specifies exact implementation details

**Example:**
```markdown
## Code Conventions
- Use this exact pattern for all API endpoints:
  app.get('/endpoint', async (req, res) => {
    const data = await db.query(...)
    return res.json({ data })
  })
```

**Fix:** Document WHAT and WHY, not HOW. Leave implementation to AI.

```markdown
## Code Conventions
- API endpoints return JSON with `{ data }` wrapper
- Use async/await for database operations
- Let AI choose specific implementation pattern
```

**Prevention:** Ask "Am I describing requirements or dictating code?"

---

## Pitfall 2: Too Vague

**Symptom:** Generic advice that doesn't guide behavior

**Example:**
```markdown
## Quality Standards
- Write clean code
- Follow best practices
- Make it maintainable
```

**Fix:** Be specific and actionable

```markdown
## Quality Standards
- Use type hints on all functions (Python) or TypeScript types
- Functions > 50 lines should be broken down
- All public APIs need docstrings with examples
- Test coverage: 80% minimum for new code
```

**Prevention:** If you can't measure it or enforce it, make it more specific

---

## Pitfall 3: Outdated Context

**Symptom:** AGENTS.md references old tech stack or deprecated patterns

**Example:**
```markdown
**Tech Stack**
- React 16 with class components
- Webpack 4
- Node 12
```

**Fix:** Add update date and review regularly

```markdown
**Last Updated:** 2026-02-16
**Tech Stack**
- React 18 with functional components + hooks
- Vite 5
- Node 20 LTS

**Changelog**
- 2026-02-16: Migrated from Webpack to Vite
- 2025-11-01: Updated to React 18
```

**Prevention:** Review AGENTS.md quarterly or when major tech changes happen

---

## Pitfall 4: Context Overload

**Symptom:** 2000-line AGENTS.md covering every edge case

**Example:**
```markdown
## API Conventions (500 lines of every possible pattern)
## Database Patterns (800 lines of every query type)
## Testing Strategies (600 lines of every test scenario)
```

**Fix:** Keep core AGENTS.md concise, link to detailed docs

```markdown
## API Conventions
- RESTful endpoints: `/v1/resources`
- Error format: `{ code, message, details }`
- See [[docs/api-guide.md]] for detailed examples

## Database Patterns
- Use ORM for CRUD, raw SQL for complex joins
- See [[docs/database-guide.md]] for migration patterns
```

**Prevention:** If AGENTS.md > 500 lines, extract specialized guides

---

## Pitfall 5: Missing Domain Knowledge

**Symptom:** AI doesn't understand business rules

**Example:** E-commerce API where prices are floats instead of integers, causing rounding errors

**Fix:** Document critical business rules

```markdown
## Domain: E-commerce

### Pricing Rules
- Prices stored in cents (integer), never float
- Tax calculated at checkout, not stored on product
- Discounts apply before tax
- Free shipping threshold: $50 USD
```

**Prevention:** When AI makes domain-specific mistake, add rule to AGENTS.md

---

## Pitfall 6: No Validation

**Symptom:** AGENTS.md created but never tested with AI

**Fix:** Test context with sample prompts

```bash
# Test 1: Create new endpoint
"Create POST /api/users endpoint"
→ Verify: Follows naming, error format, has tests?

# Test 2: Fix bug
"Debug the login failure"
→ Verify: Writes test first, follows debugging skill?

# Test 3: Refactor
"Refactor user authentication for better testability"
→ Verify: Maintains behavior, runs tests?
```

**Prevention:** Always test AGENTS.md with 3-5 prompts before considering it done
