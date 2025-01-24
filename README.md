# NixOS Configuration Repository

Welcome to my NixOS configuration repository! This repository contains my personalized NixOS setup managed through Nix flakes. It allows for easy switching between different system modes, updating configurations, monitoring system changes, and performing maintenance tasks.

## Table of Contents

- [Usage](#usage)
- [Script Details](#script-details)


## Usage
Run the setup.sh script to manage your NixOS configuration:

` ./setup.sh ` or `sh setup.sh `



## Script Details
>The setup.sh script provides a menu interface to manage your NixOS. 


- ***The Default Mode (Option 1)***  has been removed and does nothing RN. 

- ***Flake Update (Option 4):*** Update all flake inputs or specific flake.
- ***What's Happened (Options 5 & 6):*** View differences in system, track changes between generations.

- ***Cleanup System (Option 7):*** Perform garbage collection to remove unused packages and free up disk space.
    - ***Delete Everything (7.1):*** Remove all unused packages.
    - ***Delete Older Than 30 Days (7.2):*** Remove packages not used in the last 30 days.
    - ***Custom Number of Days (7.3):*** Specify a custom timeframe for deletion.

- ***Nix Store Optimize (Option 8):*** Optimize the Nix store.