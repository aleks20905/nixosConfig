{pkgs, ...}:{

    imports = [ 

    #    ./lazygit.nix 
    ];

    environment.systemPackages = with pkgs; [

        google-chrome 

        firefox

        tor-browser

    ];

}