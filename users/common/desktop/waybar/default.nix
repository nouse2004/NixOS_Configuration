{ config, lib , pkgs , var , inputs ,... } : let
	configPath = "${var.sourcePath}/users/common/desktop/waybar";
in  {
	programs.waybar = {
		enable = true;
		systemd.enable = true;
		package = inputs.waybar.packages.${pkgs.system}.waybar;
	};
	
	# 由於waybar配置文件過於複雜，所以使用原版配置文件
	# 可能需要修改文件中的path
	xdg.configFile = {
		"waybar/config.jsonc".source = ./config.jsonc;
		"waybar/modules.json".source = config.lib.file.mkOutOfStoreSymlink "${configPath}/modules.json";
		"waybar/scripts".source = lib.mkForce(config.lib.file.mkOutOfStoreSymlink "${configPath}/scripts");
		"waybar/style.css".source = lib.mkForce(config.lib.file.mkOutOfStoreSymlink "${configPath}/style.css"); 
	};

}
