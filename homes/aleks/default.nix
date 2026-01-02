{ ... }: {
  imports = [ ../common ];

  nixpkgs = {

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.username = "aleks";
  home.homeDirectory = "/home/aleks";

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11"; # Please read the comment before changing.
}

