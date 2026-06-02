{ pkgs , ... } : {
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting # Disable greeting
		'';
		shellAliases = {
			cat = "bat";
		};
		plugins = [
			{ name = "grc" ; src = pkgs.fishPlugins.grc.src; }
		];
	};

	home.packages = with pkgs; [
		bat
		grc
	];
}
