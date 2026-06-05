{ config, lib, pkgs ,... }:

{
	imports = [
		../../modules/system.nix
		../../modules/dm.nix
		../../modules/programs.nix
		./hardware-configuration.nix
		./disable-nvidia.nix
		./nvidia.nix
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

	# GPU
	services.xserver.videoDrivers = [ "amdgpu" ];

	# State
	system.stateVersion = "25.05";
}
