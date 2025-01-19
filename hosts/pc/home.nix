{ inputs,  config, pkgs, ... }:

{

  imports = [
    ../../homes/aleks
    # ../../homeManagerModules/common/audio.nix
    ../../homes/common/applications
    ../../homes/common/cli
    ../../homes/common/terminals/kitty.nix
  ];





 


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
