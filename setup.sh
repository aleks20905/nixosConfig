#!/bin/bash

# Get the directory where the script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Function to switch to a specific mode
switch_mode() {
    local package_path="$1"
    echo "Switching to mode at: $package_path"
    sudo nixos-rebuild switch --flake "$package_path"
}

update_nix() {
    sudo nix flake update 
}

# Main function to display menu and handle user input
main() {
    echo "Choose mode to switch:"
    echo "1. Default Mode"
    echo "2. Hack Mode"
    echo "3. flake update"
    echo "0. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) switch_mode "$script_dir#default" ;;
        2) switch_mode "$script_dir#hack" ;;
        3) update_nix ;;
        0) echo "Exiting..."; exit ;;
        *) echo "Invalid choice. Please choose again." ;;
    esac
}

# Call the main function
main
