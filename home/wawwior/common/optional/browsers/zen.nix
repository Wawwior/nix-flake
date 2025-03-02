{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.zen-browser.packages.${system}.twilight
  ];
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "zen_twilight.desktop" ];
    "text/xml" = [ "zen_twilight.desktop" ];
    "x-scheme-handler/http" = [ "zen_twilight.desktop" ];
  };
}
