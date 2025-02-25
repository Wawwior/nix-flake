{
  description = "system configuration";

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let

      inherit (self) outputs;
      inherit (nixpkgs) lib;

      lix = inputs.lix-module;

      mkHost =
        host: isDarwin:
        let
          mkSys = if isDarwin then inputs.nix-darwin.lib.darwinSystem else lib.nixosSystem;
        in
        {
          ${host} = mkSys {
            specialArgs = {
              inherit inputs outputs;
            };
            modules = [
              ./hosts/${if isDarwin then "darwin" else "nixos"}/${host}
              lix.nixosModules.default
            ];

            lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
          };
        };

      mkHostConfigs =
        hosts: isDarwin: lib.foldl (acc: set: acc // set) { } (lib.map (host: mkHost host isDarwin) hosts);

      readHosts = folder: lib.attrNames (builtins.readDir ./hosts/${folder});

    in
    {
      nixosConfigurations = mkHostConfigs (readHosts "nixos") false;
    };

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
