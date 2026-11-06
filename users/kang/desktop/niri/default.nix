{config, pkgs , var , ...} : let
	niriConfigSource = "${var.sourcePath}/users/${var.username}/desktop/niri";
in {
  home.packages = with pkgs; [
	wl-kbptr
	wlrctl
  ];

  xdg.configFile = {
    "niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${niriConfigSource}/config.kdl";
    "niri/dms".source = config.lib.file.mkOutOfStoreSymlink "${niriConfigSource}/dms";
  };
}
