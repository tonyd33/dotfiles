{
  plugins.lsp = {
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
        installGhc = true;
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
      # denols = {
      #   enable = true;
      #   package = null;
      # };
      zls = {
        enable = true;
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
}
