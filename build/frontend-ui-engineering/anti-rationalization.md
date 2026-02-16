# Anti-Rationalization: Frontend UI Engineering

## Why This Matters

| Excuse | Reality |
|--------|---------|
| "We'll add accessibility later" | Retrofitting costs 10x more and often gets skipped under deadline pressure |
| "Performance optimization is premature" | Slow UIs lose users immediately—50% abandon if load > 3s |
| "Users don't care about design systems" | Consistency reduces cognitive load and builds trust, directly impacting conversion |
| "Testing UI is too hard" | React Testing Library makes it straightforward with role-based queries |
| "Mobile users are minority" | Mobile traffic is 50%+ for most consumer apps, 60%+ for retail |

## Cost of Skipping

**Without UI Engineering Discipline:**
- Accessibility lawsuit risk (real legal liability)
- Failed WCAG audits block enterprise sales
- Performance issues compound (hard to optimize retroactively)
- Inconsistent UX increases support tickets
- Component duplication wastes development time
- Browser compatibility bugs discovered in production

**With UI Engineering:**
- Pass accessibility audits on first try
- Meet Core Web Vitals targets (better SEO)
- Reusable components reduce development time 40%
- Consistent UX reduces user confusion and support load
- Storybook enables parallel design/dev workflows

## When It's OK to Skip

Skip this skill when:
- ❌ Internal admin tools where UX bar is lower
- ❌ Throwaway prototypes or mockups for user testing
- ❌ Pure backend/API development with no UI layer
- ❌ CLI tools or server-side services

## Time Investment

**Per Component:**
- Basic component: 1-2 hours (with accessibility)
- Complex component (Dialog, DataTable): 4-8 hours
- Storybook documentation: +30 min
- Accessibility testing: +30 min

**Per Feature:**
- Simple page: 4-8 hours
- Complex feature with multiple components: 2-3 days

**ROI:**
- Reusable components reduce future work by 60%
- Accessibility baked in prevents expensive retrofits
- Design system reduces decision fatigue and design debt
