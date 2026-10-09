{ pkgs, ... }:
let
  treesitter-tql-grammar = pkgs.tree-sitter.buildGrammar {
    language = "tql";
    version = "0.4.rc1";
    location = "packages/tree-sitter-tql";
    src = pkgs.fetchFromGitHub {
      owner = "tonyd33";
      repo = "tql";
      rev = "b803c4f3263bcf3c74b3023d42fb32c7a583ae64";
      hash = "sha256-EZX3Sfi129oW1KbN+0+BGVbQXthr/SaslavIWYS6iDw=";
    };
    meta.homepage = "https://github.com/tonyd33/tql";
  };
in
{
  plugins.treesitter = {
    enable = true;
    folding.enable = true;
    settings.auto_install = true;
    settings.highlight.enable = true;
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars ++ [
      treesitter-tql-grammar
    ];
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
    enable = false;
    settings = {
      multiline_threshold = 1;
      max_lines = 3;
    };
  };
}
