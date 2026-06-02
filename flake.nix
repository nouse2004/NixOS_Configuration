{
	description = "NixOS Configuration of Kang";
	
	nixConfig = {
		extra-substituter = [
			"https://nix-community.cachix.org"
		];
		extra-trusted-public-key = [
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="	
		];
	};

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
		waybar = {
			url = "github:Alexays/Waybar";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	
	outputs = inputs@{ self , nixpkgs, home-manager, nix-flatpak, nixvim, waybar , ... } : let
		var = import ./var.nix;
		inherit (var) system username;

		extraArgs = { inherit var inputs; };
	in  {
		nixosConfigurations = {
			laptop-ar8x = nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = extraArgs;

				modules = [
					./hosts/laptop-ar8x
					./users/${username}/nixos.nix

					nix-flatpak.nixosModules.nix-flatpak

					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.extraSpecialArgs = extraArgs;
						home-manager.users.${username} = ./users/${username}/home.nix;
					}
				];
			};
		};
	};
}
