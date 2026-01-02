{ pkgs, config, ... }: {

  home.packages = with pkgs;
    [

      gitui
      # lazygit
    ];

  programs.git = {
    enable = true;

    settings = {
      user.name = "aleks";
      user.email = "aleks_20905@mail.bg";
    };

    ignores = [ ".env " "*.env" ".vscode" ];
  };

}

# ssh-keygen -t ed25519 -C "aleks_20905@mail.bg" 
# -->>
# eval "$(ssh-agent -s)"                                                                                                                                                       INT ✘ 
# ssh-add ~/.ssh/id_ed25519
# -->>
# cat ~/.ssh/id_ed25519.pub 

