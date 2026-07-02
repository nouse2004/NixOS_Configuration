{ pkgs, pkgsMaster, lib, ... }: let
	clashVergeRevPkg = pkgsMaster.clash-verge-rev;

	# 检测到 nixpkgs-master 的 clash-verge-rev 版本超过阈值时提示更新
	warnClashVergeRevUpdate = threshold: pkg:
		if lib.versionOlder threshold pkg.version
		then lib.warn "clash-verge-rev ${pkg.version} > ${threshold}，请更新 modules/programs.nix 中的阈值" pkg
		else pkg;
in {
	programs = {
		dconf.enable = true;
		fish.enable = true;
		clash-verge = {
			enable = true;
			tunMode = true;
			serviceMode = true;
			autoStart = true;
			package = warnClashVergeRevUpdate "2.5.1" clashVergeRevPkg;
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
