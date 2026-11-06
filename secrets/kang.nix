{ config, inputs, ... }: {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  sops.secrets."github_ssh_key" = {
    format = "binary";
    sopsFile = ./github_ssh_key.enc;
    path = "${config.home.homeDirectory}/.ssh/github";
    mode = "0600";
  };

}
