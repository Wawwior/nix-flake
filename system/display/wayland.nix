{ systemSettings, config, pkgs, ... }: {

  imports = [ ./pipewire.nix ./fonts.nix ];

  environment.systemPackages = with pkgs; [ wayland wl-clipboard ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = systemSettings.layout;
      variant = "";
      options = "caps:escape";
    };
  };

}
