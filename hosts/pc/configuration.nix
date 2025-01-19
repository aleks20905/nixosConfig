# sudo nixos-rebuild switch  --flake  /home/aleks/Desktop/nixos#default
{ config, inputs, ... }:

{
  imports = [ 
    ../common
    ../common/modules/amd.nix
    ../common/modules/audio.nix
    ../common/modules/bluetooth.nix


    ../common/desktops/plasma6/default.nix


    ./modules/testConfig.nix
  ];
  
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users ={
    "aleks"  = import ./home.nix;
    };
  };

 
  # addes partition manager 
  # programs.partition-manager.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  system.stateVersion = "24.11"; # Did you read the comment?
}
