{ config, ... }:
{
  programs.ssh = {

    enable = true;

    controlMaster = "auto";
    controlPath = "${config.home.homeDirectory}/.ssh/sockets/S.%r@%h:%p";
    controlPersist = "20m";

    addKeysToAgent = "yes";

    matchBlocks =
      let
        authKey = "${config.home.homeDirectory}/.ssh/id_auth_ed25519_key";
      in
      {

        "git" = {
          host = "github.com";
          user = "git";
          forwardAgent = true;
          identitiesOnly = true;
          identityFile = authKey;
        };
      };
  };
}
