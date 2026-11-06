{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;

    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    packages = [
      "com.qq.QQ"
      "com.tencent.WeChat"
      "com.zettlr.Zettlr"
      "com.obsproject.Studio"
      "org.telegram.desktop"
      "md.obsidian.Obsidian"
      "cn.wps.wps_365"
    ];

    update.onActivation = true;

  };
}
