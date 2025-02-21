{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    zen.enable = lib.mkEnableOption "zen browser";
  };

  config = lib.mkIf config.zen.enable {
    home.packages = with pkgs; [
      inputs.zen-browser.packages.${system}.twilight
    ];
  };
}
