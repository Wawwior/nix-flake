{

    programs.nixvim = {
        globals = {
            loaded_ruby_provider = 0;
            loaded_pearl_provider = 0;
            loaded_python_provider = 0;
        };

        clipboard = {
            register = "unnamedplus";

            providers.wl-copy.enable = true;
        };

        opts = {

            updatetime = 100;

            number = true;
            showmode = false;
            mouse = "";
            swapfile = false;
            undofile = true;
            ignorecase = true;
            smartcase = true;
            list = true;

            cursorline = false;
            tabstop = 4;
            shiftwidth = 4;
            expandtab = true;
            autoindent = true;

            scrolloff = 8;
            signcolumn = "yes";
        };
    };

}
