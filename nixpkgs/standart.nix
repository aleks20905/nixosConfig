{ config, lib, pkgs, ...}:

{

    imports = [ 

        ./fonts
       ./gaming
       ./penTools
       ./programming
        ./shells
       ./virtualisation

    ];

    pentools.enable = false;
   
    

    # Enable CUPS to print documents.
    # services.printing.enable = true;

}