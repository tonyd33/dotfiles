{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
in
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
    globals = {
      mapleader = " ";
    };

    opts = {
      syntax = "on";
      compatible = false;

      wrap = false;
      foldlevel = 2;
      cursorline = true;
      ignorecase = true;
      colorcolumn = "+1";

      number = true;
      relativenumber = true;

      list = true;
      listchars = "tab:>~,nbsp:_,trail:.";

      shiftwidth = 2;
      tabstop = 8;
      softtabstop = 0;
      # smartindent  = true; # this messes things up with autopairs
      expandtab = true;
    };

    diagnostics = {
      virtual_text = false;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "frappe";
    };

    plugins = {
      lualine.enable = true;
      sandwich.enable = true;

      nvim-tree = {
        enable = true;
        autoClose = true;
      };

      treesitter = {
        enable = true;
        folding = true;
      };

      lsp = {
        enable = true;
        keymaps = {
          lspBuf = {
            "gd" = "definition";
            "gr" = "references";
            "gt" = "type_definition";
            "gi" = "implementation";
            "<leader>rn" = "rename";
            "<leader>a" = "code_action";
          };
          diagnostic = {
            "<leader>j" = "goto_prev";
            "<leader>k" = "goto_next";
          };
        };
        servers = {

          # standard
          gleam.enable = true;
          gopls.enable = true;
          hls = {
            enable = true;
            installGhc = false;
          };
          rust_analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
          };
          basedpyright.enable = true;
          bashls.enable = true;
          c3_lsp = {
            enable = true;
            # package         = pkgs.c3-lsp;
            package = null;
          };
          clangd.enable = true;
          purescriptls = {
            enable = true;
            # package         = pkgs.purescript;
            package = null;
          };

          ts_ls.enable = true;
          biome.enable = true;
          denols.enable = true;

          # weird guys
          html.enable = true;
          htmx.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          cssls.enable = true;
          docker_compose_language_service.enable = true;
          dockerls.enable = true;

          # cloud/automation
          ansiblels.enable = true;
          terraformls.enable = true;
          helm_ls.enable = true;
        };
      };

      mini = {
        enable = true;
        mockDevIcons = true; # needed for telescope

        modules = {
          # basics.enable     = true; # this messes up things with autopairs
          ai.enable = true;
          align.enable = true;
          pairs.enable = true;
          icons.enable = true;

          trailspace.enable = true;

          # idk how to use this but it seems useful
          # pick.enable = true;
          # visits.enable = true;

          clue = {
            enable = true;
            triggers = [
              { mode = "n"; keys = "<Leader>"; }
              { mode = "n"; keys = "<C-w>"; }
            ];
            window = {
              delay = 200;
            };
            clues = {
              "__unkeyed-1__builtin_completion" = { __raw = "require('mini.clue').gen_clues.builtin_completion()"; };
              "__unkeyed-2__windows" = { __raw = "require('mini.clue').gen_clues.windows()"; };
              "__unkeyed-3__marks" = { __raw = "require('mini.clue').gen_clues.marks()"; };
              "__unkeyed-4__g" = { __raw = "require('mini.clue').gen_clues.g()"; };
            };
          };

          comment = {
            enable = true;
            mappings = {
              comment = "<leader>cc";
              comment_line = "<leader>cc";
              comment_visual = "<leader>cc";
            };
          };

          indentscope = {
            enable = true;
            draw = {
              delay = 0;
              animation = {
                __raw = ''
                  function(s, n)
                      return 0
                  end
                '';
              };
            };
          };
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = { action = "find_files"; };
          "<leader>fs" = { action = "live_grep"; };
          "<leader>fb" = { action = "buffers"; };
        };
      };
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
      {
        key = "<leader>s";
        action = "<plug>(easymotion-prefix)s";
        mode = [ "n" ];
      }
      {
        key = "<leader>tt";
        action = ":NvimTreeToggle<cr>";
        mode = [ "n" ];
      }
      {
        key = "<leader>tr";
        action = ":NvimTreeFindFile<cr>";
        mode = [ "n" ];
      }
      # Hack to write as superuser
      {
        key = "w!!";
        action = "w !sudo tee > /dev/null %";
        mode = [ "c" ];
      }
    ];
  };
}
