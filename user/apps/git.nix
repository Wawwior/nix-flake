{
  programs.git = {

    enable = true;
    userName = "Wawwior";
    userEmail = "45405580+Wawwior@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      commit.gpgsign = true;
    };

  };
}
