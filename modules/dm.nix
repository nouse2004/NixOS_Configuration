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
}
