{
	description = "system configuration";

    nixConfig = {
        extra-substituters = [
            "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
    };

    outputs = inputs @ { self, ... }:
        let
            
            systemSettings = rec {
                system = "x86_64-linux";
                unstable = true;
                hostName = "vex-laptop";
                profile = "default";
                timeZone = "Europe/Berlin";
                locale = "en_US.utf-8";
                extraLocale = "de_DE.utf-8";
                layout = "de";
                bootMode = "uefi";
                bootMountPath = "/boot";
                grubDevice = "";
                gpuType = "nvidia";
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:2:0:0";
                nvidiaOpen = false;
                wm = "hyprland";
                wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
            };

            userSettings = {
                username = "wawwior";
                name = "Wawwior";
                theme = "catppuccin-mocha";
                browser = "zen-browser";
                defaultRoamDir = "Personal.p";
                term = "rio";
                font = "JetBrains Mono Nerdfont";
                fontPkg = pkgs.nerd-fonts.jetbrains-mono;
                editor = "nvim";
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

            pkgs = (if systemSettings.unstable 
                then
                    pkgs-unstable
                else
                    pkgs-stable);

            lib = (if systemSettings.unstable
                then
                    inputs.nixpkgs.lib
                else
                    inputs.nixpkgs-stable.lib);

            home-manager = (if systemSettings.unstable
                then
                    inputs.home-manager-unstable
                else
                    inputs.home-manager-stable);

            lix = inputs.lix-module;

        in {
            nixosConfigurations = {
                system = lib.nixosSystem {
                    system = systemSettings.system;
                    modules = [
                        (./. + "/profiles/${systemSettings.profile}/configuration.nix")
                        lix.nixosModules.default
                        home-manager.nixosModules.home-manager {
                            home-manager.extraSpecialArgs = { 
                                inherit pkgs-stable; 
                                inherit systemSettings;
                                inherit userSettings;
                                inherit inputs;
                            };
                            home-manager.users."${userSettings.username}" = {
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

        hyprland = {
            url = "github:hyprwm/Hyprland";
            inputs.nixpkgs.follows = "nixpkgs";
        };

		nixvim = {
			url = "github:nix-community/nixvim";
		};

        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix.url = "github:danth/stylix";

        rust-overlay.url = "github:oxalica/rust-overlay";

        lix-module = {
            url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };
}
