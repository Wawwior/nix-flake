{ pkgs, ... }:
{

  home.packages = [
    pkgs.fastfetch
  ];

  programs.hyfetch = {
    enable = true;
  };
}
