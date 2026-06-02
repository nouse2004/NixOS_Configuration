{ config, pkgs, ... }:

let
  makoColorFile = "${config.xdg.configHome}/mako/color";
in
{
	services.mako = {
    enable = true;
    settings = {
      include = makoColorFile;
      border-size = 2;
      border-radius = 8;
      icon-border-radius = 8;
      icons = 1;
      anchor = "top-right";
      default-timeout = 8000;
      margin = 10;
      padding = "10,0";
      font = "sans-serif";
      history = 1;
      max-visible = 20;
      max-history = 100;
      grouped = 1;
    };
    extraConfig = ''
      [app-name=osd-volume]
      background=#89B4FA
      text-color=#1E1E2E

      [app-name=osd-brightness]
      background=#A6E3A1
      text-color=#1E1E2E

      [app-name=osd-mic]
      background=#F38BA8
      text-color=#1E1E2E
    '';
  };
}
