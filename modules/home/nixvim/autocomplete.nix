let
  coq-enabled = false;
  blink-enabled = true;
in
{
  plugins.coq-nvim = {
    enable = coq-enabled;
    autoLoad = true;
    installArtifacts = true;
    settings = {
      completion.always = false;
      completion.sticky_manual = false;
    };
  };
  plugins.blink-cmp = {
    enable = true;
    autoLoad = true;
    setupLspCapabilities = true;
    settings = {
      completion = {
        menu = {
          auto_show = false;
        };
      };
      keymap = {
        "<CR>" = ["accept" "fallback"];
      };
    };
  };

  keymaps =
    if coq-enabled then
      [
        {
          key = "<leader><leader>cn";
          action = ":COQnow --shut-up<cr>";
          mode = [ "n" ];
          options.desc = "Start COQ (coq-nvim)";
        }
      ]
    else
      [ ];
}
