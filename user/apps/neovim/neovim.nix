{ inputs, ... }: {

    imports = [
        ./options.nix
        ./keymappings.nix
        ./plugins
        inputs.nixvim.homeManagerModules.nixvim
    ];

    programs.nixvim = {
        enable = true;
        defaultEditor = true;

        performance = {
            combinePlugins = {
                enable = true;
            };
            byteCompileLua.enable = true;
        };

        luaLoader.enable = true;
        plugins.telescope.enable = true;
        plugins.which-key.enable = true;
    };

}
