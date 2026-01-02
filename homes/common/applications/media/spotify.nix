{ inputs, pkgs, ... }: {

  imports = [
    # inputs.spicetify-nix.nixosModules.default # For NixOS
    inputs.spicetify-nix.homeManagerModules.default # For home-manager
  ];

  programs.spicetify =
    let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {

      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];

    };

}

