{
  flake,
  pkgs,
  config,
  ...
}:
let
  inherit (flake) inputs;
  inherit (config) theme;
in
{
  imports = [ inputs.nixvim.homeModules.nixvim ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    opts = {
      syntax = "on";
      compatible = false;

      wrap = false;
      foldlevel = 99;
      cursorline = true;
      ignorecase = true;
      colorcolumn = "+1";

      number = true;
      relativenumber = true;

      list = true;
      listchars = "tab:>~,nbsp:_,trail:.";
      fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:";

      shiftwidth = 2;
      tabstop = 4;
      softtabstop = 0;
      # smartindent  = true; # this messes things up with autopairs
      expandtab = true;

      # this will get overridden by lsp
      # TODO: How to fix?
      # formatexpr = "v:lua.require'conform'.formatexpr()";
    };

    clipboard.register = "unnamedplus";
    diagnostic.settings.virtual_text = false;
    diagnostic.settings.underline = false;
    diagnostic.settings.signs = false;

    filetype = {
      extension = {
        purs = "purescript";
      };
      pattern = {
        ".*/templates/.*%.yaml" = "helm";
        ".*/templates/.*%.tpl" = "helm";
      };
    };

    imports = [
      ./lint.nix
      ./lsp.nix
      ./mini.nix
      ./treesitter.nix
      ./autocomplete.nix
      ./git.nix
      ./conform.nix
      ./fzf-lua.nix
      ./neorg.nix
      ./nvim-tree.nix
    ];

    plugins = {
      # Bloat
      # neotest.enable       = true; # Easier test running
      # fidget.enable        = true; # LSP Progress message

      sandwich.enable = true; # surround motions
      neoconf.enable = true; # project-local configuration
      oil.enable = true; # filesystem editing
      twilight.enable = true; # focus on current code
      which-key.enable = true; # too many keybinds sometimes
      web-devicons.enable = true; # soy icons
      diffview.enable = true; # better diff
      lualine.enable = true; # status line
      nvim-ufo.enable = true; # better fold
      refactoring.enable = true; # refactoring
      vimwiki.enable = true;
    };

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "easymotion";
        src = pkgs.fetchFromGitHub {
          owner = "easymotion";
          repo = "vim-easymotion";
          rev = "b3cfab2a6302b3b39f53d9fd2cd997e1127d7878";
          hash = "sha256-4Xc7QHlS2zdVHksIMPZUkJcd8Urq3NK0AmKUHMFUYMA=";
        };
      })
    ];

    extraConfigVim = ''
      runtime macros/sandwich/keymap/surround.vim
    '';

    keymaps = [
      # easymotion
      {
        key = "s";
        action = "<plug>(easymotion-prefix)s";
        mode = [ "n" ];
        options.desc = "Search by character (easymotion)";
        options.unique = true;
      }

      # plugin-agnostic
      {
        key = "gp";
        action = "`[v`]";
        mode = [ "n" ];
        options.desc = "Select pasted range";
      }
      # Hack to write as superuser
      {
        key = "w!!";
        action = "w !sudo tee > /dev/null %";
        mode = [ "c" ];
      }
      # esc in terminal mode
      {
        key = "<esc>";
        action = "<C-\\><C-n>";
        mode = [ "t" ];
      }
      {
        key = "<esc>";
        action = ":noh<cr>";
        mode = [ "n" ];
        options.desc = "Turn off highlight search";
        options.unique = true;
      }
    ];
  }
  // (
    if theme == "catppuccin" then
      {
        colorschemes.catppuccin = {
          enable = true;
          settings.flavour = "frappe";
          settings.styles = {
            comments = ["italic"];
            keywords = ["italic"];
          };
          settings.integrations = {
            cmp = true;
            gitsigns = true;
            nvimtree = true;
            treesitter = true;
            notify = false;
            mini = {
              enabled = true;
              indentscope_color = "";
            };
          };
        };
      }
    else if theme == "ansi" then
      {
        colorscheme = "industry";
      }
    else
      { }
  );

}
