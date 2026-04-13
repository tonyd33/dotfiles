{ lib, ... }:
let
  excluded = [
    "all.nix"
    "kitty.nix"
    "ghostty.nix"
    "xdg.nix"
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
