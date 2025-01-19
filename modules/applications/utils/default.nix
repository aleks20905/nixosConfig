{pkgs, ...}:{

    imports = [ 

    #    ./lazygit.nix 
    ];

    environment.systemPackages = with pkgs; [


        # bambu-studio # 3d sclicer  
        # prusa-slicer # 3d sclicer 


        # openvpn
        # openvpn3

        qalculate-qt

        qbittorrent

        lazygit
    ];

}