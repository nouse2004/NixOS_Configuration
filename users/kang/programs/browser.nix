{ pkgs, config , ... }: {
	programs.chromium = {
		enable = true;

		# 切换浏览器: pkgs.chromium / pkgs.ungoogled-chromium / pkgs.google-chrome / pkgs.brave
		# package = pkgs.chromium;

		# 命令行参数
		# commandLineArgs = [
		# 	"--enable-features=TouchpadOverscrollHistoryNavigation"
		# 	"--ignore-gpu-blocklist"
		# ];

		# Chrome Web Store 扩展 (32位ID)
		# extensions = [
		# 	{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
		# 	{ id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
		# ];

		# 拼写检查字典
		# dictionaries = with pkgs.hunspellDictsChromium; [
		# 	en_US
		# 	zh_CN
		# ];

		# 原生消息宿主 (如 KeepassXC 密码填充)
		# nativeMessagingHosts = with pkgs; [
		# 	keepassxc
		# ];
	};


	programs.firefox = {
		enable = true;
		configPath = "${config.xdg.configHome}/mozilla/firefox";
		profiles.default = {
			isDefault = true;
			settings = {
				"general.smoothScroll.currentVelocityWeighting" = 1;
				"general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
				"general.smoothScroll.msdPhysics.enabled" = true;
				"general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
				"general.smoothScroll.msdPhysics.regularSpringConstant" = 250;
				"general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
				"general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 0.3;
				"general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
				"general.smoothScroll.stopDecelerationWeighting" = 1.0;
				"mousewheel.default.delta_multiplier_y" = 200;
				"services.sync.prefs.sync.general.smoothScroll" = true;
			};
		};
	};
}
