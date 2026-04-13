{
  plugins.treesitter = {
    enable = true;
    folding.enable = true;
    settings.auto_install = true;
    settings.highlight.enable = true;
  };
  plugins.treesitter-textobjects = {
    enable = true;
    settings = {
      select = {
        enable = true;
        keymaps = {
          "if" = "@function.inner";
          "af" = "@function.outer";
          "ic" = "@class.inner";
          "ac" = "@class.outer";
        };
      };
      move = {
        enable = true;
      };
      swap.enable = true;
    };
  };
  plugins.treesitter-context = {
    enable = true;
    settings = {
      multiline_threshold = 1;
      max_lines = 3;
    };
  };
}
