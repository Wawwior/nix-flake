{ lib, systemSettings, ... }:
{

  imports = [
    ./hyprland.nix
  ];

  hyprland.enable = lib.mkDefault (systemSettings.display == "hyprland");

}
