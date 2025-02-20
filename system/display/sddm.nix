{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ catppuccin-sddm-corners ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    package = pkgs.sddm;

    theme = "catppuccin-sddm-corners";
  };
}
