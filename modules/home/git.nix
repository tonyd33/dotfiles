{ flake, ... }:
let
  inherit (flake.config) me;
in
{
  programs = {
    git = {
      enable = true;
      userName = me.fullname;
      userEmail = me.email;
      ignores = [ "*~" "*.swp" ];
      extraConfig = {
        init.defaultBranch = "master";
        # pull.rebase = "false";
      };
      signing = {
        format = "ssh";
        key = "~/.ssh/id_rsa.pub";
        signByDefault = true;
      };
    };
  };
}
