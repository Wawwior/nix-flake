{ lib, config, ... }:
{

  options = {
    waybar.enable = lib.mkEnableOption "waybar";
    waybar.battery = lib.mkEnableOption "waybar battery component";
  };

  config = lib.mkIf config.waybar.enable {
    programs.waybar = {
      systemd.enable = true;
      enable = true;
      settings = [
        {
          layer = "top";
          position = "top";
          height = 36;

          modules-left = [ "clock" ];
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [
            "tray"
            "wireplumber"
            "memory"
            "cpu"
            "temperature"
          ];

          temperature = {
            hwmon-path-abs = "/sys/devices/platform/coretemp.0/hwmon";
            input-filename = "temp1_input";
          };
        }
      ];
      style =
        # css
        ''
          * {
            font-family: "DejaVuSansM Nerd Font Mono";
          }

        '';
    };
  };
}
