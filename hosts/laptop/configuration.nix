# sudo nixos-rebuild switch  --flake  /home/aleks/Desktop/nixos#default
{ config, pkgs, inputs, ... }:

{
  imports = [ 
    ../common
    ../common/modules/audio.nix


    ../desktops/plasma6/default.nix


    ./modules/powerManagment.nix
  ];
  
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users ={
    "aleks"  = import ./home.nix;
    };
  };


  # disables network-wait-online so that it boots faster shoud not make any problems !!! but its posible to cause some services to break !!! 
  systemd.services.NetworkManager-wait-online.enable = false;
 

  system.stateVersion = "24.11"; # Did you read the comment?
}

