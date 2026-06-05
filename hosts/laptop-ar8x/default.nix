{ config, lib, pkgs ,... }:

{
	imports = [
		../../modules/system.nix
		../../modules/dm.nix
		../../modules/programs.nix
		./hardware-configuration.nix
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
	boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
	boot.extraModprobeConfig = ''
		blacklist nouveau
		options nouveau modeset=0
	'';
	services.udev.extraRules = ''
		# Remove NVIDIA USB xHCI Host Controller devices, if present
		ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
		# Remove NVIDIA USB Type-C UCSI devices, if present
		ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
		# Remove NVIDIA Audio devices, if present
		ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
		# Remove NVIDIA VGA/3D controller devices
		ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
	'';

	# State
	system.stateVersion = "25.05";
}

