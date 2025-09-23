{ lib, pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    shortcut = "Space";
    baseIndex = 1;
    escapeTime = 0;

    terminal = "xterm-kitty";

    keyMode = "vi";
    mouse = true;

    customPaneNavigationAndResize = true;

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      {
        plugin = mkTmuxPlugin rec {
          pluginName = "catppuccin";
          version = "2.1.2";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "tmux";
            rev = "v${version}";
            hash = "sha256-EHinWa6Zbpumu+ciwcMo6JIIvYFfWWEKH1lwfyZUNTo=";
          };
          postInstall = ''
            sed -i -e 's|''${PLUGIN_DIR}/catppuccin-selected-theme.tmuxtheme|''${TMUX_TMPDIR}/catppuccin-selected-theme.tmuxtheme|g' $target/catppuccin.tmux
          '';
          meta = with lib; {
            homepage = "https://github.com/catppuccin/tmux";
            description = "Soothing pastel theme for Tmux!";
            license = licenses.mit;
            platforms = platforms.unix;
            maintainers = with maintainers; [ jnsgruk ];
          };
        };
        extraConfig = ''
          set -g @catppuccin_flavour 'frappe'

          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_status_modules_right "directory host"
          set -g @catppuccin_status_modules_left "session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{b:pane_current_path}"
          set -g @catppuccin_host_icon ""
        '';
      }
      # {
      #   plugin = catppuccin;
      #   extraConfig = ''
      #     set -g @catppuccin_flavour 'frappe'
      #
      #     set -g @catppuccin_window_left_separator ""
      #     set -g @catppuccin_window_right_separator " "
      #     set -g @catppuccin_window_middle_separator " █"
      #     set -g @catppuccin_window_number_position "right"
      #     set -g @catppuccin_window_default_fill "number"
      #     set -g @catppuccin_window_default_text "#W"
      #     set -g @catppuccin_window_current_text "#W"
      #     set -g @catppuccin_window_current_fill "number"
      #     set -g @catppuccin_status_modules_right "directory host"
      #     set -g @catppuccin_status_modules_left "session"
      #     set -g @catppuccin_status_left_separator  " "
      #     set -g @catppuccin_status_right_separator " "
      #     set -g @catppuccin_status_right_separator_inverse "no"
      #     set -g @catppuccin_status_fill "icon"
      #     set -g @catppuccin_status_connect_separator "no"
      #     set -g @catppuccin_directory_text "#{b:pane_current_path}"
      #     set -g @catppuccin_host_icon ""
      #   '';
      # }
    ];

    extraConfig = ''
      # Automatic window renumbering
      set -g renumber-windows on

      # Pane movement
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      unbind |
      bind | split-window -h -c "#{pane_current_path}"
      unbind -
      bind - split-window -v -c "#{pane_current_path}"

      unbind a
      bind a copy-mode
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection

      # This is needed to enable C-a passthrough (jump to start of line)
      bind-key C-a send-keys C-a

      # set default directory for new windows in this session to current directory
      bind M-c attach-session -c "#{pane_current_path}"
    '';
  };
}
