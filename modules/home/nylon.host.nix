{ lib, ... }:
let
  excluded = [
    "all.nix"
    "ghostty.nix"
    "mise.nix"
  ];
in
{
  config = {
    theme = "ansi";
  };
  imports =
    with builtins;
    with lib;
    map (fn: ./${fn}) (
      filter (fn: !(hasSuffix ".host.nix" fn) && !(elem fn excluded)) (attrNames (readDir ./.))
    );
}

