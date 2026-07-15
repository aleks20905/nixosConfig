#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Map of remote targets: menu label -> flake attr -> ssh alias
declare -A REMOTES=(
  [obezglaven]="obezglaven"
  # add more later, e.g. [nas]="nas-alias"
)

remote_switch() {
  local flake_attr="$1"
  local host="$2"
  echo -e "${CYAN}Deploying $flake_attr to $host...${NC}"
  nixos-rebuild switch \
    --flake "$script_dir#$flake_attr" \
    --target-host "$host" \
    --build-host "$host" \
    --ask-elevate-password
}

remote_boot() {
  # stage for next reboot instead of switching immediately
  local flake_attr="$1"
  local host="$2"
  echo -e "${CYAN}Staging (boot) $flake_attr on $host...${NC}"
  nixos-rebuild boot \
    --flake "$script_dir#$flake_attr" \
    --target-host "$host" \
    --build-host "$host" \
    --ask-elevate-password
}

remote_test() {
  # activate without adding a boot entry - good for risky changes
  local flake_attr="$1"
  local host="$2"
  echo -e "${CYAN}Test-activating $flake_attr on $host (no bootloader entry)...${NC}"
  nixos-rebuild test \
    --flake "$script_dir#$flake_attr" \
    --target-host "$host" \
    --build-host "$host" \
    --ask-elevate-password
}

remote_diff() {
  local host="$1"
  echo -e "${CYAN}Diffing remote system generations on $host...${NC}"
  ssh "$host" 'nvd diff $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2)'
}

remote_gc() {
  local host="$1"
  echo -e "${CYAN}Garbage-collecting on $host...${NC}"
  ssh "$host" 'sudo nix-collect-garbage --delete-older-than 30d'
}

main() {
  echo -e "${CYAN}Remote NixOS hosts:${NC}"
  local i=1
  local keys=("${!REMOTES[@]}")
  for k in "${keys[@]}"; do
    echo -e "${YELLOW}$i.${NC} $k"
    ((i++))
  done
  read -p "Choose a host: " host_choice
  local flake_attr="${keys[$((host_choice - 1))]}"
  local host="${REMOTES[$flake_attr]}"

  if [ -z "$host" ]; then
    echo -e "${RED}Invalid choice.${NC}"
    exit 1
  fi

  echo -e "${CYAN}Action for $flake_attr:${NC}"
  echo -e "${YELLOW}1.${NC} Switch (activate + boot entry)"
  echo -e "${YELLOW}2.${NC} Test (activate only, no boot entry)"
  echo -e "${YELLOW}3.${NC} Boot (boot entry only, no activation)"
  echo -e "${YELLOW}4.${NC} Diff last two generations"
  echo -e "${YELLOW}5.${NC} Garbage collect (30d+)"
  read -p "Enter your choice: " action_choice

  case $action_choice in
  1) remote_switch "$flake_attr" "$host" ;;
  2) remote_test "$flake_attr" "$host" ;;
  3) remote_boot "$flake_attr" "$host" ;;
  4) remote_diff "$host" ;;
  5) remote_gc "$host" ;;
  *) echo -e "${RED}Invalid choice.${NC}" ;;s
  esac
}

main