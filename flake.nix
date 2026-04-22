{
  description = "Nixos config flake";
  inputs = {

    # " --lock " pins a specifig commit and will not be changed my the flake update script
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

    gotth.url = "github:aleks20905/GOTTH/shopi1";
    gotth.inputs.nixpkgs.follows = "nixpkgs";

    curtisDashboard.url = "github:aleks20905/hakaton30/main";
    curtisDashboard.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
      ...
    }@inputs:
    {

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
