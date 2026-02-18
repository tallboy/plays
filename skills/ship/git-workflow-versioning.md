---
name: "Git Workflow and Versioning"
phase: "ship"
complexity: "beginner"
duration: "10-30 minutes (per release)"
prerequisites: ["incremental-implementation"]
version: "1.1.0"
---

## When to Use

- ✅ Creating releases and tags
- ✅ Managing branches (feature, release, hotfix)
- ✅ Versioning software for distribution
- ✅ Publishing packages (npm, PyPI, Docker)
- ✅ Generating changelogs

---

## Overview

Structure git workflow for clear history, traceable releases, and semantic versioning.

**Core Principle:** Git history should tell the story of why, not just what.

---

## Process

### 1. Branch Strategy
**Main Branches:**
- `main`: Production-ready code
- `develop`: Integration branch (if using Git Flow)

**Supporting Branches:**
- `feature/xyz`: New features
- `bugfix/xyz`: Bug fixes
- `hotfix/xyz`: Critical production fixes
- `release/x.y.z`: Release preparation

### 2. Commit Message Convention
**Format:**
```
type(scope): brief description

Detailed explanation (if needed)

Breaking changes (if any)

Co-Authored-By: ...
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

### 3. Semantic Versioning (SemVer)
**Format:** MAJOR.MINOR.PATCH (e.g., 2.4.1)

- **MAJOR**: Breaking changes (incompatible API changes)
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### 4. Create Release
```bash
# 1. Update version
npm version patch  # or minor, major

# 2. Create tag
git tag -a v1.2.3 -m "Release v1.2.3"

# 3. Push tag
git push origin v1.2.3

# 4. Create GitHub release
gh release create v1.2.3 --notes "Release notes"
```

### 5. Generate Changelog
- Group changes by type (Features, Fixes, Breaking Changes)
- Link to PRs and issues
- Credit contributors

---

## Verification Checklist

- [ ] All changes merged to main
- [ ] Version bumped according to SemVer
- [ ] Git tag created
- [ ] Changelog updated
- [ ] Release notes published
- [ ] Package published (if applicable)

---

## Related Skills

- **Before:** [Code Review Quality](../review/code-review-quality.md) - Review before merge
- **After:** [CI/CD Automation](ci-cd-automation.md) - Automated deployment
- **After:** [Shipping & Launch](shipping-launch.md) - Production deployment
