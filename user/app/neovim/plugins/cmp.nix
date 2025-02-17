{
    programs.nixvim.plugins.cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {

            mapping = {
                "<S-CR>" = "cmp.mapping.confirm { 
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }";

                "<Tab>" = "cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' })";

                "<S-Tab>" = "cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' })";
            };

            sources = [
                { name = "nvim_lsp"; }
                { name = "path"; }
                { name = "buffer"; }
                { name = "nixpkgs_maintainers"; }
            ];
        };
    };
}
