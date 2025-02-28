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
    defaultSopsFile = lib.custom.fromTop "./secrets.yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      "passwords/wawwior" = {
        neededForUsers = true;
      };
      "passwords/root" = {
        neededForUsers = true;
      };
    };
  };
}
