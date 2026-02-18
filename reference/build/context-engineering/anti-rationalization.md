# Anti-Rationalization: Context Engineering

## Why Context Engineering Matters

| Excuse | Reality |
|--------|---------|
| "Code comments are enough context" | Comments describe code; AGENTS.md describes intent and constraints |
| "AI should figure it out from code" | AI wastes time inferring what you could state in 5 minutes |
| "This adds maintenance burden" | Outdated AGENTS.md better than none; update when conventions change |
| "We don't have conventions yet" | AGENTS.md IS how you establish conventions |
| "Only works with Claude, not other tools" | Most AI tools support context files (.cursorrules, .windsurfrules, etc.) |

## Cost of Skipping

**Without Context Engineering:**
- AI repeatedly makes same mistakes (wrong naming, ignored conventions)
- Team members get inconsistent AI suggestions
- Every developer re-explains project setup to AI
- AI-generated code requires extensive manual correction
- Onboarding new team members takes longer

**With Context Engineering:**
- AI follows conventions automatically
- Consistent code generation across team
- One-time setup benefits entire team
- AI becomes force multiplier, not friction source
- New developers learn conventions from AGENTS.md

## When It's OK to Skip

Skip context engineering when:
- ❌ One-off script or throwaway code (won't be maintained)
- ❌ Working in someone else's repository (respect their context)
- ❌ Solo exploratory prototype (can add later if it becomes real project)
- ❌ Project already has well-documented AGENTS.md

## Time Investment

**Initial Setup:** 30 minutes - 2 hours
- Basic AGENTS.md: 30 min
- With domain knowledge: 1-2 hours
- With slash commands: +30 min per command

**Maintenance:** 5 minutes per major change
- Update tech stack version: 2 min
- Add new convention: 5 min
- Document domain rule: 10 min

**ROI:** Every developer on team saves 30+ min per day correcting AI mistakes
