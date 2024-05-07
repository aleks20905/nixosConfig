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
    
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
           # ./moduls/penTools.nix
            ./moduls/db.nix
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

        
        

    };
}

# sudo nixos-rebuild switch  --flake  /home/aleks/Desktop/nixos#default
