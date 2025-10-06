# My dotfiles

This repository contains all my dotfiles for macOS, including my Brewfile, my config for zsh, tmux, ghostty and more.

## Prerequisites

Before you begin, ensure you have the following installed on your macOS system:

- [Homebrew](https://brew.sh)
- Git

## Installation

1. Clone this repository to your home directory:

   ```sh
   git clone git@github.com:hlaclau/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Install Homebrew packages and applications:

   ```sh
   brew bundle --file=.config/homebrew/Brewfile
   ```

   This will install all necessary tools including:

   - Development tools (neovim, git-delta, etc.)
   - Shell enhancements (starship, zoxide, fzf)
   - Terminal utilities (bat, eza, btop)
   - Applications (Ghostty, Firefox, Raycast, etc.)
   - Fonts (JetBrains Mono Nerd Font, Geist Mono, Maple Mono)

3. Create symbolic links for the dotfiles:

   ```sh
   stow .
   ```

   This will symlink all configuration files to their appropriate locations in your home directory.

4. Set up your shell:

   ```sh
   # Add Homebrew's zsh to allowed shells
   sudo sh -c 'echo $(brew --prefix)/bin/zsh >> /etc/shells'
   # Change your default shell to Homebrew's zsh
   chsh -s $(brew --prefix)/bin/zsh
   ```

## Post-Installation

Some applications might need additional configuration:

- **Raycast**: Replace Spotlight (⌘ Space) with Raycast in System Settings
- **Alt-Tab**: Configure preferred behavior in its settings
- **Aerospace**: Enable accessibility permissions when prompted

## Updating

To update your dotfiles and packages:

1. Pull the latest changes:

   ```sh
   cd ~/.dotfiles
   git pull
   ```

2. Update Homebrew packages:

   ```sh
   brew bundle --file=.config/homebrew/Brewfile
   ```

3. Reapply symlinks if needed:

   ```sh
   stow .
   ```
