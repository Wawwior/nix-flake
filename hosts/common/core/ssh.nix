{ pkgs, ... }:
{

  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
    askPassword = "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
  };
}
