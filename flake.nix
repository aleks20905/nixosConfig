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
            ./modules/laptopConfig.nix
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
            inputs.home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];

              # This should point to your home.nix path of course. For an example
              # of this see ./home.nix in this directory.
              home-manager.users."${username}" = import ./home.nix;
            }
          ];
        };
      };
    };
}