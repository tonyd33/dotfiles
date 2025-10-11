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

      shiftwidth = 2;
      tabstop = 4;
      softtabstop = 0;
      # smartindent  = true; # this messes things up with autopairs
      expandtab = true;

      # this will get overridden by lsp
      # TODO: How to fix?
      # formatexpr = "v:lua.require'conform'.formatexpr()";
    };

    diagnostic.settings = {
      virtual_text = false;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "frappe";
    };

    filetype = {
      extension = {
        purs = "purescript";
      };
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
      # fidget.enable        = true; # LSP Progress message

      sandwich.enable = true; # surround motions
      fugitive.enable = true; # git
      rhubarb.enable = true; # fugitive github plugin
      neoconf.enable = true; # Local configuration
      oil.enable = true; # filesystem editing
      twilight.enable = true; # focus on current code
      which-key.enable = true; # too many keybinds sometimes
      web-devicons.enable = true; # soy icons
      neoclip.enable = true; # register management
      nvim-tree.enable = true; # file tree browser
      glance.enable = true; # navigation by reference
      todo-comments.enable = true; # todo comments
      trouble.enable = true; # diagnostics

      neorg = {
        enable = true;
        telescopeIntegration.enable = true;
        settings.load = {
          "core.concealer" = {
            config = {
              icon_preset = "varied";
            };
          };
          "core.defaults" = {
            __empty = null;
          };
          "core.dirman" = {
            config = {
              workspaces = {
                home = "~/Documents/notes/home";
                work = "~/Documents/notes/work";
              };
            };
          };
        };
      };

      zen-mode = {
        enable = true;
        settings = {
          plugins.twilight.enabled = true;
          plugins.kitty.enabled = true;
        };
      };

      treesitter = {
        enable = true;
        folding = true;
        settings.auto_install = true;
        settings.highlight.enable = true;
      };

      # Powerful structural navigator
      navbuddy = {
        enable = true;
        lsp = {
          autoAttach = true;
          preference = [
            "ts_ls"
            "deno"
          ];
        };
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

      lint = {
        enable = true;
        lintersByFt = {
          clojure = [ "clj-kondo" ];
          dockerfile = [ "hadolint" ];
          inko = [ "inko" ];
          janet = [ "janet" ];
          json = [ "jsonlint" ];
          markdown = [ "vale" ];
          rst = [ "vale" ];
          ruby = [ "ruby" ];
          terraform = [ "tflint" ];
          text = [ "vale" ];
          typescript = [ "eslint" ];
          javascript = [ "eslint" ];
          typescriptreact = [ "eslint" ];
          javascriptreact = [ "eslint" ];
          deno = [
            "deno"
            "eslint"
          ];
          haskell = [ "hlint" ];
          python = [ "flake8" ];
          yaml = [
            "ansible_lint"
            "yamllint"
          ];
        };
        autoCmd = {
          # callback = {
          #   __raw = ''
          #     function()
          #       require('lint').try_lint()
          #     end
          #   '';
          # };
          callback = null;
          command = "silent! lua require('lint').try_lint()";
          desc = "Try to lint buffer";
          event = "BufWritePost";
        };
      };

      conform-nvim = {
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
              "eslint_d"
            ];
            typescript = [
              "biome"
              "biome-check"
              "biome-organize-imports"
              "eslint_d"
            ];
            haskell = [ "stylish-haskell" ];
            nix = [ "nixpkgs_fmt" ];
            bash = [ "shellcheck" ];
          };
          default_format_opts = {
            lsp_format = "never";
          };
        };
      };

      # alternative completion engine
      blink-cmp.enable = false;

      lspkind.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          performance = {
            # These values might be too low, negatively affecting performance.
            debounce = 10;
            throttle = 5;
            max_view_entries = 10;
          };
          # Change this to false for manual trigger, null for auto
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
          enabled = {
            __raw = ''
              function()
                local disabled = false
                disabled = disabled or (vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt')
                disabled = disabled or (vim.fn.reg_recording() ~= ''')
                disabled = disabled or (vim.fn.reg_executing() ~= ''')
                disabled = disabled or require('cmp.config.context').in_treesitter_capture('comment')
                return not disabled
              end
            '';
          };
        };
      };

      lsp = {
        enable = true;
        keymaps = {
          lspBuf = {
            "gd" = "definition";
            "gr" = "references";
            "gi" = "implementation";
            "<leader>gt" = "type_definition";
            "<leader>rn" = "rename";
            "<leader>a" = "code_action";
            # Also see the map with "<leader>p" to use conform
            "<leader>P" = "format";
          };
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
        };
        servers = {
          # standard
          gleam = {
            enable = true;
            package = null;
          };
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
          fsharp_language_server = {
            enable = true;
            package = null;
          };
          ocamllsp = {
            enable = true;
            package = null;
          };
          roc_ls = {
            enable = true;
            package = null;
          };
          unison = {
            enable = true;
            package = null;
          };

          ts_ls.enable = true;
          # biome.enable = true;
          denols = {
            enable = false;
            package = null;
          };

          # weird guys
          html.enable = true;
          # htmx.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          cssls.enable = true;
          docker_compose_language_service.enable = true;
          dockerls.enable = true;
          prismals = {
            enable = true;
            package = null;
            cmd = [
              "npx"
              "prisma-language-server"
              "--stdio"
            ];
          };

          # cloud/automation
          # ansiblels.enable = true;
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
          "<leader>ff" = {
            action = "find_files";
          };
          "<leader>fg" = {
            action = "live_grep";
          };
          "<leader>fG" = {
            action = "grep_string";
          };
          "<leader>fh" = {
            action = "git_files";
          };
          "<leader>fb" = {
            action = "buffers";
          };
          "<leader>fm" = {
            action = "marks";
          };
          "<leader>fj" = {
            action = "jumplist";
          };
          "<leader>fl" = {
            action = "loclist";
          };
          "<leader>fs" = {
            action = "lsp_workspace_symbols";
          };
          "<leader>fn" = {
            action = "neoclip";
          };
        };
        luaConfig = {
          pre = ''
            local telescopeConfig = require('telescope.config')
            local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
            -- I want to search in hidden/dot files.
            table.insert(vimgrep_arguments, "--hidden")
            -- I don't want to search in the `.git` directory.
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")
          '';
        };
        settings = {
          defaults = {
            layout_strategy = "flex";
            layout_config = {
              width = 0.99;
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
              "^.direnv/"
            ];
            mappings = {
              i = {
                "<C-q><C-q>" = {
                  __raw = "require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist";
                };
                "<C-q><C-a>" = {
                  __raw = "require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist";
                };
              };
              n = {
                "<C-q><C-q>" = {
                  __raw = "require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist";
                };
                "<C-q><C-a>" = {
                  __raw = "require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist";
                };
              };
            };

            vimgrep_arguments = {
              __raw = ''
              vimgrep_arguments
              '';
            };

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
        options.desc = "Definitions (Glance)";
        options.unique = true;
      }
      {
        key = "<leader>gR";
        action = ":Glance references<cr>";
        mode = [ "n" ];
        options.desc = "References (Glance)";
        options.unique = true;
      }
      {
        key = "<leader>gY";
        action = ":Glance type_definitions<cr>";
        mode = [ "n" ];
        options.desc = "Type definitions (Glance)";
        options.unique = true;
      }
      {
        key = "<leader>gM";
        action = ":Glance implementations<cr>";
        mode = [ "n" ];
        options.desc = "Implementations (Glance)";
        options.unique = true;
      }

      # trouble
      {
        key = "<leader>xx";
        action = ":Trouble diagnostics toggle<cr>";
        mode = [ "n" ];
        options.desc = "Diagnostics (Trouble)";
        options.unique = true;
      }
      {
        key = "<leader>xX";
        action = ":Trouble diagnostics toggle filter.buf=0<cr>";
        mode = [ "n" ];
        options.desc = "Buffer Diagnostics (Trouble)";
        options.unique = true;
      }
      {
        key = "<leader>cs";
        action = ":Trouble symbols toggle focus=false<cr>";
        mode = [ "n" ];
        options.desc = "Symbols (Trouble)";
        options.unique = true;
      }
      {
        key = "<leader>cl";
        action = ":Trouble lsp toggle focus=false win.position=right<cr>";
        mode = [ "n" ];
        options.desc = "LSP Definitions / references / ... (Trouble)";
        options.unique = true;
      }
      {
        key = "<leader>xL";
        action = ":Trouble loclist toggle<cr>";
        mode = [ "n" ];
        options.desc = "Location List (Trouble)";
        options.unique = true;
      }
      {
        key = "<leader>xQ";
        action = ":Trouble qflist toggle<cr>";
        mode = [ "n" ];
        options.desc = "Quickfix List (Trouble)";
        options.unique = true;
      }

      # navbuddy
      {
        key = "<leader>es";
        action = ":Navbuddy<cr>";
        mode = [ "n" ];
        options.desc = "Navbuddy";
        options.unique = true;
      }

      # zenmode
      {
        key = "<leader>0";
        action = ":ZenMode<cr>";
        mode = [ "n" ];
        options.desc = "Toggle Zen (zenmode)";
        options.unique = true;
      }

      # easymotion
      {
        key = "S";
        action = "<plug>(easymotion-prefix)s";
        mode = [ "n" ];
        options.desc = "Search by character (easymotion)";
        options.unique = true;
      }

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

      # conform
      {
        key = "<leader>p";
        action = ":lua require('conform').format({bufnr=0, async=true})<cr>";
        mode = [ "n" ];
        options.desc = "Format buffer (conform)";
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
  };
}
