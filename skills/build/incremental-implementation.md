---
name: "Incremental Implementation"
phase: "build"
complexity: "beginner"
duration: "Continuous (per-step)"
prerequisites: ["planning-and-task-breakdown"]
version: "1.1.0"
---

## When to Use

- ✅ Always (default development approach)
- ✅ Executing work tracker with multiple steps
- ✅ Want traceable, reviewable commits
- ✅ Need to pause/resume work safely

---

## Overview

Implement features in small, verified increments. Each step is independently tested, committed, and traceable.

**Core Principle:** One step, one verification, one commit. Repeat.

---

## Process

### 1. Read Work Tracker
- Open `scratch/WORK_TRACKER.md`
- Find next **Status: [ ] Pending** step
- Note: files to modify, verification criteria, commit message

### 2. Mark In Progress
```markdown
- **Status:** [~] In Progress
- **Started:** [timestamp]
```

### 3. Implement ONLY This Step
- Modify identified files ONLY
- Don't refactor unrelated code
- Don't work ahead to next step
- Focus on verification criteria

**Key Question:** "Does this change contribute to THIS step's verification?"

### 4. Run Verification
- Work through step's verification checklist
- If any fail: debug, fix, re-verify
- Don't proceed until ALL pass

### 5. Run Quality Checks
```bash
# Python example
ruff check --fix . && mypy src/ && pytest

# Node example
npm run lint && npm run type-check && npm test

# Go example
golangci-lint run && go test ./...
```

**Quality Gate:** ALL checks pass before commit.

### 6. Create Atomic Commit
```bash
# Stage files from work tracker
git add [files-from-step]

# Use pre-written commit message
git commit -m "[step-commit-message] (#issue)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

### 7. Mark Complete
```markdown
- **Status:** [x] Complete
- **Completed:** [timestamp]
- **Commit:** [hash]
```

### 8. Repeat
- Next pending step → return to step 1
- All steps complete → [Git Workflow & Versioning](../ship/git-workflow-versioning.md)

---

## Verification Checklist

**Per Step:**
- [ ] Only identified files modified
- [ ] All step verifications pass
- [ ] Quality checks pass
- [ ] Atomic commit created
- [ ] Work tracker updated

**Per Feature:**
- [ ] All steps marked complete
- [ ] Full test suite passes
- [ ] No uncommitted changes

---

## Related Skills

- **Before:** [Planning and Task Breakdown](../define/planning-and-task-breakdown.md)
- **During:** [Test-Driven Development](../verify/test-driven-development.md)
- **After:** [Git Workflow & Versioning](../ship/git-workflow-versioning.md)
- **Context:** [Context Engineering](context-engineering.md)
