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

	xdg.configFile."fontconfig/conf.d/10-sc-priority.conf".text = ''
		<?xml version="1.0"?>
		<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
		<fontconfig>
			<alias>
				<family>sans-serif</family>
				<prefer>
					<family>Noto Sans SC</family>
					<family>Noto Sans</family>
				</prefer>
			</alias>
			<alias>
				<family>serif</family>
				<prefer>
					<family>Noto Serif SC</family>
					<family>Noto Serif</family>
				</prefer>
			</alias>
			<alias>
				<family>monospace</family>
				<prefer>
					<family>JetBrainsMono Nerd Font</family>
					<family>Noto Sans CJK SC</family>
				</prefer>
			</alias>
		</fontconfig>
	'';
}
