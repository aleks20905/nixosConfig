#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARSER="$SCRIPT_DIR/updateflake_parser.py"

help() {
  cat <<'EOF'
updateflake - flake update with before/after diff

Usage:
  sh updateflake.sh              preview + apply (with confirmation)
  sh updateflake.sh --check      show current state only, no changes
  sh updateflake.sh --apply      skip preview, apply directly
  sh updateflake.sh --help       show this help
EOF
}

APPLY=false
CHECK_ONLY=false

for arg in "$@"; do
  case "$arg" in
    --apply|-a) APPLY=true ;;
    --check|-c) CHECK_ONLY=true ;;
    --help|-h) help; exit 0 ;;
    *)
      echo "Unknown flag: $arg (try --help)"
      exit 1
      ;;
  esac
done

if [[ -t 1 ]]; then
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  CYAN='\033[0;36m'
  BOLD='\033[1m'
  DIM='\033[2m'
  RST='\033[0m'
else
  RED=''
  GREEN=''
  YELLOW=''
  CYAN=''
  BOLD=''
  DIM=''
  RST=''
fi

FLAKE="flake.nix"
LOCK="flake.lock"

if [[ ! -f "$FLAKE" || ! -f "$LOCK" ]]; then
  echo -e "${RED}Error: $FLAKE or $LOCK not found${RST}"
  exit 1
fi

all_inputs=$(grep -oP '^\s*([A-Za-z0-9_-]+)\.url' "$FLAKE" | sed 's/\s*\.url.*//')
locked_tags=$(grep -oP '^\s*([A-Za-z0-9_-]+)\.url.*#\s*--lock;' "$FLAKE" | sed 's/\.url.*//')
auto_tags=$(grep -oP '^\s*([A-Za-z0-9_-]+)\.url.*#\s*--auto;' "$FLAKE" | sed 's/\.url.*//')

# flake.nix convention: every input carries exactly one tag, --lock; or --auto;
for name in $all_inputs; do
  in_locked=false
  in_auto=false
  echo "$locked_tags" | grep -qw "$name" && in_locked=true
  echo "$auto_tags" | grep -qw "$name" && in_auto=true

  if [[ "$in_locked" == true && "$in_auto" == true ]]; then
    echo -e "${RED}Error: $name carries both --lock; and --auto; in $FLAKE${RST}"
    exit 1
  fi
  if [[ "$in_locked" == false && "$in_auto" == false ]]; then
    echo -e "${RED}Error: $name has no tag in $FLAKE. Add '# --lock;' to pin or '# --auto;' to update.${RST}"
    exit 1
  fi
done

# name → url pairs from flake.nix input lines
declare -A input_url
while IFS=$'\t' read -r name url; do
  input_url[$name]="$url"
done < <(grep -oP '^\s*([A-Za-z0-9_-]+)\.url\s*=\s*"[^"]*"' "$FLAKE" | sed -E 's/^\s*([A-Za-z0-9_-]+)\.url\s*=\s*"([^"]*)"/\1\t\2/')

lock_state() {
  python3 "$PARSER" lockstate "$LOCK" 2>/dev/null
}

latest_rev() {
  local input=$1
  local url=${input_url[$input]:-$input}
  local out
  out=$(python3 "$PARSER" latest "$url" 2>/dev/null) || out=$'n/a\t0'
  echo "$out"
}

fmt_date() {
  local ts=$1
  if [[ "$ts" == "0" || -z "$ts" ]]; then
    echo "n/a"
    return
  fi
  local now
  now=$(date +%s)
  local diff=$(( now - ts ))

  if (( diff < 60 )); then
    echo "just now"
  elif (( diff < 3600 )); then
    echo "$(( diff / 60 ))m ago"
  elif (( diff < 86400 )); then
    echo "$(( diff / 3600 ))h ago"
  elif (( diff < 2592000 )); then
    echo "$(( diff / 86400 ))d ago"
  else
    echo "$(( diff / 2592000 ))mo ago"
  fi
}

declare -A cur_rev cur_ts
while IFS=$'\t' read -r name rev ts repo owner branch; do
  cur_rev[$name]="$rev"
  cur_ts[$name]="$ts"
done < <(lock_state)

echo
echo -e "${BOLD}${CYAN}╔════════════════════════════════════════════════╗${RST}"
echo -e "${BOLD}${CYAN}║  ❄  Flake Update                              ║${RST}"
echo -e "${BOLD}${CYAN}╚════════════════════════════════════════════════╝${RST}"
echo

updates_available=0
declare -A new_rev

if [[ "$CHECK_ONLY" != true ]]; then
  echo -e "  ${DIM}checking latest from GitHub...${RST}"
fi

