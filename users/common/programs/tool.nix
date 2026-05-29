# Kang
# May,20,2026
{ pkgs , ... } : {
	#home.packages = [pkgs.gh];

	home.packages = with pkgs; [
		p7zip
		btop
		nvtopPackages.full
		yazi
		yarn
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
			];
		};
		zed-editor = {
			enable = true;
			extensions = [ "nix" "toml" "rust" ];
			userSettings = {
				theme = {
					mode = "system";
				};
				hour_format = "hour24";
				vim_mode = true;
			};
		};

	};
	
} 
