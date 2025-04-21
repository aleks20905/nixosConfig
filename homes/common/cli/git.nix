{ pkgs, config, ... }: {

    home.packages = with pkgs; [

        lazygit
    ];

    programs.git = {
        enable = true;

        userName = "aleks";
        userEmail = "aleks_20905@mail.bg";

        ignores = [
            ".env "
            "*.env"
            ".vscode"
        ];
    };

}

# ssh-keygen -t ed25519 -C "aleks_20905@mail.bg" 
# -->>
# eval "$(ssh-agent -s)"                                                                                                                                                       INT ✘ 
# ssh-add ~/.ssh/id_ed25519
# -->>
# cat ~/.ssh/id_ed25519.pub 