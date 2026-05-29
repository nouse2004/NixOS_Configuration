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
	};
	
	outputs = inputs@{ self , nixpkgs, home-manager, nix-flatpak , ... } : let
		var = import ./var.nix;
	in  {
		nixosConfigurations = {
			laptop-ar8x = nixpkgs.lib.nixosSystem {	
				system = var.system;
				specialArgs = { inherit var ;};
				
				modules = [
					./hosts/laptop-ar8x
					./users/${var.username}/nixos.nix
					
					nix-flatpak.nixosModules.nix-flatpak					
	
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						
						home-manager.extraSpecialArgs = {inherit inputs var ;};		
						home-manager.users.${var.username} = ./users/${var.username}/home.nix;
					}
				 ];
			};	
		};
	};
}
