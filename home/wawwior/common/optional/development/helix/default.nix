{ lib, ... }:
{
  imports = lib.flatten [
    ./languages.nix
    (map lib.custom.fromTop [
      "home/wawwior/common/core/helix.nix"
    ])
  ];
}
