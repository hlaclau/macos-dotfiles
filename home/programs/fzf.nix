{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    # Default command using fd
    defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";

    # Ctrl+T command
    fileWidgetCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    fileWidgetOptions = [
      "--preview 'bat --color=always -n --line-range :500 {}'"
    ];

    # Alt+C command
    changeDirWidgetCommand = "fd --type=d --hidden --strip-cwd-prefix --exclude .git";
    changeDirWidgetOptions = [
      "--preview 'eza --long --color=always --icons=always --git {} | head -200'"
    ];

    # Catppuccin Mocha colors
    defaultOptions = [
      "--height 50%"
      "--layout=default"
      "--border"
      "--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8"
      "--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC"
      "--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8"
      "--color=selected-bg:#45475A"
      "--color=border:#6C7086,label:#CDD6F4"
    ];

    tmux = {
      enableShellIntegration = true;
      shellIntegrationOptions = [ "-p90%,70%" ];
    };
  };

  # Bat configuration
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Mocha";
      style = "numbers,header";
    };
  };
}
