{
  description = "Nixos config flake";
  inputs = {

    # Tag each input. "# --lock;" pins it, updateflake.sh skips it.
    # "# --auto;" means updateflake.sh updates it on every run.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # --auto;

    sops-nix.url = "github:Mic92/sops-nix"; # --auto;
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager"; # --auto;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix"; # --auto;
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Pinned for the older factorio-headless; not currently used.
    oldNixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # --lock;

    # nix-minecraft.url = "github:Infinidoge/nix-minecraft"; # --auto;
    nix-minecraft.url = "github:aleks20905/nix-minecraft/add-fetchFTBModpack";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";

    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module"; # --auto;
    playit-nixos-module.inputs.nixpkgs.follows = "nixpkgs";

    gotth.url = "github:aleks20905/GOTTH/shopi1"; # --auto;
    gotth.inputs.nixpkgs.follows = "nixpkgs";

    curtisDashboard.url = "github:aleks20905/hakaton30/main"; # --auto;
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
