{ lib, flake, ... }:
let
  inherit (flake.config) me;
  excluded = [
    "all.nix"
    "ghostty.nix"
    "mise.nix"
  ];
in
{
  imports =
    with builtins;
    with lib;
    map (fn: ./${fn}) (
      filter (fn: !(hasSuffix ".host.nix" fn) && !(elem fn excluded)) (attrNames (readDir ./.))
    );
}

