{ flake, ... }:
let
  inherit (flake.config) me;
in
{
  # https://nixos.asia/en/git
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
    };
  };
}
