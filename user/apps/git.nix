{
  programs.git = {

    enable = true;
    userName = "Wawwior";
    userEmail = "45405580+Wawwior@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      # TODO: change the way this works
      user.signingkey = "883066537CBE279E";
      commit.gpgsign = true;
    };

  };
}
