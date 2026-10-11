{
  # Garbage collect the Nix store
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
    # Change how often the garbage collector runs (default: weekly)
    # frequency = "monthly";
  };
}
