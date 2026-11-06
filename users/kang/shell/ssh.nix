{
 programs.ssh = {
    enable = true;
    matchBlocks."github.com" = {
      identityFile = config.sops.secrets."github_ssh_key".path;
      identitiesOnly = true;
    };
  };
}
