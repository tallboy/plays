#!/usr/bin/env bash
# Compare a vendored plays install against this repo, and say exactly what
# drifted. Read-only: it never writes to the target.
#
#   bash scripts/sync.sh ~/code/myrepo            # finds .claude/skills/
#   bash scripts/sync.sh ~/.claude/skills         # or point straight at it
#
# Exit: 0 in sync · 1 drift (updates or missing skills) · 2 dangling router
# references, i.e. a broken install · 64 usage error.
#
# It deliberately does not apply anything. Installs carry retargets — a copied
# skill pointed at the host repo's own verify skill — and a blind re-copy
# clobbers them silently. So this reports, prints the commands, and leaves the
# judgment call where it belongs.
set -euo pipefail

PLAYS="$(cd "$(dirname "$0")/.." && pwd)"

if [ $# -ne 1 ]; then
  sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'
  exit 64
fi

target="${1%/}"
if [ -d "$target/.claude/skills" ]; then
  skills="$target/.claude/skills"
elif [ "$(basename "$target")" = "skills" ] && [ -d "$target" ]; then
  skills="$target"
else
  echo "no .claude/skills/ under '$target' (and it isn't a skills dir itself)" >&2
  exit 64
fi

echo "plays:  $PLAYS"
echo "target: $skills"
echo

# --- canonical set, read off the filesystem so it can't drift from the repo ---
canon() {
  find "$PLAYS/plays" -mindepth 1 -maxdepth 1 -type d ! -name principles
  find "$PLAYS/plays/principles" -mindepth 1 -maxdepth 1 -type d
}

# Names as one space-padded string, so membership is a `case` test rather than a
# pipeline: `canon | grep -q` lets grep exit on first match, SIGPIPEs find, and
# under `set -o pipefail` that reads as "not found" for whichever names happen to
# sort early. Every managed skill got reported project-local before this.
CANON_NAMES=" $(canon | while read -r d; do printf '%s ' "$(basename "$d")"; done)"

same=0; differs=0; missing=0; global=0
differs_list=""; missing_list=""

# A project that relies on the global install has no local copy, and that is not
# the same as a broken one. Only meaningful when the target isn't itself global.
GLOBAL_SKILLS="$HOME/.claude/skills"
[ "$skills" = "$GLOBAL_SKILLS" ] && GLOBAL_SKILLS=""

# A reference resolves if the skill is installed locally or globally.
have() { [ -d "$skills/$1" ] || { [ -n "$GLOBAL_SKILLS" ] && [ -d "$GLOBAL_SKILLS/$1" ]; }; }

echo "== managed skills =="
while read -r src; do
  name="$(basename "$src")"
  dst="$skills/$name"
  if [ ! -d "$dst" ] && [ -n "$GLOBAL_SKILLS" ] && [ -d "$GLOBAL_SKILLS/$name" ]; then
    if diff -rq "$src" "$GLOBAL_SKILLS/$name" >/dev/null 2>&1; then
      printf '  global   %s\n' "$name"
    else
      printf '  global*  %s  (global copy differs from plays)\n' "$name"
      global_stale=$((${global_stale:-0} + 1))
    fi
    global=$((global + 1))
  elif [ ! -d "$dst" ]; then
    printf '  MISSING  %s\n' "$name"
    missing=$((missing + 1)); missing_list="$missing_list $src"
  elif diff -rq "$src" "$dst" >/dev/null 2>&1; then
    printf '  same     %s\n' "$name"
    same=$((same + 1))
  else
    printf '  DIFFERS  %s\n' "$name"
    differs=$((differs + 1)); differs_list="$differs_list $src"
  fi
done < <(canon | sort)

# --- show what actually differs, because "DIFFERS" alone can't tell a stale
#     copy from a deliberate retarget, and those need opposite responses ---
if [ -n "$differs_list" ]; then
  echo
  echo "== what differs (< = plays, > = target) =="
  for src in $differs_list; do
    name="$(basename "$src")"
    printf '\n  --- %s\n' "$name"
    diff -r "$src" "$skills/$name" 2>&1 | grep -E '^[<>]' | head -12 | sed 's/^/  /' || true
    extra=$(diff -r "$src" "$skills/$name" 2>&1 | grep -cE '^[<>]' || true)
    [ "$extra" -gt 12 ] && printf '  … %s more changed lines\n' "$((extra - 12))"
  done
  echo
  echo "  A line pointing at this repo's own verify skill or command names is a"
  echo "  retarget: keep it, and reapply it after re-copying. Anything else is"
  echo "  upstream drift."
fi

# --- anything in the target that plays does not manage is the project layer ---
echo
echo "== project-local (not managed by plays) =="
local_found=0
for d in "$skills"/*/; do
  [ -d "$d" ] || continue
  name="$(basename "$d")"
  case "$CANON_NAMES" in
    *" $name "*) ;;
    *) printf '  %s\n' "$name"; local_found=1 ;;
  esac
done
[ "$local_found" -eq 1 ] || echo "  (none)"

# --- the remember step's log, which is per-repo even under a global install ---
echo
if [ "$skills" = "$HOME/.claude/skills" ]; then
  echo "== OBSERVED-FAILURES.md: not expected here =="
  echo "  this is the global install; the log lives in each repo's .claude/skills/"
  [ -f "$skills/OBSERVED-FAILURES.md" ] && echo "  WARNING: one exists here anyway — corrections from every repo would pool into it"
elif [ -f "$skills/OBSERVED-FAILURES.md" ]; then
  entries=$(grep -c '^## ' "$skills/OBSERVED-FAILURES.md" || true)
  echo "== OBSERVED-FAILURES.md: present, $entries entr$([ "$entries" = 1 ] && echo y || echo ies) =="
  [ "$entries" -ge 3 ] && echo "  improve gate fires at 3+ — run author-skills' Eval playbook before the next Ship"
else
  echo "== OBSERVED-FAILURES.md: absent =="
  echo "  the remember step has nowhere to land:"
  echo "    cp -n $PLAYS/templates/OBSERVED-FAILURES.md $skills/"
fi

# --- a router naming a skill that isn't installed is a broken install ---
dangling=0
router="$skills/go-tallboy/SKILL.md"
[ -f "$router" ] || [ -z "$GLOBAL_SKILLS" ] || router="$GLOBAL_SKILLS/go-tallboy/SKILL.md"
echo
echo "== router references =="
if [ ! -f "$router" ]; then
  echo "  (no router installed — skipping)"
else
  for s in $(grep -oE '\*\*[a-z][a-z-]*\*\* skill' "$router" | sed 's/\*\*//g;s/ skill//' | sort -u); do
    have "$s" || { printf '  DANGLING skill      %s\n' "$s"; dangling=$((dangling + 1)); }
  done
  for p in $(grep -oE 'principle-[a-z][a-z-]*' "$router" | sort -u); do
    have "$p" || { printf '  DANGLING principle  %s\n' "$p"; dangling=$((dangling + 1)); }
  done
  for pb in $(grep -oE 'playbooks/[a-z-]+\.md' "$router" | sort -u); do
    [ -f "$(dirname "$router")/$pb" ] || { printf '  DANGLING playbook   %s\n' "$pb"; dangling=$((dangling + 1)); }
  done
  [ "$dangling" -eq 0 ] && echo "  all resolve"
fi

# --- verdict ---
echo
echo "== summary =="
line="  $same same · $differs differs · $missing missing · $dangling dangling"
[ "$global" -gt 0 ] && line="$line · $global from global install"
echo "$line"
[ "${global_stale:-0}" -gt 0 ] && echo "  ${global_stale} global skill(s) differ from plays — re-run the global install (see README)"

if [ "$differs" -gt 0 ] || [ "$missing" -gt 0 ]; then
  echo
  echo "To update — re-copy, then REAPPLY THIS INSTALL'S RETARGETS by hand"
  echo "(check the commit messages that touched $skills for what was retargeted):"
  echo
  [ -n "$differs_list" ] && echo "  cp -r$differs_list \\" && echo "        $skills/"
  [ -n "$missing_list" ] && echo "  cp -r$missing_list \\" && echo "        $skills/"
  echo
  echo "Then re-run this script; it should report 0 differs, 0 missing, 0 dangling."
fi

[ "$dangling" -gt 0 ] && exit 2
{ [ "$differs" -gt 0 ] || [ "$missing" -gt 0 ]; } && exit 1
echo "  in sync"
exit 0
