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

    age.keyFile = "${config.hostSpec.home}/.config/sops/age/keys.txt";

    secrets = {
      "passwords/primary" = {
        owner = config.hostSpec.username;
      };
      "passwords/root" = { };
      nix-github-token = { };
    };
  };
}
