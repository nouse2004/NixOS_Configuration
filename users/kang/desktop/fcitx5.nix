{
  pkgs,
  lib,
  config,
  ...
}:
{

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        qt6Packages.fcitx5-configtool
        fcitx5-gtk
        (fcitx5-rime.override {
          rimeDataPkgs = [ rime-ice ];
        })
      ];
      settings = {
        inputMethod = {
          "GroupOrder"."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            DefaultIM = "rime";
            "Default Layout" = "us";
          };
          "Groups/0/Items/0".Name = "rime";
        };
        globalOptions = {
          Hotkey = {
            ToggleInputMethod = "Control+space";
          };
        };
        addons = {
          classicui.globalSection = {
            Font = "Sans 14";
            Theme = "AutoMaterialTheme";
          };
        };
      };
    };
  };

  xdg.dataFile."fcitx5/rime/default.custom.yaml".source =
    let
      toYAML = (pkgs.formats.yaml { }).generate "default.custom.yaml";
    in
    toYAML {
      patch = {
        "__include" = "rime_ice_suggestion:/";
        schema_list = [ { schema = "rime_ice"; } ];
        "ascii_composer.switch_key" = {
          Shift_L = "commit_code";
          Shift_R = "commit_code";
        };
        "menu.page_size" = 6;
      };
    };
}
