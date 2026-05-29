{ config, pkgs, ... }:
let
  dynamicColor = "${config.xdg.configHome}/tofi/color/tofi-drun";
in
{
	xdg.configFile."tofi/tofi-drun" = {
		text = ''# --- Window ---
		anchor = left
		width = 200
		height = 100%
		padding-top = 6
		padding-left = 8
		padding-right = 0
		border-width = 4
		outline-width = 0

		# --- Font ---
		font = monospace
		font-size = 14

		# --- Input ---
		text-cursor = true
		text-cursor-style = bar
		prompt-text = ""
		prompt-background-padding = 6,-1,5,-1
		prompt-background-corner-radius = 8
		placeholder-text = "Run Application"

		# --- List ---
		selection-background-padding = 4,-1,3,-1
		selection-background-corner-radius = 8
		result-spacing = 15

		# --- Others ---
		clip-to-padding = false
		drun-launch = true
		include=${dynamicColor}'';
	};

	home.packages = [
		(pkgs.writeShellScriptBin "drun"
		 ''exec ${pkgs.tofi}/bin/tofi-drun -c ${config.xdg.configHome}/tofi/tofi-drun'') 
	];
}

