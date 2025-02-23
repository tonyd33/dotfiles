{  config, pkgs, ... }:

let
    nixvim = import (builtins.fetchGit {
        url = "https://github.com/nix-community/nixvim";
        # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
        # ref = "nixos-24.11";
    });
in
{
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "tony";
    home.homeDirectory = "/home/tony";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "24.11";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.packages = [
        pkgs.htop
        pkgs.yazi
        pkgs.jq
        pkgs.yq
        pkgs.fzf
        pkgs.fd
        pkgs.ncdu
        pkgs.ripgrep
        pkgs.imv
        pkgs.mpv
        pkgs.ncmpcpp
        pkgs.restish
        pkgs.obs-studio
        pkgs.tofi
    ];

    imports = [
        nixvim.homeManagerModules.nixvim
        ./config/sway/default.nix
        ./config/nixvim/default.nix
        ./config/tmux/default.nix
        ./config/zsh/default.nix
        ./config/git/default.nix
        ./config/bat/default.nix
    ];

}
