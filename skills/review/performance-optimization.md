---
name: "Performance Optimization"
phase: "review"
complexity: "intermediate"
duration: "2-8 hours (per optimization)"
prerequisites: ["browser-testing-devtools"]
version: "1.1.0"
---

## When to Use

- ✅ Page load time > 3 seconds
- ✅ API response time > 500ms
- ✅ Database queries slow (> 100ms)
- ✅ Memory usage growing unbounded
- ✅ User complaints about sluggishness

---

## Overview

Measure first, optimize second. Focus on 80/20 rule—fix bottlenecks that impact most users.

**Core Principle:** Premature optimization is evil, but measured optimization is engineering.

---

## Process

### 1. Measure Performance
**Frontend:**
- Lighthouse audit (Core Web Vitals)
- Chrome Performance panel
- Network waterfall analysis

**Backend:**
- APM tools (New Relic, Datadog)
- Query profiling
- Load testing (k6, JMeter)

### 2. Identify Bottlenecks
**Common Culprits:**
- N+1 database queries
- Unoptimized images
- Missing indexes
- Excessive JavaScript bundle size
- Memory leaks
- Slow external API calls

### 3. Optimize (Priority Order)

**Database:**
- Add indexes on frequently queried columns
- Use eager loading to prevent N+1
- Cache expensive queries (Redis)
- Optimize query structure

**Frontend:**
- Code splitting (lazy load routes)
- Image optimization (WebP, responsive images)
- Tree shaking (remove unused code)
- Memoization (React.memo, useMemo)
- Virtualize long lists

**Backend:**
- Cache frequently accessed data
- Use connection pooling
- Implement pagination
- Async/non-blocking operations
- Compress responses (gzip)

### 4. Verify Improvement
- Re-run performance tests
- Compare before/after metrics
- Monitor in production

---

## Verification Checklist

**Frontend:**
- [ ] Lighthouse score ≥ 90 (performance)
- [ ] LCP < 2.5s
- [ ] FID < 100ms
- [ ] CLS < 0.1
- [ ] Bundle size < 200KB (gzipped)

**Backend:**
- [ ] API response time < 500ms (p95)
- [ ] Database queries < 100ms
- [ ] No N+1 queries
- [ ] Memory usage stable (no leaks)
- [ ] CPU usage < 70% under load

---

## Related Skills

- **Uses:** [Browser Testing & DevTools](../verify/browser-testing-devtools.md) - Profile and measure
- **After:** [Code Review Quality](code-review-quality.md) - Review optimization changes
- **Before:** [Shipping & Launch](../ship/shipping-launch.md) - Performance validated before launch
