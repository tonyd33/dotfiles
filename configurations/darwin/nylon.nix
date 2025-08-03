# See /modules/darwin/* for actual settings
# This file is just *top-level* configuration.
{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  imports = [
    self.darwinModules.default
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  networking = {
    hostName = "nylon";
    # FIXME: but this laptop can travel outside lan...
    # dns = [ "10.0.123.123" ];
    knownNetworkServices = [ "Wi-Fi" "Thunderbolt Bridge" ];
  };


  # For home-manager to work.
  # https://github.com/nix-community/home-manager/issues/4026#issuecomment-1565487545
  users.users."${me.username}".home = "/Users/${me.username}";

  documentation = {
    enable = true;
    doc.enable = true;
    man.enable = true;
  };


  home-manager = {
    # Automatically move old dotfiles out of the way
    #
    # Note that home-manager is not very smart, if this backup file already exists it
    # will complain "Existing file .. would be clobbered by backing up". To mitigate this,
    # we try to use as unique a backup file extension as possible.
    backupFileExtension = "nixos-unified-template-backup";

    # Enable home-manager for our user
    users."${me.username}" = {
      imports = [ (self + /configurations/home/${me.username} + "@nylon.nix") ];
    };
  };

  ids.gids.nixbld = 350;

  homebrew = {
    enable = true;
    brews = [
      "helm"
    ];
    casks = [
      "bitwarden"
      "zen-browser"
      "discord"
      "blender"
      "kap"
      "skim"
      "docker"
      "musescore"
      "autodesk-fusion"
    ];
    taps = [ ];
    masApps = {
      tailscale = 1475387142;
      "fluent reader" = 1520907427;
    };
    onActivation.cleanup = "uninstall";
  };

  system.primaryUser = "tony";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
