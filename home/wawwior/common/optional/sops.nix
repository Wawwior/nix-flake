{ inputs, lib, ... }:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/home/wawwior/.config/sops/age/keys.txt";

    defaultSopsFile = lib.custom.fromTop "secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "private-keys/wawwior" = {
        path = "/home/wawwior/.ssh/id_auth_ed25519_key";
      };
    };
  };
}
