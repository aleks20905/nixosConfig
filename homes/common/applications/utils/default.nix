{pkgs, ...}:{

    imports = [ 

    #    ./lazygit.nix 
    ];

    home.packages = with pkgs; [

        # lm_sensors      # Hardware monitoring tool
        # xorg.xrandr     # need for thest in for pcConfig [remove]

        # p7zip 
        # unar

        # bambu-studio # 3d sclicer  
        # prusa-slicer # 3d sclicer 


        # openvpn
        # openvpn3

        qalculate-qt

        qbittorrent

        lazygit
    ];

}