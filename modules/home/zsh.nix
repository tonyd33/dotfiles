{
  flake,
  inputs,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
  system = pkgs.system;
  isDarwin = builtins.match ".*-darwin" system != null;
  isLinux = builtins.match ".*-linux" system != null;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    profileExtra =
      ''''
      + (
        if isDarwin then
          ''
            alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
            PATH="$PATH:/opt/homebrew/bin"
          ''
        else
          ''
            PATH="$PATH:$HOME/.local/bin"
          ''
      );

    initContent = ''
      PROMPT='%F{blue}%2~%f %F{green}$%f '

      autoload -Uz compinit
      compinit -C

      # emacs keybinds
      WORDCHARS='*?[]~=&;!#$%^(){}<>'
      bindkey -e
      backward-kill-dir() {
        local WORDCHARS='*?[]~=&;!#$%^(){}<>'
        zle backward-kill-word
      }
      zle -N backward-kill-dir
      bindkey '^W' backward-kill-dir

      # Make kubecolor share same completion logic as kubectl
      compdef kubecolor=kubectl
      alias ls="ls --color=auto"
      enable-fzf-tab
    '';

    plugins = [
      {
        name = "zsh-fzf-tab";
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
        src = pkgs.zsh-fzf-tab;
      }
      # Automatically activate zsh in temporary shells
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";

        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
  };
}
