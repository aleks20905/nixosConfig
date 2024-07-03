{ config, pkgs, ...}:

{

    environment.systemPackages = with pkgs; [

        vscode
        vscode-fhs
        git
        gh
        templ
        air
        
        discord
        google-chrome 
        tor-browser

        python3
        go  
        libgcc
        gcc
        gdb
        stdenv

        p7zip 
        # toybox 
        lm_sensors
        xorg.xrandr

        lf  
        btop
        neofetch
    


    ];

}