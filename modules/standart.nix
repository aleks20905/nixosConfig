{ config, pkgs, ...}:

{
 

    imports = [ 
       ./applications/default.nix 
       ./fonts/default.nix 
       ./gaming/default.nix 
    #    ./penTools/default.nix 
       ./programming/default.nix 
       ./virtualisation/default.nix 
       ./zsh/default.nix 

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