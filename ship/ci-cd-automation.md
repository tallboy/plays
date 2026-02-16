# Skill: CI/CD Automation

**Phase:** Ship | **Complexity:** Intermediate | **Duration:** 2-8 hours (initial setup)
**Prerequisites:** [[git-workflow-versioning]]

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

- **Before:** [[git-workflow-versioning]] - Versioning triggers deployments
- **Uses:** [[../verify/test-driven-development]] - Automated test execution
- **After:** [[shipping-launch]] - Production deployment checklist

---

## Tools

- **CI Platforms:** GitHub Actions, GitLab CI, CircleCI, Jenkins
- **Container:** Docker, Kubernetes
- **IaC:** Terraform, Pulumi
- **Secrets:** AWS Secrets Manager, HashiCorp Vault

---

## Learn More

- **Why this matters:** [[./ci-cd-automation/anti-rationalization]]
- **Common mistakes:** [[./ci-cd-automation/pitfalls]]
- **Detailed examples:** [[./ci-cd-automation/examples]]

---

**v1.1.0** (2026-02-16): Refactored to progressive disclosure
