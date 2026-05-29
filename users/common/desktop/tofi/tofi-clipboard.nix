{ config, pkgs, ... }:
let
	dynamicColor = "${config.xdg.configHome}/tofi/color/tofi-clipboard";
in
{
	xdg.configFile."tofi/clipboard_config" = {
		text = ''
		anchor = left
		width = 40%
		height = 100%
		padding-top = 4
		padding-left = 8
		padding-right = 0
		border-width = 0
		outline-width = 4
		font = Fanwood Text Bold
		font-size = 14
		text-cursor = true
		text-cursor-style = bar
		prompt-text = ""
		prompt-background-padding = 4,-1,2,-1
		prompt-background-corner-radius = 8
		placeholder-text = "Search Clipboard"
		selection-background-padding = 3,-1,3,-1
		selection-background-corner-radius = 8
		result-spacing = 8
		clip-to-padding = false
		fuzzy-match = true
		include=${dynamicColor}'';
	};

	home.packages = [
		(pkgs.writeShellScriptBin "clipboard"
			''${pkgs.cliphist}/bin/cliphist list | ${pkgs.tofi}/bin/tofi -c ${config.xdg.configHome}/tofi/clipboard_config | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy'')
	];
}
