{ pkgs, ... }: {

    
    home.packages = with pkgs; [
        rio
    ];

    xdg.configFile."rio/config.toml".source = ./config.toml;

    wayland.windowManager.hyprland.settings."$term" = "rio";

}
