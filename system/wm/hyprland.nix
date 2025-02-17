{ inputs, pkgs, lib, ... }: let

    pkgs-hyprland = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};

in {

    imports = [
        ./wayland.nix
        ./pipewire.nix
    ];

    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        xwayland.enable = true;
        # portalPackage = pkgs-hyprland.xdg-desktop-portal-hyprland;
    };

    services.xserver = {
        excludePackages = [ pkgs.xterm ];
    };
    services.displayManager.sddm = {
            enable = true;
            wayland.enable = true;
            enableHidpi = true;
            #TODO: Theme
            theme = "chili";
            package = pkgs.sddm;
        };
}
