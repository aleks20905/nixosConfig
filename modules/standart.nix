{ config, pkgs, ...}:

{
    users.defaultUserShell=pkgs.zsh; 

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
            "git"
            "history"
            "rust"
            "deno"
            ];
        };
    };
    };

    environment.systemPackages = with pkgs; [

        godot_4
        vscode
        vscode-fhs
        git
        gh
        
        discord
        spotify
        bambu-studio
        google-chrome 
        tor-browser

        python3

        go  
        templ
        air

        libgcc
        gcc
        gdb
        stdenv
        gnumake

        p7zip 
        # toybox 
        lm_sensors
        xorg.xrandr

        lf  
        btop
        neofetch
    


    ];

}