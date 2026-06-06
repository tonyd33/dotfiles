{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      pkgs.noto-fonts-color-emoji
      pkgs.font-awesome
      pkgs.comic-mono
    ];
  };
}
