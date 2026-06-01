{ pkgs, ... }: {
	home.packages = [
		(pkgs.writeShellScriptBin "kitty_popup" ''
			exec ${pkgs.kitty}/bin/kitty --class kitty_popup \
				--override "remember_window_size=no" \
				--override "initial_window_width=800" \
				--override "initial_window_height=520" \
				"$@"
		'')
	];
}
