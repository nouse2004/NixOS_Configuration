{config,pkgs,...} : {
	programs = {
		steam = {
			enable = true;
			extraCompatPackages = [ pkgs.dwproton-bin ];
		};
		gamemode.enable = true;
		gamescope = {
			enable = true;
		};
	};
}
