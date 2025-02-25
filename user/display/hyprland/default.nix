{
  inputs,
  pkgs,
  lib,
  config,
  systemSettings,
  userSettings,
  ...
}:
{

  imports = [
    ../wofi.nix
    ../waybar.nix
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf config.hyprland.enable {

    waybar.enable = true;

    home.sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };

    home.packages = with pkgs; [ dunst ];

    home.pointerCursor = {
      hyprcursor.enable = true;
      gtk.enable = true;
      x11.enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      systemd.enable = true;
      xwayland.enable = true;
      settings = {

        monitor = "${systemSettings.display.monitor},${systemSettings.display.resolution},0x0,${systemSettings.display.scale}";

        general = {
          gaps_in = 2;
          gaps_out = 4;
          border_size = 2;
          resize_on_border = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 7;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 7, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        misc = {

        };

        input = {
          kb_layout = "de";
          follow_mouse = 1;
          accel_profile = "flat";
          touchpad = {
            scroll_factor = 0.2;
            natural_scroll = true;
          };
        };

        gestures = {
          workspace_swipe = true;
        };

        cursor = {
          no_hardware_cursors = 1;
        };

        "$mainMod" = "Super";
        "$run" = "wofi --show run";
        "$drun" = "wofi --show drun";
        "$term" = "${userSettings.term}";

        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "GDK_BACKEND,wayland,x11,*"
          "QT_QPA_PLATFORM,wayland;xcb"
          "QT_QPA_PLATFORMTHEME,qt5ct"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "CLUTTER_BACKEND,wayland"
        ];

        bind = [
          "$mainMod, Q, killactive"
          "$mainMod, F, togglefloating"
          "$mainMod, Return, fullscreen"

          "$mainMod, Space, exec, $term"
          "$mainMod, A, exec, $drun"
          "$mainMod, W, exec, $run"

          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          "bind = $mainMod, 1, workspace, 1"
          "bind = $mainMod, 2, workspace, 2"
          "bind = $mainMod, 3, workspace, 3"
          "bind = $mainMod, 4, workspace, 4"
          "bind = $mainMod, 5, workspace, 5"
          "bind = $mainMod, 6, workspace, 6"
          "bind = $mainMod, 7, workspace, 7"
          "bind = $mainMod, 8, workspace, 8"
          "bind = $mainMod, 9, workspace, 9"
          "bind = $mainMod, 0, workspace, 10"

          "$mainMod+Shift, 1, movetoworkspace, 1"
          "$mainMod+Shift, 2, movetoworkspace, 2"
          "$mainMod+Shift, 3, movetoworkspace, 3"
          "$mainMod+Shift, 4, movetoworkspace, 4"
          "$mainMod+Shift, 5, movetoworkspace, 5"
          "$mainMod+Shift, 6, movetoworkspace, 6"
          "$mainMod+Shift, 7, movetoworkspace, 7"
          "$mainMod+Shift, 8, movetoworkspace, 8"
          "$mainMod+Shift, 9, movetoworkspace, 9"
          "$mainMod+Shift, 0, movetoworkspace, 10"

          "$mainMod+Shift, h, movewindow, l"
          "$mainMod+Shift, l, movewindow, r"
          "$mainMod+Shift, k, movewindow, u"
          "$mainMod+Shift, j, movewindow, d"

          "$mainMod+Shift, Tab, movetoworkspace, special"
          "$mainMod, Tab, togglespecialworkspace"

          "bind = $mainMod, o, togglesplit"

          "$mainMod+Alt, 1, movetoworkspacesilent, 1"
          "$mainMod+Alt, 2, movetoworkspacesilent, 2"
          "$mainMod+Alt, 3, movetoworkspacesilent, 3"
          "$mainMod+Alt, 4, movetoworkspacesilent, 4"
          "$mainMod+Alt, 5, movetoworkspacesilent, 5"
          "$mainMod+Alt, 6, movetoworkspacesilent, 6"
          "$mainMod+Alt, 7, movetoworkspacesilent, 7"
          "$mainMod+Alt, 8, movetoworkspacesilent, 8"
          "$mainMod+Alt, 9, movetoworkspacesilent, 9"
          "$mainMod+Alt, 0, movetoworkspacesilent, 10"
        ];

        bindl = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        bindel = [
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ];

        binde = [
          "$mainMod+Ctrl, Right, resizeactive, 30 0"
          "$mainMod+Ctrl, Left, resizeactive, -30 0"
          "$mainMod+Ctrl, Up, resizeactive, 0 -30"
          "$mainMod+Ctrl, Down, resizeactive, 0 30"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

      };
      extraConfig = ''




      '';
    };
  };
}
