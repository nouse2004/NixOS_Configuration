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
		HandlePowerKey = "suspend-then-hibernate";
		HandleLidSwitch = "suspend-then-hibernate";
		HandleLidSwitchExternalPower = "suspend";
	};

	# Systemd
	systemd.settings.Manager.DefaultTimeoutStopSec = "15s";
	systemd.sleep.settings.Sleep = {
		HibernateDelaySec = "2h";
		HibernateOnACPower = false;
	};

	# State
	system.stateVersion = "25.05";
}
