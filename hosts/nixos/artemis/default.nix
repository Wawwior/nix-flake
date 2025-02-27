{
  inputs,
  lib,
  ...
}:
{
  imports = lib.flatten [

    inputs.nixos-facter-modules.nixosModules.facter

    inputs.disko.nixosModules.disko
    (lib.custom.fromTop "hosts/common/disks/ext4-simple.nix")
    {
      _module.args = {
        disk = "/dev/nvme0n1";
        withSwap = true;
        swapSize = "16";
      };
    }

    (map lib.custom.fromTop [
      "hosts/common/core"
      "hosts/common/optional/services/openssh.nix"
      "hosts/common/optional/services/cpufreq.nix"
      "hosts/common/optional/services/thermald.nix"

      # PONDER_THE_ORB: is this the best way to do this?
      "hosts/common/optional/stylix/catppuccin-mocha"

      "hosts/common/optional/audio.nix"
      "hosts/common/optional/sddm.nix"
      "hosts/common/optional/hyprland.nix"
    ])
  ];

  facter.reportPath = ./facter.json;

  hostSpec = {
    hostName = "artemis";
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    initrd.systemd.enable = true;
  };

  system.stateVersion = "24.11";

  console.useXkbConfig = true;

  services.xserver = {
    xkb = {
      layout = "de";
      variant = "nodeadkeys";
    };
  };
}
