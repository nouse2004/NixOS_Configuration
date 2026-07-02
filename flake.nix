{
	description = "NixOS Configuration of Kang";

	nixConfig = {
		extra-substituters = [
			"https://nix-community.cachix.org"
		];
		extra-trusted-public-keys = [
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCwyvRCYg3Fs="
		];
	};

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixpkgs-master.url = "github:NixOS/nixpkgs";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
		waybar = {
			url = "github:Alexays/Waybar";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, ... } @ inputs: let
		var = import ./var.nix;
		specialArgs = {
			inherit var inputs;
			pkgsMaster = inputs.nixpkgs-master.legacyPackages.${var.system};
		};
	in {
		nixosConfigurations.${var.hostName} = inputs.nixpkgs.lib.nixosSystem {
			system = var.system;
			inherit specialArgs;

			modules = [
				./hosts/${var.hostName}
				./users/${var.username}/nixos.nix

				inputs.nix-flatpak.nixosModules.nix-flatpak

				inputs.home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.extraSpecialArgs = specialArgs;
					home-manager.users.${var.username} = ./users/${var.username}/home.nix;
				}
			];
		};
	};
}
