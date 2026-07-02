{ pkgs, var, ... } : let
	flake = "${var.sourcePath}#${var.hostName}";
	hmFlake = "${var.sourcePath}#${var.username}";
in {
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting # Disable greeting
		'';
		shellAliases = {
			cat = "bat";
			nrs = "sudo nixos-rebuild switch --flake ${flake}";
			nrb = "nixos-rebuild build --flake ${flake}";
			nfu = "nix flake update ${var.sourcePath}";
			hms = "home-manager switch --flake ${hmFlake}";
			ned = "";
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
