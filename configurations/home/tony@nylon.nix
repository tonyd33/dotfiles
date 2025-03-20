{ flake, pkgs, lib, config, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  imports = with self.homeModules; [
    bat
    direnv
    gc
    git
    kitty
    k8s
    nixvim
    packages
    tmux
    yazi
    zoxide
    zsh
    fzf
  ]
  ++
  [
    (self + /configurations/home/${me.username}.nix)
  ];
}

