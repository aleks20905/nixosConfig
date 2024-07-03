{ config, pkgs, ...}:

{

    environment.systemPackages = with pkgs; [

        vscode
        vscode-fhs
        git
        gh
        
        discord
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

        p7zip 
        # toybox 
        lm_sensors
        xorg.xrandr

        lf  
        btop
        neofetch
    


    ];

}