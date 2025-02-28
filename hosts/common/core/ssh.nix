{ pkgs, lib, ... }:
{

  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
    askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
  };
}
