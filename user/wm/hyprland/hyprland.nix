{ inputs, pkgs, config, userSettings, ... }: {

    #TODO: there is gdk in here

    imports = [
    ];

    home.sessionVariables = {
        NIXOS_OZONE_WL = 1;
    };

    home.packages = with pkgs; [
        eww
        wl-clipboard
        dunst
    ];

    gtk.cursorTheme = {
        package = pkgs.quintom-cursor-theme;
#       name = if (config.stylix.polarity == "light") then "Quintom_Ink" else "Quintom_Snow";
        name = "Quintom_Snow";
        size = 36;
    };

    wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        settings = {};
        extraConfig = "
            source=~/.config/hypr/config.conf
            source=~/.config/hypr/keybinds.conf

            exec-once = dbus-update-activation-environment --systemd DISPLAY XAUTHORITY WAYLAND_DISPLAY XDG_SESSION_DESKTOP=Hyprland XDG_CURRENT_DESKTOP=Hyprland XDG_SESSION_TYPE=wayland
            exec-once = hyprctl setcursor " + config.gtk.cursorTheme.name + " " + builtins.toString config.gtk.cursorTheme.size + "

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

            bind = $mainMod, Space, exec, " + userSettings.term + "
        ";
        xwayland.enable = true;
        systemd.enable = true;
    };
}
