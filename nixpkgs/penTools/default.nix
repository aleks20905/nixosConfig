{ config, lib, pkgs, ...}:

{
    # options = {
    #     pentools.enable = lib.mkEnableOption "enables pentools";
    # };

    # config = lib.mkIf config.pentools.enable {

    environment.systemPackages = with pkgs; [
    
        aircrack-ng # airmon-ng   create new global template network security or smt
        wireshark # create new global template network security or smt
        wifite2

        # wordlists   

        wordlists # rockyou package create new global template network security or smt
        (wordlists.override {
            lists = [ rockyou dirbuster];
        })
        
        exploitdb
        nmap
        gobuster
        nikto
        thc-hydra
        sqlmap

    ];

    # }; # part of the config = lib.$$$$ ... S 


}