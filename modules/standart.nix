{ config, pkgs, ...}:

{

    environment.systemPackages = with pkgs; [

        vscode
        vscode-fhs
        git
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

        lf  
        btop
        neofetch
  


    ];

}