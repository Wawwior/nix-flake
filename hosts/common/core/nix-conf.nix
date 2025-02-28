{ inputs, config, ... }:
{

  nix = {
    settings = {
      trusted-users = [ "@wheel" ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    extraOptions =
      # !include ${config.sops.secrets.nix-github-token.path}
      ''
        builders-use-substitutes = true
      '';

    buildMachines = [
      {
        hostName = "192.168.178.35";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        maxJobs = 16;
        speedFactor = 5;
        supportedFeatures = [
          "kvm"
          "benchmark"
          "big-parallel"
          "nixos-test"
        ];
        mandatoryFeatures = [ ];

      }
    ];

    distributedBuilds = true;

    optimise.automatic = true;

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  };
}
