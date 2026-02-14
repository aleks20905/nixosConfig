{ inputs, config, pkgs, ... }:

{

  imports = [
    ../../homes/aleks
    ../../homes/common/applications
    ../../homes/common/cli
    ../../homes/common/terminals/kitty.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
