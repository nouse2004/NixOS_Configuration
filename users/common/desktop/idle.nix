{ config , pkgs , ...} :
 let 
	dynamicColors = "${config.xdg.configHome}/swaylock/color";
	backgroundPath = "${config.xdg.userDirs.pictures}/Wallpapers/current";
	swaylock-launcher = pkgs.writeShellScriptBin "swaylock-launcher" ''
		exec ${pkgs.swaylock-effects}/bin/swaylock $(${pkgs.coreutils}/bin/cat "${dynamicColors}") "$@"
	'';		
in  {
	programs = {
		swaylock = {
			enable = true;
			package = pkgs.swaylock-effects;
			settings = {
				ignore-empty-password = true;
				daemonize = true;

				# 视觉元素
				indicator = true;
				clock = true;
				timestr = "%R";
				datestr = "%a, %h %d";
				image = backgroundPath;
				indicator-radius = 220;
				indicator-thickness = 10;
				indicator-y-position = 250;

				# 固定颜色
				inside-color = "#00000000";
				inside-clear-color = "#00000000";
				inside-caps-lock-color = "#00000000";
				inside-ver-color = "#00000000";
				inside-wrong-color = "#00000000";
				line-uses-inside = true;
				ring-color = "#00000000";
				ring-clear-color = "#ffffff00";
				ring-caps-lock-color = "#ffffff00";
				ring-ver-color = "#ffffff00";
				ring-wrong-color = "#ffffff00";
				separator-color = "#00000000";

			  #swaylock 不支持 fontconfig的 fallback 配置，請選擇nerd 字體
			  font = "Noto Sans Nerd Font";

				text-clear = "󰽤";
				text-caps-lock = "󰪛";
				text-ver = "󰳌";
				text-wrong = "";
				
				effect-blur = "5x10";
				effect-vignette = "0.5:0.5";
			};
		};

	};
	
	home.packages = [ swaylock-launcher ];

	services.swayidle = let 
		locker = "${swaylock-launcher}/bin/swaylock-launcher";
		display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
		systemctl = action: "${pkgs.systemd}/bin/systemctl ${action}";
	in {
		enable = true;
		timeouts = [
			{ timeout = 300; command = locker; }
			{ timeout = 600; command = display "off" ; resumeCommand = display "on"; }
			{ timeout = 700; command = systemctl "suspend"; }
		];
		events = {
			"before-sleep" = locker;
			"lock" = (display "off") + ";" + locker;
		};
		systemdTargets = [ "graphical-session.target" ] ;
	};
}
