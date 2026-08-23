{
  flake,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  inherit (flake) inputs;
  system = pkgs.system;
  isDarwin = builtins.match ".*-darwin" system != null;
  isLinux = builtins.match ".*-linux" system != null;
in
{
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages =
    with pkgs;
    [

      # Nix dev
      nil # Nix language server
      nix-info
      nixfmt
      devenv

      # util
      bash
      watch
      less
      jq
      yq
      ripgrep
      fd
      tree
      ncdu
      btop
      entr
      unzip

      # applications
      mpv
      ncmpcpp
      restish
      localsend
      irssi
      # bitwarden-cli

      # others
      python3
      typst

      just
      go-task

      # kubectl
      kubernetes-helm
      # k9s
      minikube
      kubectx
      gh
      tmux-xpanes

      opencode
    ]
    ++ (
      if isLinux then
        [
          # imv
          lazysql
          obs-studio
          tofi
          # on macOS, tailscale will be installed through app store
          tailscale
          # darkman
          gimp
        ]
      else
        [ ]
    )
    ++ (
      if isDarwin then
        [

        ]
      else
        [ ]
    );
}
