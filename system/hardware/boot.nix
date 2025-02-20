{ pkgs, systemSettings, ... }: {

  boot.loader = {
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

  boot.kernelPatches = [{
    name = "Rust Support";
    patch = null;
    features = { rust = true; };
  }];

  boot.kernelPackages = pkgs.linuxPackages_latest;

}
