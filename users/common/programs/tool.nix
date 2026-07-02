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
				jnoortheen.nix-ide
				rust-lang.rust-analyzer
			];
		};
		zed-editor = {
			enable = true;
			extensions = [ "nix" "toml" "rust" ];
			userSettings = {
				theme = "One Dark Pro";
				hour_format = "hour24";
				vim_mode = true;
			};
		};

	};
	
} 
