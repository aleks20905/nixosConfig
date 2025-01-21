{pkgs, ...}:{


    # zsh can be added by home-manager but its harder so no point 
    # enable zsh and set config
    users.defaultUserShell=pkgs.zsh; # needed
    programs.zsh = {
        enable = true;
        autosuggestions.enable = true;      #it doest have the same name from home-manager or doest work at all idk 
        zsh-autoenv.enable = true;
        syntaxHighlighting.enable = true;
        ohMyZsh = {
            enable = true;
            theme = "agnoster";
            plugins = [
            # "git"
            # "history"
            # "rust"
            # "deno"
            ];
        };
    };

}