{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      pkgs.noto-fonts-emoji
      pkgs.font-awesome
      pkgs.comic-mono
    ];
  };
}
