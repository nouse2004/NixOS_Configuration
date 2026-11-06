{ config , ... } : let
	d = config.xdg.dataHome;
	c = config.xdg.configHome;
	cache = config.xdg.cacheHome;
in {
	imports = [
		./fish.nix
		./starship.nix
		./terminals.nix
		./programs.nix
	];

	home.sessionVariables = {
		EDITOR = "vim";
	};
}
