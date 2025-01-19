{ config, pkgs, ...}:

{
 

    imports = [ 
       ./applications/default.nix 
       ./fonts/default.nix 
       ./gaming/default.nix 
    #    ./penTools/default.nix 
       ./virtualisation/default.nix 
       ./zsh/default.nix 

    ];

   
    # Global-PACKAGES
    environment.systemPackages = with pkgs; [

        #------- Development Environments -------
        godot_4

        # gh 
        #------- Development Environments -------
        
        #------- MISC Utilities -------
        # p7zip 
        # unar

        # viber
        discord 
        # vesktop # furry discord 

        spotify


        
        #------- MISC Utilities -------

        #------- Programming stuff & Tools -------
        sqlite

        python312

        lua

        go 
        # gosec # brutfocess some security problems for golang apps 
        templ
        air

        # nodejs_22
        
        # tailwindcss # binery - https://github.com/tailwindlabs/tailwindcss/releases

        libgcc
        gcc
        gdb
        stdenv
        gnumake
        #------- Programming stuff & Tools -------

        #------- System Utilities -------
        # lm_sensors      # Hardware monitoring tool
        # xorg.xrandr     # need for thest in for pcConfig [remove]
        #------- System Utilities -------

        #------- Console Utilities -------
        # toybox # problem bugs and cant use ls and etc 
        ripgrep
        lf  
        fd
        btop
        fastfetch
        #------- Console Utilities -------




    ];

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

    # Enable CUPS to print documents.
    services.printing.enable = true;
}