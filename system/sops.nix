{ inputs, userSettings, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../secrets/github.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${userSettings.userName}/.config/sops/age/keys.txt";

    secrets = {
      nix-github-token = {
        owner = userSettings.userName;
      };
    };

  };
}
