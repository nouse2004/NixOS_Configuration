{ pkgs, var, ... }:
let
  flake = "${var.sourcePath}#${var.hostName}";
  hmFlake = "${var.sourcePath}#${var.username}";
in
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
            set fish_greeting # Disable greeting
            fish_vi_key_bindings
          '';
    shellAliases = {
      cat = "bat";
      nrs = "sudo nixos-rebuild switch --flake ${flake}";
      nrb = "nixos-rebuild build --flake ${flake}";
      nfu = "nix flake update ${var.sourcePath}";
      hms = "home-manager switch --flake ${hmFlake}";
      nixos = "cd ~/Documents/nixos-config/";
    };
    functions = {
      set_proxy = ''
                    set http_proxy "127.0.0.1:7890"
                    set https_proxy "127.0.0.1:7890"
                    set all_proxy "127.0.0.1:7890"
                    echo "Proxy Enabled"
                '';
      unset_proxy = ''
                    unset http_proxy
                    unset https_proxy
                    unset all_proxy
                    echo "Proxy Disabled"
                '';
    };
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
    ];
  };

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    bat
    grc
  ];
}
