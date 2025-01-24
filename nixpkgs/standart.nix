{ config, lib, pkgs, ...}:

{
    #! standart.nix shoud not be used in the future ... 

    imports = [ 

        ./fonts
        ./gaming
        # ./penTools
        ./programming
        ./shells
        ./virtualisation

    ];

    # pentools.enable = lib.mkDefault false; # testing  
   
    

    # Enable CUPS to print documents.
    # services.printing.enable = true;

}