{
  plugins.nvim-tree = {
    enable = false;
    autoClose = true;
  };
  keymaps = [
    # nvim tree
    {
      key = "<leader>tt";
      action = ":NvimTreeToggle<cr>";
      mode = [ "n" ];
      options.desc = "Toggle tree sitter (nvim-tree)";
      options.unique = true;
    }
    {
      key = "<leader>tr";
      action = ":NvimTreeFindFile<cr>";
      mode = [ "n" ];
      options.desc = "Open tree sitter at current file (nvim-tree)";
      options.unique = true;
    }
  ];
}
