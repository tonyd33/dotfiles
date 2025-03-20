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
    bash watch less
    jq   yq    ripgrep
    fd   tree  ncdu
    btop

    # applications
    mpv       ncmpcpp
    restish
    localsend gimp bitwarden-cli

    # I'm practicing to purposely not install these system-wide and force
    # myself to install this on a per-project basis so I don't miss
    # dependencies.
    # kubectl podman podman-compose
  ]
  ++
  (if isLinux then [
    imv
    obs-studio
    tofi
    # on macOS, tailscale will be installed through app store
    tailscale
  ] else [ ])
  ++
  (if isDarwin then [

  ] else [ ]);
}
