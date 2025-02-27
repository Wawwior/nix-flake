{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = lib.custom.fromTop "./.secrets.yaml";

    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      "passwords/primary" = {
        neededForUsers = true;
        owner = config.hostSpec.username;
      };
      "passwords/root" = {
        neededForUsers = true;
      };
      nix-github-token = { };
    };
  };
}
