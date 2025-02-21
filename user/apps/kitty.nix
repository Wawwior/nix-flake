{ lib, config, ... }:
{

  options = {
    kitty.enable = lib.mkEnableOption "kitty terminal";
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
    };
  };
}
