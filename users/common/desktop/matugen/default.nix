{ config , inputs , pkgs ,...} : {
	home.packages = with  pkgs ; [
		matugen
	 ];
	
	xdg.configFile = {
		"matugen/config.toml" = {
			text =  ''
			[config] 
			version-check = false
							
			[templates.waybar]
			input_path = '${builtins.toString ./templates/colors.css}'
			output_path = '${config.xdg.configHome}/waybar/colors.css'

			[templates.tofi-drun]
			input_path = '${builtins.toString ./templates/tofi-drun}'
			output_path = '${config.xdg.configHome}/tofi/color/tofi-drun'

			[templates.tofi-clipboard]
			input_path = '${builtins.toString ./templates/tofi-clipboard}'
			output_path = '${config.xdg.configHome}/tofi/color/tofi-clipboard'

			#[templates.tofi-nm]
			#input_path = '~/.config/matugen/templates/tofi/tofi-nm'
			#output_path = '~/.config/tofi/nm_config'

			[templates.tofi-powermenu]
			input_path = '${builtins.toString ./templates/tofi-powermenu}'
			output_path = '${config.xdg.configHome}/tofi/color/tofi-powermenu'

			#[templates.tofi-run]
			#input_path = '~/.config/matugen/templates/tofi/tofi-run'
			#output_path = '~/.config/tofi/run_config'

			[templates.mako]
			input_path = '${builtins.toString ./templates/mako}'
			output_path = '${config.xdg.configHome}/mako/color'
			post_hook='makoctl reload &'

			[templates.swaylock]
			input_path = '${builtins.toString ./templates/swaylock}'
			output_path = '${config.xdg.configHome}/swaylock/color'

			#[templates.yazi]
			#input_path = '~/.config/matugen/templates/yazi'
			#output_path = '~/.config/yazi/theme.toml'	

			#[templates.fcitx5]
			#input_path = '~/.config/matugen/templates/fcitx5'
			#output_path = '~/.local/share/fcitx5/themes/matugen/theme.conf'
			#post_hook = 'systemctl --user restart app-org.fcitx.Fcitx5@autostart.service'

			#[templates.gtk3]
			#input_path ='~/.config/matugen/templates/gtk-color'
			#output_path = '~/.config/gtk-3.0/colors.css'

			#[templates.gtk4]
			#input_path ='~/.config/matugen/templates/gtk-color'
			#output_path = '~/.config/gtk-4.0/colors.css'

			#[templates.kitty]
			#input_path = '~/.config/matugen/templates/kitty'
			#output_path = '~/.config/kitty/themes/matugen.conf'
			#post_hook = "kitty +kitten themes --reload-in=all matugen &"

			[templates.niri]
			input_path = '${builtins.toString ./templates/niri}'
			output_path = '${config.xdg.configHome}/niri/color.kdl'

			#[templates.starship]
			#input_path = '~/.config/matugen/templates/starship'
			#output_path = '~/.config/starship.toml'

			#[templates.zed]
			#input_path = '~/.config/matugen/templates/zed'
			#output_path = '~/.config/zed/themes/matugen.json' '';
		};
	};	

	

}
