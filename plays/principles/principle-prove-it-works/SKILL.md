---
name: principle-prove-it-works
description: "Verify against the real artifact, not a proxy. You don't practice free throws against imaginary defenders (MJ). Test on production-like data, real code paths, actual user behavior."
metadata:
  phase: principle
  pstack_ref: "prove-it-works"
  player_analogy: "Michael Jordan in the Finals"
  version: "1.0.0"
---

# Prove It Works

**The MJ Principle:** When it matters, MJ practiced free throws with a defender in his face and the crowd screaming. Not alone in a gym. Not against imaginary opponents. Real stakes, real pressure.

## When to Apply This

- ✅ Before saying "this is fixed"
- ✅ Before shipping to production
- ✅ Before claiming a performance improvement
- ✅ Before promising backwards compatibility
- ✅ When you're uncertain and need confidence

## The Rule

**Verify against the real artifact.** Not a test double. Not a simulator. Not a happy-path example.

Real artifact = the actual codebase, actual database, actual API, actual user behavior, actual edge cases.

## How

### 1. Identify the Real Artifact
- Not a mock
- Not a sanitized test dataset
- Not an example workflow
- The actual thing users interact with

### 2. Design the Proof
What would convince a skeptic?
- A screenshot of the feature working
- A test result on production data
- A timing measurement on the real system
- A code path that executes the exact change
- A user who confirms it works

### 3. Execute the Proof
Run it. Observe the result. Capture evidence.

Don't:
- ✗ Trust a test framework to tell you it works
- ✗ Assume "if the test passes, production will too"
- ✗ Verify on a smaller dataset and assume it scales
- ✗ Read the code and declare it correct (code lies)

Do:
- ✓ Run the actual code against real data
- ✓ Measure on the actual system
- ✓ Watch it happen
- ✓ Save the evidence

### 4. Name What Could Still Break
Even with proof:
- What edge cases did you not test?
- What load did you not simulate?
- What user behavior is unpredictable?
- What dependency could fail?

Name it. Don't pretend the proof is complete.

## Examples

**Bad:** "I optimized the query. The code looks faster."  
**Good:** "I optimized the query. Before: 2.3s on 1M rows. After: 0.8s. Same rows, same data shape, same hardware."

**Bad:** "Tests pass, it's ready to ship."  
**Good:** "Tests pass. Deployed to staging. Ran the actual user workflow. Confirmed it works end-to-end."

**Bad:** "Backwards compatible. Old code should still work."  
**Good:** "Backwards compatible. Ran old client against new server. Verified 10 integration scenarios. Zero breaking changes."

## The Principle in One Sentence

**If you wouldn't bet your job on it, you haven't proved it.**
