{ pkgs, lib, systemSettings, userSettings, ... }: {

    imports = [ 
        # Include the results of the hardware scan.
        ../../system/hardware-configuration.nix
        ../../system/hardware/boot.nix
       #../../system/hardware/graphics.nix
       #(./. + "../../../system/wm/${systemSettings.wm}.nix")
    ];

    nix.settings.trusted-users = [ "@wheel" ];

    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };

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

    users.users.${userSettings.username} = {
        isNormalUser = true;
        description = userSettings.name;
        extraGroups = [ "wheel" "networkmanager" "input" ];
        packages = [];
        uid = 1000;
    };

    networking.hostName = systemSettings.hostName;
    networking.networkmanager.enable = true;

    environment.systemPackages = with pkgs; [
        vim
        zsh
        git
        home-manager
        ripgrep
    ];

    environment.shells = with pkgs; [ zsh ];
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;

    fonts.fontDir.enable = true;

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    system.stateVersion = "24.11";

 } 
