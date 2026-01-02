{ pkgs, config, ... }: {

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
      clipboard_control =
        "write-clipboard read-clipboard write-primary read-primary";
      # font_family = "FantasqueSansMono Nerd Font";
      #
    };

  };

}

