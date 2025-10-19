{
  plugins.coq-nvim = {
    enable = true;
    autoLoad = true;
    installArtifacts = true;
    settings = {
      completion.always = false;
      completion.sticky_manual = false;
    };
  };
  keymaps = [
    {
      key = "<leader><leader>cn";
      action = ":COQnow --shut-up<cr>";
      mode = [ "n" ];
      options.desc = "Start COQ (coq-nvim)";
    }
  ];
}
