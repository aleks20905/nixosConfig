{
  description = "Nixos config flake";
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # --auto;

    sops-nix.url = "github:Mic92/sops-nix"; # --auto;
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager"; # --auto;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix"; # --auto;
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Input for the older version of factorio-headles not in use
    oldNixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # --lock;

    nix-minecraft.url = "github:Infinidoge/nix-minecraft"; # --auto;
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";

    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module"; # --auto;
    playit-nixos-module.inputs.nixpkgs.follows = "nixpkgs"; 

  };

  outputs = { self, nixpkgs, sops-nix, ... }@inputs:
    let

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      nixosConfigurations = {

        obezglaven = nixpkgs.lib.nixosSystem {
          modules = [
            sops-nix.nixosModules.sops
            ./hosts/obezglaven/configuration.nix

          ];
          specialArgs = { inherit inputs; };

        };

        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/laptop/configuration.nix ];
        };

        pc = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/pc/configuration.nix ];
        };

      };
    };
}
