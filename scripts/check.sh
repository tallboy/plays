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
cp -r plays/verify-this plays/bootstrap-verify plays/adversarial-review plays/arena plays/unslop plays/epistemics "$tmp/skills/"
for d in "$tmp/skills"/*/; do
  base=$(basename "$d")
  [ "$base" = "go-tallboy" ] && continue
  [ -f "$d/SKILL.md" ] || err "installed skill '$base' has no SKILL.md one level deep — undiscoverable"
  nested=$(find "$d" -mindepth 2 -name SKILL.md | grep -v playbooks || true)
  [ -z "$nested" ] || err "installed skill '$base' hides nested SKILL.md files: $nested"
done
[ -f "$tmp/skills/go-tallboy/SKILL.md" ] || err "router did not install"
rm -rf "$tmp"

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
#        when the router gained the project-layer and pipeline-mode sections.
while read -r words f; do
  [ "$f" = "total" ] && continue
  if [ "$words" -gt 1800 ]; then err "$f is $words words (>1800) — trim it or raise this ratchet deliberately"; fi
done < <(find plays -name '*.md' -exec wc -w {} + | awk '{print $1, $2}')

if [ "$fail" -eq 0 ]; then echo "OK: all checks passed"; else exit 1; fi
