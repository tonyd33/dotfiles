{
  programs.fzf = {
    enable = true;
    # It's not that great
    tmux.enableShellIntegration = false;
    enableZshIntegration = true;
    defaultOptions = [
      "--walker-skip .git,node_modules,target,.direnv"
      # TODO: Make this check if the entry is even a directory
      # "--preview 'test -f {} && bat -n --color=always {} || tree -C {}'"
    ];

    # Catppuccin colors
    colors = {
      "bg+"         = "#414559";
      "bg"          = "#303446";
      "spinner"     = "#f2d5cf";
      "hl"          = "#e78284";
      "fg"          = "#c6d0f5";
      "header"      = "#e78284";
      "info"        = "#ca9ee6";
      "pointer"     = "#f2d5cf";
      "marker"      = "#babbf1";
      "fg+"         = "#c6d0f5";
      "prompt"      = "#ca9ee6";
      "hl+"         = "#e78284";
      "selected-bg" = "#51576d";
      "border"      = "#414559";
      "label"       = "#c6d0f5";
    };
  };
}
