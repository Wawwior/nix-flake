{
  lib,
  userSettings,
  ...
}:
{

  imports = [
    ./git.nix
    ./kitty.nix
    ./helix.nix
    ./zen.nix
    ./yazi.nix
  ];

  kitty.enable = lib.mkDefault (userSettings.term == "kitty");
  zen.enable = lib.mkDefault (userSettings.browser == "zen");

}
