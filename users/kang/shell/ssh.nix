{ config, ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = config.sops.secrets."github_ssh_key".path;
      };

    };
  };
}
