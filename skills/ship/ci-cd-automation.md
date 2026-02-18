---
name: "CI/CD Automation"
phase: "ship"
complexity: "intermediate"
duration: "2-8 hours (initial setup)"
prerequisites: ["git-workflow-versioning"]
version: "1.1.0"
---

## When to Use

- ✅ Automating test execution on every commit
- ✅ Deploying to staging/production automatically
- ✅ Running quality gates (linting, type-checking)
- ✅ Building and publishing packages/containers
- ✅ Ensuring consistent build process

---

## Overview

Automate build, test, and deployment pipelines to catch issues early and deploy confidently.

**Core Principle:** If it's not automated, it will be skipped.

---

## Process

### 1. Set Up CI Pipeline
**On Every Push:**
- Run linters (eslint, ruff)
- Run type checker (mypy, tsc)
- Run unit tests
- Run integration tests
- Build artifacts

**Example (GitHub Actions):**
```yaml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: npm run lint
      - run: npm run type-check
      - run: npm test
      - run: npm run build
```

### 2. Quality Gates
**Requirements to Merge:**
- [ ] All tests pass
- [ ] Code coverage ≥ 80%
- [ ] No linting errors
- [ ] No type errors
- [ ] Security scan passes
- [ ] Dependency audit passes

### 3. CD Pipeline
**Deployment Workflow:**
- Merge to `main` → Deploy to staging
- Create tag → Deploy to production
- Run smoke tests post-deploy
- Rollback on failure

### 4. Environment Management
- **Development:** Local dev environment
- **Staging:** Production-like environment
- **Production:** Live environment

**Configuration:**
- Use environment variables
- Keep secrets in secret manager
- Use feature flags for gradual rollout

---

## Verification Checklist

- [ ] CI runs on every push
- [ ] All quality gates enforced
- [ ] Deployment automated (no manual steps)
- [ ] Secrets managed securely
- [ ] Rollback plan tested
- [ ] Monitoring and alerts configured

---

## Related Skills

- **Before:** [Git Workflow & Versioning](git-workflow-versioning.md) - Versioning triggers deployments
- **Uses:** [Test-Driven Development](../verify/test-driven-development.md) - Automated test execution
- **After:** [Shipping & Launch](shipping-launch.md) - Production deployment checklist
