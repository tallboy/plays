---
name: context-budget
description: "Audit token overhead across agents, skills, MCP servers, rules, and CLAUDE.md; classify each always/sometimes/rarely-needed and report prioritized savings. Use for 'context budget', 'why is context filling up', before adding another skill/agent/MCP server, or when output quality degrades in a long session."
---

# Context Budget

Every loaded component costs tokens whether or not it's ever used this session — an agent's description, a skill's frontmatter, an MCP server's tool schemas. Nothing here is free just because it wasn't invoked.

**Why:** principle-guard-the-context-window says route bulk to subagents and skip what you won't use — this skill is the audit that tells you where the bulk already is, before you can act on it.

## Workflow

1. **Inventory.** Estimate tokens per loaded component: `words × 1.3` for prose, `chars / 4` for code-heavy files.
   - **Agents** (`agents/*.md`) — lines and tokens per file; flag files >200 lines or descriptions >30 words (a bloated description loads into every Task invocation, used or not).
   - **Skills** (`skills/*/SKILL.md`) — tokens per file; flag files >400 lines.
   - **Rules / CLAUDE.md chain** — tokens per file; flag combined CLAUDE.md total >300 lines.
   - **MCP servers** (`.mcp.json` or active config) — tool count × ~500 tokens/tool schema; flag servers with >20 tools or servers wrapping a CLI already available for free (`gh`, `git`, `npm`).
2. **Classify** each component:
   - *Always needed* — referenced in CLAUDE.md, backs an active workflow, matches the project type. Keep.
   - *Sometimes needed* — domain-specific, not referenced anywhere standing. Consider on-demand activation instead of standing load.
   - *Rarely needed* — no reference, overlapping content, no match to this project. Remove.
3. **Detect issues:** bloated descriptions, heavy agents, redundant components (a skill duplicating an agent's logic, a rule duplicating CLAUDE.md), MCP over-subscription, CLAUDE.md bloat (verbose explanation, stale sections, instructions that should be a lint instead).
4. **Report**, ranked by token savings — biggest lever first. MCP schemas are usually the biggest single lever: one 30-tool server can cost more than every skill combined.

## Output

```
Context Budget
──────────────
Total estimated overhead: ~XX,XXX tokens (~XX% of window)

Component        Count   Tokens
Agents            N       ~X,XXX
Skills            N       ~X,XXX
Rules             N       ~X,XXX
MCP tools         N       ~XX,XXX
CLAUDE.md         N       ~X,XXX

Issues found (N), ranked by savings:
1. [action] → save ~X,XXX tokens
2. [action] → save ~X,XXX tokens

Potential savings: ~XX,XXX tokens (~XX% of current overhead)
```

State the estimation method used (word/char heuristic, not a real tokenizer) alongside the numbers — these are estimates, not measurements, and the report should say so rather than imply precision it doesn't have.
