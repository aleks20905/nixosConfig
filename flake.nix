{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            # ./modules/penTools.nix
            ./modules/db.nix
            ./modules/standart.nix
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./hardware-modules/hardware-laptop.nix
            # ./modules/laptopConfig.nix
            ./modules/penTools.nix
            ./modules/db.nix
            ./modules/standart.nix
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

        pc = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./hardware-modules/hardware-pc.nix
            ./modules/pcConfig.nix
            # ./modules/penTools.nix
            ./modules/db.nix
            ./modules/standart.nix
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}