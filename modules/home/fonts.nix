{ pkgs, ... }:
{
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "noto-fonts-emoji" ];
        monospace = [ "Comic Mono" ];
      };
    };
  };
}
