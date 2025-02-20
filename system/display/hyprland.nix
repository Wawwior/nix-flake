{ inputs, pkgs, lib, ... }:
let

  pkgs-hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};

in {

  imports = [ ./wayland.nix ./pipewire.nix ./sddm.nix ];

  programs.hyprland = {
    enable = true;
    package = pkgs-hyprland.hyprland;
    portalPackage = pkgs-hyprland.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    withUWSM = true;
  };

  services.xserver = { excludePackages = [ pkgs.xterm ]; };

}
