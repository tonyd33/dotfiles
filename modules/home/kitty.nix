{
  pkgs,
  flake,
  config,
  ...
}:
let
  inherit (config) theme;
  kitty-themes = pkgs.fetchFromGitHub {
    owner = "kovidgoyal";
    repo = "kitty-themes";
    rev = "4b5bc83496a18b5bbc272d2c32c3f30d8e44937e";
    sha256 = "sha256-lXFDRnK1I8KvlOdnIwvi9Ew2pBzO+mD3HGTvgrJfF14=";
  };
in
{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    font = {
      name = "Comic Code Ligatures";
      size = 16;
    };
    settings = {
      macos_option_as_alt = "left";
    }
    // (
      if theme == "catppuccin" then
        { }
      else if theme == "ansi" then
        {
          theme = "${kitty-themes}/themes/ANSI-87.conf";
        }
      else
        { }
    );
  }
  // (
    if theme == "catppuccin" then
      {
        themeFile = "Catppuccin-Frappe";
      }
    else if theme == "ansi" then
      { }
    else
      { }
  );
}
