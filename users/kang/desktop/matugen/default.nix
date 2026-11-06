{
  config,
  inputs,
  pkgs,
  ...
}:
{
  xdg.configFile = {
    "matugen/config.toml".text = ''
            [config]
            version-check = false

            [templates.fcitx5]
            input_path = '${./templates/fcitx5-theme.conf}'
            output_path = '${config.xdg.dataHome}/fcitx5/themes/AutoMaterialTheme/theme.conf'
            post_hook='fcitx5 -r -d'
            '';
  };

}
