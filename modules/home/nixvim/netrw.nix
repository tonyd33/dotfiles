{ config, ... }:
let
  oilKeybinds =
    if config.plugins.oil.enable then
      [
        {
          key = "<leader>to";
          action = ":Oil<cr>";
          mode = [ "n" ];
          options.desc = "Toggle oil (oil)";
          options.unique = true;
        }
      ]
    else
      [ ];
  nvimTreeKeybinds =
    if config.plugins.nvim-tree.enable then
      [
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
      ]
    else
      [ ];
in
{
  plugins.oil = {
    enable = true;
  };
  plugins.neo-tree = {
    enable = true;
  };

  plugins.nvim-tree = {
    enable = false;
    autoClose = true;
  };

  keymaps = nvimTreeKeybinds ++ oilKeybinds;
}
