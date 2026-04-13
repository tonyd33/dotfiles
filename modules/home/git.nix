{ config, ... }:
let
  inherit (config) me;
in
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = me.fullname;
        email = me.email;
      };
    };
    ignores = [
      "*~"
      "*.swp"
    ];
    settings = {
      init.defaultBranch = "master";
      # pull.rebase = "false";
    };
    signing = {
      format = "ssh";
      key = "~/.ssh/id_rsa.pub";
      signByDefault = true;
    };
  };
}
