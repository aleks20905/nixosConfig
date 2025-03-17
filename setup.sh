#!/bin/bash

# Define color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'  # No Color (reset)

# Get the directory where the script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Function to switch to a specific mode
switch_mode() {
    local package_path="$1"
    echo -e "${CYAN}Switching to mode at: $package_path${NC}"
    sudo nixos-rebuild switch --flake "$package_path"
}

# Function to update all flakes
update_all_flakes() {
    echo -e "${CYAN}Updating all flake inputs...${NC}"
    sudo nix flake update
    echo -e "${GREEN}All flakes have been updated.${NC}"
}

# Function to update a specific flake
update_specific_flake() {
    echo -e "${CYAN}Available flake inputs:${NC}"
    echo -e "${YELLOW}1.${NC} nixpkgs"
    echo -e "${YELLOW}2.${NC} home-manager"
    echo -e "${YELLOW}3.${NC} spicetify-nix"
    echo -e "${YELLOW}4.${NC} Cancel"
    read -p "Enter the number of the flake to update: " flake_choice

    case $flake_choice in
        1) flake_name="nixpkgs" ;;
        2) flake_name="home-manager" ;;
        3) flake_name="spicetify-nix" ;;
        4) return ;;
        *)
            echo -e "${RED}Invalid choice. Please try again.${NC}"
            update_specific_flake
            return ;;
    esac

    echo -e "${CYAN}Updating flake: $flake_name ...${NC}"
    sudo nix flake lock --update-input "$flake_name"
    echo -e "${GREEN}Flake '$flake_name' has been updated.${NC}"
}

# Function to display the Update submenu
update_flakes() {
    echo ""
    echo -e "${CYAN}Update Flakes:${NC}"
    echo -e "${YELLOW}1.${NC} Update All Flakes"
    echo -e "${YELLOW}2.${NC} Update Specific Flake"
    echo -e "${YELLOW}0.${NC} Return to Main Menu"
    read -p "Enter your choice: " update_choice

    case $update_choice in
        1) update_all_flakes ;;
        2) update_specific_flake ;;
        0) return ;;
        *) 
            echo -e "${RED}Invalid choice. Please select a valid option.${NC}" 
            update_flakes ;;
    esac
}

# Function to view differences in system closures
what_happened() {
    echo -e "${CYAN}Showing system closure differences...${NC}"

    nvd diff $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2) # print only from this to the last rebild

    # nix store diff-closures /run/*-system
}

what_happened_between_boot() {
    echo -e "${CYAN}Showing system closure differences...${NC}"
    # all options does the prety much the same 

    nvd diff /run/booted-system /run/current-system
    # nvd diff /run/*-system # from boot to now  
    # nix store diff-closures /run/*-system
}

what_happened_all() {
    echo -e "${CYAN}Showing all profile closure differences...${NC}"
    nix profile diff-closures --profile /nix/var/nix/profiles/system
}

# Function to collect garbage and remove old versions based on user input
cleanup_system() {
    echo -e "${CYAN}Garbage Collection Options:${NC}"
    echo -e "${YELLOW}1.${NC} Delete everything"
    echo -e "${YELLOW}2.${NC} Delete older than 30 days"
    echo -e "${YELLOW}3.${NC} Custom number of days"
    echo -e "${YELLOW}0.${NC} Go back"
    read -p "Enter your choice: " gc_choice

    case $gc_choice in
        1)
            echo -e "${CYAN}Deleting everything...${NC}"
            sudo nix-collect-garbage -d ;;
        2)
            echo -e "${CYAN}Deleting everything older than 30 days...${NC}"
            sudo nix-collect-garbage --delete-older-than 30d ;;
        3)
            read -p "Enter the number of days: " days
            echo -e "${CYAN}Deleting everything older than $days days...${NC}"
            sudo nix-collect-garbage --delete-older-than "${days}d" ;;
        0)
            return ;; # Go back to the main menu
        *)
            echo -e "${RED}Invalid choice. Please choose again.${NC}"
            cleanup_system ;; # Call again if the choice is invalid
    esac
}

# Function to optimize the Nix store
nix_store_optimize() {
    echo -e "${CYAN}Optimizing Nix store...${NC}"
    sudo nix store optimize
    echo -e "${GREEN}Nix store optimized.${NC}"
}

# Main function to display menu and handle user input
main() {
    echo -e "${CYAN}Choose an option:${NC}"
    echo -e "${YELLOW}1.${NC} Obezglaven Mode"
    echo -e "${YELLOW}2.${NC} Laptop Mode"
    echo -e "${YELLOW}3.${NC} PC Mode"
    echo -e "${YELLOW}4.${NC} Update Flake(s)"
    echo -e "${YELLOW}5.${NC} What's Happened"
    echo -e "${YELLOW}6.${NC} What's Happened - ALL"
    echo -e "${YELLOW}7.${NC} Cleanup System (Garbage Collection)"
    echo -e "${YELLOW}8.${NC} Nix Store Optimize"
    echo -e "${YELLOW}0.${NC} Exit"

    read -p "Enter your choice: " choice
    case $choice in
        1) switch_mode "$script_dir#obezglaven" ;;
        2) switch_mode "$script_dir#laptop" ;;
        3) switch_mode "$script_dir#pc" ;;
        4) update_flakes ;; 
        5) what_happened ;;
        6) what_happened_all ;;
        7) cleanup_system ;;
        8) nix_store_optimize ;;
        0) echo -e "${GREEN}Exiting...${NC}"; exit ;;
        *) echo -e "${RED}Invalid choice. Please choose again.${NC}" ;;
    esac
}

# clear
echo -e "${BLUE}"
echo -e "=============================="
echo -e "      ${CYAN}NixOS Configuration ${BLUE}"
echo -e "=============================="
echo -e "${NC}"
main
echo ""
