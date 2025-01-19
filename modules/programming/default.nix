{pkgs, ...}:{

    imports = [ 

       ./c-dev.nix 
       ./go.nix 
    ];

    environment.systemPackages = with pkgs; [

        #------- Programming stuff & Tools -------
        sqlite

        python312

        lua

        # nodejs_22
        
        # tailwindcss # binery - https://github.com/tailwindlabs/tailwindcss/releases

        libgcc
        gcc
        gdb
        stdenv
        gnumake

        #------- Programming stuff & Tools -------




    ];

}