---
name: "Shipping and Launch"
phase: "ship"
complexity: "advanced"
duration: "1-4 hours (pre-launch checklist)"
prerequisites: ["ci-cd-automation", "security-hardening", "performance-optimization"]
version: "1.1.0"
---

## When to Use

- ✅ Deploying to production for first time
- ✅ Launching new major feature
- ✅ Going live with public-facing service
- ✅ Preparing for high-traffic event

---

## Overview

Comprehensive pre-launch checklist ensures production readiness across functionality, security, performance, and operations.

**Core Principle:** Hope is not a strategy—validate everything before launch.

---

## Process: Production Readiness Checklist

### 1. Functionality
- [ ] All acceptance criteria met
- [ ] Manual testing completed
- [ ] Smoke tests passing
- [ ] Feature flags configured
- [ ] Rollback plan documented

### 2. Security
- [ ] Authentication & authorization tested
- [ ] Input validation on all endpoints
- [ ] Secrets in environment variables
- [ ] HTTPS enforced
- [ ] Security headers configured
- [ ] Dependencies scanned (no critical vulnerabilities)
- [ ] CORS configured correctly

### 3. Performance
- [ ] Load testing completed
- [ ] Database queries optimized
- [ ] API response times < 500ms
- [ ] Frontend Core Web Vitals passing
- [ ] CDN configured for static assets
- [ ] Caching strategy implemented

### 4. Observability
- [ ] Logging configured
- [ ] Error tracking (Sentry, Rollbar)
- [ ] APM instrumented (New Relic, Datadog)
- [ ] Uptime monitoring (Pingdom, UptimeRobot)
- [ ] Alerts configured for critical metrics
- [ ] Dashboards created

### 5. Operations
- [ ] Deployment process documented
- [ ] Rollback plan tested
- [ ] Database migrations tested
- [ ] Backup strategy in place
- [ ] Disaster recovery plan documented
- [ ] On-call rotation defined

### 6. Compliance
- [ ] GDPR compliance (if handling EU data)
- [ ] Privacy policy updated
- [ ] Terms of service updated
- [ ] Accessibility tested (WCAG 2.1 AA)

### 7. Communication
- [ ] Stakeholders notified of launch
- [ ] Documentation published
- [ ] Support team trained
- [ ] Launch announcement prepared

---

## Launch Day Checklist

**Before Launch:**
- [ ] Final smoke test in staging
- [ ] Team on standby
- [ ] Monitoring dashboards open
- [ ] Communication channels ready

**During Launch:**
- [ ] Deploy with feature flag off (gradual rollout)
- [ ] Monitor error rates
- [ ] Monitor performance metrics
- [ ] Watch for user reports

**After Launch:**
- [ ] Verify key user flows working
- [ ] Check error tracking tools
- [ ] Review performance metrics
- [ ] Gradual rollout (10% → 50% → 100%)
- [ ] Post-launch retrospective scheduled

---

## Verification Checklist

- [ ] All production readiness items checked
- [ ] Launch plan reviewed by team
- [ ] Rollback plan ready and tested
- [ ] Monitoring and alerts confirmed working
- [ ] Team briefed on launch process
- [ ] Post-launch review scheduled

---

## Related Skills

- **Before:** [Security Hardening](../review/security-hardening.md) - Security review
- **Before:** [Performance Optimization](../review/performance-optimization.md) - Performance validation
- **Before:** [CI/CD Automation](ci-cd-automation.md) - Deployment automation
- **After:** [Documentation & ADRs](documentation-adrs.md) - Document launch decisions
