{ pkgs, config, var, ... }: {
	# Display manager (greetd) + compositor (niri)
	programs.niri.enable = true;

	environment.systemPackages = with pkgs; [
		xwayland-satellite
	];

	services.greetd = {
		enable = true;
		settings = {
			default_session = {
				command = "${config.programs.niri.package}/bin/niri-session";
				user = "${var.username}";
			};
		};
	};

	# Fonts
		fonts = {
		packages = with pkgs; [
			noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-cjk-serif
			nerd-fonts.symbols-only
			noto-fonts-color-emoji
			nerd-fonts.jetbrains-mono
			nerd-fonts.noto
			font-manager
		];
		enableDefaultPackages = false;
	};
}
