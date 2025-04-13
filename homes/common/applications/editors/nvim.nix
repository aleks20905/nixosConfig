{pkgs, ...}:{

# nvim configuration 

    home.packages = with pkgs;[

        neovim
   
        wl-clipboard

        ripgrep # needed 
        fzf

    ];



}


