{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
in
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
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
      # For some reason, this enables virtual text for diagnostics, which I
      # don't like.
      # distant.enable       = true;
      # remote-nvim.enable  = true;

      # These have some finnicky behavior when using lsp move to new file
      # action. Maybe try enabling in the future if I figure out why this
      # happens or it's fixed.
      # barbar.enable        = true;
      # bufferline.enable    = true;

      # Bloat
      # neotest.enable       = true; # Easier test running

      sandwich.enable      = true; # surround motions
      fugitive.enable      = true; # git
      fidget.enable        = true; # LSP Progress message
      flash.enable         = true; # Better f/t/F/T
      neoconf.enable       = true; # Local configuration
      oil.enable           = true; # filesystem editing
      hardtime.enable      = true; # make things harder, why not
      twilight.enable      = true; # focus on current code
      which-key.enable     = true; # too many keybinds sometimes
      web-devicons.enable  = true; # soy icons
      neoclip.enable       = true; # register management
      nvim-tree.enable     = true; # file tree browser
      glance.enable        = true; # navigation by reference
      todo-comments.enable = true; # todo comments

      refactoring = {
        enable = true;
      };

      zen-mode = {
        enable = true;
        settings = {
          plugins.twilight.enabled = true;
          plugins.tmux.enabled = true;
          plugins.todo.enabled = true;
          plugins.kitty.enabled = true;
        };
      };

      treesitter = {
        enable = true;
        folding = true;
      };

      # Powerful structural editor
      navbuddy = {
        enable = true;
        lsp.autoAttach = true;
      };

      # Breadcrumb stuff
      navic = {
        enable = true;
        settings.lsp.auto_attach = true;
      };

      lualine = {
        enable = true;
        settings = {
          winbar = {
            lualine_c = [
              {
                __unkeyed-1 = "navic";
              }
            ];
          };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          # I only want manual trigger
          completion.autocomplete = false;
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
              })
            '';
          };
        };
      };

      lsp = {
        enable = true;
        keymaps = {
          lspBuf = {
            "gd"         = "definition";
            "gr"         = "references";
            "gi"         = "implementation";
            "<leader>gt" = "type_definition";
            "<leader>rn" = "rename";
            "<leader>a"  = "code_action";
            "<leader>p"  = "format";
          };
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
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
          # denols.enable = true;

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

        modules = {
          # basics.enable     = true; # this messes up things with autopairs
          ai.enable = true;
          align.enable = true;
          pairs.enable = true;
          icons.enable = true;

          trailspace.enable = true;

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
          "<leader>fg" = { action = "live_grep"; };
          "<leader>fb" = { action = "buffers"; };
          "<leader>fm" = { action = "marks"; };
          "<leader>fj" = { action = "jumplist"; };
          "<leader>fl" = { action = "loclist"; };
          "<leader>fs" = { action = "lsp_workspace_symbols"; };
          "<leader>fn" = { action = "neoclip"; };
        };
        settings = {
          defaults = {
            layout_strategy = "flex";
            layout_config = {
              width = 0.8;
              height = 0.95;
              anchor = "CENTER";
              horizontal = {
                preview_width = 0.5;
              };
              vertical = {
                prompt_position = "top";
                mirror = true;
                preview_height = 0.5;
                preview_cutoff = 0;
              };
            };
            file_ignore_patterns = [
              "^.git/"
            ];
          };
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
      # glance
      {
        key = "<leader>gD";
        action = ":Glance definitions<cr>";
        mode = [ "n" ];
      }
      {
        key = "<leader>gR";
        action = ":Glance references<cr>";
        mode = [ "n" ];
      }
      {
        key = "<leader>gY";
        action = ":Glance type_definitions<cr>";
        mode = [ "n" ];
      }
      {
        key = "<leader>gM";
        action = ":Glance implementations<cr>";
        mode = [ "n" ];
      }

      # navbuddy
      {
        key = "<leader>es";
        action = ":Navbuddy<cr>";
        mode = [ "n" ];
      }

      # zenmode
      {
        key = "<leader>0";
        action = ":ZenMode<cr>";
        mode = [ "n" ];
      }

      # easymotion
      {
        key = "<leader>s";
        action = "<plug>(easymotion-prefix)s";
        mode = [ "n" ];
      }

      # tree sitter
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

      # plugin-agnostic
      {
        key = "gp";
        action = "`[v`]";
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