for name in $all_inputs; do
  is_locked=false
  if echo "$locked_tags" | grep -qw "$name"; then
    is_locked=true
  fi

  cr="${cur_rev[$name]:-n/a}"
  ct="${cur_ts[$name]:-0}"

  if [[ "$is_locked" == true ]]; then
    printf "  %-24s ${YELLOW}🔒 locked${RST}  ${DIM}%-10s %s${RST}\n" "$name" "$(fmt_date "$ct")" "$cr"
    continue
  fi

  if [[ "$CHECK_ONLY" == true ]]; then
    printf "  %-24s ${GREEN}●${RST}  ${DIM}%-10s %s${RST}\n" "$name" "$(fmt_date "$ct")" "$cr"
    continue
  fi

  printf "  ${CYAN}↵ %-22s${RST} checking..." "$name" >&2
  read -r lr lt <<< "$(latest_rev "$name")"
  printf "\r\033[K" >&2

  new_rev[$name]="$lr"

  if [[ "$lr" == "$cr" ]]; then
    printf "  %-24s ${GREEN}✓ up to date${RST}   ${DIM}%-10s %s${RST}\n" "$name" "$(fmt_date "$ct")" "$cr"
  elif [[ "$lt" == "0" || "$lr" == "n/a" ]]; then
    printf "  %-24s ${YELLOW}? unknown${RST}     ${DIM}%-10s %s${RST}\n" "$name" "$(fmt_date "$ct")" "$cr"
    ((updates_available++)) || true
  else
    printf "  %-24s ${RED}↓ update${RST}       ${DIM}%-10s %s${RST}  →  ${GREEN}%-10s %s${RST}\n" \
      "$name" "$(fmt_date "$ct")" "$cr" "$(fmt_date "$lt")" "$lr"
    ((updates_available++)) || true
  fi
done

echo

if [[ "$CHECK_ONLY" == true ]]; then
  echo -e "  ${DIM}(--check mode, no changes made)${RST}"
  echo
  exit 0
fi

if (( updates_available == 0 )); then
  echo -e "  ${GREEN}All inputs are up to date.${RST}"
  echo
  exit 0
fi

if [[ "$APPLY" != true ]]; then
  echo -e "  ${BOLD}Update ${updates_available} input(s)?${RST} [y/N] "
  read -r confirm
  if [[ "${confirm}" != [yY] ]]; then
    echo -e "  ${DIM}Aborted.${RST}"
    echo
    exit 0
  fi
fi

echo
echo -e "${BOLD}${CYAN}── Updating ────────────────────────────────────${RST}"
echo

changed=0
for name in $all_inputs; do
  is_locked=false
  if echo "$locked_tags" | grep -qw "$name"; then
    is_locked=true
  fi
  [[ "$is_locked" == true ]] && continue

  lr="${new_rev[$name]:-n/a}"
  cr="${cur_rev[$name]:-n/a}"
  [[ "$lr" == "$cr" ]] && continue

  printf "  ${CYAN}⟳ %-22s${RST}" "$name"
  if nix flake update "$name" 2>/dev/null; then
    printf " ${GREEN}done${RST}\n"
    ((changed++)) || true
  else
    printf " ${RED}failed${RST}\n"
  fi
done

echo
echo -e "${BOLD}${CYAN}── Summary ──────────────────────────────────────${RST}"
echo

declare -A final_rev
while IFS=$'\t' read -r name rev ts repo owner branch; do
  final_rev[$name]="$rev"
done < <(lock_state)

printf "  ${DIM}%-22s  %-14s  %-14s${RST}\n" "INPUT" "BEFORE" "AFTER"
printf "  ${DIM}%-22s  %-14s  %-14s${RST}\n" "──────────────────────" "──────────────" "──────────────"

for name in $all_inputs; do
  is_locked=false
  if echo "$locked_tags" | grep -qw "$name"; then
    is_locked=true
  fi

  cr="${cur_rev[$name]:-n/a}"
  fr="${final_rev[$name]:-n/a}"

  if [[ "$is_locked" == true ]]; then
    printf "  ${DIM}%-22s  %-14s  %-14s${RST}\n" "$name" "$cr (locked)" "$fr (locked)"
    continue
  fi

  if [[ "$cr" == "$fr" ]]; then
    printf "  ${DIM}%-22s  %-14s  %-14s${RST}\n" "$name" "$cr" "$fr"
  else
    printf "  %-22s  ${RED}%-14s${RST}  ${GREEN}%-14s${RST}\n" "$name" "$cr" "$fr"
  fi
done

echo
if (( changed > 0 )); then
  echo -e "  ${GREEN}✓ ${changed} input(s) updated${RST}"
  echo -e "  ${DIM}Run 'nixos-rebuild switch' (or your setup.sh) to apply.${RST}"
else
  echo -e "  ${DIM}No inputs were updated.${RST}"
fi
echo