{
  inputs,
  pkgs,
  lib,
  config,
  userSettings,
  ...
}:
{

  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf config.hyprland.enable {

    home.sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };

    home.packages = with pkgs; [ dunst ];

    home.pointerCursor = {
      hyprcursor.enable = true;
      gtk.enable = true;
      x11.enable = true;
    };

    xdg.configFile."hypr/config.conf".source = ./config.conf;
    xdg.configFile."hypr/keybinds.conf".source = ./keybinds.conf;

    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      settings = { };
      extraConfig = ''

        source=./config.conf
        source=./keybinds.conf

        monitor=eDP-1,1920x1080@60,0x0,1.25

        env = XDG_CURRENT_DESKTOP,Hyprland
        env = XDG_SESSION_DESKTOP,Hyprland
        env = XDG_SESSION_TYPE,wayland
        env = GDK_BACKEND,wayland,x11,*
        env = QT_QPA_PLATFORM,wayland;xcb
        env = QT_QPA_PLATFORMTHEME,qt5ct
        env = QT_AUTO_SCREEN_SCALE_FACTOR,1
        env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
        env = CLUTTER_BACKEND,wayland

        $mainMod = Super

        $term = ${userSettings.term}
        bind = $mainMod, Space, exec, $term

        cursor {
            no_hardware_cursors = 1
        }

      '';
      xwayland.enable = true;
      systemd.enable = true;
    };
  };
}
