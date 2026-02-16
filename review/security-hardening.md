# Skill: Security Hardening

**Phase:** Review | **Complexity:** Advanced | **Duration:** 1-4 hours (per feature)
**Prerequisites:** [[code-review-quality]]

---

## When to Use

- ✅ Handling authentication/authorization
- ✅ Processing user input
- ✅ Storing sensitive data (passwords, PII, payment info)
- ✅ Building public-facing APIs
- ✅ Before production deployment

---

## Overview

Apply security best practices to prevent common vulnerabilities. Focus on OWASP Top 10 and defense in depth.

**Core Principle:** Trust nothing, validate everything.

---

## Process: OWASP Top 10 Checklist

### 1. Broken Access Control
- Verify authorization on every endpoint
- Enforce principle of least privilege
- Check object-level permissions

### 2. Cryptographic Failures
- Hash passwords (bcrypt, Argon2)
- Encrypt sensitive data at rest
- Use HTTPS for data in transit
- Don't roll your own crypto

### 3. Injection Attacks
- Use parameterized queries (prevent SQL injection)
- Sanitize HTML output (prevent XSS)
- Validate and escape all user input
- Use ORMs correctly

### 4. Insecure Design
- Threat modeling for critical features
- Security requirements in specs
- Fail securely (deny by default)

### 5. Security Misconfiguration
- No default credentials
- Disable debug mode in production
- Keep dependencies updated
- Secure headers (CSP, HSTS, X-Frame-Options)

### 6. Vulnerable Components
- Audit dependencies regularly
- Update to latest secure versions
- Use tools: npm audit, Snyk, Dependabot

### 7. Authentication Failures
- Multi-factor authentication available
- Strong password requirements
- Rate limiting on login attempts
- Secure session management

### 8. Data Integrity Failures
- Verify digital signatures
- Validate serialized data
- Use integrity checks (checksums)

### 9. Logging Failures
- Log authentication attempts
- Don't log sensitive data (passwords, tokens)
- Monitor logs for suspicious activity

### 10. Server-Side Request Forgery (SSRF)
- Validate and sanitize URLs
- Use allowlists for external requests
- Network segmentation

---

## Verification Checklist

- [ ] All user input validated and sanitized
- [ ] Passwords hashed (never plaintext)
- [ ] Secrets in environment variables (not code)
- [ ] SQL injection prevented (parameterized queries)
- [ ] XSS prevented (output escaping)
- [ ] CSRF protection enabled
- [ ] HTTPS enforced
- [ ] Security headers configured
- [ ] Dependencies scanned for vulnerabilities
- [ ] Authentication rate limited

---

## Related Skills

- **During:** [[code-review-quality]] - Security review in PR process
- **Before:** [[../ship/shipping-launch]] - Security checklist before launch

---

## Tools

- **SAST:** SonarQube, Semgrep, CodeQL
- **Dependency Scanning:** Snyk, npm audit, OWASP Dependency-Check
- **Secrets Detection:** GitGuardian, TruffleHog
- **Penetration Testing:** OWASP ZAP, Burp Suite

---

## Learn More

- **Why this matters:** [[./security-hardening/anti-rationalization]]
- **Common mistakes:** [[./security-hardening/pitfalls]]
- **Detailed examples:** [[./security-hardening/examples]]

---

**v1.1.0** (2026-02-16): Refactored to progressive disclosure
