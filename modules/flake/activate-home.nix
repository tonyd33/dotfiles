{
  perSystem =
    {
      self',
      pkgs,
      lib,
      ...
    }:
    {
      # Enables 'nix run #home' to activate home-manager config.
      apps.home = {
        inherit (self'.packages.activate) meta;
        program = pkgs.writeShellApplication {
          name = "activate-home";
          text = ''
            set -x
            HOSTNAME=$(hostname -s)
            ${lib.getExe self'.packages.activate} "$USER"@"$HOSTNAME"
          '';
        };
      };
    };
}
