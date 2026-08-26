---
name: browser-testing-devtools
description: "Use browser DevTools for debugging, profiling, and E2E testing. Use when investigating UI bugs, performance issues, or validating frontend behavior."
metadata:
  phase: verify
  complexity: beginner
  duration: "Continuous (debugging sessions)"
  version: "1.1.0"
---

## When to Use

- ✅ Debugging frontend issues (rendering, styles, JavaScript errors)
- ✅ Investigating performance problems
- ✅ Analyzing network requests (API calls, failed requests)
- ✅ Testing responsive designs across devices
- ✅ Validating accessibility in real browsers

---

## Overview

Browser DevTools are built-in debugging and profiling tools in modern browsers. Mastering them enables rapid diagnosis of frontend issues.

**Core Principle:** Observe, measure, then fix—don't guess.

---

## Process

### 1. Console Debugging
- Log messages with context (`console.log`, `console.table`, `console.group`)
- Use `console.time`/`timeEnd` for performance
- Execute JavaScript in browser context
- Set breakpoints with `debugger;` statement

### 2. Elements Panel (DOM Inspection)
- Inspect HTML structure
- Edit CSS in real-time
- View computed styles
- Debug layout issues (box model diagram)
- Check event listeners

### 3. Network Panel
- Monitor API requests/responses
- Identify slow requests
- Check request headers
- Inspect response payloads
- Simulate network conditions (throttling)

### 4. Performance Panel
- Record performance profile
- Identify rendering bottlenecks
- Find JavaScript long tasks
- Analyze frame rate
- Memory profiling

### 5. Application Panel
- Inspect LocalStorage/SessionStorage
- View and edit cookies
- Check Service Workers
- Inspect IndexedDB
- Debug Progressive Web Apps

### 6. Lighthouse Audits
- Run performance audit
- Check accessibility compliance
- Validate SEO best practices
- Test Progressive Web App criteria

---

## Verification Checklist

- [ ] Console errors investigated and fixed
- [ ] Network requests optimized (< 2s load)
- [ ] Performance profile analyzed
- [ ] Lighthouse score ≥ 90 (performance, accessibility)
- [ ] Responsive design tested at 3+ breakpoints
- [ ] Cross-browser tested (Chrome, Firefox, Safari)

---

## Related Skills

- **Complements:** [Test-Driven Development](../test-driven-development/SKILL.md) - Automated tests catch regressions
- **Complements:** [Debugging & Error Recovery](../debugging-error-recovery/SKILL.md) - Systematic debugging process
- **After:** [Performance Optimization](../../review/performance-optimization/SKILL.md) - Fix identified bottlenecks
