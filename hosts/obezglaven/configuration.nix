# sudo nixos-rebuild switch  --flake  /home/aleks/Desktop/nixos#default
{ config, inputs, ... }:

{
  imports = [
    ../common # loads all .nix files in the directory, doesnt add any other folders etc

    # ../common/desktops/plasma6/default.nix

    # ../common/modules/amd.nix
    # ../common/modules/audio.nix
    # ../common/modules/bluetooth.nix

    ./hardware-config.nix # [import local hardware-config.nix]
    ./nixpkg.nix # [import local nixpkgs.nix ]
    ./service.nix # [import local service.nix]

    # k
    # k

    ./modules/testConfig.nix # [testing file] when testing someting
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "qubits" = import ./home.nix;
      "aleks" = import ./home_aleks.nix;
    };
  };

}
