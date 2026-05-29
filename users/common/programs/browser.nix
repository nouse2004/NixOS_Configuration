# Kang
# May,20,2026
{ pkgs , config , var , ... } : {
	programs = {
		firefox = {
			enable = true;
			configPath = "${config.xdg.configHome}/mozilla/firefox";
			profiles.${var.username} = {};
		};
	};
}
