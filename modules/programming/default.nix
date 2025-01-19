{pkgs, ...}:{

    imports = [ 

    #    ./lazygit.nix 
    ];

    environment.systemPackages = with pkgs; [

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




    ];

}