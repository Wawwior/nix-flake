{
  systemSettings,
  config,
  pkgs,
  ...
}:
{

  imports = [
    ./pipewire.nix
  ];

  environment.systemPackages = with pkgs; [
    wayland
    wl-clipboard
  ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = systemSettings.layout;
      variant = systemSettings.variant;
    };
  };

}
