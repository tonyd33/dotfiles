{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules."carbon.host"
  ];

  # Defined by /modules/home/me.nix
  # And used all around in /modules/home/*
  me = {
    username = "tony";
    fullname = "Tony Du";
    email = "tonydu121@hotmail.com";
  };
  theme = "ansi";

  home.stateVersion = "24.11";
}
