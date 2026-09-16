---
name: security-scan
description: "Audit a .claude/ directory (CLAUDE.md, settings.json, MCP config, hooks, agent files) for secrets, prompt-injection surface, and permission over-grants using AgentShield. Use for 'security scan', 'audit the agent config', before committing changes to settings.json/CLAUDE.md/MCP config, or when onboarding to a repo with an existing Claude Code setup."
---

# Security Scan

Agent configuration is an attack surface, not just settings — a hardcoded secret in `CLAUDE.md`, an unrestricted `Bash(*)` allow, or a hook that interpolates a filename into a shell command are all exploitable the same way application code is. Treat the `.claude/` directory as code that needs review, because it runs like code.

**Why:** this is a review step, not a build step — it never modifies config unless run with `--fix`, and even then it only applies changes marked safe.

## Prerequisite

Requires the `agentshield` CLI ([AgentShield](https://github.com/affaan-m/agentshield), MIT, npm package `ecc-agentshield`):

```bash
npx ecc-agentshield --version   # check if available
npm install -g ecc-agentshield  # install globally
```

If npm isn't available or the install fails, degrade to a manual pass over the same checklist: grep `.claude/` for hardcoded secrets, `Bash(*)` or other unrestricted allows, `${...}`-style interpolation in hook commands, and `2>/dev/null`/`|| true` swallowing errors. Say which mode ran — tool-backed or manual — in the output.

## Workflow

1. **Scan.** `agentshield scan --path .claude` (or `--path .` for the whole repo). Add `--min-severity medium` to cut noise on a first pass.
2. **Read the grade and findings**, ranked by severity:
   - **Critical** (fix immediately): hardcoded API keys/tokens in config, `Bash(*)` unrestricted shell access, command injection via `${file}`-style interpolation in a hook, a shell-running MCP server.
   - **High** (fix before shipping): auto-run instructions in CLAUDE.md (a prompt-injection vector), missing deny lists, agents with Bash access they don't need.
   - **Medium**: silent error suppression in hooks (`2>/dev/null`, `|| true`), missing PreToolUse security hooks, `npx -y` auto-install in MCP configs.
   - **Info**: missing MCP server descriptions.
3. **Fix.** `agentshield scan --fix` applies only auto-fixable changes (secrets → env-var references, wildcard permissions → scoped ones) and never touches a manual-only finding. Review the diff before committing — this skill doesn't grant the fix a pass it hasn't earned.
4. **Re-scan** to confirm the grade moved and nothing new appeared.

## Grades

| Grade | Score | Meaning |
|---|---|---|
| A | 90–100 | Secure configuration |
| B | 75–89 | Minor issues |
| C | 60–74 | Needs attention |
| D | 40–59 | Significant risks |
| F | 0–39 | Critical vulnerabilities |

## Output

The grade, findings by severity with file:line, which findings were auto-fixed versus need a manual decision, and the re-scan result if `--fix` ran.
