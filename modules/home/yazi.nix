{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    enableZshIntegration = true;
  };
}
