{ lib, hostSpec, ... }:
{

  imports = lib.flatten [
    (map lib.custom.fromTop [
      "modules/common/host-spec.nix"
    ])
  ];

  home = {
    stateVersion = "24.11";
  };

  inherit hostSpec;

}
