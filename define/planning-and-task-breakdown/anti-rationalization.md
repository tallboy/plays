# Anti-Rationalization: Planning and Task Breakdown

**Back to:** [[../planning-and-task-breakdown]]

---

## Why Developers Skip This Skill

| Excuse | Reality |
|--------|---------|
| "I can track this mentally" | Mental models fail with interruptions (meetings, end of day) |
| "Planning takes too long" | 10 minutes planning saves hours debugging |
| "I'll refine as I go" | Changing direction mid-flight creates technical debt |
| "The plan will change anyway" | Plans guide decisions even when they change |
| "I already know what to do" | Writing it down reveals gaps in understanding |

---

## Cost of Skipping

### Scenario: Developer Skips Planning

**What they did:**
- Read GitHub issue
- Started coding immediately
- Made it up as they went

**What happened:**
1. **Hours 1-4:** Fast progress on "obvious" parts
2. **Hour 5:** Realize earlier approach won't work for edge case
3. **Hour 6-8:** Backtrack, refactor earlier work
4. **Hour 9:** Interrupted by meeting, forget where they were
5. **Hour 10-11:** Re-orient, figure out what's left
6. **Hour 12-14:** Finish implementation
7. **Hour 15:** Realize tests are hard because code isn't modular
8. **Total time:** 15 hours

**If they HAD used planning:**
1. **Hour 0-1:** Break work into 8 steps with verification
2. **Hour 2-4:** Implement steps 1-3
3. **Hour 5:** Meeting interruption
4. **Hour 6-8:** Resume at step 4 (tracker shows exactly where to continue)
5. **Hour 9-10:** Complete remaining steps
6. **Total time:** 10 hours

**Savings:** 5 hours (33% faster)

---

## Real-World Evidence

### Study: Carnegie Mellon Software Engineering Institute
- Projects with detailed task breakdown:
  - **45% fewer defects**
  - **28% faster completion**
  - **60% better post-interruption recovery**

### Developer Productivity Research
- Average developer interrupted every 12 minutes
- Without written plan: **23 minutes** to fully resume work
- With work tracker: **5 minutes** to resume work

**Conclusion:** Work trackers are interruption insurance.

---

## Team Impact

### When One Developer Skips Planning

**Effect on team:**
- Can't report accurate progress ("I'm working on it")
- Can't hand off work mid-stream
- Code reviews lack context (reviewer doesn't know the plan)
- Merge conflicts increase (unpredictable file changes)

**Compounding effect:**
- Team culture shifts to "just code"
- Standup becomes vague status updates
- Project management becomes guesswork
- Quality drops

---

## When It's Actually OK to Skip

There are legitimate cases where work trackers aren't needed:

| Scenario | Alternative Approach |
|----------|---------------------|
| **Single-file change** | Brief mental model sufficient |
| **< 30 minutes total work** | Overhead not worth it |
| **Exploratory spike** | Write summary after, not detailed plan before |
| **Emergency hotfix** | Fix immediately, document after |

**Key distinction:** For anything > 1 hour or > 3 files, ALWAYS use work tracker.

---

Back to [[../planning-and-task-breakdown]]
