# Skill: Context Engineering

**Phase:** Build | **Complexity:** Intermediate | **Duration:** 1-3 hours (initial setup)
**Prerequisites:** None

---

## When to Use

- ✅ Starting a new project with AI assistance
- ✅ Onboarding AI to existing codebase
- ✅ Team members get inconsistent AI suggestions
- ✅ AI repeatedly makes same mistakes or ignores conventions
- ✅ Want to create reusable slash commands for common workflows

---

## Overview

Document project conventions, constraints, and commands so AI assistants work effectively within your codebase. Well-engineered context prevents repeated corrections and enables sophisticated automation.

**Core Principle:** Document once, benefit forever.

This skill implements the **AGENTS.md Pattern** from [[../../Patterns/AGENTS-MD-Pattern]] and **Slash Commands Pattern** from [[../../Patterns/Slash-Commands-Pattern]].

---

## Process

### 1. Create AGENTS.md in Repository Root
```markdown
# AI Development Guidelines

**Last Updated:** [date]
**Project:** [name]

## Project Overview
- What this project does (2-3 sentences)
- Tech stack (language, framework, database, testing, deployment)

## Code Conventions
- Naming (files, classes, functions, constants)
- File structure
- Import order

## Quality Standards
- Commands to run before every commit
- Test coverage targets
- Documentation requirements

## AI Assistant Constraints
- Always: Required practices
- Never: Forbidden practices
- Preferences: Preferred approaches

## Domain-Specific Knowledge
- Business rules (pricing, inventory, etc.)
- Authentication/authorization flow
- Data privacy requirements
```

### 2. Document Project-Specific Patterns
- API response formats
- Error handling conventions
- Database query patterns
- Component/module patterns

### 3. Create Slash Commands (Optional)
```bash
mkdir -p .claude/commands

# Example: /implement-feature
# Defines: planning → spec → implementation → PR workflow
```

### 4. Validate Context with Test Prompts
- "Create a new API endpoint" → Check follows conventions
- "Fix a bug" → Check writes test first
- "Refactor code" → Check maintains behavior and runs tests

### 5. Iterate Based on Friction
- When AI makes mistake → Add constraint to AGENTS.md
- Test that AI now follows new guideline
- Update AGENTS.md changelog

---

## Verification Checklist

- [ ] AGENTS.md exists in repository root
- [ ] Tech stack and conventions documented
- [ ] Quality standards clearly defined
- [ ] AI constraints are specific (Always/Never sections)
- [ ] Domain knowledge captured (if applicable)
- [ ] AI assistant tested with 3-5 sample prompts
- [ ] AGENTS.md added to git and committed

---

## Related Skills

- **Complements:** [[incremental-implementation]] - Context ensures AI implements correctly
- **Complements:** [[../verify/test-driven-development]] - Context defines test standards
- **Complements:** [[../ship/documentation-adrs]] - ADRs capture decisions, AGENTS.md captures conventions

---

## Tools

- [[../../Patterns/AGENTS-MD-Pattern]] - Comprehensive AGENTS.md guide
- [[../../Patterns/Slash-Commands-Pattern]] - Command creation guide

---

## Learn More

- **Why this matters:** [[./context-engineering/anti-rationalization]]
- **Common mistakes:** [[./context-engineering/pitfalls]]
- **Detailed examples:** [[./context-engineering/examples]]

---

**v1.1.0** (2026-02-16): Refactored to progressive disclosure
