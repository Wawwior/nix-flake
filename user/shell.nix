{ pkgs, ... }:
{

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.fzf = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
    };

    shellAliases = {
      os = "nh os";
      fetch = "hyfetch";
    };

    plugins = [
      {
        name = "sudo";
        src = pkgs.fetchFromGitHub {
          "owner" = "zap-zsh";
          "repo" = "sudo";
          "rev" = "b3e86492d6d48c669902b9fb5699a75894cfcebc";
          "sha256" = "sha256-+yMZO4HRF+dS1xOP/19Fneto8JxdVj5GiX3sXOoRdlM=";
        };
      }
    ];

  };

  programs.oh-my-posh = {
    enable = true;
    useTheme = "catppuccin_mocha";
    settings = { };
  };
}
