# Kang
# May,20,2026

{ pkgs, var , ... } : let 
	username = var.username;
in {
	home = {
		inherit username;
		homeDirectory = "/home/${username}";
		stateVersion = "25.11";
	};	

	programs.home-manager.enable = true;

	fonts.fontconfig = {
		enable = true;
		defaultFonts = {
			serif = ["Noto Serif SC" "Noto Serif" "Noto Color Emoji"];
			sansSerif = ["Noto Sans SC" "Noto Sans" "Noto Color Emoji"];
			monospace = ["JetBrainsMono Nerd Font" "Noto Sans CJK SC" "Noto Color Emoji"];
			emoji = ["Noto Color Emoji"];
		};
	};
}
