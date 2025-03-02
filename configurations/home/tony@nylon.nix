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
    nix-index
    nixvim
    packages
    tmux
    yazi
    zsh
  ]
  ++
  [
    (self + /configurations/home/${me.username}.nix)
  ];
}

