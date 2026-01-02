{ pkgs, ... }: {

  #? everything that doest have a folder for it or is kinda unknow what it is will go to utils 

  imports = [

    #    ./lazygit.nix 
  ];

  home.packages = with pkgs; [

    # p7zip 
    unar

    # bambu-studio # 3d sclicer  
    # prusa-slicer # 3d sclicer 

    # openvpn
    # openvpn3

    # localsend

    # qalculate-qt

    qbittorrent

    # krita # drawing software

  ];

}

