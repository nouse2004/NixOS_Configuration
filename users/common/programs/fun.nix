{ pkgs , config , ... } : {
	home.packages = with pkgs; [
		imv	
	];

	programs = {
		mpv = {
			enable = true;
			defaultProfiles = ["gpu-hq"];
			scripts = [ pkgs.mpvScripts.mpris ];
		};
		obs-studio.enable = true;
	};

	services = {

	};
}
