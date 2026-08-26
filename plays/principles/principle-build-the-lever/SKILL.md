---
name: principle-build-the-lever
description: "Build the tool that does the work, not the work by hand. Codemod, script, generator, or skill—ship the artifact that others can run."
metadata:
  phase: principle
  pstack_ref: "build-the-lever"
  version: "1.0.0"
---

# Build the Lever

**The play:** Don't do bulk work by hand. Build the tool that does it. The tool is the artifact.

## When to Apply This

- ✅ Refactoring 50 files
- ✅ Migrating data
- ✅ Any repetitive work
- ✅ Work that takes more than 2 iterations

## The Rule

**Automate it. The script/tool/codemod is the real deliverable, not the result.**

Not:
- ✗ Manually fix 50 files
- ✗ Manual data migration with notes
- ✗ Hand-edits across the codebase

Instead:
- ✓ Write a codemod
- ✓ Write a migration script
- ✓ Write a generator
- ✓ Run it. Commit both tool and results.

## How

### 1. Recognize the Pattern
Same change 3+ times? Build a tool.

### 2. Build the Tool
Codemod, script, generator. Something runnable.

### 3. Run It
Once, consistently.

### 4. Commit Both
Tool + results. Reviewers can rerun the tool.

## Examples

**Bad:** Manually migrate 100 database records.
**Good:** Write migration script. Run it. Commit script.

## The Principle in One Sentence

**Tools scale work. People don't.**
