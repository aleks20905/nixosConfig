# sudo nixos-rebuild switch  --flake  /home/aleks/Desktop/nixos#default
{ config, inputs, ... }:

{
  imports = [ 
    ../common # loads all .nix files in the directory, doesnt add any other folders etc  
    
    ../common/desktops/plasma6/default.nix

    # ../common/modules/amd.nix
    # ../common/modules/audio.nix
    # ../common/modules/bluetooth.nix









    ./hardware-config.nix     # [import local hardware-config.nix] 
    ./nixpkg.nix              # [import local nixpkgs.nix ] 
    ./service.nix             # [import local service.nix]

    ./modules/testConfig.nix  # [testing file] when testing someting  
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


}
