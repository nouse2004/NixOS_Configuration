{
  pkgs,
  config,
  var,
  inputs,
  ...
}:
{
  # Display manager (greetd) + compositor (niri)
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    pam_fde_boot_pw
  ];

  # services.greetd = {
  # 	enable = true;
  # 	settings = {
  # 		default_session = {
  # 			command = "${config.programs.niri.package}/bin/niri-session";
  # 			user = "${var.username}";
  # 		};
  # 	};
  # };

  # Enable gnome-keyring in PAM but DON'T enable
  # services.gnome.gnome-keyring (which adds gnome-keyring's DBus
  # service files → DBus activation races with PAM's auto_start
  # and spawns a second daemon without the login password).
  security.pam.services.greetd.enableGnomeKeyring = true;

  # Fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      nerd-fonts.symbols-only
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      nerd-fonts.noto
      font-manager
    ];
    enableDefaultPackages = false;
  };

  services.displayManager = {
    dms-greeter = {
      enable = true;
      compositor = {
        name = "niri";
        #customConfig = '' '';
      };

      configHome = "/home/${var.username}";
      logs = {
        save = true;
        path = "/tmp/dms-greeter.log";
      };
    };
  };

  security.pam.services.greetd.text = ''
      auth      substack      login
      account   include       login
      password  substack      login
      session   optional      ${pkgs.pam_fde_boot_pw}/lib/security/pam_fde_boot_pw.so inject_for=gkr
      session   include       login
      '';

  #	imports = [ inputs.dms-plugin-registry.nixosModules.default ];

  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    plugins = {

    };
  };
}
