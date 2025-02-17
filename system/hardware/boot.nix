{ pkgs, systemSettings, ...}: {

    boot.loader.systemd-boot.enable = (systemSettings.bootMode == "uefi");


    boot.loader.efi = {
        canTouchEfiVariables = (systemSettings.bootMode == "uefi");
        efiSysMountPoint = systemSettings.bootMountPath;
    };

    boot.loader.grub = {
        enable = (systemSettings.bootMode != "uefi");
        device = systemSettings.grubDevice;
    };

    boot.kernelPatches = [
        {
            name = "Rust Support";
            patch = null;
            features = {
                rust = true;
            };
        }
    ];

    boot.kernelPackages = pkgs.linuxPackages_latest;

}
