{
  lib,
  pkgs,
  config,
  hostSpec,
  ...
}:
{

  imports = lib.flatten [

    ./zsh
    ./git.nix
    ./helix.nix
    ./kitty.nix
    ./tools

    (map lib.custom.fromTop [
      "modules/common/host-spec.nix"
      "modules/home"
    ])
  ];

  home = {
    stateVersion = "24.11";
  };

  inherit hostSpec;

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/media/audio";
    videos = "${config.home.homeDirectory}/media/video";
    pictures = "${config.home.homeDirectory}/media/images";
    download = "${config.home.homeDirectory}/downloads";
    documents = "${config.home.homeDirectory}/documents";
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  home.sessionVariables = {
    EDITOR = "hx";
    TERM = "kitty";
    BROWSER = "zen";
  };
}
