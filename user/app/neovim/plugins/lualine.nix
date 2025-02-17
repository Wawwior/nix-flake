{

    programs.nixvim.plugins.lualine = {
        enable = true;

        settings = {

            options = {

                globalstatus = true;
                component_separators = "";
                section_separators = {
                    left = "";
                    right = "";
                };

            };

        };
    };

}
