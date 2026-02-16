# Skill: Incremental Implementation

**Phase:** Build | **Complexity:** Beginner | **Duration:** Continuous (per-step)
**Prerequisites:** [[../define/planning-and-task-breakdown]]

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
- All steps complete → [[../ship/git-workflow-versioning]]

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

- **Before:** [[../define/planning-and-task-breakdown]]
- **During:** [[../verify/test-driven-development]]
- **After:** [[../ship/git-workflow-versioning]]
- **Context:** [[context-engineering]]

---

## Tools

- [[../../Patterns/Work-Tracker-Pattern]]
- [[../../Workflows/Workflow-Issue-To-PR]]
- `/issue-step` command (if available)

---

## Learn More

- **Why this matters:** [[./incremental-implementation/anti-rationalization]]
- **Common mistakes:** [[./incremental-implementation/pitfalls]]
- **Detailed example:** [[./incremental-implementation/examples]]
- **Advanced patterns:** [[./incremental-implementation/advanced]]

---

**v1.1.0** (2026-02-16): Refactored to progressive disclosure
