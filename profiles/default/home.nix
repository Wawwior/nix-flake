{ inputs, config, pkgs, userSettings, systemSettings, ... }: {

    imports = [
        ../../user/app/neovim
        (./. + "../../user/wm/${systemSettings.wm}/${systemSettings.wm}.nix")
        (./. + "../../user/app/${userSettings.browser}/${userSettings.browser}.nix")
        ../../user/app/rio
        ../../user/app/git.nix
    ];

    programs.home-manager.enable = true;

    home = {
        username = userSettings.username;
        homeDirectory = "/home/${userSettings.username}";
        stateVersion = "24.11";

        packages = with pkgs; [
            fastfetch
        ];
    };

    xdg.enable = true;
    xdg.userDirs = {
        enable = true;
        createDirectories = true;
        music = "${config.home.homeDirectory}/Media/Music";
        videos = "${config.home.homeDirectory}/Media/Videos";
        pictures = "${config.home.homeDirectory}/Media/Pictures";
        templates = "${config.home.homeDirectory}/Templates";
        download = "${config.home.homeDirectory}/Downloads";
        documents = "${config.home.homeDirectory}/Documents";
        desktop = null;
        publicShare = null;
    };
    xdg.mime.enable = true;
    xdg.mimeApps.enable = true;

    home.sessionVariables = {
        EDITOR = userSettings.editor;
        TERM = userSettings.term;
        BROWSER = userSettings.browser;
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            rebuild-flake = "sudo nixos-rebuild --flake ~/.nixos/";
        };
    };
}
