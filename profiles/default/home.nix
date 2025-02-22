{
  config,
  pkgs,
  userSettings,
  ...
}:
{

  imports = [
    ../../user/zsh.nix
    ../../user/apps
    ../../user/display
  ];

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home = {
    username = userSettings.userName;
    homeDirectory = "/home/${userSettings.userName}";
    stateVersion = "24.11";

    packages = with pkgs; [

      # cli
      btop
      eza
      fastfetch
      hyfetch
      lazygit

      # lsp
      nixd

      # media
      spotify

      # productivity
      obsidian
    ];
  };

  programs.bat = {
    enable = true;
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

}
