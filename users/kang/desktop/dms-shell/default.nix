{
  config,
  pkgs,
  var,
  ...
}:
let
  dmsConfigSource = "${var.sourcePath}/users/${var.username}/desktop/dms-shell";
in
{

  xdg.configFile = {
    "DankMaterialShell/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${dmsConfigSource}/DankMaterialShell/settings.json";
  };
}
