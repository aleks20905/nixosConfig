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


    # ADDS THE KEYBOARD LAYOUTs #todo doest have binde for chaneing betwen the layouts
    services.xserver = {
        enable = true;
        xkb.layout = "us, bg";
        xkb.variant = ",phonetic";
    };


    # Sets your time zone.
    time.timeZone = "Europe/Sofia";

    # Selects internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "bg_BG.UTF-8";
        LC_IDENTIFICATION = "bg_BG.UTF-8";
        LC_MEASUREMENT = "bg_BG.UTF-8";
        LC_MONETARY = "bg_BG.UTF-8";
        LC_NAME = "bg_BG.UTF-8";
        LC_NUMERIC = "bg_BG.UTF-8";
        LC_PAPER = "bg_BG.UTF-8";
        LC_TELEPHONE = "bg_BG.UTF-8";
        LC_TIME = "bg_BG.UTF-8";
    };
            

    # this is activation scrip it is executed when u do "nixos-rebild" 
    # and print info for packages that were installed, deleted & etc.
    system.activationScripts.report-changes = ''
        PATH=$PATH:${lib.makeBinPath [ pkgs.nvd pkgs.nix ]}
        nvd diff $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2)
    '';

    system.stateVersion = "24.11"; # Did you read the comment?

}