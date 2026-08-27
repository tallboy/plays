---
name: bootstrap-verify
description: "Generate a project-local verification skill that drives the app the way a user does — any language, framework, or platform. Use for 'set up verification for this repo', 'make a verify skill', or when a project has no scripted way to prove UI/CLI/service behavior. Also covers the maintenance pass that keeps it honest."
---

# Bootstrap Verification

Every serious project needs a scripted way to drive the real app and prove behavior: launch it, exercise a feature the way a user would, and capture evidence. This skill generates that as a project-local skill (`.claude/skills/verify-<app>/`) tailored to the repo. Write the output for the next agent, not for a human: it will be read cold, mid-task, by an agent that has never seen the app.

This is what makes verification portable: don't ship a universal verify gate — generate a repo-specific one and prove it runs.

## 1. Interview the repo, not the user

Answer these from the codebase; ask the user only what you cannot observe:

- **Surface:** what does a user actually touch? Web UI, CLI/TUI, desktop app, API, mobile app, library? Pick the primary one and note the rest.
- **Run:** how does the app start locally? Prefer the repo's own documented dev command (package scripts, Makefile, README quickstart). Note ports, env vars, seed data, auth.
- **Gates:** what checks already exist? Read CI config for the true gate list and path triggers — CI is the source of truth, not the README. If the repo has a composite gate (`preflight`, `check-all`), bind to it; if it doesn't, propose one, because per-command gate lists drift.
- **Drive:** how can an agent interact with the app programmatically? Existing harnesses first — Playwright/Cypress specs, expect scripts, curl-able endpoints, a debug port. Only then pick a generic recipe: browser/CDP for web and Electron, tmux/PTY for CLI/TUI, plain HTTP for services.
- **Observe:** what evidence can be captured? Screenshots, terminal transcripts, response bodies, logs, exit codes, DB state.
- **Isolate:** can two instances run side by side (ports, data dirs, profiles)? If not, say so in the generated skill: refusing to double-drive a shared instance beats corrupting the user's session.

If the checkout doesn't build or start as-is, fix that first (or report it precisely) before generating; a skill written against a broken base teaches wrong steps.

## 2. Generate the skill

Write `.claude/skills/verify-<app>/SKILL.md` with frontmatter (`name`, and a `description` naming the app, the surface, and when to reach for it) and these sections, each grounded in what the interview actually found — no placeholders left:

- **Launch:** the exact command that starts the app for verification, and how to tell it's ready (a log line, a port answering, a prompt). Include teardown. For a short-lived CLI there is no server to keep alive: launch means build once, then start each drive in its own isolated session.
- **Doctor:** one read-only check that answers "is this instance worth driving?" — process up, right version, port owned by us, auth valid. Run it first whenever anything looks off.
- **Gates:** the gate commands and when each runs, preferring the composite entry point. A gate that cannot run must fail loud, never silently skip.
- **Drive:** the harness recipe with real selectors/commands from this repo, not examples. Prefer stable handles (ARIA labels, data attributes, prompt strings, route paths) over coordinates.
- **Evidence:** what to capture for a proof and where it goes. Exercise the real user path, not internal setters or test-only endpoints; capture the action and the resulting state, not just the final screen; verify side effects (files written, rows inserted) alongside what's visible. When the safe path is a dry-run mode, verify what it actually skips by observing rather than trusting its name.
- **Cleanup:** tear down what the run created. Never kill by process name; kill what you started. Cleanup removes instances and scratch state, never the evidence: proof artifacts survive teardown, in a location the skill names.

## 3. Seed the feature map

Create `features/README.md` plus one file per user-facing feature (top 3–5 to start, from routes, commands, menus, or docs). Each file answers, from the user's point of view: what the feature is, how to reach it, how to drive it with the harness, and what observable end state proves it works. Sections: `Sub-features`, `How to get to it (user POV)`, `Driving it`, `Gotchas`.

The map is what turns a vague bug report ("screenshot + ???") into something an agent can navigate to and reproduce. A proof that drives one convenient entry point is incomplete when the map lists others.

## 4. Prove the generated skill before handing it over

Run its own instructions end to end once: launch, doctor, drive ONE mapped feature, capture evidence, clean up. After cleanup, confirm the evidence still exists at the named location — a cleanup that eats the proof fails this step. Fix what fails, and run cleanup after every failed iteration too. **A generated skill that was never executed is a draft, not a deliverable.**

## 5. The maintenance pass

A feature map rots the moment the app changes. On "audit the verify skill" or when drift shows:

- **Edit scope:** only the verification skill's own directory. Never edit product code during a maintenance run — behavior the map describes that the app no longer does is either doc drift (fix the map) or a product regression (report it; don't paper over it in docs).
- **Source pass:** one read-only check per feature file — does the source still match the described behavior? Flag drift with citations.
- **Live pass:** required even when source looks clean. Exercise every mapped feature at least once. Doctor before first drive and after any failed drive; evidence survives every cleanup; nothing a drive started outlives the run.
- **Triage:** wrong user-POV description → doc drift, fix it. Working behavior the harness can't drive → harness gap, fix it. Behavior that's actually broken → product gap; record it for the user, keep it out of this change.
- **Outcome, stated:** `clean` (full coverage, nothing to ship), `changed` (one change set of proven corrections), or `blocked` (say exactly what blocked it).
