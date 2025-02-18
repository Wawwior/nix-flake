{ inputs, config, pkgs, userSettings, systemSettings, ... }: {

    imports = [
        ../../user/app/neovim/neovim.nix
       #(./. + "/../../user/wm/${systemSettings.wm}/${systemSettings.wm}.nix")
       #(./. + "/../../user/app/${userSettings.browser}/${userSettings.browser}.nix")
       #../../user/app/rio
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

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            rebuild-flake = "sudo nixos-rebuild --flake ~/.nixos/#system";
        };
    };
}
