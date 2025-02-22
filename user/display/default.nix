{ lib, systemSettings, ... }:
{

  imports = [
    ./hyprland
  ];

  hyprland.enable = lib.mkDefault (systemSettings.display == "hyprland");

}
