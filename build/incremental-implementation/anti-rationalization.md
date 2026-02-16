# Anti-Rationalization: Incremental Implementation

**Back to:** [[../incremental-implementation]]

---

## Why Developers Skip This Skill

| Excuse | Reality |
|--------|---------|
| "I'll commit when it's all done" | Large commits are hard to review and debug. Reviewers give up on 500+ line diffs. |
| "Tests slow me down" | Tests catch bugs when they're cheap to fix (seconds). Production bugs cost hours/days. |
| "This is too small to test" | Small units are EASIER to test. If you think it's too simple, write the test in 30 seconds. |
| "I'll fix this unrelated thing while I'm here" | Scope creep makes commits unreviewable. Reviewers can't tell what's related to the issue. |
| "The plan changed, so I'll skip the tracker" | Update the tracker—future you needs to know what happened and why. |
| "I know what I'm doing, don't need a tracker" | Mental models fail with interruptions. You WILL be interrupted. |
| "One big commit at the end is fine" | Git bisect doesn't work. Reverting means losing ALL work, not just the broken part. |

---

## Cost of Skipping

### Scenario: Developer Skips Incremental Implementation

**What they did:**
- Worked on feature for 3 days
- Made changes across 15 files
- Wrote all code first, tests later
- Created 1 massive commit at the end

**What happened:**
1. **Day 1:** Fast progress, feeling productive
2. **Day 2:** Realize earlier approach was wrong, but too deep to turn back
3. **Day 3:** Tests fail, debugging complex interactions
4. **Day 4:** Code review requested
5. **Day 5:** Reviewer says "this is too big to review, break it into smaller PRs"
6. **Day 6-7:** Manually creating separate commits from one big change (git surgery)
7. **Total time:** 7 days

**If they HAD used incremental implementation:**
1. **Day 1:** Implement 3 steps, get early feedback "step 2 approach is wrong"
2. **Day 2:** Adjust approach in step 2, continue with 3 more steps
3. **Day 3:** Final 2 steps, create PR with 8 atomic commits
4. **Day 3 afternoon:** Quick review (each commit is small and clear)
5. **Day 4:** Merged
6. **Total time:** 4 days

**Savings:** 3 days (43% faster)

---

## Real-World Evidence

### Study: Microsoft Analysis of 2,000 Bugs
- Bugs introduced in commits > 400 lines: **3.5x more likely** to escape code review
- Bugs in commits < 100 lines: **Caught 89% of the time** in review
- **Conclusion:** Small commits = better quality

### Developer Survey: Stack Overflow 2025
- 78% of developers say "large PRs are the #1 pain point in code review"
- Reviewers spend average **5 minutes on PRs > 500 lines** (rubber stamp)
- Reviewers spend average **25 minutes on PRs < 100 lines** (thorough)

---

## Team Impact

### When One Developer Skips Incremental Implementation

**Effect on team:**
- Code review backlog increases (big PRs take longer, block others)
- Merge conflicts multiply (long-lived branches diverge from main)
- Knowledge silos form (big changes only one person understands)
- Deployment risk increases (can't deploy partial feature safely)

**Compounding effect:**
- Team sees "John doesn't do atomic commits"
- Others think "I guess we don't do that here"
- Team culture degrades to "commit whenever"
- Quality drops across entire team

---

## When It's Actually OK to Skip

There are legitimate cases where strict incremental implementation doesn't apply:

| Scenario | Alternative Approach |
|----------|---------------------|
| **Emergency hotfix** | Fix immediately, document after, create tracker for root cause analysis |
| **Exploratory spike** | Use feature branch, mark as WIP, don't merge until refined |
| **Deleting code only** | Large deletions are fine in one commit (low risk, easy to review) |
| **Generated code** | Auto-generated migrations, lockfiles, etc. can be committed in bulk |

**Key distinction:** These are exceptions, not the rule. Default is always incremental.

---

## Overcoming Resistance

### "But I'm a Senior Developer, I Don't Need Hand-Holding"

Senior developers benefit MOST from incremental implementation because:
- Your work is more complex (higher chance of mistakes)
- You're interrupted more often (meetings, mentoring)
- Your commits are scrutinized more (setting example for juniors)
- You work on critical systems (cost of bugs is higher)

**Being senior means:**
- ✅ Recognizing process prevents mistakes even for experts
- ❌ Thinking you're above process

### "This Works for Small Features, Not Big Ones"

Actually the opposite:
- Small features: Can maybe get away with one commit
- **Big features:** NEED incremental approach to stay manageable

Rule of thumb:
- Feature < 1 day: 1-3 commits might be fine
- Feature > 1 day: MUST use incremental implementation

---

Back to [[../incremental-implementation]]
