{ inputs, pkgs, ... }: {
    
    programs.wezterm = { 
        enable = true;
        package = inputs.wezterm.packages.${pkgs.system}.default;
    };

    wayland.windowManager.hyprland.settings."$term" = "wezterm";

    xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;

}
