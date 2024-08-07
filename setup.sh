#!/bin/bash

# Get the directory where the script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Function to switch to a specific mode
switch_mode() {
    local package_path="$1"
    echo "Switching to mode at: $package_path"
    sudo nixos-rebuild switch --flake "$package_path"
}

# Function to update the flake
update_nix() {
    sudo nix flake update 
}

what_happend() {
    nix store diff-closures /run/*-system

}

what_happend_all() {
    nix profile diff-closures --profile /nix/var/nix/profiles/system

}


# Main function to display menu and handle user input
main() {
    echo "Choose mode to switch:"
    echo "1. Default Mode"
    echo "2. Laptop Mode"
    echo "3. PC Mode"
    echo "4. flake update"
    echo "5. whats happend "
    echo "6. whats happend - ALL"
    echo "0. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) switch_mode "$script_dir#default" ;;
        2) switch_mode "$script_dir#laptop" ;;
        3) switch_mode "$script_dir#pc" ;;
        4) update_nix ;;
        5) what_happend ;;
        5) what_happend_all ;;
        0) echo "Exiting..."; exit ;;
        *) echo "Invalid choice. Please choose again." ;;
    esac
}

# Call the main function
main
