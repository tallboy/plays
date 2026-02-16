# Skill: Planning and Task Breakdown

**Phase:** Define | **Complexity:** Beginner | **Duration:** 15-60 minutes
**Prerequisites:** Clear requirements (from [[idea-refinement]] or [[spec-driven-development]])

---

## When to Use

- ✅ Complex changes requiring multiple sessions
- ✅ Work needing atomic, independently testable steps
- ✅ Implementation order matters for safety
- ✅ More than 3 files will be modified
- ✅ You'd benefit from pausing/resuming work mid-implementation
- ✅ You want to create atomic commits (one per step)

---

## Overview

Break complex work into small, traceable steps using a **Work Tracker**. This prevents "lost in the weeds" syndrome and creates natural commit boundaries.

**Core Principle:** If you can't break it down, you don't understand it yet.

This skill implements the **Work Tracker Pattern** from [[../../Patterns/Work-Tracker-Pattern]].

---

## Process

### 1. Analyze Scope
- List all files/modules that will change
- Map dependencies between changes (what must come first?)
- Estimate complexity (Low/Medium/High per step)

### 2. Break Into Vertical Slices

**What is a Vertical Slice?** A complete path through the system that delivers testable value.

**Sizing Guidelines:**
- Each slice should be < 4 hours of focused work
- Each slice should have independent test
- Each slice should create one logical commit

### 3. Create Work Tracker

Create `scratch/WORK_TRACKER.md` with:
- Issue number and branch name
- Steps with status, complexity, verification criteria
- Files to modify per step
- Pre-written commit messages

**Or use:** `/issue-plan` command to auto-generate from GitHub issue

### 4. Review Plan

Before implementing, verify:
- [ ] Steps are in logical order (dependencies first)
- [ ] Each step is independently testable
- [ ] No steps are missing
- [ ] Verification criteria are clear
- [ ] File paths are identified
- [ ] Commit messages are pre-written

---

## Verification Checklist

- [ ] All work is broken into steps < 4 hours each
- [ ] Dependencies are ordered correctly (A before B if B needs A)
- [ ] Each step has clear verification criteria
- [ ] Files to modify are identified for each step
- [ ] Commit messages are pre-written
- [ ] Work tracker is saved in `scratch/WORK_TRACKER.md` or project equivalent

---

## Related Skills

- **Before:** [[idea-refinement]] or [[spec-driven-development]] - Get clear requirements first
- **After:** [[../build/incremental-implementation]] - Execute the plan step-by-step
- **Parallel:** [[../ship/git-workflow-versioning]] - Each step becomes one commit

---

## Tools

- [[../../Patterns/Work-Tracker-Pattern]] - Full pattern documentation
- [[../../Templates/Template-Work-Tracker]] - Copy/paste work tracker template
- [[../../Workflows/Workflow-Issue-To-PR]] - Full workflow using work tracker
- `/issue-plan` command (if available) - Auto-generate work tracker from GitHub issue

---

## Learn More

- **Why this matters:** [[./planning-and-task-breakdown/anti-rationalization]]
- **Common mistakes:** [[./planning-and-task-breakdown/pitfalls]]
- **Detailed examples:** [[./planning-and-task-breakdown/examples]]
- **Advanced patterns:** [[./planning-and-task-breakdown/advanced]]

---

**v1.1.0** (2026-02-16): Refactored to progressive disclosure
