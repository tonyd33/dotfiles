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
    themeFile = "Catppuccin-Frappe";
  };
}
