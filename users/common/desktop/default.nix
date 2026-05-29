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
		./fontconfig.nix
	];

	home.packages = with pkgs; [
		adwaita-icon-theme
		libnotify
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
