{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, plasma-manager, ... }@inputs:
    let
      username = "aleks";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      commonModules = [
        ./modules/db.nix
        ./modules/standart.nix
        ./configuration.nix
      ];

      nixosConfig = { hardwareModule, extraModules, userConfigFile }:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            hardwareModule
          ] ++ commonModules ++ extraModules ++ [
            inputs.home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
              home-manager.users."${username}" = import userConfigFile;
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        default = nixosConfig {
          hardwareModule = null;  # No specific hardware module for default
          extraModules = [];
          userConfigFile = ./home.nix;
        };

        laptop = nixosConfig {
          hardwareModule = ./hardware-modules/hardware-laptop.nix;
          extraModules = [
            ./modules/laptopConfig.nix
            ./modules/penTools.nix
          ];
          userConfigFile = ./home.nix;
        };

        pc = nixosConfig {
          hardwareModule = ./hardware-modules/hardware-pc.nix;
          extraModules = [
            ./modules/pcConfig.nix
            # ./modules/penTools.nix
          ];
          userConfigFile = ./home.nix;
        };
      };
    };
}
