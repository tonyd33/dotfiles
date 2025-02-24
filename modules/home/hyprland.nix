{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$menu" = "tofi-drun --drun-launch=true";

      bind = [
        "$mod, RETURN, exec, $terminal"
        "$mod SHIFT, E, exit"
        "$mod, D, exec, $menu"

        # Motions
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, R"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
      ];
    };
  };
}
