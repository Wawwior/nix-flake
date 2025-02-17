{
    programs.nixvim.plugins.barbar = {
        enable = true;

        settings = {
            clickable = false;
            icons = {
                buffer_index = true;
                button = "";
            };
            sidebar_filetypes = {
                NvimTree = true;
            };
            auto_hide = 1;
            minimum_padding = 1;
            maximum_padding = 200;
        };
    };
}
