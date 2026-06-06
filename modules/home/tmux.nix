{
  lib,
  pkgs,
  flake,
  config,
  ...
}:
let
  inherit (config) theme;
in
{
  programs.tmux = {
    enable = true;
    shell = "/bin/zsh";

    shortcut = "a";
    baseIndex = 1;
    escapeTime = 0;

    terminal = "tmux-256color";

    keyMode = "vi";
    mouse = true;

    customPaneNavigationAndResize = true;

    plugins =
      with pkgs.tmuxPlugins;
      [
        better-mouse-mode
        {
          plugin = fuzzback;
          extraConfig = ''
            set -g @fuzzback-bind '?'
          '';
        }
        {
          plugin = tmux-fzf;
          extraConfig = ''
            TMUX_FZF_LAUNCH_KEY="C-f"
          '';
        }
        {
          plugin = fzf-tmux-url;
          extraConfig = ''
            set -g @fzf-url-bind 'u'
          '';
        }
        {
          plugin = jump;
          extraConfig = ''
            set -g @jump-key 's'
          '';
        }
        {
          plugin = mkTmuxPlugin rec {
            pluginName = "tmux-menus";
            version = "2.2.33";
            src = pkgs.fetchFromGitHub {
              owner = "jaclu";
              repo = "tmux-menus";
              rev = "v${version}";
              hash = "sha256-UPWsa7sFy6P3Jo3KFEvZrz4M4IVDhKI7T1LNAtWqTT4=";
            };
            rtpFilePath = "menus.tmux";
            meta = with lib; {
              homepage = "https://github.com/jaclu/tmux-menus";
              description = "Tmux plugin, Popup menus to help with managing your environment";
              license = licenses.mit;
              platforms = platforms.unix;
              maintainers = with maintainers; [ jaclu ];
            };
          };
          extraConfig = ''
            set -g @menus_trigger '+'
            set -g @menus_use_cache 'false'
          '';
        }
        # {
        #   plugin = mkTmuxPlugin rec {
        #     pluginName = "tmux-modal";
        #     version = "unstable-2024-11-03";
        #     src = pkgs.fetchFromGitHub {
        #       owner = "whame";
        #       repo = "tmux-modal";
        #       rev = "21adf90b27068948a8ce12dce805c95faeb9459f";
        #       hash = "sha256-HbnAQJidmwz5orpiSAj/HOcDrNSHU379Gyvwl5n5jDE=";
        #     };
        #     rtpFilePath = "tmux-modal.tmux";
        #     meta = with lib; {
        #       homepage = "https://github.com/whame/tmux-modal";
        #       description = "Execute complex tmux commands in just a few keystrokes with a modal mode that is designed to be efficient, easy to remember and comfortable";
        #       license = licenses.mit;
        #       platforms = platforms.unix;
        #       maintainers = with maintainers; [ whame ];
        #     };
        #   };
        # }
      ]
      ++ (
        if theme == "catppuccin" then
          [
            {
              plugin = mkTmuxPlugin rec {
                pluginName = "catppuccin";
                version = "2.1.2";
                src = pkgs.fetchFromGitHub {
                  owner = "catppuccin";
                  repo = "tmux";
                  rev = "v${version}";
                  hash = "sha256-EHinWa6Zbpumu+ciwcMo6JIIvYFfWWEKH1lwfyZUNTo=";
                  # hash = "sha256-Is0CQ1ZJMXIwpDjrI5MDNHJtq+R3jlNcd9NXQESUe2w=";
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
            {
              plugin = catppuccin;
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
          ]
        else if theme == "ansi" then
          [ ]
        else
          [ ]
      );

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

      # This is needed to enable C-a passthrough
      bind-key C-a send-keys C-a

      # set default directory for new windows in this session to current directory
      bind M-c attach-session -c "#{pane_current_path}"
    '' + (
      if theme == "catppuccin" then
        ""
      else if theme == "ansi" then
        ''
          status_style="fg=colour0,bg=colour7"
          status_style_inverse="fg=colour7,bg=colour0"

          set -g status-position bottom
          set -g status "on"
          set -g status-bg "colour0"
          set -g status-fg "colour7"
          set -g status-justify "left"
          set -g status-left-length "100"
          set -g status-right-length "100"
          set -g status-interval 5

          set -g pane-border-style fg="colour8"
          set -g pane-active-border-style fg="color3"

          setw -g window-status-activity-style fg="colour7",bg="colour0",none
          setw -g window-status-separator "#[$status_style_inverse] |"
          setw -g window-status-style fg="colour7",bg="colour0",none

          set -g status-left " "
          set -g status-right "#[$status_style_inverse]#[$status_style] 󰻋  #S #[$status_style_inverse] #[$status_style_inverse]#[$status_style]   #h #[$status_style_inverse] "

          setw -g window-status-format "#[$status_style_inverse,fg=colour2] #I #[$status_style_inverse] #{b:pane_current_command}"
          setw -g window-status-current-format "#[$status_style,bg=colour2] #I #[$status_style_inverse] #{b:pane_current_command}"
        ''
      else
        ""
    );
  };
}
