{config, pkgs , inputs,...} : {
	imports = [
		./browser.nix
		./fun.nix
		./tool.nix
		./flatpak.nix
		./user.nix
	];
}
