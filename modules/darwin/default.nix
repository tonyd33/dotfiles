# This is your nix-darwin configuration.
# For home configuration, see /modules/home/*
{
  flake,
  pkgs,
  lib,
  ...
}:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  # Use TouchID for `sudo` authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # These users can add Nix caches.
  nix.settings.trusted-users = [
    "root"
    me.username
  ];

  # Configure macOS system
  # More nylons => https://github.com/ryan4yin/nix-darwin-kickstarter/blob/main/rich-demo/modules/system.nix
  system = {
    defaults = {
      dock = {
        autohide = true;
        # customize Hot Corners
        wvous-tl-corner = 2; # top-left - Mission Control
        # wvous-tr-corner = 13; # top-right - Lock Screen
        wvous-bl-corner = 3; # bottom-left - Application Windows
        wvous-br-corner = 4; # bottom-right - Desktop
      };

      finder = {
        _FXShowPosixPathInTitle = true; # show full path in finder title
        AppleShowAllExtensions = true; # show all file extensions
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
      };

      NSGlobalDomain = {
        InitialKeyRepeat = 15;
        KeyRepeat = 1;
        "com.apple.mouse.tapBehavior" = 1;
      };

      trackpad = {
        FirstClickThreshold = 0;
        SecondClickThreshold = 0;
        Clicking = true;
      };
    };

    keyboard = {
      # enableKeyMapping = true;
      # remapCapsLockToControl = true;
    };
  };

  power.sleep = {
    # in minutes
    display = 10;
    computer = 60;
  };

  # Bare essentials
  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  fonts = {
    packages = with pkgs; [
      pkgs.noto-fonts-color-emoji
      pkgs.font-awesome
      pkgs.comic-mono
    ];
  };
}
