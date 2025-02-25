{ inputs, lib, ... }:
{
  imports = lib.flatten [
    ./hardware-configuration.nix

    (map lib.custom.root [
      "hosts/common/core"
    ])
  ];

  hostSpec = {
    hostName = "artemis";
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    initrd.systemd.enable = true;
  };

  system.stateVersion = "24.11";
}
