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

    age.keyFile = "${config.hostSpec.home}/.config/sops/keys.txt";

    secrets = {
      "passwords/primary" = {
        owner = config.hostSpec.username;
      };
      nix-github-token = { };
    };
  };
}
