# Kang
# May,20,2026
{ pkgs , config , var , ... } : {
	programs = {
		firefox = {
			enable = true;
			configPath = "${config.xdg.configHome}/mozilla/firefox"; # TODO: remove when home.stateVersion >= 26.05 (new default)
			profiles.${var.username} = {};
		};
	};
}
