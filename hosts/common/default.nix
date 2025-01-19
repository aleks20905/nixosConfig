{inputs, config, pkgs, lib, ...}: {

    imports = [
        ./networking.nix
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


    # ADDS THE KEYBOARD LAYOUTs #todo doest have binde for chaneing betwen the layouts
    services.xserver = {
        enable = true;
        xkb.layout = "us, bg";
        xkb.variant = ",phonetic";
    };


            

}