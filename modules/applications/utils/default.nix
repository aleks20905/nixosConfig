{pkgs, ...}:{

    imports = [ 

    #    ./lazygit.nix 
    ];

    environment.systemPackages = with pkgs; [

        # openvpn
        # openvpn3

        qalculate-qt

        qbittorrent

        lazygit
    ];

}