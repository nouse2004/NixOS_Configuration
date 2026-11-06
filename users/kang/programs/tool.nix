# Kang
# May,20,2026
{ pkgs , ... } : {
	#home.packages = [pkgs.gh];

	home.packages = with pkgs; [
		p7zip
		nautilus
		btop
		nvtopPackages.full
		yazi
		imv
	];
	programs = {
		tmux = {
			enable = true;
			clock24 = true;
			keyMode = "vi";
			extraConfig = "mouse on";
		};
		git = {
			enable = true;
		};
		vscode = {
			enable = true;
			profiles.default.extensions = with pkgs.vscode-extensions; [
				vscodevim.vim
				jnoortheen.nix-ide
				# tencent-cloud.coding-copilot
				rust-lang.rust-analyzer
			];
		};
		zed-editor = {
			enable = true;
			extensions = [ "nix" "toml" "rust" ];
			userSettings = {
				theme = {
				    mode = "system";
						light = "DankShell Light";
						dark = "DankShell Dark";
				};
				hour_format = "hour24";
				vim_mode = true;
			};
		};
		mpv = {
			enable = true;
			defaultProfiles = ["gpu-hq"];
			scripts = [ pkgs.mpvScripts.mpris ];
		};

	};

	services.udiskie = {
		enable = true;
		automount = true;
		notify = true;
		settings  = {
			program_options = {
				file_manager = "${pkgs.nautilus}/bin/nautilus";
			};
		};
	};
}
