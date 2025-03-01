{ flake, inputs, pkgs, ... }:
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
  home.packages = with pkgs; [

    # Nix dev
    nil # Nix language server
    nix-info
    nixpkgs-fmt

    # util
    less
    jq
    yq
    btop
    fzf
    ripgrep
    fd
    tree
    gnumake
    ncdu
    bash

    # applications
    mpv
    ncmpcpp
    restish
    bitwarden-cli
  ]
  ++
  (if isLinux then [
    imv
    obs-studio
    tofi
  ] else [])
  ++
  (if isDarwin then [

  ] else []);
}
