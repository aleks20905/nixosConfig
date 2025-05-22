{pkgs, lib, ...}:{

# nvim configuration 

    programs.neovim = {

        enable = true;
        # extraConfig = ''
        #     set number relativenumber
        # '';

        defaultEditor = true;

        viAlias = true;
        vimAlias = true;
    };

    home.packages = with pkgs;[

        # neovim
   
        wl-clipboard

        ripgrep # needed 
        fzf

        # nixfmt-rfc-style
        nixfmt-classic
    ];

    # each rebuild checks in the home folder for "./config/nvim" if it doest exist, it will pull it from github
    home.activation = {
    cloneNvimConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "$HOME/.config/nvim" ]; then
        echo "Cloning Neovim config..."
        ${pkgs.git}/bin/git clone https://github.com/aleks20905/nvim.git "$HOME/.config/nvim"
      else
        echo "Neovim config already exists. Skipping clone."
      fi
    '';
  };

}


