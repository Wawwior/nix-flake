{ config, lib, ... }: {

    programs.nixvim = { 

        globals = {
            mapleader = " ";
            maplocalleader = " ";
        };

        keymaps = let 
            normal = lib.mapAttrsToList
                (key: action: {
                    mode = "n";
                    inherit action key;
                }) {
                    "<Space>" = "<NOP>";

                    "<C-h>" = "<C-w><C-h>";
                    "<C-j>" = "<C-w><C-j>";
                    "<C-k>" = "<C-w><C-k>";
                    "<C-l>" = "<C-w><C-l>";

                    "<leader>tt" = ":NvimTreeToggle<CR>";

                    "<C-X>" = ":BufferClose<CR>";
                    "<C-S-X>" = ":BufferClose!<CR>";

                    "<leader>sf" = { __raw = "require('telescope.builtin').find_files"; };
                    "<leader>sg" = { __raw = "require('telescope.builtin').live_grep"; };
                    "<C-B>" = { __raw = "require('telescope.builtin').buffers"; };
                    "<leader>sh" = { __raw = "require('telescope.builtin').help_tags"; };
                    "<leader>/" = { __raw = "require('telescope.builtin').current_buffer_fuzzy_find"; };
                };
            visual = lib.mapAttrsToList
                (key: action: {
                    mode = "v";
                    inherit action key;
                }) {

                };
            in config.lib.nixvim.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual);

    };
}
