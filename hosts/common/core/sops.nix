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

  # TODO FIXME

  sops = {
    defaultSopsFile = lib.custom.fromTop "./secrets/passwd.yaml";
    secrets = {
      primary = {
        owner = config.hostSpec.username;
      };
    };
  };
}
