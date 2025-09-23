{ config, pkgs, ... }:
{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };
}

