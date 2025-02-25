{ lib, systemSettings, ... }:
{

  imports = [
    ./hyprland
  ];

  hyprland.enable = lib.mkDefault (systemSettings.display.manager == "hyprland");

}
