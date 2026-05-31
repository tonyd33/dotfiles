{ pkgs, lib, ... }:
let
  system = pkgs.system;
  isLinux = builtins.match ".*-linux" system != null;
in
lib.mkIf isLinux {
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;

      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
      publicShare = "$HOME/Public";
      templates = "$HOME/Templates";
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        # Add your default applications here
        # "text/html" = "firefox.desktop";
        # "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
  };
}
