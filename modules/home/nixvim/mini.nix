{
  plugins.mini = {
    enable = true;

    modules = {
      # basics.enable     = true; # this messes up things with autopairs
      # ai.enable = true;
      align.enable = true;
      # pairs.enable = true;
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
    };
  };
}
