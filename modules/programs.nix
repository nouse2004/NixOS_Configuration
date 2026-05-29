{ pkgs, ... }: {
	programs = {
		dconf.enable = true;
		fish.enable = true;
		clash-verge = {
			enable = true;
			tunMode = true;
			serviceMode = true;
			autoStart = true;
		};
	};

	environment.systemPackages = with pkgs; [
		vim
		curl
		git
		fastfetch
		distrobox
	];

	services = {
		resolved.enable = true;
		printing.enable = true;
		dbus.packages = [ pkgs.gcr ];
		flatpak.enable = true;
		pipewire = {
			enable = true;
			pulse.enable = true;
		};
		tlp = {
			enable = true;
			pd.enable = true;
		};
		upower.enable = true;
		power-profiles-daemon.enable = false;
	};

	security.polkit.enable = true;
	security.rtkit.enable = true;

	virtualisation.podman = {
		enable = true;
		dockerCompat = true;
	};
}
