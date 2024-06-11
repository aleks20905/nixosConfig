{ config, pkgs, ...}:

{
  

    environment.systemPackages = with pkgs; [
    
    aircrack-ng # airmon-ng   create new global template network security or smt
    wordlists # rockyou package create new global template network security or smt
    wireshark # create new global template network security or smt
    wifite2

    ];

}