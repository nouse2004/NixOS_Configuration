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

	# Networking
	networking.hostName = "laptop-ar8x";
	networking.networkmanager.enable = true;

	# GPU — default: Nvidia + Prime
	services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];
	hardware.nvidia = {
		open = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = true;
		nvidiaSettings = true;
		prime = {
			offload = {
				enable = true;
				enableOffloadCmd = true;
			};
			amdgpuBusId = "PCIE:6:0:0";
			nvidiaBusId = "PCIE:1:0:0";
		};
	};

	# State
	system.stateVersion = "25.05";
}
