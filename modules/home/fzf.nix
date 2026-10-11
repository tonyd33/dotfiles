{ flake, config, ... }:
let
  inherit (config) theme;
in
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

  }
  // (
    if theme == "catppuccin" then
      {
        # Catppuccin colors
        colors = {
          "bg+" = "#363a4f";
          "bg" = "#24273a";
          "spinner" = "#f4dbd6";
          "hl" = "#ed8796";
          "fg" = "#cad3f5";
          "header" = "#ed8796";
          "info" = "#c6a0f6";
          "pointer" = "#f4dbd6";
          "marker" = "#b7bdf8";
          "fg+" = "#cad3f5";
          "prompt" = "#c6a0f6";
          "hl+" = "#ed8796";
          "selected-bg" = "#494d64";
          "border" = "#363a4f";
          "label" = "#cad3f5";
        };
      }
    else if theme == "ansi" then
      { }
    else
      { }
  );
}
