{ lib, ... }:
{
  imports = lib.flatten [
    (map lib.custom.root [
      "modules/common"
    ])
  ];
}
