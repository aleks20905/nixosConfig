{ inputs, config, pkgs, ... }:

{

  imports = [
    ../../homeManagerModules/aleks
    # ../../homeManagerModules/common/audio.nix
    ../../homes/common/applications
    # ../../homes/common/cli
    # ../../homes/common/desktop/hyprland
    # ../../homes/common/services/gnome-keyring.nix
  ];


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

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

  programs.kitty = {
  	enable = true;
    font = {
        name = "FantasqueSansM Nerd Font Mono";
        size = 12;
    };

  	settings = {
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      # window_padding_width = -5;
      background_opacity = "0.5";
      background_blur = 5; 
  		confirm_os_window_close = -0;
  		copy_on_select = true;
  		clipboard_control = "write-clipboard read-clipboard write-primary read-primary";
  	  # font_family = "FantasqueSansMono Nerd Font";

    };
  };
  


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/aleks/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
