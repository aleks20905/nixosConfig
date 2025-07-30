{

	description = "Nixos config flake";

	inputs = {

		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    sops-nix.url = "github:Mic92/sops-nix";

		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		spicetify-nix.url = "github:Gerg-L/spicetify-nix";
		spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

		oldNixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";
	};

	outputs = { self, nixpkgs, sops-nix, ... }@inputs:
	let

		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {

		nixosConfigurations = {


			obezglaven = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [ 
          sops-nix.nixosModules.sops
					./hosts/obezglaven/configuration.nix
				];
			};


			laptop = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [ 
					./hosts/laptop/configuration.nix
				];
			};


			pc = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [ 
					./hosts/pc/configuration.nix
				];
			};


		};
	};
}
