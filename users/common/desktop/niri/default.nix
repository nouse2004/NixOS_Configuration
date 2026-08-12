{config, pkgs , var , ...} : let 
	niriConfigSource = "${var.sourcePath}/users/common/desktop/niri";
in {
  home.packages = with pkgs; [
	wl-kbptr
	wlrctl
  ];

  xdg.configFile = {
    "niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${niriConfigSource}/config.kdl";
    "niri/binds.kdl".source = config.lib.file.mkOutOfStoreSymlink "${niriConfigSource}/binds.kdl";
    "niri/animations.kdl".source = config.lib.file.mkOutOfStoreSymlink "${niriConfigSource}/animations.kdl";
    "niri/layout.kdl".source = config.lib.file.mkOutOfStoreSymlink "${niriConfigSource}/layout.kdl";
    "niri/output.kdl".source = config.lib.file.mkOutOfStoreSymlink "${niriConfigSource}/output.kdl";
    "niri/window-rule.kdl".source = config.lib.file.mkOutOfStoreSymlink "${niriConfigSource}/window-rule.kdl";
  };
}
