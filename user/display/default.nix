{ lib, systemSettings, ... }:
{

  imports = [
    ./hyprland/hyprland.nix
  ];

  hyprland.enable = lib.mkDefault (systemSettings.display == "hyprland");

}
