{ pkgs, vars, ... }:

let
  colors = vars.theme.colors;
in
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";
    prefix = "C-s";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
    ];

    extraConfig = ''
      # Terminal overrides for true color
      set-option -sa terminal-overrides ",xterm*:Tc"

      # Pane base index
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # Status bar configuration (using theme colors)
      set -g status on
      set -g status-interval 1
      set -g status-justify left
      set -g status-left-length 40
      set -g status-right-length 150
      set -g status-left '#[fg=${colors.mauve},bg=${colors.base}] #S #[fg=${colors.base},bg=${colors.mauve}] '
      set -g status-right '#[fg=${colors.text},bg=${colors.base}] %Y-%m-%d %H:%M #[fg=${colors.mauve},bg=${colors.base}] #(whoami)@#h '
      set -g status-style 'fg=${colors.text},bg=${colors.base}'

      # Window status
      setw -g window-status-format ' #I:#W#F '
      setw -g window-status-current-format ' #I:#W#F '
      setw -g window-status-current-style 'fg=${colors.base},bg=${colors.mauve},bold'
      setw -g window-status-style 'fg=${colors.text},bg=${colors.base}'

      # Pane borders
      set -g pane-border-style 'fg=${colors.overlay0}'
      set -g pane-active-border-style 'fg=${colors.mauve}'

      # Message style
      set -g message-style 'fg=${colors.text},bg=${colors.base}'

      # Vi mode keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Split windows in current path
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
