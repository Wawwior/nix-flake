{ inputs, pkgs, ... }: {
    
    imports = [
        inputs.stylix.nixosModules.stylix
    ];

    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

}
