{
  inputs,
  lib,
  ...
}:
{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager

    ./sops.nix

    (map lib.custom.fromTop [
      "modules/common"
      "hosts/common/users/primary"
    ])
  ];

  hostSpec = {
    username = "wawwior";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
