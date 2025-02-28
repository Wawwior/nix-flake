{ ... }:
{

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        mouse = false;
        bufferline = "multiple";
        line-number = "relative";
        clipboard-provider = "wayland";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      keys = {
        normal = {
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
        };
      };
    };
  };
}
