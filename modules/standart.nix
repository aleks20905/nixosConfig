{ config, pkgs, ...}:

{
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

    imports = [ 
       ./virtualisation/default.nix 
    ];



    # enable zsh and set config
    users.defaultUserShell=pkgs.zsh; # needed
    programs.zsh = {
        enable = true;
        autosuggestions.enable = true;
        zsh-autoenv.enable = true;
        syntaxHighlighting.enable = true;
        ohMyZsh = {
            enable = true;
            theme = "agnoster";
            plugins = [
            # "git"
            # "history"
            # "rust"
            # "deno"
            ];
        };
    };

    # ADDS THE KEYBOARD LAYOUTs #todo doest have binde for chaneing betwen the layouts
    services.xserver = {
        enable = true;
        xkb.layout = "us, bg";
        xkb.variant = ",phonetic";
    };

   
   
    # Global-PACKAGES
    environment.systemPackages = with pkgs; [

        #------- Development Environments -------

        kdePackages.kate
        godot_4
        neovim
        lazygit
        vscode
        vscode-fhs
        git
        # gh 
        obsidian
        #------- Development Environments -------
        
        #------- MISC Utilities -------
        # p7zip 
        # unar
        # viber

        discord 
        # vesktop # furry discord 
        spotify
        # bambu-studio # 3d sclicer  
        # prusa-slicer # 3d sclicer 
        google-chrome 
        firefox
 
        tor-browser
        qbittorrent
        qalculate-qt
        # openvpn
        # openvpn3
        #------- MISC Utilities -------

        #------- Programming stuff & Tools -------
        sqlite
        python312
        lua

        go 
        # gosec # brutfocess some security problems for golang apps 
        templ
        air

        nodejs_22
        
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
        kitty
        lf  
        fd
        btop
        # neofetch
        fastfetch
        #------- Console Utilities -------


        nerd-fonts.fantasque-sans-mono
        # nixpacks # some type of conteriner shiet idk 'shity version of docker '

        wineWowPackages.stable


        mangohud # see gpu usage etc frame time top left

        # factorio-headless
    ];

    # services.factorio = {
    #     enable = true;
    #     public = false;
    #     requireUserVerification = false;
    #     lan = true;
    #     openFirewall = true;
    # };

}