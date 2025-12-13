{ pkgs, vars, ... }:

{
  imports = [
    ./shell/zsh.nix
    ./shell/starship.nix
    ./shell/tmux.nix
    ./programs/git.nix
    ./programs/fzf.nix
    ./programs/terminals.nix
    ./editors/neovim.nix
  ];

  home = {
    username = vars.username;
    homeDirectory = "/Users/${vars.username}";
    stateVersion = "24.05";

    # CLI packages managed by Nix
    packages = with pkgs; [
      # Modern CLI replacements
      bat
      eza
      fd
      ripgrep
      zoxide

      # TUI tools
      lazygit
      lazydocker
      bottom
      btop
      gdu

      # Development
      rustup
      go
      nodejs
      pnpm
      sqlc
      golangci-lint

      # Utilities
      fastfetch
      glow
      gum
      lolcat
      cmatrix
      thefuck
      mpv
      television

      # Git tools
      git-delta
    ];
  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # XDG directories
  xdg.enable = true;

  # Symlink configs that are complex or shell-scripted
  xdg.configFile = {
    # Aerospace tiling window manager
    "aerospace/aerospace.toml".source = ../.config/aerospace/aerospace.toml;

    # Sketchybar (complex shell scripts)
    "sketchybar".source = ../.config/sketchybar;

    # Bat themes
    "bat/themes".source = ../.config/bat/themes;

    # Btop
    "btop/btop.conf".source = ../.config/btop/btop.conf;
    "btop/themes".source = ../.config/btop/themes;

    # Fastfetch
    "fastfetch".source = ../.config/fastfetch;

    # Television
    "television".source = ../.config/television;

    # Yazi
    "yazi/theme.toml".source = ../.config/yazi/theme.toml;
  };
}
