let
  editor = "oil"; # | nvim-tree
in
{
  plugins.oil = {
    enable = editor == "oil";
  };

  plugins.nvim-tree = {
    enable = editor == "nvim-tree";
    autoClose = true;
  };

  keymaps = if editor == "nvim-tree" then [
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
  ] else if editor == "oil" then [
    {
      key = "<leader>tt";
      action = ":Oil<cr>";
      mode = [ "n" ];
      options.desc = "Toggle oil (oil)";
      options.unique = true;
    }
  ] else [
  ];
}
