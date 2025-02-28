{ pkgs, hostSpec, ... }:
{
  programs.helix.languages = {
    language-server = {
      nixd = {
        command = "nixd";
        config.nixd = {
          nixpgs = {
            expr = "import <nixpkgs> { }";
          };
          options = {
            nixos = {
              expr = "(builtins.getFlake \"${hostSpec.home}/.nixos\").nixosConfigurations.${hostSpec.hostName}.options";
            };
          };
        };
      };
      jdtls = {
        command = "jdtls";
        args = [
          "-data"
          "${hostSpec.home}/.cache/jdtls/workspace"
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
    ];
  };
}
