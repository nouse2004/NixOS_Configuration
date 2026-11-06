{
	lib,
	var,
	...
}: {

	imports = [../secrets];
	# Nix
	nix.settings.trusted-users = [var.username];
	nix.settings = {
		experimental-features = ["nix-command" "flakes"];
		substituters = [
			"https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
			"https://mirror.sjtu.edu.cn/nix-channels/store"
			"https://cache.nixos.org"
			"https://nix-community.cachix.org"
		];
		trusted-public-keys = [
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
		];
		builders-use-substitutes = true;
	};
	nix.gc = {
		automatic = lib.mkDefault true;
		dates = lib.mkDefault "weekly";
		options = lib.mkDefault "--delete-older-than 7d";
	};

	nixpkgs.config.allowUnfree = true;

	# Time & locale
	time.timeZone = "Asia/Hong_Kong";
	i18n.defaultLocale = "en_US.UTF-8";
#	i18n.extraLocaleSettings = {
#		LC_ADDRESS = "zh_CN.UTF-8";
#		LC_IDENTIFICATION = "zh_CN.UTF-8";
#		LC_MEASUREMENT = "zh_CN.UTF-8";
#		LC_MONETARY = "zh_CN.UTF-8";
#		LC_NAME = "zh_CN.UTF-8";
#		LC_NUMERIC = "zh_CN.UTF-8";
#		LC_PAPER = "zh_CN.UTF-8";
#		LC_TELEPHONE = "zh_CN.UTF-8";
#		LC_TIME = "zh_CN.UTF-8";
#	};


}
