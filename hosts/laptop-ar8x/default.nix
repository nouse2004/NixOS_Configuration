{
  config,
  lib,
  pkgs,
  var,
  ...
}:
{
  imports = [
    ../../modules/system.nix
    ../../modules/desktop.nix
    ../../modules/programs.nix
    ./hardware-configuration.nix
    ./integrated.nix
  ]
  ++ lib.optional (var.game == true) ../../modules/games.nix;

  # Boot
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 8;
    };
    efi = {
      efiSysMountPoint = "/boot";
      canTouchEfiVariables = true;
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "laptop-ar8x";
  networking.networkmanager.enable = true;

  # Display
  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];

  # Power management
  services.logind.settings.Login = {
    HandlePowerKey = "hibernate";
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
  };

  # Systemd
  systemd.settings.Manager.DefaultTimeoutStopSec = "15s";

  # SysRq
  boot.kernel.sysctl."kernel.sysrq" = 1;

  # Networking
  networking.firewall.enable = false;

  services.udisks2.enable = true;
  # State
  system.stateVersion = "25.05";
}
