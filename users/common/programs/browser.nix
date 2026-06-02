# Kang
# May,20,2026
{ config , pkgs , inputs , ... } : {
	imports = [
		inputs.zen-browser.homeModules.default
	];

	programs.zen-browser = {
		enable = true;
		configPath = "${config.home.homeDirectory}/.mozilla/firefox";
		profiles.hrmcqcqm = {
			id = 0;
			name = "default";
			path = "hrmcqcqm.default";
			isDefault = true;
		};
	};

	home.packages = with pkgs; [ firefox ];
}
