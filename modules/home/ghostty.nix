{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-size = 12;
      font-family = [ "Comic Code Ligatures" "Comic Mono" ];
      theme = "catppuccin-frappe";
      window-decoration = false;
    };
  };
}
