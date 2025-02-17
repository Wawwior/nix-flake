{ pkgs, ... }: {

    home.packages = with pkgs; [
        ghostty
    ];

    xdg.configFile."ghostty/themes/catppuccin-mocha.conf".source = ./themes/catppuccin-mocha.conf;
    xdg.configFile."ghostty/config".source = ./config;

    wayland.windowManager.hyprland.settings."$term" = "ghostty";
}
