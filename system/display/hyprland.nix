{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let

  pkgs-hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};

in
{

  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";
  };

  imports = [
    ./wayland.nix
    ./pipewire.nix
    ./sddm.nix
  ];

  config = lib.mkIf config.hyprland.enable {

    programs.hyprland = {
      enable = true;
      package = pkgs-hyprland.hyprland;
      portalPackage = pkgs-hyprland.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
      withUWSM = true;
    };

    services.xserver = {
      excludePackages = [ pkgs.xterm ];
    };
  };

}
