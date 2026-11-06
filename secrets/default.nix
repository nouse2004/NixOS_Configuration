{ var, ... }:
let
  sopsFile = "${var.sourcePath}/secrets/secrets.yaml";
in
{
  sops.defaultSopsFile = sopsFile;
  sops.age.keyFile = "/var/lib/sops/key.txt";
}
