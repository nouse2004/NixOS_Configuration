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

	# Auto-unlock keyring on greetd login
	security.pam.services.greetd.enableGnomeKeyring = true;

	# Fonts
		fonts = {
		packages = with pkgs; [
			noto-fonts
			noto-fonts-cjk-sans
			nerd-fonts.symbols-only
			noto-fonts-color-emoji
			nerd-fonts.jetbrains-mono
			nerd-fonts.noto
		];
		enableDefaultPackages = false;
	};
}
