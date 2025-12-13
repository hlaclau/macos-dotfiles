# dotfiles

My macOS configuration managed with **Nix**, **nix-darwin**, and **home-manager**.

## What's Included

- **Shell**: zsh with syntax highlighting, autosuggestions, starship prompt
- **Terminal**: ghostty, kitty (Catppuccin Mocha theme)
- **Editor**: Neovim (AstroNvim) with LSPs and treesitter
- **Tools**: bat, eza, fd, fzf, zoxide, lazygit, tmux
- **macOS**: aerospace (tiling WM), sketchybar, system defaults
- **Theme**: Catppuccin Mocha throughout

## Prerequisites

- macOS (Apple Silicon or Intel)
- Git

## Installation

### 1. Install Nix

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Open a new terminal after installation.

### 2. Clone this repository

```bash
git clone git@github.com:hlaclau/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Build and apply the configuration

```bash
# First-time build (bootstraps nix-darwin)
nix build .#darwinConfigurations.macbook.system
./result/sw/bin/darwin-rebuild switch --flake .#macbook
```

Open a new terminal to load the new shell configuration.

## Updating

After making changes to any `.nix` files:

```bash
rebuild  # alias for darwin-rebuild switch --flake ~/dotfiles
```

Or explicitly:

```bash
darwin-rebuild switch --flake ~/dotfiles#macbook
```

## Structure

```
~/dotfiles/
├── flake.nix                    # Nix flake entry point
├── hosts/darwin/default.nix     # macOS system config + Homebrew casks
└── home/
    ├── default.nix              # Main home-manager config
    ├── shell/
    │   ├── zsh.nix              # Shell configuration
    │   ├── starship.nix         # Prompt
    │   └── tmux.nix             # Terminal multiplexer
    ├── programs/
    │   ├── git.nix              # Git + delta
    │   ├── fzf.nix              # Fuzzy finder + bat
    │   └── terminals.nix        # Ghostty + Kitty configs
    └── editors/
        └── neovim.nix           # Neovim + treesitter + LSPs
```

## Package Management

| Type | Manager | Location |
|------|---------|----------|
| CLI tools | Nix | `home/default.nix` |
| GUI apps | Homebrew | `hosts/darwin/default.nix` |
| Neovim plugins | lazy.nvim | `.config/nvim/` |

## Key Aliases

| Alias | Command |
|-------|---------|
| `rebuild` | `darwin-rebuild switch --flake ~/dotfiles` |
| `ls` | `eza --color=always --icons=always -a` |
| `cat` | `bat` |
| `cd` | `z` (zoxide) |
| `lg` | `lazygit` |
| `n` | `nvim` |

## Useful Commands

```bash
# Update flake inputs (nixpkgs, home-manager, etc.)
nix flake update

# Garbage collect old generations
nix-collect-garbage -d

# List installed packages
nix-env -q

# Show what will change before rebuilding
darwin-rebuild build --flake ~/dotfiles#macbook
```

## Legacy (Stow)

The original stow-based setup has been migrated to Nix. The `.config/` directory still contains the source configurations, which are now symlinked via home-manager's `xdg.configFile`.
