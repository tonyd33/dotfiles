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
    autosuggestion.enable = false;
    syntaxHighlighting.enable = false;

    profileExtra = "";

    initContent = ''
      PROMPT='%F{blue}%2~%f %F{green}$%f '

      autoload -Uz compinit
      compinit -C

      # bash readline keybinds
      WORDCHARS=""
      bindkey -e
      autoload -U select-word-style
      select-word-style bash

      backward-kill-space-word() {
        WORDCHARS='*?[]~=&;!#$%^(){}<>-_./:|'
        zle backward-kill-word
      }
      zle -N backward-kill-space-word
      bindkey '^W' backward-kill-space-word

      # ctrl x ctrl e editor
      autoload -Uz edit-command-line
      zle -N edit-command-line
      bindkey '^X^E' edit-command-line

      # Make kubecolor share same completion logic as kubectl
      compdef kubecolor=kubectl
      alias ls="ls --color=auto"
      enable-fzf-tab

      export MANPAGER="nvim +Man!"
    ''
    + (
      if isDarwin then
        ''
          alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
          alias copy="pbcopy"
          alias paste="pbpaste"
        ''
      else
        ''
          alias copy="wl-copy"
          alias paste="wl-paste"
          PATH="$PATH:$HOME/.local/bin"
        ''
    );

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
