{
    imports = [
        ./lualine.nix
        ./nvim-tree.nix
        ./lsp.nix
        ./cmp.nix
        ./luasnip.nix
        ./barbar.nix
    ];

    programs.nixvim = {
        plugins = {
            lz-n.enable = true;

            nvim-autopairs.enable = true;

            web-devicons.enable = true;
        };
    };
}
