{ pkgs, ... }:
{
  imports = [
    ./helix
  ];

  home.packages = [
    pkgs.gradle
    pkgs.nixd
    pkgs.jdt-language-server
  ];
}
