{pkgs, ...}:{

    # enable zsh and set config
    users.defaultUserShell=pkgs.zsh; # needed
    programs.zsh = {
        enable = true;
        autosuggestions.enable = true;
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