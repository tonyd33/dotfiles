{
  plugins = {
    fugitive.enable = true;
    rhubarb.enable = true;

    gitlinker.enable = true;

    # trying these
    neogit.enable = true;
    octo = {
      enable = true;
      settings.picker = "fzf-lua";
    };
  };
  keymaps = [
    {
      key = "<leader><leader>gl";
      action = "<cmd>lua require'gitlinker'.get_buf_range_url('n')<cr>";
      mode = [ "n" ];
      options.desc = "Get git link (gitlinker)";
    }
    {
      key = "<leader><leader>gl";
      action = "<cmd>lua require'gitlinker'.get_buf_range_url('v')<cr>";
      mode = [ "v" ];
      options.desc = "Get git link (gitlinker)";
    }

  ];
}
