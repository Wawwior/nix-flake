{
  description = "system configuration";

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs =
    inputs@{ self, ... }:
    let

      systemSettings = {
        system = "x86_64-linux";
        unstable = true;
        hostName = "vex-laptop";
        profile = "default";
        timeZone = "Europe/Berlin";
        locale = "en_US.utf-8";
        extraLocale = "de_DE.utf-8";
        layout = "de";
        bootMode = "systemd";
        bootMountPath = "/boot";
        grubDevice = "nodev";
        graphics = {
          type = "nvidia";
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:2:0:0";
        };
        display = "hyprland";
      };

      userSettings = {
        userName = "wawwior";
        name = "Wawwior";
        browser = "zen";
        term = "kitty";
        editor = "hx";
        passHash = "$6$/IfaUKyDgQ9EW21b$U9gQD3xBh/w2.E8FisR8.kYKejtrSWnKhfn9FmV0r.ZMca.zElCLV3kCgQwmpzgW0VfcQmIrD.9AyCFQeupSf/";
      };

      pkgs-stable = import inputs.nixpkgs-stable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      pkgs-unstable = import inputs.nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
        overlays = [ inputs.rust-overlay.overlays.default ];
      };

      pkgs = (if systemSettings.unstable then pkgs-unstable else pkgs-stable);

      lib = (if systemSettings.unstable then inputs.nixpkgs.lib else inputs.nixpkgs-stable.lib);

      home-manager = (
        if systemSettings.unstable then inputs.home-manager-unstable else inputs.home-manager-stable
      );

      lix = inputs.lix-module-unstable;

      sops = inputs.sops-nix;

    in
    {
      nixosConfigurations = rec {
        system = lib.nixosSystem {
          inherit pkgs;
          system = systemSettings.system;
          modules = [
            (./. + "/profiles/${systemSettings.profile}/configuration.nix")
            lix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit pkgs-stable;
                inherit systemSettings;
                inherit userSettings;
                inherit inputs;
              };
              home-manager.users."${userSettings.userName}" = {
                imports = [ (./. + "/profiles/${systemSettings.profile}/home.nix") ];
              };
            }
          ];
          specialArgs = {
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
        };

        vex-laptop = system;
      };
    };

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    rust-overlay.url = "github:oxalica/rust-overlay";

    lix-module-unstable = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixd.url = "github:nix-community/nixd";

    sops-nix.url = "github:Mic92/sops-nix";

  };
}
