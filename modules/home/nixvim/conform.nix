{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      async = true;
      # Map of filetype to formatters
      formatters_by_ft = {
        sql = [ "sqruff" ];
        javascriptreact = [
          "biome"
          "biome-check"
          "biome-organize-imports"
          "eslint_d"
        ];
        javascript = [
          "biome"
          "biome-check"
          "biome-organize-imports"
          "eslint_d"
        ];
        typescriptreact = [
          "biome"
          "biome-check"
          "biome-organize-imports"
          # "eslint_d"
        ];
        typescript = [
          "biome"
          "biome-check"
          "biome-organize-imports"
          # "eslint_d"
        ];
        haskell = [ "stylish-haskell" ];
        nix = [ "nixpkgs_fmt" ];
        bash = [ "shellcheck" ];
      };
      default_format_opts = {
        lsp_format = "fallback";
      };
    };
  };

  keymaps = [
    {
      key = "<leader>p";
      action = ":lua require('conform').format({bufnr=0, async=true})<cr>";
      mode = [ "n" ];
      options.desc = "Format buffer (conform)";
    }
  ];
}
