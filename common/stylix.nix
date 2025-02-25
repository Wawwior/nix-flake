{
  inputs,
  pkgs,
  config,
  userSettings,
  ...
}:
{

  imports = [ inputs.stylix.nixosModules.stylix ];

  fonts.packages = with pkgs; [
    nerd-fonts.dejavu-sans-mono
  ];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    image = ./.;

    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.dejavu-sans-mono;
        name = "DejaVuSansM Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = config.stylix.fonts.sansSerif;
    };
  };
  home-manager.users."${userSettings.userName}".stylix = {

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/os/nix-black-4k.png";
      sha256 = "sha256-HRZYeKDmfA53kb3fZxuNWvR8cE96tLrqPZhX4+z4lZA=";
    };

    iconTheme = {
      enable = true;
      package = pkgs.adwaita-icon-theme;
      dark = "Adwaita";
      light = "Adwaita";
    };
  };
}
