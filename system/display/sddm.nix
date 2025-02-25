{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [ catppuccin-sddm-corners ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    theme = "catppuccin-sddm-corners";
  };
}
