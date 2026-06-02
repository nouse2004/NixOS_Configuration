{ config, pkgs, lib, ... }:

let
	dynamicColor = "${config.xdg.configHome}/tofi/color/tofi-powermenu";

	tofiConfigText = ''
		include=${dynamicColor}
		width=100%
		height = 100%
		prompt-text = ""
		border-width = 0
		outline-width = 0
		padding-left = 45%
		padding-top = 20%
		result-spacing = 25
		font = Fanwood Text
		font-size = 36
		hide-input = true
		require-match = true
	'';

	menuItems = [
		{ label = "󰐥  Off";      command = "systemctl poweroff"; }
		{ label = "  Lock";     command = "swaylock-launcher"; }
		{ label = "󰩈  Exit";     command = "niri msg action quit"; }
		{ label = "󰤁  Hiber";    command = "systemctl hibernate"; }
		{ label = "󰤄  Sleep";    command = "systemctl suspend"; }
		{ label = "󰑧  Reboot";   command = "systemctl reboot"; }
	];

	menuOptions = lib.concatStringsSep "\n" (map (item: item.label) menuItems);

	caseBody = lib.concatMapStrings (item: ''
		"${item.label}")
			${item.command}
			;;
	'') menuItems;

in
{
	xdg.configFile."tofi/powermenu/powermenu_config".text = tofiConfigText;

	home.packages = [
		(pkgs.writeShellApplication {
			name = "powermenu";
			runtimeInputs = with pkgs; [ tofi libnotify systemd niri ];
			text = ''
				TOFI_CONF="${config.xdg.configHome}/tofi/powermenu/powermenu_config"

				choice=$(printf '%s\n' "${menuOptions}" | tofi -c "$TOFI_CONF") || exit 0

				if [[ -n "$choice" ]]; then
					case "$choice" in
						${caseBody}
						*)
							notify-send "Power Menu" "Error: Invalid selection '$choice'" --icon=dialog-error
							exit 1
							;;
					esac
				fi
			'';
		})
	];
}
