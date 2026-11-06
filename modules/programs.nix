{ pkgs, pkgsMaster, lib, inputs , ... }:
# 	clashVergeRevPkg = pkgsMaster.clash-verge-rev;

# 	warnClashVergeRevUpdate = threshold: pkg:
# 		if lib.versionOlder threshold pkg.version
# 		then lib.warn "clash-verge-rev ${pkg.version} > ${threshold}，请更新 modules/programs.nix 中的阈值" pkg
# 		else pkg;
# in
{
	programs = {
		fish.enable = true;
		clash-verge = {
			enable = true;
			autoStart = true;
			package = pkgs.clash-verge-rev;
			serviceMode = true;
			tunMode = true;
		};
	};

	environment.systemPackages = with pkgs; [
		vim
		curl
		git
		fastfetch
		distrobox
		qemu
	#	inputs.nixvim-config.packages.${pkgs.stdenv.hostPlatform.system}.default
	];

	services = {
		resolved.enable = true;
		printing.enable = true;
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
