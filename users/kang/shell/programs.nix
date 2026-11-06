{ pkgs, ... }: {
  home.packages = with pkgs; [
    p7zip # 7z
    imv
  ];

  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      extraConfig = "mouse on";
    };

    git.enable = true;

  };
}
