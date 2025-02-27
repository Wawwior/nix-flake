{ pkgs, ... }:
{
  imports = [
    ./hyprland
    ./wofi.nix
    ./waybar.nix
    ./services/mako.nix
    ./fonts.nix
  ];

  home.packages = [
    pkgs.wl-clipboard
  ];
}
