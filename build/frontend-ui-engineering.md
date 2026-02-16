# Skill: Frontend UI Engineering

**Phase:** Build | **Complexity:** Intermediate | **Duration:** Continuous (per-component)
**Prerequisites:** [[context-engineering]] - Project conventions documented

---

## When to Use

- ✅ Building user-facing interfaces (web, mobile, desktop)
- ✅ Creating reusable component libraries
- ✅ Implementing design system specifications
- ✅ Accessibility compliance required (WCAG 2.1 AA)
- ✅ Production UI quality needed (not prototypes)

---

## Overview

Build production-quality user interfaces with accessibility, performance, and design system consistency baked in from the start.

**Core Principle:** Build it right the first time—retrofitting accessibility and performance is 10x harder.

---

## Process

### 1. Design System Foundation
- Define or reference design system
- Set up design tokens (colors, spacing, typography)
- Create base component primitives (Button, Input, Label)

### 2. Component Hierarchy
Follow atomic design:
- **Atoms:** Basic building blocks (Button, Input)
- **Molecules:** Simple combinations (SearchField = Input + Button)
- **Organisms:** Complex sections (Header, DataTable)
- **Templates:** Page layouts
- **Pages:** Actual routes

### 3. Build Accessible Components
**Per Component Checklist:**
- [ ] Color contrast ≥ 4.5:1 for text
- [ ] All interactive elements keyboard accessible
- [ ] Semantic HTML (button, nav, main, etc.)
- [ ] ARIA labels for icons and non-text controls
- [ ] Focus indicators visible
- [ ] Screen reader tested

### 4. Optimize Performance
**Core Web Vitals Targets:**
- First Contentful Paint (FCP): < 1.8s
- Largest Contentful Paint (LCP): < 2.5s
- Cumulative Layout Shift (CLS): < 0.1
- First Input Delay (FID): < 100ms

**Techniques:**
- Code splitting for heavy components
- Image optimization (next/image or similar)
- Virtualization for long lists (react-window)
- Memoization (useMemo, useCallback, memo)

### 5. Responsive Design
- Mobile-first CSS
- Breakpoints: 640px (sm), 768px (md), 1024px (lg), 1280px (xl)
- Responsive images with picture/srcSet

### 6. Test Components
- Unit tests (75%): Logic and utilities
- Integration tests (20%): Component interactions
- E2E tests (5%): Full user flows
- Accessibility tests (jest-axe)

### 7. Document in Storybook
- Create stories for all variants
- Add autodocs with JSDoc comments
- Include interactive controls

---

## Verification Checklist

**Per Component:**
- [ ] Follows design system tokens
- [ ] Accessible (passes axe, keyboard navigable)
- [ ] Responsive (mobile, tablet, desktop)
- [ ] Performant (no unnecessary re-renders)
- [ ] Tested (unit, integration, a11y)
- [ ] Documented (Storybook stories)
- [ ] Type-safe (no `any` types)

**Per Feature:**
- [ ] Core Web Vitals meet targets
- [ ] Works in target browsers
- [ ] Handles loading, error, empty states
- [ ] Mobile-first responsive design

---

## Related Skills

- **Before:** [[context-engineering]] - Document component conventions
- **During:** [[incremental-implementation]] - Build components step-by-step
- **During:** [[../verify/test-driven-development]] - Write tests for components
- **During:** [[../verify/browser-testing-devtools]] - Debug rendering issues
- **Review:** [[../review/performance-optimization]] - Optimize slow components

---

## Tools

- **Component Dev:** Storybook
- **Testing:** React Testing Library, jest-axe, Playwright
- **Performance:** Lighthouse, React DevTools Profiler
- **Libraries:** Radix UI / Headless UI, TanStack Virtual, Framer Motion

---

## Learn More

- **Why this matters:** [[./frontend-ui-engineering/anti-rationalization]]
- **Common mistakes:** [[./frontend-ui-engineering/pitfalls]]
- **Detailed examples:** [[./frontend-ui-engineering/examples]]
- **Advanced patterns:** [[./frontend-ui-engineering/advanced]]

---

**v1.1.0** (2026-02-16): Refactored to progressive disclosure
