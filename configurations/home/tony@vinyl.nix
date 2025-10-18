{
  flake,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  imports = [
    (self + /configurations/home/${config.me.username}.nix)
    self.homeModules."vinyl.host"
  ];
}
