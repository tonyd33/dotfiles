{ flake, inputs, pkgs, ... }:
let
  inherit (flake) inputs;
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
    htop
    yq
    fzf
    ripgrep
    fd
    tree
    gnumake
    ncdu

    # applications
    imv
    mpv
    ncmpcpp
    restish
    obs-studio
    tofi
    ghostty
  ];
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    jq.enable = true;
    # Install btop https://github.com/aristocratos/btop
    btop.enable = true;
    # Tmate terminal sharing.
    tmate = {
      enable = true;
      #host = ""; #In case you wish to use a server other than tmate.io
    };
  };
}
