{inputs, config, pkgs, lib, ...}: {

    imports = [
        ./openssh.nix
        ./users.nix 
        inputs.home-manager.nixosModules.default
    ];

    nix = {
        settings.experimental-features = [ "nix-command" "flakes" ];
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

        # nix Garbage colection - atomatily to delete garbage when they are <value> days or etc ...  
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 30d";
        };
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    hardware.bluetooth.enable = true;



    # Disable X11 if not needed
    # services.xserver.enable = false;

    # Enable the KDE Plasma Desktop Environment.
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
        plasma-browser-integration
        oxygen
    ];



 
            

}