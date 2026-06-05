{ config, lib, pkgs, ... }:

{
	specialisation = {
		nvidia = {
			configuration = {
				# Undo default dGPU disable for this specialisation
				boot.blacklistedKernelModules = lib.mkForce [ "nouveau" ];
				boot.extraModprobeConfig = lib.mkForce "";
				services.udev.extraRules = lib.mkForce "";

				services.xserver.videoDrivers = lib.mkForce [ "amdgpu" "nvidia" ];

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
			};
		};
	};
}
