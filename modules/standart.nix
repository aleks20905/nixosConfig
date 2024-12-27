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
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    # Docker stuff rootles etc ... 
    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };
    
    # Global-PACKAGES
    environment.systemPackages = with pkgs; [

        #------- Development Environments -------
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

        steam

        discord 
        # vesktop # furry discord 
        spotify
        # bambu-studio # 3d sclicer  
        # prusa-slicer # 3d sclicer 
        google-chrome 
        tor-browser
        qbittorrent
        qalculate-qt
        openvpn
        openvpn3
        #------- MISC Utilities -------

        #------- Programming stuff & Tools -------
        sqlite
        python312
        lua

        go  
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
        lm_sensors      # Hardware monitoring tool
        xorg.xrandr     # need for thest in for pcConfig [remove]
        #------- System Utilities -------

        #------- Console Utilities -------
        # toybox # problem bugs and cant use ls and etc 
        ripgrep
        kitty
        lf  
        fd
        btop
        neofetch
        #------- Console Utilities -------


        nerd-fonts.fantasque-sans-mono
        # nixpacks # some type of conteriner shiet idk 'shity version of docker '


        wineWowPackages.stable



    ];
}