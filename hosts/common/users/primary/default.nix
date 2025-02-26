{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  hostSpec = config.hostSpec;
in
{

  users.users.${hostSpec.username} = {
    name = hostSpec.username;
    home = hostSpec.home;
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets.primary.path;

    extraGroups = lib.flatten [
      "wheel"
    ];
  };

  users.mutableUsers = false;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs pkgs hostSpec;
    };
    users.${hostSpec.username}.imports = lib.flatten [
      (
        { config, ... }:
        import (lib.custom.fromTop "home/${hostSpec.username}/${hostSpec.hostName}.nix") {
          inherit
            inputs
            pkgs
            lib
            config
            hostSpec
            ;
        }
      )
    ];
  };

}
