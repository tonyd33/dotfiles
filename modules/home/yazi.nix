{ pkgs, flake, config, ... }:
let
  inherit (config) theme;
  yaziFlavors = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "flavors";
    rev = "c0234604789f17953b356f9d36879349e793f2ed";
    sha256 = "sha256-xYEVdDv0AzPYGwANiP1V5JEKg6k1JXEBeH5tHbPPFl4=";
  };
in
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    enableBashIntegration = true;
    enableZshIntegration = true;
    flavors = (
      if theme == "catppuccin" then
        {
          catppuccin-frappe = "${yaziFlavors}/catppuccin-frappe.yazi";
        }
      else if theme == "ansi" then
        { }
      else
        { }
    );
  };
}
