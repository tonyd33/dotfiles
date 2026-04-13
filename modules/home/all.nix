# A module that automatically imports everything else in the parent folder.
{lib,...}:
{
  imports =
    with builtins;
    map (fn: ./${fn}) (
      filter (fn: fn != "all.nix" && !(hasSuffix ".host.nix")) (attrNames (readDir ./.))
    );
}
