{ pkgs, flake, config, ... }:
let
  inherit (config) theme;
in
{
  programs.bat = {
    enable = true;
  }
  // (
    if theme == "catppuccin" then
      {
        themes = {
          catppuccin = {
            src = pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "bat";
              rev = "699f60fc8ec434574ca7451b444b880430319941";
              sha256 = "sha256-6fWoCH90IGumAMc4buLRWL0N61op+AuMNN9CAR9/OdI=";
            };
            file = "themes/Catppuccin Frappe.tmTheme";
          };
        };
        config = {
          theme = "catppuccin";
        };
      }
    else if theme == "ansi" then
      { }
    else
      { }
  );
}
