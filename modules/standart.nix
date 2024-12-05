{ config, pkgs, ...}:

{
    users.defaultUserShell=pkgs.zsh; # needed

    # enable zsh and oh my zsh
    programs = {
        zsh = {
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
        godot_4
        neovim
        lazygit
        vscode
        vscode-fhs
        git
        gh 
        obsidian
        #------- Development Environments -------
        
        #------- MISC Utilities -------
        p7zip 
        # unar
        # viber
        discord
        vesktop
        spotify
        bambu-studio 
        prusa-slicer 
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


        wineWowPackages.stable



    ];
    # networking 

    networking.networkmanager.enable = true;

    networking.networkmanager.dns = "none";
    # These options are unnecessary when managing DNS ourselves
    networking.useDHCP = false;
    networking.dhcpcd.enable = false;

    networking.nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "9.9.9.9"

        "2606:4700:4700::1111#cloudflare-dns.com"
        "2606:4700:4700::1001#cloudflare-dns.com"
        "2620:fe::fe#dns.quad9.net"
        "2620:fe::9#dns9.quad9.net"
    ];

    # networking 

}