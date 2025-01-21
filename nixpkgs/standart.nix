{ config, pkgs, ...}:

{
 
    imports = [ 

       ./fonts
       ./gaming
    #    ./penTools
       ./programming
       ./virtualisation
    #    ./zsh
    ];

   
    # Global-PACKAGES
    environment.systemPackages = with pkgs; [

       
        #------- Console Utilities -------
        # toybox # problem bugs and cant use ls and etc 
        ripgrep
        lf  
        fd
        #------- Console Utilities -------
    ];

    # Enable CUPS to print documents.
    # services.printing.enable = true;

}