{ lib, systemSettings, ... }:
{

  imports = [
    ./hyprland.nix
  ];

  hyprland.enable = lib.mkDefault (systemSettings.display.manager == "hyprland");

}
