{
  pkgs,
  systemSettings,
  userSettings,
  ...
}:
{

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        mouse = false;
        bufferline = "multiple";
        line-number = "relative";
        clipboard-provider = "wayland";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      keys = {
        normal = {
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
        };
      };
    };
    languages = {
      language-server = {
        nixd = {
          command = "nixd";
          config.nixd = {
            nixpgs = {
              expr = "import <nixpkgs> { }";
            };

            options = {
              nixos = {
                expr = "(builtins.getFlake \"/home/${userSettings.userName}/.nixos\").nixosConfigurations.${systemSettings.hostName}.options";
              };
            };
          };
        };
        jdtls = {
          command = "jdtls";
          args = [
            "-data"
            "/home/${userSettings.userName}/.cache/jdtls/workspace"
          ];
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          language-servers = [ "nixd" ];
        }
        {
          name = "java";
          scope = "source.java";
          roots = [
            "pom.xml"
            "build.gradle"
          ];
          language-servers = [ "jdtls" ];
        }
        {
          name = "css";
          scope = "source.css";
          injection-regex = "css";
          file-types = [ "css" ];
        }
      ];
    };
  };
}
