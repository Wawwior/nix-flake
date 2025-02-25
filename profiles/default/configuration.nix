{
  pkgs,
  systemSettings,
  userSettings,
  ...
}:
{

  imports = [
    # Include the results of the hardware scan.
    ../../system/hardware-configuration.nix
    ../../system/hardware
    ../../system/display
    ../../system/sops.nix
    ../../system/nix-conf.nix
    ../../common/stylix.nix
  ];

  home-manager.backupFileExtension = "backup";
  # Set your time zone.
  time.timeZone = systemSettings.timeZone;

  # Select internationalisation properties.
  i18n = {
    defaultLocale = systemSettings.locale;
    extraLocaleSettings = {
      LC_ADDRESS = systemSettings.extraLocale;
      LC_IDENTIFICATION = systemSettings.extraLocale;
      LC_MEASUREMENT = systemSettings.extraLocale;
      LC_MONETARY = systemSettings.extraLocale;
      LC_NAME = systemSettings.extraLocale;
      LC_NUMERIC = systemSettings.extraLocale;
      LC_PAPER = systemSettings.extraLocale;
      LC_TELEPHONE = systemSettings.extraLocale;
      LC_TIME = systemSettings.extraLocale;
    };
  };

  # Configure console keymap
  console = {
    #keyMap = systemSettings.layout;
    useXkbConfig = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.${userSettings.userName} = {
      isNormalUser = true;
      description = userSettings.name;
      extraGroups = [
        "wheel"
        "networkmanager"
        "input"
      ];
      hashedPassword = userSettings.passHash;
      packages = [ ];
      uid = 1000;
    };
  };

  networking = {
    hostName = systemSettings.hostName;
    networkmanager = {
      enable = true;
      wifi.macAddress = "permanent";
    };
  };

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      vim
      zsh
      git
      ripgrep
      powertop
      gnupg
      lm_sensors
      systemctl-tui
    ];
  };

  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;
    pcscd.enable = true;
  };

  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 5";
      flake = "/home/${userSettings.userName}/.nixos";
    };
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
      enableSSHSupport = true;
    };
    zsh.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Do not change
  # DONT_CHANGE:
  system.stateVersion = "24.11";

}
