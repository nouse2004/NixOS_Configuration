{ pkgs, ... }: {
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
