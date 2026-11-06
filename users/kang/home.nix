{ config , pkgs , inputs , var, ...}:
{
	imports = [
		./desktop
		./programs
		./shell
		../../secrets/${var.username}.nix
	];

	programs.git.settings = {
		user.name = var.username;
		user.email = "${var.useremail}";
	};

	home = {
		username=var.username;
		homeDirectory = "/home/${var.username}";
		stateVersion = "25.11";
	};

	programs.home-manager.enable = true;

	fonts.fontconfig = {
		enable = true;
		defaultFonts = {
			serif = ["Noto Serif CJK SC" "Noto Serif" "Noto Color Emoji"];
			sansSerif = ["Noto Sans CJK SC" "Noto Sans" "Noto Color Emoji"];
			monospace = ["JetBrainsMono Nerd Font" "Noto Sans CJK SC" "Noto Color Emoji"];
			emoji = ["Noto Color Emoji"];
		};
	};
}
