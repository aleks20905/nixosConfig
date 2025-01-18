{ config, pkgs, ...}:

{

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

    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    programs.gamemode.enable = true;

    # Docker stuff rootles etc ... 
    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
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

        protonup # thing to download porton TODO need to move to diff folder

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

    environment.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\${HOME}/.steam/root/compatibilitytools.d";
    };
    # gamemoderun %command%
    # mangohud %command%
    # gamescope %command%
}