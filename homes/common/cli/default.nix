{pkgs, ...}:{

    imports = [

		./btop.nix
		./nvtop.nix
		./fastfetch.nix
		./git.nix
		./ssh.nix

    ];

    home.packages = with pkgs; [

        #------- Console Utilities ------- #TODO may need to move to somewhere else idk 

        # toybox # problem bugs and cant use ls and etc | https://search.nixos.org/packages?channel=unstable&show=toybox 

        # lm_sensors      # Hardware monitoring tool
        # xorg.xrandr     # need for thest in for pcConfig [remove]

        lazygit
        
        lf  
        fd

        nixpkgs-fmt

        nvd

        #------- Console Utilities -------

    ];


}