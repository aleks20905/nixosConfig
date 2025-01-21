{

	description = "Nixos config flake";

	inputs = {

		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		# nix-spicetify.url = "github:the-argus/spicetify-nix";
		# nix-spicetify.inputs.nixpkgs.follows = "nixpkgs";

	};

	outputs = { self, nixpkgs, ... }@inputs:
	let

		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {

		nixosConfigurations = {

			# default = nixpkgs.lib.nixosSystem {
			#   specialArgs = {inherit inputs;};
			#   modules = [ 
			#     ./modules/standart.nix
			#     ./configuration.nix
			#   ];
			# };


			laptop = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [ 
					./hosts/laptop/hardware-config.nix
					./nixpkgs/standart.nix
					./hosts/laptop/configuration.nix
				];
			};


			pc = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [ 
					./hosts/pc/hardware-config.nix
					./nixpkgs/standart.nix
					./hosts/pc/configuration.nix
				];
			};


		};
	};
}