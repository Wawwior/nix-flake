{ pkgs, ... }:
{

  home-manager.sharedModules = [
    {
      stylix = {
        enable = true;
        image = ./wallpaper.png;
        iconTheme = {
          enable = true;
          package = pkgs.yaru-theme;
        };
      };
    }
  ];
}
