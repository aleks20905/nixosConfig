{ inputs, config, pkgs, ... }:

{

  imports = [
    ../../homes/aleks
    # ../../homeManagerModules/common/audio.nix

    # ../../homes/common/applications/browsers
    # ../../homes/common/applications/communications
    ../../homes/common/applications/editors
    # ../../homes/common/applications/media
    # ../../homes/common/applications/utils

    ../../homes/common/cli
    ../../homes/common/terminals/kitty.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
