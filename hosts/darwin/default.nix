{ pkgs, vars, ... }:

{
  # Nix configuration
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages (available globally)
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
  ];

  # Homebrew configuration (GUI apps only)
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Remove unlisted casks
      upgrade = true;
    };

    taps = [
      "nikitabobko/tap"
    ];

    brews = [
      # Keep mise here as it needs shell integration from brew
      "mise"
    ];

    casks = [
      # Terminals & Editors
      "cursor"
      "ghostty"

      # Productivity
      "raycast"
      "obsidian"

      # Window Management
      "nikitabobko/tap/aerospace"
      "dockey"

      # Browsers & Communication
      "zen"
      "legcord"

      # Fonts
      "font-jetbrains-mono-nerd-font"
      "font-geist-mono-nerd-font"
      "font-maple-mono"
      "font-maple-mono-nf"
    ];
  };

  # macOS system defaults
  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.4;
      expose-animation-duration = 0.2;
      tilesize = 48;
      launchanim = true;
      orientation = "bottom";
      show-recents = false;
      mru-spaces = false;
    };

    # Finder settings
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXDefaultSearchScope = "SCcf"; # Search current folder
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv"; # List view
    };

    # Global macOS settings
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      "com.apple.swipescrolldirection" = true; # Natural scrolling
    };

    # Trackpad
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
    };

    # Screenshots
    screencapture = {
      location = "~/Pictures/Screenshots";
      type = "png";
    };
  };

  # Keyboard settings
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = false;
  };

  # Touch ID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;

  # User configuration
  users.users.${vars.username} = {
    name = vars.username;
    home = "/Users/${vars.username}";
  };

  # Used for backwards compatibility
  system.stateVersion = 5;
}
