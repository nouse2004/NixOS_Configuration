{ config, lib , pkgs , ... } : {
	programs.waybar = {
		enable = true;
		systemd.enable = true;
	};
	
	# 由於waybar配置文件過於複雜，所以使用原版配置文件
	# 可能需要修改文件中的path
	xdg.configFile = {
		"waybar/config.jsonc".source = ./config.jsonc;
		"waybar/modules.json".source = ./modules.json;
		"waybar/scripts".source = lib.mkForce(config.lib.file.mkOutOfStoreSymlink ./scripts);
		"waybar/style.css".source = lib.mkForce(config.lib.file.mkOutOfStoreSymlink ./style.css); 
	};

}
