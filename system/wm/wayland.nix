{ systemSettings, config, pkgs, ... }: {

    imports = [
        ./pipewire.nix
        ./fonts.nix
    ];

    environment.systemPackages = with pkgs; [
        wayland 
        waydroid
        (sddm-chili-theme.override {
            themeConfig = {
                ScreenWidth = 1920;
                ScreenHeight = 1080;
                blur = false;
            };
        })
    ];

    services.xserver = {
        enable = true;
        xkb = {
            layout = systemSettings.layout;
            variant = "";
            options = "caps:escape";
        };
    };

}
