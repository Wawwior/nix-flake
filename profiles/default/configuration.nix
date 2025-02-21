{
  inputs,
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
    ../../system/style/stylix.nix
  ];

  nix.settings.trusted-users = [ "@wheel" ];

  nix.settings.substituters = [ "https://hyprland.cachix.org" ];

  nix.settings.trusted-public-keys = [
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];

  home-manager.backupFileExtension = "backup";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # Set your time zone.
  time.timeZone = systemSettings.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = systemSettings.locale;

  i18n.extraLocaleSettings = {
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

  # Configure console keymap
  console.keyMap = systemSettings.layout;

  users.users.${userSettings.userName} = {
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

  networking.hostName = systemSettings.hostName;
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    zsh
    git
    ripgrep
    powertop
    gnupg
  ];

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
    enableSSHSupport = true;
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/${userSettings.userName}/.nixos";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Do not change
  system.stateVersion = "24.11";

}
