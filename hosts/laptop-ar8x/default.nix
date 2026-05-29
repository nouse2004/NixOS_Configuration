{ config, lib, pkgs ,... }:

{
	imports = [
		../../modules/system.nix
		../../modules/dm.nix
		../../modules/programs.nix
		./hardware-configuration.nix
	];

	# Boot
	boot.loader = {
		systemd-boot.enable = true;
		efi = {
			efiSysMountPoint = "/boot";
			canTouchEfiVariables = true;
		};
	};

	# Networking
	networking.hostName = "laptop-ar8x";
	networking.networkmanager.enable = true;

	# State
	system.stateVersion = "25.05";
}

