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
		qemu
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
		power-profiles-daemon.enable = true;
		upower = {
			enable = true;
			percentageLow = 20;
			percentageCritical = 10;
			percentageAction = 5;
		};
		tlp.enable = false;
	};

	security.polkit.enable = true;
	security.rtkit.enable = true;

	virtualisation.podman = {
		enable = true;
		dockerCompat = true;
	};

	virtualisation.libvirtd = {
		enable = true;
		qemu.swtpm.enable = true;
	};
}
