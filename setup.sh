#!/bin/bash

# Get the directory where the script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Function to switch to a specific mode
switch_mode() {
    local package_path="$1"
    echo "Switching to mode at: $package_path"
    sudo nixos-rebuild switch --flake "$package_path"
}

# Function to update all flakes
update_all_flakes() {
    echo "Updating all flake inputs..."
    sudo nix flake update
    echo "All flakes have been updated."
}

# Function to update a specific flake
update_specific_flake() {
    echo "Available flake inputs:"
    echo "1. nixpkgs"
    echo "2. home-manager"
    echo "3. spicetify-nix"
    echo "4. Cancel"
    read -p "Enter the number of the flake to update: " flake_choice

    case $flake_choice in
        1)
            flake_name="nixpkgs" ;;
        2)
            flake_name="home-manager" ;;
        3)
            flake_name="spicetify-nix" ;;
        4)
            echo "Update canceled."
            return ;;
        *)
            echo "Invalid choice. Please try again."
            update_specific_flake
            return ;;
    esac

    echo "Updating flake: $flake_name ..."
    sudo nix flake lock --update-input "$flake_name"
    echo "Flake '$flake_name' has been updated."
}

# Function to display the Update submenu
update_flakes() {
    while true; do
        echo ""
        echo "=== Update Menu ==="
        echo "1. Update All Flakes"
        echo "2. Update Specific Flake"
        echo "0. Return to Main Menu"
        read -p "Enter your choice: " update_choice

        case $update_choice in
            1)
                update_all_flakes
                break ;;
            2)
                update_specific_flake
                break ;;
            0)
                return ;;
            *)
                echo "Invalid choice. Please select a valid option." ;;
        esac
    done
}

# Function to view differences in system closures
what_happened() {
    nix store diff-closures /run/*-system
}

what_happened_all() {
    nix profile diff-closures --profile /nix/var/nix/profiles/system
}

# Function to collect garbage and remove old versions based on user input
cleanup_system() {
    echo "Garbage Collection Options:"
    echo "1. Delete everything"
    echo "2. Delete older than 30 days"
    echo "3. Custom number of days"
    echo "0. Go back"
    read -p "Enter your choice: " gc_choice

    case $gc_choice in
        1)
            echo "Deleting everything..."
            sudo nix-collect-garbage -d ;;
        2)
            echo "Deleting everything older than 30 days..."
            sudo nix-collect-garbage --delete-older-than 30d ;;
        3)
            read -p "Enter the number of days: " days
            echo "Deleting everything older than $days days..."
            sudo nix-collect-garbage --delete-older-than "${days}d" ;;
        0)
            return ;; # Go back to the main menu
        *)
            echo "Invalid choice. Please choose again."
            cleanup_system ;; # Call again if the choice is invalid
    esac
}

# Function to optimize the Nix store
nix_store_optimize() {
    echo "Optimizing Nix store..."
    sudo nix store optimize
    echo "Nix store optimized."
}

# Main function to display menu and handle user input
main() {
    echo "Choose an option:"
    echo "1. Default Mode (Removed)"
    echo "2. Laptop Mode"
    echo "3. PC Mode"
    echo "4. Update"
    echo "5. What's Happened"
    echo "6. What's Happened - ALL"
    echo "7. Cleanup System (Garbage Collection)"
    echo "8. Nix Store Optimize"
    echo "0. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) echo "Default mode has been removed and is no longer available." ;;
        2) switch_mode "$script_dir#laptop" ;;
        3) switch_mode "$script_dir#pc" ;;
        4) update_flakes;; 
        5) what_happened ;;
        6) what_happened_all ;;
        7) cleanup_system ;;
        8) nix_store_optimize ;;
        0) echo "Exiting..."; exit ;;
        *) echo "Invalid choice. Please choose again." ;;
    esac
}

# Call the main function
# clear # its cool when u clean the screen but sometimes u wanna see the things from early
echo ""
echo "=============================="
echo "      NixOS Configuration      "
echo "=============================="
main
echo ""