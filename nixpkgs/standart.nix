{ config, lib, pkgs, ...}:

{
    options = {

        # Define options for enabling/disabling modules
        enableGaming = lib.mkEnableOption "Enable gaming-related packages "                 // { default = true; }; 
        enableProgramming = lib.mkEnableOption "Enable programming-related packages "       // { default = true; }; 
        enablePentools = lib.mkEnableOption "Enable pentesting tools"                       // { default = false; };
        enableVirtualisation = lib.mkEnableOption "Enable virtualisation-related packages " // { default = true; }; 
    }; 

    imports = [ 

        ./fonts
    #    ./gaming
    #    ./penTools
    #    ./programming
        ./shells
    #    ./virtualisation

        (lib.mkIf config.enableGaming ./gaming)
        (lib.mkIf config.enableProgramming ./programming)
        (lib.mkIf config.enablePentools ./pentools)
        (lib.mkIf config.enableVirtualisation ./virtualisation)
    ];

   
    

    # Enable CUPS to print documents.
    # services.printing.enable = true;

}