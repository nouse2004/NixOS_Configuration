{ config , pkgs , ...} :
 let 
	dynamicColors = "${config.xdg.configHome}/swaylock/color";
	
	swaylock-launcher = pkgs.writeShellScriptBin "swaylock-launcher" ''
		exec ${pkgs.swaylock-effects}/bin/swaylock -c ${dynamicColors} "$@"
	'';		
in  {
	programs = {
		swaylock = {
			enable = true;
			package = pkgs.swaylock-effects;
			settings = {
				ignore-empty-password = true;
				fade-in = "0.2";
				daemonize = true;

				# 视觉元素
				indicator = true;
				clock = true;
				timestr = "%R";
				datestr = "%a, %h %d";
				image = "${config.xdg.userDirs.pictures}/Wallpaper/currentwallpaper";
				indicator-radius = 220;
				indicator-thickness = 10;
				indicator-y-position = 250;
				#swaylock 不支持 fontconfig的 fallback 配置，請選擇nerd 字體
				#font = "HarmonyOSSans Nerd Font";

				text-clear = "󰽤";
				text-caps-lock = "󰪛";
				text-ver = "󰳌";
				text-wrong = "";

				# 视觉特效
				effect-blur = "5x10";
				effect-vignette = "0.5:0.5";
			};
		};

	};
	
	home.packages = [ swaylock-launcher ];

	services = {
		swayidle = {
			enable = true;
			timeouts = [
				{ timeout = 300; command = "swaylock-launcher"; }
				{ timeout = 600; command = "niri msg action power-off-monitors"; resumeCommand = "niri msg action power-on-monitors"; }
				{ timeout = 700; command = "systemctl suspend-then-hibernate"; }
			];
			events = {
				"before-sleep" = "pgrep -x swaylock || swaylock-launcher";
			};
			systemdTargets = [ "graphical-session.target" ] ;
		};
	};
}
