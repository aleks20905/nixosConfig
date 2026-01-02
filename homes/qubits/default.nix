{ ... }: {
  imports = [ ];

  nixpkgs = {

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.username = "qubits";
  home.homeDirectory = "/home/qubits";

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11"; # Please read the comment before changing.
}

