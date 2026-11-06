{
  lib,
  var,
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./browser.nix
    ./tool.nix
    ./flatpak.nix
  ]
  ++ lib.optional (var.game == true) ./games.nix;
}
