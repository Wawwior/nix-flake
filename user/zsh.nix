{

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      os = "nh os";
      fetch = "hyfetch";
    };

  };

  programs.oh-my-posh = {
    enable = true;
    useTheme = "catppuccin_mocha";
    settings = { };
  };
}
