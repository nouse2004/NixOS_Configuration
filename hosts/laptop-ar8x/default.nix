{ config, lib, pkgs ,... }:

{
	imports = [
		../../modules/system.nix
		../../modules/dm.nix
		../../modules/programs.nix
		./hardware-configuration.nix
		./integrated.nix
	];

	# Boot
	boot.loader = {
		systemd-boot.enable = true;
		efi = {
			efiSysMountPoint = "/boot";
			canTouchEfiVariables = true;
		};
	};
	boot.kernelPackages = pkgs.linuxPackages_latest;

	# Networking
	networking.hostName = "laptop-ar8x";
	networking.networkmanager.enable = true;

	# Display
	services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

	# Power management
	services.logind.settings.Login = {
		HandlePowerKey = "hibernate";
		HandleLidSwitch = "suspend";
		HandleLidSwitchExternalPower = "suspend";
	};

	# Systemd
	systemd.settings.Manager.DefaultTimeoutStopSec = "15s";

	# Udev
	services.udev.extraRules = ''
		KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0657", GROUP="users", TAG+="uaccess"
	'';
	
	# State
	system.stateVersion = "25.05";
}
