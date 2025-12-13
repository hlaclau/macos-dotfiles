{ pkgs, vars, ... }:

{
  programs.git = {
    enable = true;
    userName = vars.git.userName;
    userEmail = vars.git.userEmail;

    delta = {
      enable = true;
      options = {
        features = "catppuccin-mocha";
        side-by-side = true;
        line-numbers = true;
      };
    };

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      core = {
        editor = vars.editor;
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
    };

    includes = [
      # Include catppuccin delta theme
      { path = "~/.config/delta/catppuccin.gitconfig"; }
    ];
  };

  # Symlink the delta catppuccin theme
  xdg.configFile."delta/catppuccin.gitconfig".source = ../../.config/delta/catppuccin.gitconfig;

  # GitHub CLI
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };
}
