# sudo nixos-rebuild switch  --flake  /home/aleks/Desktop/nixos#default
{ config, pkgs, inputs, ... }:

{

  imports = [ 
    ../common # loads all .nix files from hosts/common in the directory, doesnt add any other folders etc  
    
    ../common/desktops/plasma6/default.nix

    ../common/modules/audio.nix
    ../common/modules/bluetooth.nix





    ./hardware-config.nix # import hardware config from hardware-config.nix
    ./nixpkg.nix # import nixpkgs from nixpkgs.nix 
    ./service.nix # import services from service.nix

    ./modules/powerMenagment.nix
  ];
  

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users ={
    "aleks"  = import ./home.nix;
    };
  };


 
  # for faster boot times 
  # disables network-wait-online so that it boots faster shoud not make any problems !!! but its posible to cause some services to break !!! 
  systemd.services.NetworkManager-wait-online.enable = false;
 
}

