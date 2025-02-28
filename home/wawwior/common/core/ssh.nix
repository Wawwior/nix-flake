{ config, ... }:
{
  programs.ssh = {
    enable = true;
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
