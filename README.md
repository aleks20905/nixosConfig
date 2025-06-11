# NixOS Configuration Repository

Welcome to my NixOS configuration repository! This repository contains my personalized NixOS setup modular flake-based setup used to manage multiple machines (desktop, laptop, server), with Home Manager

Most of the stuff is managed in user environment and packages managed via Home Manager

### ⚠️ Disclaimer

This config is **not meant to be a perfect example** of how to structure NixOS or flakes.  
It's a personal setup that grew organically over time and is still evolving.  
**Use at your own risk, copy with caution, and most 
importantly — have fun! Break stuff and roll back until it works 😄**

## Table of Contents

- [Usage](#usage)
- [Script Details](#script-details)


## Usage
Run the setup.sh script to manage your NixOS configuration:

` ./setup.sh ` or `sh setup.sh `

It's a simple shell script to help with flake updates, rebuilds, and system cleanup.
(Note: may not always be 100% up-to-date — I tweak it as needed.)

## 🔧 Script Details
>The **setup.sh** script provides a menu interface to manage your NixOS. 


- ***The Obezglaven Mode (Option 1)***  Switch to the server config
- ***The Laptop Mode (Option 2)***  Switch to laptop config
- ***The PC Mode (Option 3)***  Switch to desktop config

- ***Flake Update (Option 4):*** Update all flake inputs or specific flake.
- ***What's Happened (Options 5 & 6):*** View differences in system, track changes between generations current and previous or all generations.

- ***Cleanup System (Option 7):*** Perform garbage collection to remove unused packages and free up disk space.
    - ***Delete Everything (7.1):*** Remove all unused packages.
    - ***Delete Older Than 30 Days (7.2):*** Remove packages not used in the last 30 days.
    - ***Custom Number of Days (7.3):*** Specify a custom timeframe for deletion.

- ***Nix Store Optimize (Option 8):*** Optimize the Nix store.

Feel free to explore, fork or use parts of this config as a base for your own setup!