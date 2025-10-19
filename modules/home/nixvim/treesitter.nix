{
  plugins.treesitter = {
    enable = true;
    folding = true;
    settings.auto_install = true;
    settings.highlight.enable = true;
  };
  plugins.treesitter-textobjects = {
    enable = true;
    move = {
      enable = true;
    };
    select = {
      enable = true;
      keymaps = {
        "if" = "@function.inner";
        "af" = "@function.outer";
        "ic" = "@class.inner";
        "ac" = "@class.outer";
      };
    };
    swap.enable = true;
  };
  plugins.treesitter-context = {
    enable = true;
    settings = {
      multiline_threshold = 1;
      max_lines = 3;
    };
  };
}
