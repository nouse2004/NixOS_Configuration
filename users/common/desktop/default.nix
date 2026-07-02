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
		./script.nix
		./battery.nix
	];

	home.packages = with pkgs; [
		adwaita-icon-theme
		file-roller
		libnotify
		brightnessctl
		nautilus
	];

	services = {
		polkit-gnome.enable = true;
	};

	systemd.user.services.swaybg = {
		Unit = {
			Description = "Wallpaper daemon for Wayland";
			After = [ "graphical-session.target" ];
			PartOf = [ "graphical-session.target" ];
		};
		Service = {
			ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${config.xdg.userDirs.pictures}/Wallpapers/current -m fill";
			Restart = "on-failure";
			RestartSec = 3;
		};
		Install = {
			WantedBy = [ "graphical-session.target" ];
		};
	};

	home.pointerCursor = {
		name = "Adwaita";
		package = pkgs.adwaita-icon-theme;
		size = 24;
	};
}
