{
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/home/wawwior/.config/sops/age/keys.txt";

    defaultSopsFile = lib.custom.fromTop "keys.yaml";
    validateSopsFiles = false;

    secrets = {
      "wawwior/auth/public" = {
        path = "/home/wawwior/.ssh/id_auth_ed25519_key.pub";
      };
      "wawwior/auth/private" = {
        path = "/home/wawwior/.ssh/id_auth_ed25519_key";
      };
      "wawwior/sign/public" = {
        path = "/home/wawwior/.ssh/id_sign_ed25519_key.pub";
      };
      "wawwior/sign/private" = {
        path = "/home/wawwior/.ssh/id_sign_ed25519_key";
      };
    };
  };
}
