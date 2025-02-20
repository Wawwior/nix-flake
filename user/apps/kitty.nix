{ lib, config, ... }:
{

  options = {
    kitty.enable = lib.mkEnableOption "enables kitty terminal";
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
    };
  };
}
