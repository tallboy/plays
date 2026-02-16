# Skill: Browser Testing and DevTools

**Phase:** Verify | **Complexity:** Beginner | **Duration:** Continuous (debugging sessions)
**Prerequisites:** None (foundational skill)

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

- **Complements:** [[test-driven-development]] - Automated tests catch regressions
- **Complements:** [[debugging-error-recovery]] - Systematic debugging process
- **After:** [[../review/performance-optimization]] - Fix identified bottlenecks

---

## Tools

- **Chrome DevTools** - Most comprehensive
- **Firefox Developer Tools** - Great for CSS Grid/Flexbox
- **Safari Web Inspector** - iOS debugging
- **Lighthouse** - Automated audits

---

## Learn More

- **Why this matters:** [[./browser-testing-devtools/anti-rationalization]]
- **Common mistakes:** [[./browser-testing-devtools/pitfalls]]
- **Detailed examples:** [[./browser-testing-devtools/examples]]

---

**v1.1.0** (2026-02-16): Refactored to progressive disclosure
