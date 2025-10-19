{
  plugins.fzf-lua = {
    enable = true;
    settings = {
      keymap.builtin = {
        "<m-p>" = "toggle-preview";
      };
      keymap.fzf = {
        "ctrl-f" = "half-page-down";
        "ctrl-b" = "half-page-up";
        "alt-a" = "toggle-all";
      };
      winopts = {
        height = 0.94;
        width = 0.94;
        backdrop = 80;
      };
      grep = {
        rg_glob = true;
      };
    };
  };

  keymaps = [
    {
      key = "<leader>fp";
      action = ":FzfLua ";
      mode = [ "n" "v" ];
      options.desc = "fzf-lua prompt (fzf-lua)";
    }
    {
      key = "<leader>fa";
      action.__raw = ''
        function()
          require'fzf-lua'.fzf_exec(
            {
              "buffers",
              "files",
              "oldfiles",
              "quickfix",
              "quickfix_stack",
              "loclist",
              "loclist_stack",
              "lines",
              "blines",
              "treesitter",
              "tabs",
              "args",
              "grep",
              "grep_last",
              "grep_cword",
              "grep_cWORD",
              "grep_project",
              "grep_curbuf",
              "grep_quickfix",
              "grep_loclist",
              "lgrep_curbuf",
              "lgrep_curbuf",
              "lgrep_quickfix",
              "lgrep_loclist",
              "live_grep",
              "live_grep_resume",
              "live_grep_glob",
              "live_grep_native",
              "tags",
              "btags",
              "tags_grep",
              "tags_grep_cword",
              "tags_grep_cWORD",
              "tags_grep_visual",
              "tags_live_grep",
              "git_files",
              "git_status",
              "git_diff",
              "git_hunks",
              "git_commits",
              "git_bcommits",
              "git_blame",
              "git_branches",
              "git_tags",
              "git_stash",
              "lsp_references",
              "lsp_definitions",
              "lsp_declarations",
              "lsp_typedefs",
              "lsp_implementations",
              "lsp_document_symbols",
              "lsp_workspace_symbols",
              "lsp_live_workspace_symbols",
              "lsp_incoming_calls",
              "lsp_outgoing_calls",
              "lsp_code_actions",
              "lsp_finder",
              "diagnostics_document",
              "diagnostics_workspace",
              "lsp_document_diagnostics",
              "lsp_workspace_diagnostics",
              "resume",
              "builtin",
              "combine",
              "global",
              "profiles",
              "helptags",
              "manpages",
              "colorschemes",
              "awesome_colorschemes",
              "highlights",
              "commands",
              "command_history",
              "search_history",
              "marks",
              "jumps",
              "changes",
              "registers",
              "tagstack",
              "autocmds",
              "nvim_options",
              "keymaps",
              "filetypes",
              "menus",
              "spellcheck",
              "spell_suggest",
              "packadd"
            },
            {
              actions = {
                ["default"] = function(selected, opts)
                  vim.cmd("FzfLua " .. selected[1])
                end
              }
            }
          )
        end
      '';
      mode = [ "n" ];
      options.desc = "fzf-lua all (fzf-lua)";
    }
    {
      key = "<leader>ff";
      action = ":FzfLua files<cr>";
      mode = [ "n" ];
      options.desc = "Find files (fzf-lua)";
    }
    {
      key = "<leader>fg";
      action = ":FzfLua live_grep<cr>";
      mode = [ "n" ];
      options.desc = "Find string (fzf-lua)";
    }
    {
      key = "<leader>fg";
      action = ":FzfLua grep_visual<cr>";
      mode = [ "v" ];
      options.desc = "Find string (fzf-lua)";
    }
  ];
}
