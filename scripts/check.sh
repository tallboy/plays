#!/usr/bin/env bash
# Structural gate for the plays suite. Run from the repo root: bash scripts/check.sh
# The suite's own encode-lessons-in-structure principle, applied to itself:
# every failure mode below was observed once before being encoded here.
set -euo pipefail

cd "$(dirname "$0")/.."
fail=0
err() { echo "FAIL: $1"; fail=1; }

# --- 1. Every skill dir has a SKILL.md with name/description frontmatter,
#        name matches the dir, description is in trigger form.
skill_dirs=$(find plays -mindepth 1 -maxdepth 2 -type d ! -name playbooks ! -name principles ! -path 'plays/principles' ; find plays/principles -mindepth 1 -maxdepth 1 -type d)
for d in $skill_dirs; do
  case "$d" in plays/go-tallboy/playbooks) continue;; esac
  f="$d/SKILL.md"
  if [ ! -f "$f" ]; then err "$d has no SKILL.md"; continue; fi
  name=$(sed -n 's/^name: *//p' "$f" | head -1 | tr -d '"')
  desc=$(sed -n 's/^description: *//p' "$f" | head -1)
  base=$(basename "$d")
  [ -n "$name" ] || err "$f missing name: frontmatter"
  [ -n "$desc" ] || err "$f missing description: frontmatter"
  [ "$name" = "$base" ] || err "$f name '$name' != dir '$base'"
  case "$desc" in
    *"Use for"*|*"Use when"*|*"Apply "*) ;;
    *) err "$f description not in trigger form (needs 'Use for/when' or 'Apply')";;
  esac
done

# --- 2. Install simulation: the README's install command must land every
#        skill exactly one directory deep (skills nested deeper never load).
tmp=$(mktemp -d)
mkdir -p "$tmp/skills"
cp -r plays/go-tallboy plays/principles/principle-* "$tmp/skills/"
cp -r plays/verify-this plays/bootstrap-verify plays/adversarial-review plays/arena plays/unslop plays/epistemics plays/receive-review plays/author-skills plays/file-issue plays/context-budget plays/strategic-compact plays/security-scan "$tmp/skills/"
cp -n templates/OBSERVED-FAILURES.md "$tmp/skills/"
for d in "$tmp/skills"/*/; do
  base=$(basename "$d")
  [ "$base" = "go-tallboy" ] && continue
  [ -f "$d/SKILL.md" ] || err "installed skill '$base' has no SKILL.md one level deep — undiscoverable"
  nested=$(find "$d" -mindepth 2 -name SKILL.md | grep -v playbooks || true)
  [ -z "$nested" ] || err "installed skill '$base' hides nested SKILL.md files: $nested"
done
[ -f "$tmp/skills/go-tallboy/SKILL.md" ] || err "router did not install"
[ -f "$tmp/skills/OBSERVED-FAILURES.md" ] || err "the remember step's log template did not install — the improve gate has nothing to count"
rm -rf "$tmp"

# --- 2b. The log template must not count as an entry before anyone writes one.
#         Observed: an entry heading at column zero inside the template's example
#         fence counted itself, so the improve gate would fire a correction early.
seeded=$(grep -c '^## ' templates/OBSERVED-FAILURES.md || true)
[ "$seeded" -eq 0 ] || err "OBSERVED-FAILURES.md template reads as $seeded entries while still empty — indent the example heading inside its fence"

# --- 3. No relative markdown links (they break under copy-install).
links=$(grep -rn '](\.\./' plays/ || true)
[ -z "$links" ] || err "relative links found (break when copied): $links"

# --- 4. Every playbook the router names exists; every playbook file is named.
for p in $(grep -o 'playbooks/[a-z-]*\.md' plays/go-tallboy/SKILL.md | sort -u); do
  [ -f "plays/go-tallboy/$p" ] || err "router references missing $p"
done
for f in plays/go-tallboy/playbooks/*.md; do
  b=$(basename "$f")
  grep -q "playbooks/$b" plays/go-tallboy/SKILL.md || err "$b exists but the router table never names it"
done

# --- 5. Every principle the router indexes exists; every principle dir is indexed.
for p in $(grep -oE 'principle-[a-z][a-z-]*' plays/go-tallboy/SKILL.md | sort -u); do
  [ -d "plays/principles/$p" ] || err "router indexes missing principle dir: $p"
done
for d in plays/principles/principle-*/; do
  b=$(basename "$d")
  grep -q "$b" plays/go-tallboy/SKILL.md || err "$b exists but the router index never names it"
