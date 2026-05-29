{ config , pkgs , ...} : {
	
	imports = [
		./niri
		./tofi
		./waybar
		./xdg.nix
		./mako.nix
		./idle.nix
		./fcitx5.nix
		./clipboard.nix
		./matugen
	];

	home.packages = with pkgs; [
		adwaita-icon-theme
	];

	services = {
		polkit-gnome.enable = true;
		awww.enable = true;
	};

	home.pointerCursor = {
		name = "Adwaita";
		package = pkgs.adwaita-icon-theme;
		size = 24;
	};
}
