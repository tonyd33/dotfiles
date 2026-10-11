{ pkgs, ... }:
let
  treesitter-tql-grammar = pkgs.tree-sitter.buildGrammar {
    language = "tql";
    version = "0.4.rc2";
    location = "packages/tree-sitter-tql";
    src = pkgs.fetchFromGitHub {
      owner = "tonyd33";
      repo = "tql";
      rev = "386ef2fd1b72d01126da69240965b55e07cb1131";
      hash = "sha256-D2lVqotq1+Em3PADk81Cjjve1WDuOgJh3spsWl/COds=";
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
