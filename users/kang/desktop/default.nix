{ config , pkgs , ...} : {

	imports = [
		./niri
		./xdg.nix
		./matugen
		./fcitx5.nix
	];

	home.packages = with pkgs; [
	    papirus-icon-theme
	];

	services = {
		polkit-gnome.enable = true;
	};

	home.pointerCursor = {
	  enable = true;
		name = "Adwaita";
		package = pkgs.adwaita-icon-theme;
		size = 24;
	};
}
