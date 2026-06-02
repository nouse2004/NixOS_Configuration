{config, pkgs , inputs,...} : {
	imports = [
		./browser.nix
		./fun.nix
		./tool.nix
		./flatpak.nix
		./neovim.nix
		./user.nix
	];
}
