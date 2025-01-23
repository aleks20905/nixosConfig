{ config, pkgs, ...}:

{
 
    imports = [ 

       ./fonts
       ./gaming
    #    ./penTools
       ./programming
       ./virtualisation
       ./shells
    ];

   
    

    # Enable CUPS to print documents.
    # services.printing.enable = true;

}