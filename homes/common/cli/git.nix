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

