{ pkgs, vars, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    history = {
      size = vars.shell.historySize;
      save = vars.shell.historySize;
      ignoreDups = true;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
      ignoreSpace = true;
    };

    shellAliases = {
      # Modern replacements
      ls = "eza --color=always --icons=always -a";
      ll = "eza --long --color=always --icons=always --git -a";
      cat = "bat";
      cd = "z";

      # Editor aliases
      n = vars.editor;
      vi = vars.editor;
      vim = vars.editor;

      # Git aliases
      lg = "lazygit";
      glog = "git log --oneline --graph --all";
      gh-create = "gh repo create --private --source=. --remote=origin && git push -u --all && gh browse";

      # Utilities
      cls = "clear";
      f = "fuck";
      sb = "brew services restart sketchybar";
      reload = "source ~/.zshrc";

      # Nix rebuild alias
      rebuild = "darwin-rebuild switch --flake ~/dotfiles";
    };

    initExtra = ''
      # =============================================================================
      #                               PATH CONFIGURATIONS
      # =============================================================================

      # Add deno completions to search path
      if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then
        export FPATH="$HOME/.zsh/completions:$FPATH"
      fi

      # Rust/Cargo binaries
      export PATH="$HOME/.cargo/bin:$PATH"

      # Go binaries
      export PATH="$PATH:$HOME/.local/opt/go/bin"
      export PATH="$PATH:$HOME/go/bin"

      # pnpm
      export PNPM_HOME="$HOME/Library/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac

      # dotnet tools
      export PATH="$HOME/.dotnet/tools:$PATH"
      export PATH="$HOME/.local/bin:$PATH"

      # Spicetify
      export PATH="$PATH:$HOME/.spicetify"

      # =============================================================================
      #                               TOOL INITIALIZATION
      # =============================================================================

      # Initialize zoxide (smart cd)
      eval "$(zoxide init zsh)"

      # Initialize thefuck
      eval "$(thefuck --alias)"

      # Load mise (version manager)
      eval "$(mise activate zsh)"

      # Load envman if available
      [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

      # =============================================================================
      #                               ZSH HIGHLIGHT STYLES
      # =============================================================================

      # Disable path underline
      (( ''${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
      ZSH_HIGHLIGHT_STYLES[path]=none
      ZSH_HIGHLIGHT_STYLES[path_prefix]=none

      # =============================================================================
      #                               FUNCTIONS
      # =============================================================================

      # Open GitHub repo in browser
      repo() {
        gh repo view --web
      }

      # Interactive directory selection with eza
      fzf-cd() {
        local dir
        dir=$(eza --tree --level=2 --color=always --icons=always | fzf --ansi --preview 'eza --long --color=always --icons=always {}' | sed 's/.* //')
        if [ -n "$dir" ] && [ -d "$dir" ]; then
          cd "$dir"
        fi
      }

      # History search with fzf
      h() {
        history 1 | fzf
      }

      # =============================================================================
      #                               TMUX AUTO-START
      # =============================================================================

      # Open tmux by default if available and not already in tmux
      if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ -n "$PS1" ] && [[ $- == *i* ]]; then
        tmux attach || tmux
      fi

      # =============================================================================
      #                               FASTFETCH DISPLAY
      # =============================================================================

      # Show fastfetch only in interactive shells that are not inside tmux
      if [[ $- == *i* ]] && [ -z "$TMUX" ]; then
        fastfetch
      fi
    '';
  };
}
