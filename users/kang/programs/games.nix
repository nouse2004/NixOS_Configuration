{ pkgs , config , osConfig ,... } : {
	home.packages = with pkgs; [
		imv
	];

	programs = {
		lutris  = {
			enable = true;
			steamPackage = osConfig.programs.steam.package;
			defaultWinePackage = pkgs.dwproton-bin;
		};
	};

	services = {

	};
}
