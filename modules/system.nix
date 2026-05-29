{
	pkgs,
	lib,
	var,
	...
} : {
	# Nix
	nix.settings.trusted-users = [var.username];
	nix.settings = {
		experimental-features = ["nix-command" "flakes"];
		substituters = [
			"https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
			"https://mirror.sjtu.edu.cn/nix-channels/store"
			"https://cache.nixos.org"
		];
		trusted-public-keys = [];
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

	# Fonts
	fonts = {
		packages = with pkgs; [
			noto-fonts
			noto-fonts-cjk-sans
			nerd-fonts.symbols-only
			noto-fonts-color-emoji
			nerd-fonts.symbols-only
			nerd-fonts.jetbrains-mono
		];
		enableDefaultPackages = false;
		fontconfig.defaultFonts = {
			serif = ["Noto Serif" "Noto Color Emoji"];
			sansSerif = ["Noto Sans" "Noto Color Emoji"];
			monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
			emoji = ["Noto Color Emoji"];
		};
	};

	# Programs
	programs = {
		dconf.enable = true;
		fish.enable = true;
	};

	# Services
	services = {
		printing.enable = true;
		dbus.packages = [ pkgs.gcr ];
		flatpak.enable = true;
		pipewire = {
			enable = true;
			pulse.enable = true;
		};
		tlp = {
			enable = true;
			pd.enable = true;
		};
		upower.enable = true;
		power-profiles-daemon.enable = false;
	};

	# Networking
	networking.firewall.enable = false;

	# Virtualisation
	virtualisation.podman = {
		enable = true;
		dockerCompat = true;
	};

	# Security
	security.polkit.enable = true;
	security.rtkit.enable = true;

	# System packages
	environment.systemPackages = with pkgs; [
		vim
		curl
		git
		fastfetch
		distrobox
	];
}