done

# --- 6. No placeholders; no fabricated-evidence tells.
ph=$(grep -rnE '\bTODO\b|\bPLACEHOLDER\b|\(add [a-z ]* here\)' plays/ || true)
[ -z "$ph" ] || err "placeholder text shipped: $ph"

# --- 7. Token ratchet: no skill file grows past the limit without a
#        deliberate bump here. History: 1600 at creation; 1800 on 2026-08-26
#        when the router gained the project-layer and pipeline-mode sections;
#        1820 on 2026-09-02 when the router gained the file-issue trigger;
#        1900 on 2026-09-15 when the router gained the context-budget,
#        strategic-compact, and security-scan triggers; 1920 on 2026-09-15
#        when the router and author-skills gained the OBSERVED-FAILURES.md
#        remember step (evals/BASELINE.md Run 7); 2000 on 2026-09-16 when
#        the router gained the mandatory review and improve gates
#        (evals/BASELINE.md Run 8).
while read -r words f; do
  [ "$f" = "total" ] && continue
  if [ "$words" -gt 2000 ]; then err "$f is $words words (>2000) — trim it or raise this ratchet deliberately"; fi
done < <(find plays -name '*.md' -exec wc -w {} + | awk '{print $1, $2}')

# --- 8. sync.sh smoke test. It gates upgrades, so a silent break in it is a
#        silent break in every install. HOME is redirected at a temp dir so the
#        developer's own global install can't change the answer.
#        History: `canon | grep -q` let grep exit on first match, SIGPIPEd find,
#        and under `set -o pipefail` that read as "not found" — every managed
#        skill was reported project-local. Case 1 encodes exactly that.
st=$(mktemp -d)
mkdir -p "$st/skills" "$st/home"
cp -r plays/go-tallboy plays/principles/principle-* "$st/skills/" 2>/dev/null
cp -r plays/verify-this plays/bootstrap-verify plays/adversarial-review plays/arena plays/unslop plays/epistemics plays/receive-review plays/author-skills plays/file-issue plays/context-budget plays/strategic-compact plays/security-scan "$st/skills/"
cp -n templates/OBSERVED-FAILURES.md "$st/skills/"

out=$(HOME="$st/home" bash scripts/sync.sh "$st/skills" 2>&1) && rc=0 || rc=$?
[ "$rc" -eq 0 ] || err "sync.sh exits $rc on a complete install (expected 0)"
echo "$out" | grep -q "0 missing" || err "sync.sh does not report 0 missing on a complete install"
echo "$out" | sed -n '/project-local/,/^$/p' | grep -q "(none)" || err "sync.sh reports managed skills as project-local: $(echo "$out" | sed -n '/project-local/,/^$/p' | tr '\n' ' ')"

rm -rf "$st/skills/epistemics"
out=$(HOME="$st/home" bash scripts/sync.sh "$st/skills" 2>&1) && rc=0 || rc=$?
[ "$rc" -eq 2 ] || err "sync.sh exits $rc when the router names an uninstalled skill (expected 2)"
echo "$out" | grep -q "DANGLING skill      epistemics" || err "sync.sh missed a dangling router reference"
rm -rf "$st"

if [ "$fail" -eq 0 ]; then echo "OK: all checks passed"; else exit 1; fi
