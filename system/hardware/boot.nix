{ pkgs, systemSettings, ... }:
{

  boot = {

    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot.enable = (systemSettings.bootMode == "systemd");
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = systemSettings.bootMountPath;
      };
      grub = {
        devices = [ systemSettings.grubDevice ];
        enable = (systemSettings.bootMode == "grub");
        efiSupport = true;
        useOSProber = true;
      };
    };

    kernelPatches = [
      {
        name = "Rust Support";
        patch = null;
        features = {
          rust = true;
        };
      }
    ];

    kernelPackages = pkgs.linuxPackages_latest;
  };
}
