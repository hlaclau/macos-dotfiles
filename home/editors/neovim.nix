{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Pre-compile treesitter grammars via Nix for faster startup
    plugins = with pkgs.vimPlugins; [
      # Treesitter with all grammars pre-compiled
      (nvim-treesitter.withPlugins (plugins: with plugins; [
        bash
        c
        cpp
        css
        dockerfile
        go
        gomod
        gosum
        html
        javascript
        json
        lua
        markdown
        markdown_inline
        nix
        python
        rust
        sql
        toml
        tsx
        typescript
        vim
        vimdoc
        yaml
      ]))
    ];

    # LSP servers and development tools
    extraPackages = with pkgs; [
      # LSP servers
      lua-language-server
      nil # Nix LSP
      gopls
      rust-analyzer
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted # HTML, CSS, JSON, ESLint
      pyright
      tailwindcss-language-server

      # Formatters
      stylua
      prettierd
      nixfmt-rfc-style
      gofumpt
      rustfmt

      # Linters
      selene
      eslint_d

      # Tools
      tree-sitter
    ];

    extraLuaConfig = ''
      -- Neovim is managed by Nix, but config is in the standard location
      -- The actual configuration is loaded from ~/.config/nvim/init.lua
      -- which uses lazy.nvim for AstroNvim plugin management
    '';
  };

  # Symlink the entire nvim config directory
  # This allows lazy.nvim and AstroNvim to manage plugins as usual
  xdg.configFile."nvim" = {
    source = ../../.config/nvim;
    recursive = true;
  };
}
